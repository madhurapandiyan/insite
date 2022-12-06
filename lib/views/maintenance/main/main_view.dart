import 'package:flutter/material.dart';

import 'package:insite/core/models/maintenance.dart';
import 'package:insite/core/models/maintenance_list_services.dart';
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
  List<String?>? dateRange = [];
  MainViewModel? model;

  // @override
  // initState() {
  //   model = MainViewModel();
  //   super.initState();
  // }

  onFilterApplied() {
    model!.refresh();
  }

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<MainViewModel>.reactive(
      builder: (BuildContext context, MainViewModel viewModel, Widget? _) {
        model = viewModel;
        return Stack(
          children: [
            Column(
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      InsiteButton(
                        width: 200,
                        title: Utils.getDateInFormatddMMyyyy(
                                viewModel.maintenanceStartDate) +
                            " - " +
                            Utils.getDateInFormatddMMyyyy(
                                viewModel.maintenanceEndDate),

                        //width: 90,
                        //bgColor: Theme.of(context).backgroundColor,
                        textColor: white,
                        onTap: () async {
                          //Logger().wtf(viewModel.maintenanceEndDate);
                          dateRange = [];
                          dateRange = await showDialog(
                            context: context,
                            builder: (BuildContext context) => Dialog(
                                backgroundColor: transparent,
                                child: DateRangeMaintenanceView()),
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
                  count: viewModel.maintenanceList.length <
                          viewModel.totalCount!.toInt()
                      ? viewModel.maintenanceList.length
                      : viewModel.totalCount!.toInt(),
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
                                  serviceCalBack: () {
                                    viewModel.onServiceSelected(
                                        ctx: context,
                                        serviceId:
                                            summaryData.serviceId!.toInt(),
                                        assetDataValue: AssetData(
                                          assetID: summaryData.assetID,
                                          assetIcon: summaryData.assetIcon,
                                          assetSerialNumber:
                                              summaryData.assetSerialNumber,
                                          currentHourmeter:
                                              summaryData.currentHourMeter,
                                          currentOdometer:
                                              summaryData.currentOdometer,
                                          makeCode: summaryData.makeCode,
                                          model: summaryData.model,
                                        ));
                                  },
                                );
                              },
                            )
                          : EmptyView(
                              title: "No Service Found",
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
