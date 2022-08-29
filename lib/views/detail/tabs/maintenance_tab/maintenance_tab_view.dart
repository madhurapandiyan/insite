import 'package:flutter/material.dart';
import 'package:insite/core/models/maintenance.dart';
import 'package:insite/core/models/maintenance_list_india_stack.dart';
import 'package:insite/core/models/maintenance_list_services.dart';
import 'package:insite/theme/colors.dart';
import 'package:insite/utils/enums.dart';
import 'package:insite/utils/helper_methods.dart';
import 'package:insite/views/date_range/date_range_view.dart';
import 'package:insite/widgets/dumb_widgets/empty_view.dart';
import 'package:insite/widgets/dumb_widgets/insite_button.dart';
import 'package:insite/widgets/dumb_widgets/insite_progressbar.dart';
import 'package:insite/widgets/dumb_widgets/insite_row_item_text.dart';
import 'package:insite/widgets/dumb_widgets/insite_text.dart';
import 'package:insite/widgets/dumb_widgets/toggle_button.dart';
import 'package:insite/widgets/smart_widgets/insite_expansion_tile.dart';
import 'package:logger/logger.dart';
import 'package:stacked/stacked.dart';
import 'maintenance_tab_view_model.dart';
import 'package:horizontal_data_table/horizontal_data_table.dart';

class MaintenanceTabView extends StatefulWidget {
  final Function(int? value, AssetData? assetDataValue,
      List<Services?>? serviceNames, String? service)? serviceCalBack;

  final SummaryData? summaryData;
  MaintenanceTabView({this.serviceCalBack, this.summaryData});
  @override
  State<MaintenanceTabView> createState() => _MaintenanceTabViewState();
}

class _MaintenanceTabViewState extends State<MaintenanceTabView> {
  HDTRefreshController? _htdRefreshController = HDTRefreshController();

  MaintenanceTabViewModel? model;
  List<String?>? dateRange = [];
  @override
  Widget build(BuildContext context) {
    Logger().wtf(widget.summaryData!.assetID);
    return ViewModelBuilder<MaintenanceTabViewModel>.reactive(
      builder:
          (BuildContext context, MaintenanceTabViewModel viewModel, Widget? _) {
        model = viewModel;
        if (viewModel.loading) {
          return InsiteProgressBar();
        } else {
          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  child: ToggleButton(
                      label1: "Maintenance View",
                      label2: "History View",
                      optionSelected: (value) async {
                        // print(value);
                        viewModel.toggled(value);
                        if (!viewModel.isToggled &&
                            viewModel.historyData!.isEmpty) {
                          viewModel.getHistoryMaintenanceListItem();
                        }
                      }),
                ),
                SizedBox(
                  height: 20,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    InsiteButton(
                      width: 100,
                      textColor: white,
                      title: "Refresh",
                      onTap: () {
                        viewModel.refresh();
                      },
                    ),
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
                SizedBox(
                  height: 20,
                ),
                viewModel.isToggled
                    ? viewModel.isMaintenanceDataOptained
                        ? Center(
                            child: InsiteProgressBar(),
                          )
                        : MaintenanceTabListData(
                            assetData: viewModel.assetDataValue,
                            servicesData: viewModel.services,
                            serviceCalBack:
                                (value, assetData, serviceNames, services) {
                              widget.serviceCalBack!(
                                  value, assetData, serviceNames, services);
                            },
                          )
                    : viewModel.isHistoryDataOptained
                        ? Center(
                            child: InsiteProgressBar(),
                          )
                        : HistoryListData(
                            listData: viewModel.historyData,
                          )
              ],
            ),
          );

          // return Container(
          //   child: Expanded(
          //     child: HorizontalDataTable(
          //       leftHandSideColumnWidth: 100,
          //       rightHandSideColumnWidth: 700,
          //       isFixedHeader: true,
          //       headerWidgets: _getTitleWidget(),
          //       leftSideItemBuilder: _generateFirstColumnRow,
          //       rightSideItemBuilder: _generateRightHandSideColumnRow,
          //       leftSideChildren: [],
          //       rightSideChildren: [],
          //       itemCount: viewModel.services.length,
          //       rowSeparatorWidget: const Divider(
          //         color: Colors.white,
          //         height: 1.0,
          //         thickness: 0.0,
          //       ),
          //       leftHandSideColBackgroundColor: Theme.of(context).cardColor,
          //       rightHandSideColBackgroundColor: Theme.of(context).cardColor,
          //       verticalScrollbarStyle: const ScrollbarStyle(
          //         thumbColor: Colors.white,
          //         isAlwaysShown: true,
          //         thickness: 4.0,
          //         radius: Radius.circular(5.0),
          //       ),
          //       horizontalScrollbarStyle: const ScrollbarStyle(
          //         thumbColor: Colors.white,
          //         isAlwaysShown: true,
          //         thickness: 4.0,
          //         radius: Radius.circular(5.0),
          //       ),
          //       enablePullToRefresh: false,
          //       refreshIndicator: const WaterDropHeader(),
          //       refreshIndicatorHeight: 60,
          //       onRefresh: () async {
          //         //Do sth
          //         await Future.delayed(const Duration(milliseconds: 500));
          //         _htdRefreshController?.refreshCompleted();
          //       },

          //       // enablePullToLoadNewData: true,
          //       // loadIndicator: const ClassicFooter(),
          //       // onLoad: () async {
          //       //   //Do sth
          //       //   await Future.delayed(const Duration(milliseconds: 500));
          //       //   _htdRefreshController!.loadComplete();
          //       // },
          //       htdRefreshController: _htdRefreshController,
          //     ),
          //   ),
          //   height: MediaQuery.of(context).size.height,
          // );
        }
      },
      viewModelBuilder: () => MaintenanceTabViewModel(widget.summaryData),
    );
  }

  List<Widget> _getTitleWidget() {
    return [
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
      // InsiteTextWithPadding(
      //   padding: EdgeInsets.all(8),
      //   text: "Service Interval",
      //   size: 12,
      // ),
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
      // InsiteTextWithPadding(
      //   padding: EdgeInsets.all(8),
      //   text: "Service Type",
      //   size: 12,
      // ),
    ];
  }

  Widget _generateFirstColumnRow(BuildContext context, int index) {
    Services? services = model!.services[index];
    return Padding(
      padding: const EdgeInsets.all(7.0),
      child: InsiteRichText(
        content: services!.serviceName,
        // onTap: () {
        //   // serviceName!.clear();

        //   widget.serviceCalBack!(
        //       services.serviceId, model!.assetDataValue!, model!.services);
        // },
        title: " ",
      ),
    );
  }

  Widget _generateRightHandSideColumnRow(BuildContext context, int index) {
    Services? services = model!.services[index];
    return Row(
      children: [
        InsiteButton(
          title: services!.dueInfo!.serviceStatus,
          padding: EdgeInsets.all(8),
          margin: EdgeInsets.all(8),
          bgColor: Utils.getFaultColor("fault.severityLabel"),
          height: 30,
          width: 60,
        ),
        // InsiteTextWithPadding(
        //   padding: EdgeInsets.symmetric(vertical: 8, horizontal: 30),
        //   text: services.nextOccurrence?.toStringAsFixed(0),
        //   size: 12,
        // ),
        InsiteTextWithPadding(
          padding: EdgeInsets.symmetric(vertical: 8, horizontal: 30),
          text: services.dueInfo!.dueAt!.toStringAsFixed(0),
          size: 12,
        ),
        InsiteTextWithPadding(
          padding: EdgeInsets.symmetric(vertical: 8, horizontal: 30),
          text: services.dueInfo!.dueBy!.abs().toStringAsFixed(0),
          size: 12,
        ),
        InsiteTextWithPadding(
          padding: EdgeInsets.symmetric(vertical: 8, horizontal: 30),
          text: Utils.getLastReportedDateOneUTC(services.dueInfo!.dueDate),
          size: 12,
        ),
        // InsiteTextWithPadding(
        //   padding: EdgeInsets.symmetric(vertical: 8, horizontal: 30),
        //   text: services.serviceType,
        //   size: 12,
        // ),
      ],
    );
  }
}

class MaintenanceTabListData extends StatelessWidget {
  final List<Services?>? servicesData;
  final AssetData? assetData;
  final Function(int? value, AssetData? assetDataValue,
      List<Services?>? serviceNames, String? service)? serviceCalBack;
  MaintenanceTabListData(
      {this.servicesData, this.serviceCalBack, this.assetData});

  @override
  Widget build(BuildContext context) {
    return  servicesData == null||servicesData!.isEmpty 
        ? Expanded(
            child: EmptyView(
              title: "No service pending or overdue at this time",
            ),
          )
        : Expanded(
            child: ListView.builder(
              itemCount: servicesData!.length,
              itemBuilder: (BuildContext context, int i) {
                Services? services = servicesData![i];
                return Card(
                  child: Container(
                    padding: EdgeInsets.all(2),
                    child: Column(
                      children: [
                        Table(
                          border: TableBorder.all(),
                          columnWidths: {
                            0: FlexColumnWidth(1.5),
                            1: FlexColumnWidth(1.5),
                          },
                          children: [
                            TableRow(
                              children: [
                                InsiteRichText(
                                  title: "Service :",
                                  content: services!.serviceName,
                                  onTap: () {
                                    // serviceName!.clear();

                                    serviceCalBack!(
                                        services.serviceId,
                                        assetData,
                                        servicesData,
                                        services.serviceName);
                                  },
                                ),
                                InsiteTableRowItemWithButton(
                                  title: "Service Status : ",
                                  buttonColor: Utils.getMaintenanceColor(
                                      services.dueInfo!.serviceStatus),
                                  content:
                                      services.dueInfo!.serviceStatus != null
                                          ? Utils.getFaultLabel(
                                              services.dueInfo!.serviceStatus!)
                                          : "",
                                  onTap: () {
                                    serviceCalBack!(
                                        services.serviceId,
                                        assetData,
                                        servicesData,
                                        services.serviceName);
                                  },
                                ),
                              ],
                            ),
                            TableRow(children: [
                              InsiteTableRowItem(
                                title: "Due At : ",
                                content: services.dueInfo!.dueAt!
                                        .toStringAsFixed(0) +
                                    " hrs",
                              ),
                              InsiteTableRowItem(
                                title: "Due In/Overdue By : ",
                                content: services.dueInfo!.dueBy!
                                        .abs()
                                        .toStringAsFixed(0) +
                                    " hrs",
                              ),
                            ]),
                          ],
                        ),
                        Table(
                          border: TableBorder.all(),
                          children: [
                            TableRow(children: [
                              InsiteTableRowItem(
                                title: "Due Date : ",
                                content: Utils.getDateInFormatddMMyyyy(
                                    services.dueInfo!.dueDate),
                              ),

                              // InsiteTableRowItem(
                              //   title: "Service Name : ",
                              //   content: services.se,
                              // ),
                            ])
                          ],
                        )
                      ],
                    ),
                  ),
                );
              },
            ),
          );
  }
}

class HistoryListData extends StatelessWidget {
  final List<MaintenanceList>? listData;
  HistoryListData({this.listData});
  @override
  Widget build(BuildContext context) {
    return listData!.isEmpty || listData == null
        ? Expanded(
            child: EmptyView(
              title: "No service history available to date",
            ),
          )
        : Expanded(
            child: ListView.builder(
              itemCount: listData!.length,
              itemBuilder: (BuildContext context, int index) {
                var data = listData![index];
                return Card(
                    child: InsiteExpansionTile(
                  title: Table(
                    columnWidths: {
                      0: FlexColumnWidth(3),
                      1: FlexColumnWidth(2),
                      2: FlexColumnWidth(1.5),
                    },
                    border: TableBorder.all(
                        width: 1,
                        color: Theme.of(context).textTheme.bodyText1!.color!),
                    children: [
                      TableRow(children: [
                        InsiteTableRowItemWithImage(
                          title: "Serial No :-" + "\n" + data.serialNumber!,
                          path: Utils().getImageWithAssetIconKey(
                              assetIconKey: data.assetIcon, model: data.model),
                        ),
                        InsiteTableRowItem(
                          content: data.model,
                          title: "Model",
                        ),
                      ]),
                      TableRow(children: [
                        InsiteTableRowItem(
                          content: data.productFamily,
                          title: "Product Family",
                        ),
                        InsiteTableRowItem(
                          content: data.serviceMeter,
                          title: "Service Meter",
                        ),
                        // InsiteTableRowItem(
                        //   content: data.serviceName,
                        //   title: "Service",
                        // ),
                      ]),
                    ],
                  ),
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 15.0),
                      child: Table(
                        columnWidths: {
                          0: FlexColumnWidth(1),
                          1: FlexColumnWidth(1),
                          2: FlexColumnWidth(1),
                        },
                        border: TableBorder.all(
                            width: 1,
                            color:
                                Theme.of(context).textTheme.bodyText1!.color!),
                        children: [
                          TableRow(children: [
                            InsiteTableRowItem(
                              content: data.currentHourMeter,
                              title: "Hour Meter",
                            ),
                            InsiteTableRowItem(
                              content: Utils.getDateInFormatddMMyyyy(
                                  data.serviceDate),
                              title: "Service Completion Date",
                            ),
                            InsiteTableRowItem(
                              content: data.performedBy,
                              title: "Service Performed By",
                            ),
                          ]),
                          TableRow(children: [
                            InsiteTableRowItem(
                              content: data.workOrder ?? "-",
                              title: "Work Order",
                            ),
                            InsiteTableRowItem(
                              content: data.serviceNotes,
                              title: "Service Notes",
                            ),
                            InsiteTableRowItem(
                              content: data.completedService,
                              title: "Service Completed Status",
                            ),
                          ]),
                        ],
                      ),
                    )
                  ],
                ));
              },
            ),
          );
  }
}
