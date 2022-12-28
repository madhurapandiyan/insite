import 'package:flutter/material.dart';
import 'package:insite/core/models/fault.dart';
import 'package:insite/theme/colors.dart';
import 'package:insite/utils/enums.dart';
import 'package:insite/utils/helper_methods.dart';
import 'package:insite/views/date_range/date_range_view.dart';
import 'package:insite/widgets/dumb_widgets/empty_view.dart';
import 'package:insite/widgets/dumb_widgets/health_asset_list_item.dart';
import 'package:insite/widgets/dumb_widgets/insite_button.dart';
import 'package:insite/widgets/dumb_widgets/insite_progressbar.dart';
import 'package:insite/widgets/dumb_widgets/insite_text.dart';
import 'package:insite/widgets/smart_widgets/page_header.dart';
import 'package:stacked/stacked.dart';
import 'asset_view_model.dart';

class AssetView extends StatefulWidget {
  AssetView({Key? key}) : super(key: key);

  @override
  AssetViewState createState() => AssetViewState();
}

class AssetViewState extends State<AssetView> {
  onFilterApplied() {
    viewModel.refresh();
  }

 late var viewModel;
  List<DateTime>? dateRange = [];

  @override
  void initState() {
    viewModel = AssetViewModel();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<AssetViewModel>.reactive(
      builder: (BuildContext context, AssetViewModel model, Widget? _) {
       // viewModel = model;
        return Padding(
          padding: const EdgeInsets.only(top: 35),
          child: Stack(
            children: [
              Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        // InsiteText(
                        //     text: Utils.getDateInFormatddMMyyyy(
                        //             viewModel.startDate) +
                        //         " - " +
                        //         Utils.getDateInFormatddMMyyyy(
                        //             viewModel.endDate),
                        //     fontWeight: FontWeight.bold,
                        //     size: 12),
                        // SizedBox(
                        //   width: 4,
                        // ),
                        InsiteButton(
                          //width: 90,
                          title: Utils.getDateFormatForDatePicker(
                                  viewModel.startDate, viewModel.userPref) +
                              " - " +
                              Utils.getDateFormatForDatePicker(
                                  viewModel.endDate, viewModel.userPref),
                          // bgColor: Theme.of(context).backgroundColor,
                          textColor: white,
                          onTap: () async {
                            dateRange = [];
                            dateRange = await showDialog(
                              context: context,
                              builder: (BuildContext context) => Dialog(
                                  backgroundColor: transparent,
                                  child: DateRangeView()),
                            );
                            if (dateRange != null && dateRange!.isNotEmpty) {
                              viewModel.refresh();
                            }
                          },
                        ),
                      ],
                    ),
                  ),
                  PageHeader(
                    isDashboard: false,
                    total: viewModel.totalCount,
                    screenType: ScreenType.ASSET_OPERATION,
                    count: viewModel.faults.length,
                  ),
                  Expanded(
                    child: viewModel.loading
                        ? Container(child: InsiteProgressBar())
                        : viewModel.faults.isNotEmpty
                            ? ListView.builder(
                                controller: viewModel.scrollController,
                                itemCount: viewModel.faults.length,
                                padding: EdgeInsets.only(
                                    left: 16, right: 16, top: 4),
                                shrinkWrap: true,
                                itemBuilder: (context, index) {
                                  AssetFault? fault = viewModel.faults[index];
                                  return HealthAssetListItem(
                                    dateFormat: viewModel.userPref,
                                    timeZone: viewModel.zone,
                                    key: UniqueKey(),
                                 
                                    fault: fault,
                                    onCallback: () {
                                      viewModel.onDetailPageSelected(fault);
                                    },
                                  );
                                },
                              )
                            : EmptyView(
                                title: "No Assets with fault codes to display",
                              ),
                  ),
                  viewModel.loadingMore
                      ? Padding(
                          padding: EdgeInsets.all(8),
                          child: InsiteProgressBar(),
                        )
                      : SizedBox(),
                ],
              ),
              viewModel.refreshing ? InsiteProgressBar() : SizedBox()
            ],
          ),
        );
      },
      viewModelBuilder: () => viewModel,
    );
  }
}
