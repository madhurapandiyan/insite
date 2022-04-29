import 'package:flutter/material.dart';
import 'package:insite/theme/colors.dart';
import 'package:insite/utils/enums.dart';
import 'package:insite/utils/helper_methods.dart';
import 'package:insite/views/utilization/graphs/cumulative/cumulative_view.dart';
import 'package:insite/views/utilization/graphs/distance_travelled/distance_travelled_view.dart';
import 'package:insite/views/utilization/graphs/fuel_burn_rate_trend/fuel_burn_rate_trend_view.dart';
import 'package:insite/views/utilization/graphs/idle_percent_trend/idle_percent_trend_view.dart';
import 'package:insite/views/utilization/graphs/idle_percent_working_percent/idle_percent_working_percent_view.dart';
import 'package:insite/views/utilization/graphs/runtime_hours/runtime_hours_view.dart';
import 'package:insite/views/utilization/graphs/total_fuel_burned/total_fuel_burned_view.dart';
import 'package:insite/views/utilization/graphs/total_hours/total_hours_view.dart';
import 'package:insite/views/utilization/tabs/graph_view/utilization_graph_view_model.dart';
import 'package:insite/views/date_range/date_range_view.dart';
import 'package:insite/widgets/dumb_widgets/insite_button.dart';
import 'package:insite/widgets/dumb_widgets/insite_text.dart';
import 'package:insite/widgets/smart_widgets/page_header.dart';
import 'package:insite/widgets/smart_widgets/util_graph_dropdown.dart';
import 'package:intl/intl.dart';
import 'package:logger/logger.dart';
import 'package:stacked/stacked.dart';

class UtilizationGraphView extends StatefulWidget {
  const UtilizationGraphView({Key? key}) : super(key: key);

  @override
  UtilizationGraphViewState createState() => UtilizationGraphViewState();
}

class UtilizationGraphViewState extends State<UtilizationGraphView> {
  UtilizationGraphType graphType = UtilizationGraphType.IDLEORWORKING;
  List<DateTime>? dateRange = [];
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

  late var viewModel;

  @override
  void initState() {
    viewModel = UtilizationGraphViewModel();
    super.initState();
  }

  @override
  void dispose() {
    viewModel.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<UtilizationGraphViewModel>.reactive(
      builder: (BuildContext context, UtilizationGraphViewModel viewModel,
          Widget? _) {
        var startDate2 = startDate;
        return Padding(
           padding: const EdgeInsets.only(top: 40),
          child: Column(
            children: [
              Padding(
                padding:
                    const EdgeInsets.symmetric(vertical: 8.0, horizontal: 24),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    InsiteText(
                        text: Utils.getDateInFormatddMMyyyy(viewModel.startDate) +
                            " - " +
                            Utils.getDateInFormatddMMyyyy(viewModel.endDate),
                        fontWeight: FontWeight.bold,
                        size: 11),
                    SizedBox(
                      width: 4,
                    ),
                    InsiteButton(
                      title: "Date Range",
                      width: 90,
                      bgColor: Theme.of(context).backgroundColor,
                      textColor: Theme.of(context).textTheme.bodyText1!.color,
                      onTap: () async {
                        dateRange = [];
                        dateRange = await showDialog(
                          context: context,
                          builder: (BuildContext context) => Dialog(
                              backgroundColor: transparent,
                              child: DateRangeView()),
                        );
                        if (dateRange != null && dateRange!.isNotEmpty) {
                          onFilterApplied();
                        }
                      },
                    ),
                  ],
                ),
              ),
              PageHeader(
                isDashboard: graphType == UtilizationGraphType.IDLEORWORKING ||
                        graphType == UtilizationGraphType.RUNTIMEHOURS ||
                        graphType == UtilizationGraphType.DISTANCETRAVELLED
                    ? false
                    : true,
                screenType: ScreenType.UTILIZATION,
                total: viewModel.totalCount,
                count: viewModel.count,
              ),
              Padding(
                padding: EdgeInsets.all(16.0),
                child: InsiteText(
                  text:
                      'Runtime Hours / Working Hours / Idle Hours: Value includes data occurring outside of selected date range.',
                  size: 12,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Container(
                width: MediaQuery.of(context).size.width * 1,
                margin: const EdgeInsets.only(left: 12.0, right: 12),
                decoration: BoxDecoration(
                  color: Theme.of(context).backgroundColor,
                  borderRadius: BorderRadius.all(Radius.circular(8)),
                ),
                child: Padding(
                  padding: EdgeInsets.all(6.0),
                  child: Container(
                    width: MediaQuery.of(context).size.width * 0.75,
                    decoration: BoxDecoration(
                      color: Theme.of(context).backgroundColor,
                      border: Border.all(
                          color: Theme.of(context).textTheme.bodyText1!.color!,
                          width: 0.0),
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
              Flexible(
                child: Padding(
                  padding: EdgeInsets.symmetric(vertical: 8),
                  child: getGraphView(graphType, startDate2, endDate, (value) {
                    viewModel.updateCurrentCount(value);
                  }),
                ),
              ),
            ],
          ),
        );
      },
      viewModelBuilder: () => viewModel,
    );
  }

  onFilterApplied() {
    viewModel.updateDateView();
    onDateChange();
    viewModel.getAssetCount();
  }

  onDateChange() {
    if (graphType == UtilizationGraphType.IDLEORWORKING) {
      idlePercentKey.currentState!.refresh();
    } else if (graphType == UtilizationGraphType.RUNTIMEHOURS) {
      runTimeHoursKey.currentState!.refresh();
    } else if (graphType == UtilizationGraphType.DISTANCETRAVELLED) {
      distanceTravelledKey.currentState!.refresh();
    } else if (graphType == UtilizationGraphType.CUMULATIVE) {
      cumulativeKey.currentState!.refresh();
    } else if (graphType == UtilizationGraphType.TOTALHOURS) {
      totalHoursKey.currentState!.refresh();
    } else if (graphType == UtilizationGraphType.TOTALFUELBURNED) {
      totalFuelBurnedKey.currentState!.refresh();
    } else if (graphType == UtilizationGraphType.IDLETREND) {
      idleTrendKey.currentState!.refresh();
    } else if (graphType == UtilizationGraphType.FUELBURNRATETREND) {
      fuelBurnTrendKey.currentState!.refresh();
    }
  }

  Widget getGraphView(UtilizationGraphType utilizationGraphType, startDate,
      endDate, update(int)) {
    switch (utilizationGraphType) {
      case UtilizationGraphType.IDLEORWORKING:
        return IdlePercentWorkingPercentView(
          key: idlePercentKey,
          updateCount: (value) {
            Logger().d("updateCount $value");
            update(value);
          },
        );

      case UtilizationGraphType.RUNTIMEHOURS:
        return RuntimeHoursView(
          key: runTimeHoursKey,
          updateCount: (value) {
            Logger().d("updateCount $value");
            update(value);
          },
        );

      case UtilizationGraphType.DISTANCETRAVELLED:
        return DistanceTravelledView(
          key: distanceTravelledKey,
          updateCount: (value) {
            Logger().d("updateCount $value");
            update(value);
          },
        );

      case UtilizationGraphType.CUMULATIVE:
        return CumulativeView(
          key: cumulativeKey,
        );

      case UtilizationGraphType.TOTALHOURS:
        return TotalHoursView(
          key: totalHoursKey,
        );

      case UtilizationGraphType.TOTALFUELBURNED:
        return TotalFuelBurnedView(
          key: totalFuelBurnedKey,
        );

      case UtilizationGraphType.IDLETREND:
        return IdlePercentTrendView(
          key: idleTrendKey,
        );

      case UtilizationGraphType.FUELBURNRATETREND:
        return FuelBurnRateTrendView(
          key: fuelBurnTrendKey,
        );

      default:
        return Container();
    }
  }
}
