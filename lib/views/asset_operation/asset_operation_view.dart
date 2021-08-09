import 'package:flutter/material.dart';
import 'package:insite/core/insite_data_provider.dart';
import 'package:insite/core/models/asset.dart';
import 'package:insite/theme/colors.dart';
import 'package:insite/utils/helper_methods.dart';
import 'package:insite/views/home/home_view.dart';
import 'package:insite/widgets/dumb_widgets/empty_view.dart';
import 'package:insite/widgets/dumb_widgets/insite_button.dart';
import 'package:insite/widgets/smart_widgets/asset_list_item.dart';
import 'package:insite/views/date_range/date_range_view.dart';
import 'package:insite/widgets/smart_widgets/insite_scaffold.dart';
import 'package:insite/widgets/smart_widgets/page_header.dart';
import 'package:stacked/stacked.dart';
import 'asset_operation_model.dart';

class AssetOperationView extends StatefulWidget {
  AssetOperationView();
  @override
  _AssetOperationViewState createState() => _AssetOperationViewState();
}

class _AssetOperationViewState extends State<AssetOperationView> {
  List<String> menuFilters = ['Asset ID', 'Serial Number'];
  String menuItem = "Asset ID";
  List<DateTime> dateRange = [];

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder.reactive(
      builder:
          (BuildContext context, AssetOperationViewModel viewModel, Widget _) {
        return InsiteInheritedDataProvider(
          count: viewModel.appliedFilters.length,
          child: InsiteScaffold(
              viewModel: viewModel,
              screenType: ScreenType.ASSET_OPERATION,
              onFilterApplied: () {
                viewModel.refresh();
              },
              body: Stack(
                children: [
                  Column(
                    children: [
                      PageHeader(
                        count: viewModel.assets.length,
                        total: viewModel.totalCount,
                        isDashboard: false,
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 24, vertical: 8),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            // Container(
                            //   height: 40,
                            //   padding: EdgeInsets.all(8),
                            //   decoration: BoxDecoration(
                            //     borderRadius: BorderRadius.circular(4),
                            //     color: tuna,
                            //   ),
                            //   child: DropdownButton<String>(
                            //     value: menuItem,
                            //     items: menuFilters.map((String value) {
                            //       return new DropdownMenuItem<String>(
                            //         value: value,
                            //         child: new Text(value),
                            //       );
                            //     }).toList(),
                            //     elevation: 16,
                            //     style: TextStyle(
                            //         color: white, fontWeight: FontWeight.w700),
                            //     underline: Container(
                            //       height: 0,
                            //     ),
                            //     dropdownColor: cardcolor,
                            //     icon: Icon(
                            //       Icons.keyboard_arrow_down,
                            //       color: white,
                            //     ),
                            //     onChanged: (String newValue) {
                            //       if (menuItem != newValue) {
                            //         setState(() {
                            //           menuItem = newValue;
                            //         });
                            //         viewModel.menuItem = menuItem == "Asset ID"
                            //             ? "assetid"
                            //             : "assetserialnumber";
                            //         viewModel.refresh();
                            //       }
                            //     },
                            //   ),
                            // ),
                            Text(
                              Utils.getDateInFormatddMMyyyy(
                                      viewModel.startDate) +
                                  " - " +
                                  Utils.getDateInFormatddMMyyyy(
                                      viewModel.endDate),
                              style: TextStyle(
                                  color: white,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 12),
                            ),
                            SizedBox(
                              width: 10,
                            ),
                            InsiteButton(
                              title: "Date Range",
                              height: 36,
                              onTap: () async {
                                dateRange = [];
                                dateRange = await showDialog(
                                  context: context,
                                  builder: (BuildContext context) => Dialog(
                                      backgroundColor: transparent,
                                      child: DateRangeView()),
                                );
                                if (dateRange != null && dateRange.isNotEmpty) {
                                  setState(() {
                                    dateRange=dateRange;
                                  });
                                  viewModel.refresh();
                                }
                              },
                              textColor: Colors.white,
                              width: 100,
                              bgColor: tuna,
                            ),
                          ],
                        ),
                      ),
                      SizedBox(
                        height: 8,
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 20.0),
                        child: Text(
                          "Data displayed here is only an indicative figure. For viewing actual Asset usage per day, visit Asset Utilization - Single Asset View ",
                          style: TextStyle(color: Colors.white, fontSize: 12),
                        ),
                      ),
                      Expanded(
                          child: viewModel.loading
                              ? Center(
                                  child: CircularProgressIndicator(),
                                )
                              : viewModel.assets.isNotEmpty
                                  ? ListView.builder(
                                      itemCount: viewModel.assets.length,
                                      shrinkWrap: true,
                                      controller: viewModel.scrollController,
                                      padding: EdgeInsets.all(16),
                                      itemBuilder: (context, index) {
                                        Asset asset = viewModel.assets[index];
                                        return AssetOperationListItem(
                                          asset: asset,
                                          days: viewModel.days,
                                          onCallback: () {
                                            viewModel
                                                .onDetailPageSelected(asset);
                                          },
                                        );
                                      })
                                  : EmptyView(
                                      title: "No Results",
                                    )),
                      viewModel.loadingMore
                          ? Padding(
                              padding: EdgeInsets.all(8),
                              child: CircularProgressIndicator())
                          : SizedBox()
                    ],
                  ),
                  viewModel.refreshing
                      ? Center(
                          child: CircularProgressIndicator(),
                        )
                      : SizedBox()
                ],
              )),
        );
      },
      viewModelBuilder: () => AssetOperationViewModel(),
    );
  }
}