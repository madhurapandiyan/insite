import 'package:flutter/material.dart';
import 'package:insite/core/models/maintenance.dart';
import 'package:insite/core/models/maintenance_list_services.dart';
import 'package:insite/utils/helper_methods.dart';
import 'package:insite/widgets/dumb_widgets/empty_view.dart';
import 'package:insite/widgets/dumb_widgets/insite_button.dart';
import 'package:insite/widgets/dumb_widgets/insite_progressbar.dart';
import 'package:insite/widgets/dumb_widgets/insite_text.dart';
import 'package:logger/logger.dart';
import 'package:stacked/stacked.dart';
import 'maintenance_tab_view_model.dart';

class MaintenanceTabView extends StatefulWidget {
  final Function(
          num? value, AssetData? assetDataValue, List<Services?>? serviceNames)?
      serviceCalBack;

  final SummaryData? summaryData;
  MaintenanceTabView({this.serviceCalBack, this.summaryData});
  @override
  State<MaintenanceTabView> createState() => _MaintenanceTabViewState();
}

class _MaintenanceTabViewState extends State<MaintenanceTabView> {
  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<MaintenanceTabViewModel>.reactive(
      builder:
          (BuildContext context, MaintenanceTabViewModel viewModel, Widget? _) {
        Logger()
            .wtf("services sssssssssssssssssssssssss: ${viewModel.services}");
        if (viewModel.loading) {
          return InsiteProgressBar();
        } else {
          return Container(
            decoration: BoxDecoration(
              color: Theme.of(context).backgroundColor,
              border: Border.all(
                  color: Theme.of(context).textTheme.bodyText1!.color!,
                  width: 0.0),
              borderRadius: BorderRadius.all(Radius.circular(16)),
            ),
            child: Column(
              children: [
                viewModel.services.isNotEmpty
                    ? Table(
                        columnWidths: {
                          0: FlexColumnWidth(1),
                          1: FlexColumnWidth(1),
                          2: FlexColumnWidth(1),
                          3: FlexColumnWidth(1),
                          4: FlexColumnWidth(1),
                          5: FlexColumnWidth(1),
                        },
                        border: TableBorder.all(),
                        children: [
                          TableRow(children: [
                            InsiteTextWithPadding(
                              padding: EdgeInsets.all(8),
                              text: "Service",
                              size: 12,
                            ),
                            InsiteTextWithPadding(
                              padding: EdgeInsets.all(8),
                              text: "Service Status",
                              size: 12,
                            ),
                            InsiteTextWithPadding(
                              padding: EdgeInsets.all(8),
                              text: "Service Interval",
                              size: 12,
                            ),
                            InsiteTextWithPadding(
                              padding: EdgeInsets.all(8),
                              text: "Due At",
                              size: 12,
                            ),
                            InsiteTextWithPadding(
                              padding: EdgeInsets.all(8),
                              text: "Due In/ Overdue By",
                              size: 12,
                            ),
                            InsiteTextWithPadding(
                              padding: EdgeInsets.all(8),
                              text: "Due Date",
                              size: 12,
                            ),
                            InsiteTextWithPadding(
                              padding: EdgeInsets.all(8),
                              text: "Service Type",
                              size: 12,
                            ),
                          ]),
                        ],
                      )
                    : SizedBox(),
                viewModel.services.isNotEmpty
                    ? Container(
                        height: 200,
                        child: Scrollbar(
                          isAlwaysShown: true,
                          child: SingleChildScrollView(
                            controller: viewModel.scrollController,
                            child: Column(
                              children: [
                                Table(
                                  columnWidths: {
                                    0: FlexColumnWidth(1),
                                    1: FlexColumnWidth(2),
                                    2: FlexColumnWidth(1),
                                    3: FlexColumnWidth(1),
                                    4: FlexColumnWidth(1),
                                    5: FlexColumnWidth(1),
                                  },
                                  border: TableBorder.all(),
                                  children: List.generate(
                                      viewModel.services.length, (index) {
                                    Services? services =
                                        viewModel.services[index];
                                    return TableRow(children: [
                                      // InsiteTextWithPadding(
                                      //   padding: EdgeInsets.all(8),
                                      //   text: services!.serviceName,
                                      //   size: 12,
                                      // ),
                                      InsiteRichText(
                                        content: services!.serviceName,
                                        onTap: () {
                                          // serviceName!.clear();

                                          widget.serviceCalBack!(
                                              services.serviceId,
                                              viewModel.assetDataValue!,
                                              viewModel.services);
                                        },
                                        title: " ",
                                      ),
                                      InsiteButton(
                                        title: services.dueInfo!.serviceStatus,
                                        padding: EdgeInsets.all(8),
                                        margin: EdgeInsets.all(8),
                                        bgColor: Utils.getFaultColor(
                                            "fault.severityLabel"),
                                        height: 30,
                                        width: 40,
                                      ),
                                      InsiteTextWithPadding(
                                        padding: EdgeInsets.all(8),
                                        text: services.nextOccurrence!
                                            .toStringAsFixed(0),
                                        size: 12,
                                      ),
                                      InsiteTextWithPadding(
                                        padding: EdgeInsets.all(8),
                                        text: services.dueInfo!.dueAt!
                                            .toStringAsFixed(0),
                                        size: 12,
                                      ),
                                      InsiteTextWithPadding(
                                        padding: EdgeInsets.all(8),
                                        text: services.dueInfo!.dueBy!
                                            .abs()
                                            .toStringAsFixed(0),
                                        size: 12,
                                      ),
                                      InsiteTextWithPadding(
                                        padding: EdgeInsets.all(8),
                                        text: Utils.getLastReportedDateOneUTC(
                                            services.dueInfo!.dueDate),
                                        size: 12,
                                      ),
                                      InsiteTextWithPadding(
                                        padding: EdgeInsets.all(8),
                                        text: services.serviceType,
                                        size: 12,
                                      ),
                                    ]);
                                  }),
                                ),
                                viewModel.loadingMore
                                    ? Padding(
                                        padding: EdgeInsets.all(8),
                                        child: InsiteProgressBar(),
                                      )
                                    : SizedBox(),
                              ],
                            ),
                          ),
                        ),
                      )
                    : SizedBox(),
              ],
            ),
          );
        }
      },
      viewModelBuilder: () => MaintenanceTabViewModel(widget.summaryData),
    );
  }
}
