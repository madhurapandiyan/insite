import 'package:flutter/material.dart';
import 'package:insite/core/models/maintenance.dart';
import 'package:insite/core/models/maintenance_list_services.dart';
import 'package:insite/theme/colors.dart';
import 'package:insite/utils/helper_methods.dart';
import 'package:insite/widgets/dumb_widgets/insite_button.dart';
import 'package:insite/widgets/dumb_widgets/insite_progressbar.dart';
import 'package:insite/widgets/dumb_widgets/insite_text.dart';
import 'package:stacked/stacked.dart';
import 'maintenance_tab_view_model.dart';
import 'package:horizontal_data_table/horizontal_data_table.dart';

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
  HDTRefreshController? _htdRefreshController = HDTRefreshController();

  MaintenanceTabViewModel? model;

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<MaintenanceTabViewModel>.reactive(
      builder:
          (BuildContext context, MaintenanceTabViewModel viewModel, Widget? _) {
        model = viewModel;
        if (viewModel.loading) {
          return InsiteProgressBar();
        } else {
          return Container(
            color: cardcolor,
            child: Card(
              child: Expanded(
                child: HorizontalDataTable(
                  leftHandSideColumnWidth: 100,
                  rightHandSideColumnWidth: 700,
                  isFixedHeader: true,
                  headerWidgets: _getTitleWidget(),
                  leftSideItemBuilder: _generateFirstColumnRow,
                  rightSideItemBuilder: _generateRightHandSideColumnRow,
                  leftSideChildren: [],
                  rightSideChildren: [],
                  itemCount: viewModel.services.length,
                  rowSeparatorWidget: const Divider(
                    color: Colors.white,
                    height: 1.0,
                    thickness: 0.0,
                  ),
                  leftHandSideColBackgroundColor: cardcolor,
                  rightHandSideColBackgroundColor: cardcolor,
                  verticalScrollbarStyle: const ScrollbarStyle(
                    thumbColor: Colors.white,
                    isAlwaysShown: true,
                    thickness: 4.0,
                    radius: Radius.circular(5.0),
                  ),
                  horizontalScrollbarStyle: const ScrollbarStyle(
                    thumbColor: Colors.white,
                    isAlwaysShown: true,
                    thickness: 4.0,
                    radius: Radius.circular(5.0),
                  ),
                  enablePullToRefresh: true,
                  refreshIndicator: const WaterDropHeader(),
                  refreshIndicatorHeight: 60,
                  onRefresh: () async {
                    //Do sth
                    await Future.delayed(const Duration(milliseconds: 500));
                    _htdRefreshController?.refreshCompleted();
                  },

                  // enablePullToLoadNewData: true,
                  // loadIndicator: const ClassicFooter(),
                  // onLoad: () async {
                  //   //Do sth
                  //   await Future.delayed(const Duration(milliseconds: 500));
                  //   _htdRefreshController!.loadComplete();
                  // },
                  htdRefreshController: _htdRefreshController,
                ),
              ),
            ),
            height: MediaQuery.of(context).size.height,
          );
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
    ];
  }

  Widget _generateFirstColumnRow(BuildContext context, int index) {
    Services? services = model!.services[index];
    return Padding(
      padding: const EdgeInsets.all(7.0),
      child: InsiteRichText(
        content: services!.serviceName,
        onTap: () {
          // serviceName!.clear();

          widget.serviceCalBack!(
              services.serviceId, model!.assetDataValue!, model!.services);
        },
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
        InsiteTextWithPadding(
          padding: EdgeInsets.symmetric(vertical: 8, horizontal: 30),
          text: services.nextOccurrence!.toStringAsFixed(0),
          size: 12,
        ),
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
        InsiteTextWithPadding(
          padding: EdgeInsets.symmetric(vertical: 8, horizontal: 30),
          text: services.serviceType,
          size: 12,
        ),
      ],
    );
  }
}
