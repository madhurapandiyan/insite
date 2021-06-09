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
import 'package:insite/widgets/dumb_widgets/empty_view.dart';
import 'package:insite/widgets/dumb_widgets/utilization_legends.dart';
import 'package:insite/widgets/smart_widgets/cumulative_chart.dart';
import 'package:insite/widgets/smart_widgets/fuel_burn_rate_graph.dart';
import 'package:insite/widgets/smart_widgets/idle_trend_graph.dart';
import 'package:insite/widgets/smart_widgets/percentage_widget.dart';
import 'package:insite/widgets/smart_widgets/range_selection_widget.dart';
import 'package:insite/widgets/smart_widgets/total_fuel_burned_graph.dart';
import 'package:insite/widgets/smart_widgets/total_hours_chart.dart';
import 'package:insite/widgets/smart_widgets/util_graph_dropdown.dart';
import 'package:stacked/stacked.dart';
import 'utilization_graph_view_model.dart';

class UtilizationGraphView extends StatefulWidget {
  final List<DateTime> dateRange;
  const UtilizationGraphView({Key key, this.dateRange}) : super(key: key);

  @override
  _UtilizationGraphViewState createState() => _UtilizationGraphViewState();
}

class _UtilizationGraphViewState extends State<UtilizationGraphView> {
  UtilizationGraphType graphType = UtilizationGraphType.IDLEORWORKING;
  int rangeChoice = 1;
  bool isRangeSelectionVisible = false;
  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<UtilizationGraphViewModel>.reactive(
      builder: (BuildContext context, UtilizationGraphViewModel viewModel,
          Widget _) {
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
                    padding:
                        EdgeInsets.symmetric(vertical: 4.0, horizontal: 16),
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
            Padding(
              padding: EdgeInsets.all(16.0),
              child: Row(
                children: [
                  Align(
                    alignment: Alignment.centerLeft,
                    child: graphType == UtilizationGraphType.RUNTIMEHOURS
                        ? RangeSelectionWidget(
                            label1: 'Runtime',
                            label2: 'Working',
                            label3: 'idle',
                            rangeChoice: (int choice) {
                              setState(() {
                                rangeChoice = choice;
                              });
                            },
                          )
                        : (graphType == UtilizationGraphType.TOTALHOURS ||
                                graphType ==
                                    UtilizationGraphType.TOTALFUELBURNED ||
                                graphType == UtilizationGraphType.IDLETREND ||
                                graphType ==
                                    UtilizationGraphType.FUELBURNRATETREND)
                            ? RangeSelectionWidget(
                                label1: 'Day',
                                label2: 'Week',
                                label3: 'month',
                                rangeChoice: (int choice) {
                                  setState(() {
                                    rangeChoice = choice;
                                  });
                                },
                              )
                            : graphType == UtilizationGraphType.IDLEORWORKING
                                ? RangeSelectionWidget(
                                    label1: 'Idle',
                                    label2: 'Working',
                                    label3: null,
                                    rangeChoice: (int choice) {
                                      setState(() {
                                        rangeChoice = choice;
                                      });
                                    },
                                  )
                                : graphType == UtilizationGraphType.CUMULATIVE
                                    ? RangeSelectionWidget(
                                        label1: 'Runtime',
                                        label2: 'Fuel Burned',
                                        label3: null,
                                        rangeChoice: (int choice) {
                                          setState(() {
                                            rangeChoice = choice;
                                          });
                                        },
                                      )
                                    : Container(),
                  ),
                  (graphType == UtilizationGraphType.CUMULATIVE ||
                          graphType == UtilizationGraphType.TOTALHOURS ||
                          graphType == UtilizationGraphType.TOTALFUELBURNED ||
                          graphType == UtilizationGraphType.FUELBURNRATETREND)
                      ? Expanded(
                          child: UtilizationLegends(
                            label1: 'Working',
                            label2: 'Idle',
                            label3: 'Runtime',
                            color1: emerald,
                            color2: burntSienna,
                            color3: creamCan,
                          ),
                        )
                      : Container()
                ],
              ),
            ),
            Flexible(
              child: Padding(
                padding: EdgeInsets.symmetric(vertical: 8),
                child: graphType == UtilizationGraphType.IDLEORWORKING
                    ? IdlePercentWorkingPercentView(
                        rangeChoice: rangeChoice,
                      )
                    : graphType == UtilizationGraphType.RUNTIMEHOURS
                        ? RuntimeHoursView(
                            rangeChoice: rangeChoice,
                          )
                        : graphType == UtilizationGraphType.DISTANCETRAVELLED
                            ? DistanceTravelledView()
                            : graphType == UtilizationGraphType.CUMULATIVE
                                ? CumulativeView(
                                    rangeChoice: rangeChoice,
                                  )
                                : graphType == UtilizationGraphType.TOTALHOURS
                                    ? TotalHoursView(
                                        rangeChoice: rangeChoice,
                                      )
                                    : graphType ==
                                            UtilizationGraphType.TOTALFUELBURNED
                                        ? TotalFuelBurnedView(
                                            rangeChoice: rangeChoice,
                                          )
                                        : graphType ==
                                                UtilizationGraphType.IDLETREND
                                            ? IdlePercentTrendView(
                                                rangeChoice: rangeChoice,
                                              )
                                            : graphType ==
                                                    UtilizationGraphType
                                                        .FUELBURNRATETREND
                                                ? FuelBurnRateTrendView(
                                                    rangeChoice: rangeChoice,
                                                  )
                                                : Container(),
              ),
            ),
            // GRAPH LIST WIDGET
            // Padding(
            //   padding: EdgeInsets.symmetric(vertical: 8.0),
            //   child: viewModel.utilLizationListData.isNotEmpty
            //       ? ListView.builder(
            //           itemCount:
            //                viewModel.utilLizationListData.length,
            //           itemBuilder: (BuildContext context, int index) {
            //              if (graphType ==
            //                 UtilizationGraphType.RUNTIMEHOURS) {
            //
            //             } else if (graphType ==
            //                 UtilizationGraphType.DISTANCETRAVELLED) {
            //
            //             } else if (graphType ==
            //                 UtilizationGraphType.CUMULATIVE) {
            //
            //             } else if (graphType ==
            //                 UtilizationGraphType.TOTALHOURS) {
            //
            //             } else if (graphType ==
            //                 UtilizationGraphType.TOTALFUELBURNED) {
            //
            //             } else if (graphType ==
            //                 UtilizationGraphType.IDLETREND) {
            //
            //             } else if (graphType ==
            //                 UtilizationGraphType.FUELBURNRATETREND) {
            //
            //             } else {
            //               return Container();
            //             }
            //           })
            //       : EmptyView(
            //           title: "No Assets Found",
            //         ),
            // ),
          ],
        );
      },
      viewModelBuilder: () => UtilizationGraphViewModel(),
    );
  }
}
