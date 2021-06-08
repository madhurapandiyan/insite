import 'package:flutter/material.dart';
import 'package:insite/theme/colors.dart';
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
                            graphType = selectedGraph;
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
                              rangeChoice = choice;
                            },
                          )
                        : isRangeSelectionVisible
                            ? RangeSelectionWidget(
                                label1: 'Day',
                                label2: 'Week',
                                label3: 'month',
                                rangeChoice: (int choice) {
                                  rangeChoice = choice;
                                },
                              )
                            : graphType == UtilizationGraphType.IDLEORWORKING
                                ? RangeSelectionWidget(
                                    label1: 'Idle',
                                    label2: 'Working',
                                    label3: null,
                                    rangeChoice: (int choice) {
                                      rangeChoice = choice;
                                    },
                                  )
                                : graphType == UtilizationGraphType.CUMULATIVE
                                    ? RangeSelectionWidget(
                                        label1: 'Runtime',
                                        label2: 'Fuel Burned',
                                        label3: null,
                                        rangeChoice: (int choice) {
                                          rangeChoice = choice;
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
            // GRAPH LIST WIDGET
            Padding(
              padding: EdgeInsets.symmetric(vertical: 8.0),
              child: viewModel.utilLizationListData.isNotEmpty
                  ? ListView.builder(
                      itemCount: (graphType ==
                                  UtilizationGraphType.CUMULATIVE ||
                              graphType == UtilizationGraphType.TOTALHOURS ||
                              graphType ==
                                  UtilizationGraphType.TOTALFUELBURNED ||
                              graphType == UtilizationGraphType.IDLETREND ||
                              graphType ==
                                  UtilizationGraphType.FUELBURNRATETREND)
                          ? 1
                          : viewModel.utilLizationListData.length,
                      itemBuilder: (BuildContext context, int index) {
                        if (graphType == UtilizationGraphType.IDLEORWORKING) {
                          if (rangeChoice == 1)
                            return PercentageWidget(
                                label: viewModel.utilLizationListData[index]
                                    .assetSerialNumber,
                                percentage: viewModel
                                            .utilLizationListData[index]
                                            .idleEfficiency ==
                                        null
                                    ? null
                                    : viewModel.utilLizationListData[index]
                                            .idleEfficiency *
                                        100,
                                color: sandyBrown);
                          else
                            return PercentageWidget(
                                label: viewModel.utilLizationListData[index]
                                    .assetSerialNumber,
                                percentage: viewModel
                                            .utilLizationListData[index]
                                            .workingEfficiency ==
                                        null
                                    ? null
                                    : viewModel.utilLizationListData[index]
                                            .workingEfficiency *
                                        100,
                                color: olivine);
                        } else if (graphType ==
                            UtilizationGraphType.RUNTIMEHOURS) {
                          if (rangeChoice == 1)
                            return PercentageWidget(
                                value:
                                    '${viewModel.utilLizationListData[index].runtimeHours}',
                                label: viewModel.utilLizationListData[index]
                                    .assetSerialNumber,
                                percentage: viewModel
                                        .utilLizationListData[index]
                                        .runtimeHours /
                                    10,
                                color: sandyBrown);
                          else if (rangeChoice == 2)
                            return PercentageWidget(
                                value:
                                    '${viewModel.utilLizationListData[index].workingHours}',
                                label: viewModel.utilLizationListData[index]
                                    .assetSerialNumber,
                                percentage: viewModel
                                        .utilLizationListData[index]
                                        .workingHours /
                                    10,
                                color: sandyBrown);
                          else
                            return PercentageWidget(
                                value:
                                    '${viewModel.utilLizationListData[index].idleHours}',
                                label: viewModel.utilLizationListData[index]
                                    .assetSerialNumber,
                                percentage: viewModel
                                        .utilLizationListData[index].idleHours /
                                    10,
                                color: sandyBrown);
                        } else if (graphType ==
                            UtilizationGraphType.DISTANCETRAVELLED) {
                          return PercentageWidget(
                              label: viewModel.utilLizationListData[index]
                                  .assetSerialNumber,
                              value: viewModel.utilLizationListData[index]
                                          .distanceTravelledKilometers ==
                                      null
                                  ? 'NA'
                                  : '${viewModel.utilLizationListData[index].distanceTravelledKilometers}',
                              percentage: viewModel.utilLizationListData[index]
                                          .distanceTravelledKilometers ==
                                      null
                                  ? 0
                                  : viewModel.utilLizationListData[index]
                                          .distanceTravelledKilometers /
                                      1000,
                              color: creamCan);
                        } else if (graphType ==
                            UtilizationGraphType.CUMULATIVE) {
                          if (rangeChoice == 1)
                            return CumulativeChart(
                                runTimeCumulative: viewModel.runTimeCumulative);
                          else
                            return CumulativeChart(
                                fuelBurnedCumulative:
                                    viewModel.fuelBurnedCumulative);
                        } else if (graphType ==
                            UtilizationGraphType.TOTALHOURS) {
                          if (rangeChoice == 1) {
                            viewModel.range = 'daily';
                            viewModel.getTotalHours();

                            return TotalHoursChart(
                                rangeSelection: rangeChoice,
                                totalHours: viewModel.totalHours);
                          } else if (rangeChoice == 2) {
                            viewModel.range = 'weekly';
                            viewModel.getTotalHours();

                            return TotalHoursChart(
                                rangeSelection: rangeChoice,
                                totalHours: viewModel.totalHours);
                          } else {
                            viewModel.range = 'monthly';
                            viewModel.getTotalHours();

                            return TotalHoursChart(
                                rangeSelection: rangeChoice,
                                totalHours: viewModel.totalHours);
                          }
                        } else if (graphType ==
                            UtilizationGraphType.TOTALFUELBURNED) {
                          if (rangeChoice == 1) {
                            viewModel.range = 'daily';
                            viewModel.getTotalFuelBurned();

                            return TotalFuelBurnedGraph(
                                rangeSelection: rangeChoice,
                                totalFuelBurned: viewModel.totalFuelBurned);
                          }
                          if (rangeChoice == 2) {
                            viewModel.range = 'weekly';
                            viewModel.getTotalFuelBurned();

                            return TotalFuelBurnedGraph(
                                rangeSelection: rangeChoice,
                                totalFuelBurned: viewModel.totalFuelBurned);
                          } else {
                            viewModel.range = 'monthly';
                            viewModel.getTotalFuelBurned();

                            return TotalFuelBurnedGraph(
                                rangeSelection: rangeChoice,
                                totalFuelBurned: viewModel.totalFuelBurned);
                          }
                        } else if (graphType ==
                            UtilizationGraphType.IDLETREND) {
                          if (rangeChoice == 1) {
                            viewModel.range = 'daily';
                            viewModel.getIdlePercentTrend();

                            return IdleTrendGraph(
                                rangeSelection: rangeChoice,
                                idlePercentTrend: viewModel.idlePercentTrend);
                          } else if (rangeChoice == 2) {
                            viewModel.range = 'weekly';
                            viewModel.getIdlePercentTrend();

                            return IdleTrendGraph(
                                rangeSelection: rangeChoice,
                                idlePercentTrend: viewModel.idlePercentTrend);
                          } else {
                            viewModel.range = 'monthly';
                            viewModel.getIdlePercentTrend();

                            return IdleTrendGraph(
                                rangeSelection: rangeChoice,
                                idlePercentTrend: viewModel.idlePercentTrend);
                          }
                        } else if (graphType ==
                            UtilizationGraphType.FUELBURNRATETREND) {
                          if (rangeChoice == 1) {
                            viewModel.range = 'daily';
                            viewModel.getFuelBurnRateTrend();

                            return FuelBurnRateGraph(
                                rangeSelection: rangeChoice,
                                fuelBurnRateTrend: viewModel.fuelBurnRateTrend);
                          } else if (rangeChoice == 2) {
                            viewModel.range = 'weekly';
                            viewModel.getFuelBurnRateTrend();

                            return FuelBurnRateGraph(
                                rangeSelection: rangeChoice,
                                fuelBurnRateTrend: viewModel.fuelBurnRateTrend);
                          } else {
                            viewModel.range = 'monthly';
                            viewModel.getFuelBurnRateTrend();

                            return FuelBurnRateGraph(
                                rangeSelection: rangeChoice,
                                fuelBurnRateTrend: viewModel.fuelBurnRateTrend);
                          }
                        } else {
                          return Container();
                        }
                      })
                  : EmptyView(
                      title: "No Assets Found",
                    ),
            ),
          ],
        );
      },
      viewModelBuilder: () => UtilizationGraphViewModel(),
    );
  }
}
