import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:insite/core/models/filter_data.dart';
import 'package:insite/core/models/utilization_summary.dart';
import 'package:insite/theme/colors.dart';
import 'package:insite/utils/date.dart';
import 'package:insite/utils/enums.dart';
import 'package:insite/utils/helper_methods.dart';
import 'package:insite/widgets/dumb_widgets/bar_chart.dart';
import 'package:insite/widgets/dumb_widgets/bar_wdiget.dart';
import 'package:insite/widgets/dumb_widgets/insite_text.dart';
import 'package:insite/widgets/dumb_widgets/toggle_button.dart';
import 'package:insite/widgets/dumb_widgets/utilization_legends.dart';
import 'package:logger/logger.dart';

class AssetUtilizationWidget extends StatefulWidget {
  final UtilizationSummary assetUtilization;
  final double totalGreatestNumber;
  final double averageGreatestNumber;
  final bool isLoading;
  final bool isRefreshing;
  final Function(FilterData) onFilterSelected;

  @override
  _AssetUtilizationWidgetState createState() => _AssetUtilizationWidgetState();

  const AssetUtilizationWidget(
      {Key key,
      @required this.assetUtilization,
      @required this.totalGreatestNumber,
      @required this.averageGreatestNumber,
      @required this.isLoading,
      this.onFilterSelected,
      this.isRefreshing})
      : super(key: key);
}

class _AssetUtilizationWidgetState extends State<AssetUtilizationWidget> {
  bool isAverageButtonSelected = true;
  List<bool> shouldShowLabel = [true, true, true];
  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height * 0.4,
      margin: EdgeInsets.symmetric(horizontal: 8),
      decoration: BoxDecoration(
        color: Theme.of(context).backgroundColor,
        borderRadius: BorderRadius.circular(10.0),
        boxShadow: [new BoxShadow(blurRadius: 1.0, color: cardcolor)],
        border:
            Border.all(width: 1.5, color: Theme.of(context).backgroundColor),
        shape: BoxShape.rectangle,
      ),
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 16),
            child: Row(
              children: [
                // Icon(
                //   Icons.keyboard_arrow_down,
                //   color: white,
                // ),
                SizedBox(
                  width: 10,
                ),
                InsiteText(
                    text: 'Asset Utilization'.toUpperCase(),
                    fontWeight: FontWeight.bold,
                    size: 15),
                Expanded(
                  child: Container(),
                ),
                // Icon(
                //   Icons.more_vert,
                //   color: white,
                // ),
              ],
            ),
          ),
          Padding(
            padding: EdgeInsets.only(bottom: 10),
            child: Divider(
              color: shark,
              thickness: 1,
            ),
          ),
          (widget.isLoading || widget.isRefreshing)
              ? Expanded(
                  child: Center(
                    child: CircularProgressIndicator(),
                  ),
                )
              : Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16.0),
                      child: Row(
                        children: [
                          ToggleButton(
                              label1: 'average',
                              label2: 'total',
                              optionSelected: (bool value) {
                                setState(() {
                                  isAverageButtonSelected = value;
                                });
                              }),
                          Expanded(
                            child: UtilizationLegends(
                              label1: 'Working',
                              label2: 'Idle',
                              label3: 'Running',
                              color1: emerald,
                              color2: burntSienna,
                              color3: creamCan,
                              shouldShowLabel: (List<bool> value) {
                                setState(() {
                                  shouldShowLabel = value;
                                });
                              },
                            ),
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(top: 20),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          isAverageButtonSelected
                              ? BarChartWidget(
                                  title: 'Today',
                                  averageGreatestNumber:
                                      widget.averageGreatestNumber,
                                  isAverageButtonSelected:
                                      isAverageButtonSelected,
                                  totalGreatestNumber:
                                      widget.totalGreatestNumber,
                                  shouldShowLabel: shouldShowLabel,
                                  workingValue: Utils.checkNull(widget
                                      .assetUtilization
                                      .averageDay
                                      .workingHours),
                                  onTap: () {
                                    onFilterSelected(DateRangeType.today);
                                  },
                                  idleValue: Utils.checkNull(widget
                                      .assetUtilization.averageDay.idleHours),
                                  runningValue: Utils.checkNull(widget
                                      .assetUtilization
                                      .averageDay
                                      .runtimeHours))
                              : BarChartWidget(
                                  title: 'Today',
                                  onTap: () {
                                    onFilterSelected(DateRangeType.today);
                                  },
                                  averageGreatestNumber:
                                      widget.averageGreatestNumber,
                                  isAverageButtonSelected:
                                      isAverageButtonSelected,
                                  totalGreatestNumber:
                                      widget.totalGreatestNumber,
                                  shouldShowLabel: shouldShowLabel,
                                  workingValue: Utils.checkNull(widget
                                      .assetUtilization.totalDay.workingHours),
                                  idleValue: Utils.checkNull(widget
                                      .assetUtilization.totalDay.idleHours),
                                  runningValue: Utils.checkNull(widget.assetUtilization.totalDay.runtimeHours)),
                          isAverageButtonSelected
                              ? BarChartWidget(
                                  title: 'Current Week',
                                  onTap: () {
                                    onFilterSelected(DateRangeType.currentWeek);
                                  },
                                  averageGreatestNumber:
                                      widget.averageGreatestNumber,
                                  isAverageButtonSelected:
                                      isAverageButtonSelected,
                                  totalGreatestNumber:
                                      widget.totalGreatestNumber,
                                  shouldShowLabel: shouldShowLabel,
                                  workingValue: Utils.checkNull(widget
                                      .assetUtilization
                                      .averageWeek
                                      .workingHours),
                                  idleValue: Utils.checkNull(widget
                                      .assetUtilization.averageWeek.idleHours),
                                  runningValue: Utils.checkNull(widget
                                      .assetUtilization
                                      .averageWeek
                                      .runtimeHours))
                              : BarChartWidget(
                                  title: 'Current Week',
                                  onTap: () {
                                    onFilterSelected(DateRangeType.currentWeek);
                                  },
                                  averageGreatestNumber:
                                      widget.averageGreatestNumber,
                                  isAverageButtonSelected:
                                      isAverageButtonSelected,
                                  totalGreatestNumber:
                                      widget.totalGreatestNumber,
                                  shouldShowLabel: shouldShowLabel,
                                  workingValue: Utils.checkNull(widget
                                      .assetUtilization.totalWeek.workingHours),
                                  idleValue: Utils.checkNull(
                                      widget.assetUtilization.totalWeek.idleHours),
                                  runningValue: Utils.checkNull(widget.assetUtilization.totalWeek.runtimeHours)),
                          isAverageButtonSelected
                              ? BarChartWidget(
                                  title: 'Current Month',
                                  onTap: () {
                                    onFilterSelected(
                                        DateRangeType.currentMonth);
                                  },
                                  averageGreatestNumber:
                                      widget.averageGreatestNumber,
                                  isAverageButtonSelected:
                                      isAverageButtonSelected,
                                  totalGreatestNumber:
                                      widget.totalGreatestNumber,
                                  shouldShowLabel: shouldShowLabel,
                                  workingValue: Utils.checkNull(widget
                                      .assetUtilization
                                      .averageMonth
                                      .workingHours),
                                  idleValue: Utils.checkNull(widget
                                      .assetUtilization.averageMonth.idleHours),
                                  runningValue: Utils.checkNull(widget
                                      .assetUtilization
                                      .averageMonth
                                      .runtimeHours))
                              : BarChartWidget(
                                  title: 'Current Month',
                                  onTap: () {
                                    onFilterSelected(
                                        DateRangeType.currentMonth);
                                  },
                                  averageGreatestNumber:
                                      widget.averageGreatestNumber,
                                  isAverageButtonSelected:
                                      isAverageButtonSelected,
                                  totalGreatestNumber:
                                      widget.totalGreatestNumber,
                                  shouldShowLabel: shouldShowLabel,
                                  workingValue: Utils.checkNull(widget
                                      .assetUtilization
                                      .totalMonth
                                      .workingHours),
                                  idleValue: Utils.checkNull(widget
                                      .assetUtilization.totalMonth.idleHours),
                                  runningValue: Utils.checkNull(widget
                                      .assetUtilization
                                      .totalMonth
                                      .runtimeHours),
                                )
                        ],
                      ),
                    ),
                  ],
                ),
        ],
      ),
    );
  }

  onFilterSelected(DateRangeType dateRangeType) {
    Logger().d(
        "on asset utilization filter selected ${describeEnum(dateRangeType)}");
    DateTime fromDate, toDate;
    fromDate = DateUtil.calcFromDate(dateRangeType);
    toDate = DateTime.now();
    Logger().d("from date ${fromDate} to date ${toDate}");
    FilterData data = FilterData(
        title: "Date Range",
        count: describeEnum(dateRangeType),
        extras: [
          '${fromDate.year}-${fromDate.month}-${fromDate.day}',
          '${toDate.year}-${toDate.month}-${toDate.day}',
          describeEnum(dateRangeType)
        ],
        isSelected: true,
        type: FilterType.DATE_RANGE);
    widget.onFilterSelected(data);
  }

  Container barChart(String title, double workingValue, double idleValue,
          double runningValue) =>
      Container(
        width: MediaQuery.of(context).size.width * 0.25,
        height: MediaQuery.of(context).size.height * 0.21,
        decoration: BoxDecoration(
          color: ship_grey,
          borderRadius: BorderRadius.all(
            Radius.circular(8),
          ),
        ),
        child: Column(
          children: [
            Expanded(
              flex: 4,
              child: Container(
                decoration: BoxDecoration(
                  color: ship_grey,
                  borderRadius: BorderRadius.all(
                    Radius.circular(8),
                  ),
                ),
                child: Padding(
                  padding: EdgeInsets.symmetric(vertical: 8.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      shouldShowLabel[0]
                          ? BarWidget(
                              value: workingValue,
                              color: emerald,
                              averageGreatestNumber:
                                  widget.averageGreatestNumber,
                              isAverageButtonSelected: isAverageButtonSelected,
                              totalGreatestNumber: widget.totalGreatestNumber,
                            )
                          : SizedBox(),
                      shouldShowLabel[1]
                          ? BarWidget(
                              value: idleValue,
                              color: burntSienna,
                              averageGreatestNumber:
                                  widget.averageGreatestNumber,
                              isAverageButtonSelected: isAverageButtonSelected,
                              totalGreatestNumber: widget.totalGreatestNumber,
                            )
                          : SizedBox(),
                      shouldShowLabel[2]
                          ? BarWidget(
                              value: runningValue,
                              color: creamCan,
                              averageGreatestNumber:
                                  widget.averageGreatestNumber,
                              isAverageButtonSelected: isAverageButtonSelected,
                              totalGreatestNumber: widget.totalGreatestNumber,
                            )
                          : SizedBox(),
                    ],
                  ),
                ),
              ),
            ),
            Expanded(
              child: Container(
                width: MediaQuery.of(context).size.width * 0.25,
                decoration: BoxDecoration(
                  color: black,
                  borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(8),
                    bottomRight: Radius.circular(8),
                  ),
                ),
                child: Center(
                  child: Text(
                    title.toUpperCase(),
                    style: TextStyle(
                        color: white,
                        fontSize: 10,
                        fontWeight: FontWeight.bold),
                  ),
                ),
              ),
            ),
          ],
        ),
      );

  double calculatePercentage(double value) {
    return ((value / 18) * 10);
  }
}
