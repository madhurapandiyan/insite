import 'package:flutter/material.dart';
import 'package:insite/theme/colors.dart';
import 'package:insite/views/utilization/graphs/cumulative/cumulative_view.dart';
import 'package:insite/views/utilization/graphs/distance_travelled/distance_travelled_view.dart';
import 'package:insite/views/utilization/graphs/fuel_burn_rate_trend/fuel_burn_rate_trend_view.dart';
import 'package:insite/views/utilization/graphs/idle_percent_trend/idle_percent_trend_view.dart';
import 'package:insite/views/utilization/graphs/idle_percent_working_percent/idle_percent_working_percent_view.dart';
import 'package:insite/views/utilization/graphs/runtime_hours/runtime_hours_view.dart';
import 'package:insite/views/utilization/graphs/total_fuel_burned/total_fuel_burned_view.dart';
import 'package:insite/views/utilization/graphs/total_hours/total_hours_view.dart';
import 'package:insite/views/utilization/utilization_view.dart';
import 'package:insite/views/date_range/date_range_view.dart';
import 'package:insite/widgets/smart_widgets/util_graph_dropdown.dart';
import 'package:intl/intl.dart';
import 'package:logger/logger.dart';

class UtilizationGraphView extends StatefulWidget {
  const UtilizationGraphView({
    Key key,
  }) : super(key: key);

  @override
  _UtilizationGraphViewState createState() => _UtilizationGraphViewState();
}

class _UtilizationGraphViewState extends State<UtilizationGraphView> {
  UtilizationGraphType graphType = UtilizationGraphType.IDLEORWORKING;
  List<DateTime> dateRange = [];
  String startDate = DateFormat('MM/dd/yyyy')
      .format(DateTime.now().subtract(Duration(days: DateTime.now().weekday)));
  String endDate = DateFormat('MM/dd/yyyy').format(DateTime.now());

  final GlobalKey<IdlePercentWorkingPercentViewState> idlePercentKey =
      new GlobalKey();
  final GlobalKey<RuntimeHoursViewState> runTimeHoursKey = new GlobalKey();
  final GlobalKey<DistanceTravelledViewState> distanceTravelledKey =
      new GlobalKey();
  final GlobalKey<CumulativeViewState> cumulativeKey = new GlobalKey();
  final GlobalKey<TotalHoursViewState> totalHoursKey = new GlobalKey();
  final GlobalKey<TotalFuelBurnedViewState> totalFuelBurnedKey =
      new GlobalKey();
  final GlobalKey<IdlePercentTrendViewState> idleTrendKey = new GlobalKey();
  final GlobalKey<FuelBurnRateTrendViewState> fuelBurnTrendKey =
      new GlobalKey();

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Align(
          alignment: Alignment.centerRight,
          child: Padding(
            padding: const EdgeInsets.all(12.0),
            child: GestureDetector(
              onTap: () async {
                dateRange = [];
                dateRange = await showDialog(
                  context: context,
                  builder: (BuildContext context) => Dialog(
                      backgroundColor: transparent, child: DateRangeView()),
                );
                if (dateRange != null && dateRange.isNotEmpty) {
                  setState(() {
                    startDate =
                        DateFormat('yyyy-MM-dd').format(dateRange.first);
                    endDate = DateFormat('yyyy-MM-dd').format(dateRange.last);
                  });
                  Logger().d("start date " + startDate);
                  Logger().d("end date " + endDate);
                  onDateChange();
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
        Padding(
          padding: EdgeInsets.all(16.0),
          child: Text(
            'Runtime Hours / Working Hours / Idle Hours: Value includes data occurring outside of selected date range.',
            style: TextStyle(
              color: white,
              fontSize: 12,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        Container(
          width: MediaQuery.of(context).size.width * 1,
          margin: const EdgeInsets.only(left: 12.0, right: 12),
          decoration: BoxDecoration(
            color: cardcolor,
            borderRadius: BorderRadius.all(Radius.circular(8)),
          ),
          child: Padding(
            padding: EdgeInsets.all(6.0),
            child: Container(
              width: MediaQuery.of(context).size.width * 0.75,
              decoration: BoxDecoration(
                color: cardcolor,
                border: Border.all(color: black, width: 0.0),
                borderRadius: BorderRadius.all(Radius.circular(8)),
              ),
              child: Padding(
                padding: EdgeInsets.symmetric(vertical: 4.0, horizontal: 16),
                child: Center(
                  child: Container(
                    width: MediaQuery.of(context).size.width * 0.8,
                    child: UtilGraphDropdownWidget(
                      graphType: (UtilizationGraphType selectedGraph) {
                        setState(() {
                          graphType = selectedGraph;
                        });
                      },
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
        Flexible(
          child: Padding(
            padding: EdgeInsets.symmetric(vertical: 8),
            child: getGraphView(graphType, startDate, endDate),
          ),
        ),
      ],
    );
  }

  onDateChange() {
    if (graphType == UtilizationGraphType.IDLEORWORKING) {
      idlePercentKey.currentState.refresh();
    } else if (graphType == UtilizationGraphType.RUNTIMEHOURS) {
      runTimeHoursKey.currentState.refresh();
    } else if (graphType == UtilizationGraphType.DISTANCETRAVELLED) {
      distanceTravelledKey.currentState.refresh();
    } else if (graphType == UtilizationGraphType.CUMULATIVE) {
      cumulativeKey.currentState.refresh();
    } else if (graphType == UtilizationGraphType.TOTALHOURS) {
      totalHoursKey.currentState.refresh();
    } else if (graphType == UtilizationGraphType.TOTALFUELBURNED) {
      totalFuelBurnedKey.currentState.refresh();
    } else if (graphType == UtilizationGraphType.IDLETREND) {
      idleTrendKey.currentState.refresh();
    } else if (graphType == UtilizationGraphType.FUELBURNRATETREND) {
      fuelBurnTrendKey.currentState.refresh();
    }
  }

  Widget getGraphView(
      UtilizationGraphType utilizationGraphType, startDate, endDate) {
    switch (utilizationGraphType) {
      case UtilizationGraphType.IDLEORWORKING:
        return IdlePercentWorkingPercentView(
          key: idlePercentKey,
        );
        break;
      case UtilizationGraphType.RUNTIMEHOURS:
        return RuntimeHoursView(
          key: runTimeHoursKey,
        );
        break;
      case UtilizationGraphType.DISTANCETRAVELLED:
        return DistanceTravelledView(
          key: distanceTravelledKey,
        );
        break;
      case UtilizationGraphType.CUMULATIVE:
        return CumulativeView(
          key: cumulativeKey,
        );
        break;
      case UtilizationGraphType.TOTALHOURS:
        return TotalHoursView(
          key: totalHoursKey,
        );
        break;
      case UtilizationGraphType.TOTALFUELBURNED:
        return TotalFuelBurnedView(
          key: totalFuelBurnedKey,
        );
        break;
      case UtilizationGraphType.IDLETREND:
        return IdlePercentTrendView(
          key: idlePercentKey,
        );
        break;
      case UtilizationGraphType.FUELBURNRATETREND:
        return FuelBurnRateTrendView(
          key: fuelBurnTrendKey,
        );
        break;
      default:
        return Container();
        break;
    }
  }
}
