import 'package:flutter/material.dart';
import 'package:insite/core/models/asset_detail.dart';
import 'package:insite/core/models/single_asset_utilization.dart';
import 'package:insite/theme/colors.dart';
import 'package:insite/utils/enums.dart';
import 'package:insite/utils/helper_methods.dart';
import 'package:insite/views/detail/tabs/utilization/tabs/graph/single_asset_utilization_graph_view_model.dart';
import 'package:insite/views/date_range/date_range_view.dart';
import 'package:insite/widgets/smart_widgets/idle_working_graph.dart';
import 'package:insite/widgets/smart_widgets/percentage_widget.dart';
import 'package:insite/widgets/smart_widgets/range_selection_widget.dart';
import 'package:stacked/stacked.dart';
import 'package:intl/intl.dart';

class SingleAssetUtilizationGraphView extends StatefulWidget {
  final AssetDetail detail;

  SingleAssetUtilizationGraphView({Key key, this.detail}) : super(key: key);

  @override
  _SingleAssetUtilizationGraphViewState createState() =>
      _SingleAssetUtilizationGraphViewState();
}

class _SingleAssetUtilizationGraphViewState
    extends State<SingleAssetUtilizationGraphView> {
  bool isListSelected = true;
  String dropdownValue = 'Idle Time - Idle %';
  SingleAssetUtilizationGraphType selectedGraph =
      SingleAssetUtilizationGraphType.IDLETIMEIDLEPERCENTAGE;
  int rangeChoice = 1;
  String startDate;
  String endDate;
  List<DateTime> dateRange = [];
  bool isRangeSelectionVisible = true;
  List<String> dropDownValues = [
    'Idle Time - Idle %',
    'Runtime - Performance %',
    'Runtime Hours',
    'Distance Traveled (KMs)'
  ];

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<SingleAssetUtilizationGraphViewModel>.reactive(
      builder: (BuildContext context,
          SingleAssetUtilizationGraphViewModel viewModel, Widget _) {
        if (viewModel.loading)
          return Center(child: CircularProgressIndicator());

        return Stack(
          children: [
            Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      Utils.getDateInFormatddMMyyyy(viewModel.startDate) +
                          " - " +
                          Utils.getDateInFormatddMMyyyy(viewModel.endDate),
                      style: TextStyle(
                          color: white,
                          fontWeight: FontWeight.bold,
                          fontSize: 11),
                    ),
                    SizedBox(
                      width: 4,
                    ),
                    Padding(
                      padding: const EdgeInsets.all(12.0),
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
                  ],
                ),
                Row(
                  children: [
                    Padding(
                      padding: EdgeInsets.only(left: 16.0),
                      child: Container(
                        decoration: BoxDecoration(
                          color: cardcolor,
                          borderRadius: BorderRadius.all(Radius.circular(16)),
                        ),
                        child: Padding(
                          padding: EdgeInsets.all(6.0),
                          child: Container(
                            decoration: BoxDecoration(
                              color: cardcolor,
                              border: Border.all(color: black, width: 0.0),
                              borderRadius:
                                  BorderRadius.all(Radius.circular(16)),
                            ),
                            child: Padding(
                              padding: EdgeInsets.symmetric(horizontal: 16),
                              child: DropdownButton(
                                value: dropdownValue,
                                dropdownColor: cardcolor,
                                icon: Icon(
                                  Icons.keyboard_arrow_down,
                                  color: white,
                                ),
                                iconSize: 20,
                                elevation: 16,
                                style: TextStyle(color: white, fontSize: 12),
                                underline: Container(
                                  height: 0,
                                ),
                                onChanged: (String newValue) {
                                  setState(() {
                                    dropdownValue = newValue;
                                    switch (dropDownValues.indexOf(newValue)) {
                                      case 0:
                                        selectedGraph =
                                            SingleAssetUtilizationGraphType
                                                .IDLETIMEIDLEPERCENTAGE;
                                        break;
                                      case 1:
                                        selectedGraph =
                                            SingleAssetUtilizationGraphType
                                                .RUNTIMEPERFORMANCEPERCENT;
                                        break;
                                      case 2:
                                        selectedGraph =
                                            SingleAssetUtilizationGraphType
                                                .RUNTIMEHOURS;
                                        break;
                                      case 3:
                                        selectedGraph =
                                            SingleAssetUtilizationGraphType
                                                .DISTANCETRAVELED;
                                        break;
                                      default:
                                        break;
                                    }
                                    (selectedGraph ==
                                            SingleAssetUtilizationGraphType
                                                .RUNTIMEPERFORMANCEPERCENT)
                                        ? isRangeSelectionVisible = false
                                        : isRangeSelectionVisible = true;
                                  });
                                },
                                items: dropDownValues
                                    .map<DropdownMenuItem<String>>(
                                        (String value) {
                                  return DropdownMenuItem<String>(
                                    value: value,
                                    child: Text(
                                      value,
                                    ),
                                  );
                                }).toList(),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                    Spacer(),
                    isRangeSelectionVisible
                        ? RangeSelectionWidget(
                            label1: 'Day',
                            label2: 'Week',
                            label3: 'Month',
                            rangeChoice: (int choice) {
                              setState(() {
                                rangeChoice = choice;
                              });
                            },
                          )
                        : Container(),
                    Spacer(),
                  ],
                ),
                selectedGraph == SingleAssetUtilizationGraphType.RUNTIMEHOURS
                    ? Padding(
                        padding: EdgeInsets.only(top: 20, left: 100),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Text(
                              'Idle',
                              style: TextStyle(
                                color: white,
                                fontSize: 15,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            Text(
                              'Working',
                              style: TextStyle(
                                color: white,
                                fontSize: 15,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                      )
                    : Container(),
                Flexible(
                  child: ListView.builder(
                    itemCount: getCount(viewModel.singleAssetUtilization),
                    itemBuilder: (BuildContext context, int index) {
                      if (selectedGraph ==
                          SingleAssetUtilizationGraphType
                              .IDLETIMEIDLEPERCENTAGE)
                        return PercentageWidget(
                            color: sandyBrown,
                            isTwoLineLabel: true,
                            label: rangeChoice == 1
                                ? '${DateFormat('dd/MM/yy').format(viewModel.singleAssetUtilization.daily[index].startDate)}\n${DateFormat('h:mm a').format(viewModel.singleAssetUtilization.daily[index].data.lastReportedTime)}'
                                : rangeChoice == 2
                                    ? '${DateFormat('dd/MM/yy').format(viewModel.singleAssetUtilization.weekly[index].startDate)}\n${DateFormat('dd/MM/yy').format(viewModel.singleAssetUtilization.weekly[index].endDate)}'
                                    : '${DateFormat('dd/MM/yy').format(viewModel.singleAssetUtilization.monthly[index].startDate)}\n${DateFormat('dd/MM/yy').format(viewModel.singleAssetUtilization.monthly[index].endDate)}',
                            percentage: rangeChoice == 1
                                ? getValues(
                                    viewModel.singleAssetUtilization
                                        .daily[index].data.idleEfficiency,
                                    100,
                                    true)
                                : rangeChoice == 2
                                    ? getValues(
                                        viewModel.singleAssetUtilization
                                            .weekly[index].data.idleEfficiency,
                                        100,
                                        true)
                                    : getValues(
                                        viewModel.singleAssetUtilization
                                            .monthly[index].data.idleEfficiency,
                                        100,
                                        true));
                      else if (selectedGraph ==
                          SingleAssetUtilizationGraphType
                              .RUNTIMEPERFORMANCEPERCENT)
                        return PercentageWidget(
                          color: bermudaGrey,
                          label:
                              '${DateFormat('dd/MM/yy').format(viewModel.singleAssetUtilization.daily[index].startDate)}',
                          percentage: viewModel
                                      .singleAssetUtilization
                                      .daily[index]
                                      .data
                                      .targetRuntimePerformance ==
                                  null
                              ? null
                              : viewModel.singleAssetUtilization.daily[index]
                                              .data.targetRuntimePerformance *
                                          100 >
                                      100
                                  ? 100
                                  : viewModel
                                          .singleAssetUtilization
                                          .daily[index]
                                          .data
                                          .targetRuntimePerformance *
                                      100,
                          value: viewModel.singleAssetUtilization.daily[index]
                                      .data.targetRuntimePerformance ==
                                  null
                              ? ""
                              : viewModel.singleAssetUtilization.daily[index]
                                              .data.targetRuntimePerformance *
                                          100 >
                                      100
                                  ? (viewModel
                                                  .singleAssetUtilization
                                                  .daily[index]
                                                  .data
                                                  .targetRuntimePerformance *
                                              100)
                                          .toStringAsFixed(1) +
                                      "%"
                                  : null,
                        );
                      else if (selectedGraph ==
                          SingleAssetUtilizationGraphType.RUNTIMEHOURS)
                        return IdleWorkingGraphWidget(
                          idleLength: rangeChoice == 1
                              ? viewModel.singleAssetUtilization.daily[index]
                                          .data.idleHours !=
                                      null
                                  ? viewModel.singleAssetUtilization
                                      .daily[index].data.idleHours
                                  : 0
                              : rangeChoice == 2
                                  ? viewModel.singleAssetUtilization
                                              .weekly[index].data.idleHours !=
                                          null
                                      ? viewModel.singleAssetUtilization
                                          .weekly[index].data.idleHours
                                      : 0
                                  : viewModel.singleAssetUtilization
                                              .monthly[index].data.idleHours !=
                                          null
                                      ? viewModel.singleAssetUtilization
                                          .monthly[index].data.idleHours
                                      : 0,
                          workingLength: rangeChoice == 1
                              ? viewModel.singleAssetUtilization.daily[index]
                                          .data.workingHours !=
                                      null
                                  ? viewModel.singleAssetUtilization
                                      .daily[index].data.workingHours
                                  : 0
                              : rangeChoice == 2
                                  ? viewModel
                                              .singleAssetUtilization
                                              .weekly[index]
                                              .data
                                              .workingHours !=
                                          null
                                      ? viewModel.singleAssetUtilization
                                          .weekly[index].data.workingHours
                                      : 0
                                  : viewModel
                                              .singleAssetUtilization
                                              .monthly[index]
                                              .data
                                              .workingHours !=
                                          null
                                      ? viewModel.singleAssetUtilization
                                          .monthly[index].data.workingHours
                                      : 0,
                          label: rangeChoice == 1
                              ? '${DateFormat('dd/MM/yy').format(viewModel.singleAssetUtilization.daily[index].startDate)}   \n${DateFormat('h:mm a').format(viewModel.singleAssetUtilization.daily[index].data.lastReportedTime)}'
                              : rangeChoice == 2
                                  ? '${DateFormat('dd/MM/yy').format(viewModel.singleAssetUtilization.weekly[index].startDate)}   \n${DateFormat('dd/MM/yy').format(viewModel.singleAssetUtilization.weekly[index].endDate)}'
                                  : '${DateFormat('dd/MM/yy').format(viewModel.singleAssetUtilization.monthly[index].startDate)}   \n${DateFormat('dd/MM/yy').format(viewModel.singleAssetUtilization.monthly[index].endDate)}',
                        );
                      else
                        return PercentageWidget(
                          isPercentage: false,
                          color: periwinkleGrey,
                          label: rangeChoice == 1
                              ? '${DateFormat('dd/MM/yy').format(viewModel.singleAssetUtilization.daily[index].startDate)}\n${DateFormat('h:mm a').format(viewModel.singleAssetUtilization.daily[index].data.lastReportedTime)}'
                              : rangeChoice == 2
                                  ? '${DateFormat('dd/MM/yy').format(viewModel.singleAssetUtilization.weekly[index].startDate)}\n${DateFormat('dd/MM/yy').format(viewModel.singleAssetUtilization.weekly[index].endDate)}'
                                  : '${DateFormat('dd/MM/yy').format(viewModel.singleAssetUtilization.monthly[index].startDate)}\n${DateFormat('dd/MM/yy').format(viewModel.singleAssetUtilization.monthly[index].endDate)}',
                          percentage: rangeChoice == 1
                              ? viewModel.singleAssetUtilization.daily[index]
                                          .data.distanceTravelledKilometers !=
                                      null
                                  ? ((viewModel
                                              .singleAssetUtilization
                                              .daily[index]
                                              .data
                                              .distanceTravelledKilometers) >
                                          100
                                      ? 100
                                      : (viewModel
                                          .singleAssetUtilization
                                          .daily[index]
                                          .data
                                          .distanceTravelledKilometers))
                                  : 0
                              : rangeChoice == 2
                                  ? viewModel
                                              .singleAssetUtilization
                                              .weekly[index]
                                              .data
                                              .distanceTravelledKilometers !=
                                          null
                                      ? ((viewModel
                                                  .singleAssetUtilization
                                                  .weekly[index]
                                                  .data
                                                  .distanceTravelledKilometers) >
                                              100
                                          ? 100
                                          : viewModel
                                              .singleAssetUtilization
                                              .weekly[index]
                                              .data
                                              .distanceTravelledKilometers)
                                      : 0
                                  : viewModel
                                              .singleAssetUtilization
                                              .monthly[index]
                                              .data
                                              .distanceTravelledKilometers !=
                                          null
                                      ? ((viewModel
                                                  .singleAssetUtilization
                                                  .monthly[index]
                                                  .data
                                                  .distanceTravelledKilometers) >
                                              100
                                          ? 100
                                          : viewModel
                                              .singleAssetUtilization
                                              .monthly[index]
                                              .data
                                              .distanceTravelledKilometers)
                                      : 0,
                          value: rangeChoice == 1
                              ? viewModel.singleAssetUtilization.daily[index].data.distanceTravelledKilometers !=
                                      null
                                  ? (viewModel
                                              .singleAssetUtilization
                                              .daily[index]
                                              .data
                                              .distanceTravelledKilometers) >
                                          100
                                      ? (viewModel
                                              .singleAssetUtilization
                                              .daily[index]
                                              .data
                                              .distanceTravelledKilometers)
                                          .toStringAsFixed(1)
                                      : null
                                  : 0
                              : rangeChoice == 2
                                  ? viewModel
                                              .singleAssetUtilization
                                              .weekly[index]
                                              .data
                                              .distanceTravelledKilometers !=
                                          null
                                      ? (viewModel
                                                  .singleAssetUtilization
                                                  .weekly[index]
                                                  .data
                                                  .distanceTravelledKilometers) >
                                              100
                                          ? viewModel
                                              .singleAssetUtilization
                                              .weekly[index]
                                              .data
                                              .distanceTravelledKilometers
                                              .toStringAsFixed(1)
                                          : null
                                      : 0
                                  : viewModel
                                              .singleAssetUtilization
                                              .monthly[index]
                                              .data
                                              .distanceTravelledKilometers !=
                                          null
                                      ? ((viewModel.singleAssetUtilization.monthly[index].data.distanceTravelledKilometers) > 100
                                          ? viewModel
                                              .singleAssetUtilization
                                              .monthly[index]
                                              .data
                                              .distanceTravelledKilometers
                                              .toStringAsFixed(1)
                                          : null)
                                      : null,
                        );
                    },
                  ),
                ),
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
      viewModelBuilder: () => SingleAssetUtilizationGraphViewModel(
        widget.detail,
      ),
    );
  }

  int getCount(SingleAssetUtilization data) {
    if (rangeChoice == 1)
      return data.daily.length;
    else if (rangeChoice == 2)
      return data.weekly.length;
    else
      return data.monthly.length;
  }

  double getValues(double value, int multiplyAmount, bool isNull) {
    return value == null
        ? isNull
            ? null
            : double.infinity
        : value * multiplyAmount;
  }
}
