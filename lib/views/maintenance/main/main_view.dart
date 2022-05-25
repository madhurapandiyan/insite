import 'package:flutter/material.dart';

import 'package:insite/core/models/maintenance.dart';
//import 'package:insite/core/models/single_asset_fault_response.dart';
import 'package:insite/theme/colors.dart';
import 'package:insite/utils/enums.dart';
import 'package:insite/utils/helper_methods.dart';
import 'package:insite/views/date_range/date_range_view.dart';

import 'package:insite/views/maintenance/main/main_view_model.dart';
import 'package:insite/widgets/dumb_widgets/empty_view.dart';

import 'package:insite/widgets/dumb_widgets/insite_button.dart';
import 'package:insite/widgets/dumb_widgets/insite_progressbar.dart';
import 'package:insite/widgets/dumb_widgets/insite_text.dart';
import 'package:insite/widgets/dumb_widgets/maintenance_list_item.dart';
import 'package:insite/widgets/smart_widgets/page_header.dart';
import 'package:logger/logger.dart';
import 'package:stacked/stacked.dart';

class MainView extends StatefulWidget {
  MainView({Key? key}) : super(key: key);

  @override
  MainViewState createState() => MainViewState();
}

class MainViewState extends State<MainView> {
  onFilterApplied() {
    //viewModel.refresh();
  }

  List<DateTime>? dateRange = [];
  //late var viewModel;

  // @override
  // void initState() {
  //   viewModel = ;

  //   super.initState();
  // }

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<MainViewModel>.reactive(
      builder: (BuildContext context, MainViewModel viewModel, Widget? _) {
        return Stack(
          children: [
            Column(
              children: [
                SizedBox(
                  height: 40,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      InsiteText(
                          text: Utils.getDateInFormatddMMyyyy(
                                  viewModel.startDate) +
                              " - " +
                              Utils.getDateInFormatddMMyyyy(viewModel.endDate),
                          fontWeight: FontWeight.bold,
                          size: 12),
                      SizedBox(
                        width: 4,
                      ),
                      InsiteButton(
                        width: 90,
                        title: "Date Range",
                        bgColor: Theme.of(context).backgroundColor,
                        textColor: Theme.of(context).textTheme.bodyText1!.color,
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
                  total: viewModel.totalCount!.toInt(),
                  screenType: ScreenType.MAINTENANCE,
                  count: viewModel.maintenanceList.length,
                ),
                Expanded(
                  child: viewModel.loading
                      ? Container(child: InsiteProgressBar())
                      : viewModel.maintenanceList.isNotEmpty
                          ? ListView.builder(
                              controller: viewModel.scrollController,
                              itemCount: viewModel.maintenanceList.length,
                              padding:
                                  EdgeInsets.only(left: 12, right: 12, top: 4),
                              shrinkWrap: true,
                              itemBuilder: (context, index) {
                                SummaryData? summaryData =
                                    viewModel.maintenanceList[index];

                                return MaintenanceListItem(
                                  summaryData: summaryData,
                                  onCallback: () {
                                    viewModel.onDetailPageSelected(summaryData);

                                  },
                                  serviceCalBack:
                                      (value, assetDataValue, services) {
                                    viewModel.onServiceSelected(value,
                                        assetDataValue, summaryData, services);
                                  },
                                );
                              },
                            )
                          : EmptyView(
                              title: "No services to display",
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
            viewModel.refreshing
                ? Center(
                    child: InsiteProgressBar(),
                  )
                : SizedBox()
          ],
        );
      },
      viewModelBuilder: () => MainViewModel(),
    );
  }
}
