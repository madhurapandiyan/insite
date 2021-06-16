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
import 'package:insite/widgets/smart_widgets/date_range.dart';
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
  int rangeChoice = 1;
  bool isRangeSelectionVisible = false;
  List<DateTime> dateRange = [];
  String startDate = DateFormat('MM/dd/yyyy')
      .format(DateTime.now().subtract(Duration(days: DateTime.now().weekday)));
  String endDate = DateFormat('MM/dd/yyyy').format(DateTime.now());

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
                      backgroundColor: transparent, child: DateRangeWidget()),
                );
                if (dateRange != null && dateRange.isNotEmpty) {
                  setState(() {
                    startDate =
                        DateFormat('MM/dd/yyyy').format(dateRange.first);
                    endDate = DateFormat('MM/dd/yyyy').format(dateRange.last);
                  });
                  Logger().d("start date " + startDate);
                  Logger().d("end date " + endDate);
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
          width: MediaQuery.of(context).size.width * 0.9,
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
            child: getGraphView(rangeChoice, graphType, startDate, endDate),
          ),
        ),
      ],
    );
  }

  Widget getGraphView(int rangeChoice,
      UtilizationGraphType utilizationGraphType, startDate, endDate) {
    switch (utilizationGraphType) {
      case UtilizationGraphType.IDLEORWORKING:
        return IdlePercentWorkingPercentView(
          startDate: startDate,
          endDate: endDate,
        );
        break;
      case UtilizationGraphType.RUNTIMEHOURS:
        return RuntimeHoursView(
          startDate: startDate,
          endDate: endDate,
        );
        break;
      case UtilizationGraphType.DISTANCETRAVELLED:
        return DistanceTravelledView(
          startDate: startDate,
          endDate: endDate,
        );
        break;
      case UtilizationGraphType.CUMULATIVE:
        return CumulativeView(
          startDate: startDate,
          endDate: endDate,
        );
        break;
      case UtilizationGraphType.TOTALHOURS:
        return TotalHoursView(
          startDate: startDate,
          endDate: endDate,
        );
        break;
      case UtilizationGraphType.TOTALFUELBURNED:
        return TotalFuelBurnedView(
          startDate: startDate,
          endDate: endDate,
        );
        break;
      case UtilizationGraphType.IDLETREND:
        return IdlePercentTrendView(
          startDate: startDate,
          endDate: endDate,
        );
        break;
      case UtilizationGraphType.FUELBURNRATETREND:
        return FuelBurnRateTrendView(
          startDate: startDate,
          endDate: endDate,
        );
        break;
      default:
        return Container();
        break;
    }
  }
}
