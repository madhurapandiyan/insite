import 'package:flutter/material.dart';
import 'package:insite/core/models/fault.dart';
import 'package:insite/theme/colors.dart';
import 'package:insite/views/date_range/date_range_view.dart';
import 'package:insite/widgets/dumb_widgets/empty_view.dart';
import 'package:insite/widgets/dumb_widgets/health_asset_list_item.dart';
import 'package:insite/widgets/smart_widgets/page_header.dart';
import 'package:stacked/stacked.dart';

import 'asset_view_model.dart';

class AssetView extends StatefulWidget {
  AssetView({Key key}) : super(key: key);

  @override
  AssetViewState createState() => AssetViewState();
}

class AssetViewState extends State<AssetView> {
  onFilterApplied() {
    // viewModel.refresh();
  }
  var viewModel;
  List<DateTime> dateRange = [];

  @override
  void initState() {
    viewModel = AssetViewModel();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<AssetViewModel>.reactive(
      viewModelBuilder: () => viewModel,
      builder: (BuildContext context, AssetViewModel model, Widget _) {
        return Stack(
          children: [
            Column(
              children: [
                Align(
                  alignment: Alignment.centerRight,
                  child: Padding(
                    padding:
                        const EdgeInsets.only(left: 16.0, right: 16, top: 16),
                    child: GestureDetector(
                      onTap: () async {
                        dateRange = [];
                        dateRange = await showDialog(
                          context: context,
                          builder: (BuildContext context) => Dialog(
                              backgroundColor: transparent,
                              child: DateRangeView()),
                        );
                        if (dateRange != null && dateRange.isNotEmpty) {
                          viewModel.refresh();
                        }
                      },
                      child: Container(
                        width: 90,
                        height: 30,
                        decoration: BoxDecoration(
                          color: cardcolor,
                          borderRadius: BorderRadius.all(
                            Radius.circular(4),
                          ),
                        ),
                        child: Center(
                          child: Text(
                            'Date Range',
                            style: TextStyle(
                              color: white,
                              fontSize: 12,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
                PageHeader(
                  isDashboard: false,
                  total: viewModel.totalCount,
                  count: viewModel.faults.length,
                ),
                Expanded(
                  child: viewModel.loading
                      ? Container(
                          child: Center(child: CircularProgressIndicator()))
                      : viewModel.faults.isNotEmpty
                          ? ListView.builder(
                              controller: viewModel.scrollController,
                              itemCount: viewModel.faults.length,
                              padding:
                                  EdgeInsets.only(left: 16, right: 16, top: 4),
                              shrinkWrap: true,
                              itemBuilder: (context, index) {
                                Fault fault = viewModel.faults[index];
                                return HealthAssetListItem(
                                  fault: fault,
                                  onCallback: () {
                                    viewModel.onDetailPageSelected(fault);
                                  },
                                );
                              },
                            )
                          : EmptyView(
                              title: "No Assets Found",
                            ),
                ),
                viewModel.loadingMore
                    ? Padding(
                        padding: EdgeInsets.all(8),
                        child: CircularProgressIndicator(),
                      )
                    : SizedBox(),
              ],
            ),
            viewModel.refreshing
                ? Center(
                    child: CircularProgressIndicator(),
                  )
                : SizedBox()
          ],
        );
      },
    );
  }
}
