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
import 'package:insite/widgets/smart_widgets/util_graph_dropdown.dart';

class UtilizationGraphView extends StatefulWidget {
  final String startDate;
  final String endDate;
  const UtilizationGraphView({
    Key key,
    this.startDate,
    this.endDate,
  }) : super(key: key);

  @override
  _UtilizationGraphViewState createState() => _UtilizationGraphViewState();
}

class _UtilizationGraphViewState extends State<UtilizationGraphView> {
  UtilizationGraphType graphType = UtilizationGraphType.IDLEORWORKING;
  int rangeChoice = 1;
  bool isRangeSelectionVisible = false;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
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
            child: getGraphView(rangeChoice, graphType),
          ),
        ),
      ],
    );
  }

  Widget getGraphView(
    int rangeChoice,
    UtilizationGraphType utilizationGraphType,
  ) {
    switch (utilizationGraphType) {
      case UtilizationGraphType.IDLEORWORKING:
        return IdlePercentWorkingPercentView(
          startDate: widget.startDate,
          endDate: widget.endDate,
        );
        break;
      case UtilizationGraphType.RUNTIMEHOURS:
        return RuntimeHoursView(
          startDate: widget.startDate,
          endDate: widget.endDate,
        );
        break;
      case UtilizationGraphType.DISTANCETRAVELLED:
        return DistanceTravelledView(
          startDate: widget.startDate,
          endDate: widget.endDate,
        );
        break;
      case UtilizationGraphType.CUMULATIVE:
        return CumulativeView(
          startDate: widget.startDate,
          endDate: widget.endDate,
        );
        break;
      case UtilizationGraphType.TOTALHOURS:
        return TotalHoursView(
          startDate: widget.startDate,
          endDate: widget.endDate,
        );
        break;
      case UtilizationGraphType.TOTALFUELBURNED:
        return TotalFuelBurnedView(
          startDate: widget.startDate,
          endDate: widget.endDate,
        );
        break;
      case UtilizationGraphType.IDLETREND:
        return IdlePercentTrendView(
          startDate: widget.startDate,
          endDate: widget.endDate,
        );
        break;
      case UtilizationGraphType.FUELBURNRATETREND:
        return FuelBurnRateTrendView(
          startDate: widget.startDate,
          endDate: widget.endDate,
        );
        break;
      default:
        return Container();
        break;
    }
  }
}
