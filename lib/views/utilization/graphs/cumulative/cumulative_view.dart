import 'package:flutter/material.dart';
import 'package:insite/theme/colors.dart';
import 'package:insite/utils/enums.dart';
import 'package:insite/widgets/dumb_widgets/insite_progressbar.dart';
import 'package:insite/widgets/dumb_widgets/utilization_legends.dart';
import 'package:insite/widgets/smart_widgets/cumulative_chart.dart';
import 'package:insite/widgets/smart_widgets/range_selection_widget.dart';
import 'package:stacked/stacked.dart';
import 'cumulative_view_model.dart';

class CumulativeView extends StatefulWidget {
  const CumulativeView({Key? key}) : super(key: key);

  @override
  CumulativeViewState createState() => CumulativeViewState();
}

class CumulativeViewState extends State<CumulativeView> {
  int rangeChoice = 1;
  late var viewModel;
  List<bool> shouldShowLabel = [true, true, true];

  @override
  void initState() {
    viewModel = CumulativeViewModel();
    super.initState();
  }

  refresh() {
    viewModel.refresh();
  }

  @override
  void dispose() {
    viewModel.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<CumulativeViewModel>.reactive(
      builder: (BuildContext context, CumulativeViewModel viewModel, Widget? _) {
        if (viewModel.loading) return InsiteProgressBar();
        return Stack(
          children: [
            Column(
              children: [
                Padding(
                  padding: EdgeInsets.all(16.0),
                  child: Row(
                    children: [
                      Align(
                        alignment: Alignment.centerLeft,
                        child: RangeSelectionWidget(
                          label1: 'Runtime',
                          label2: 'Fuel Burned',
                          label3: null,
                          rangeChoice: (int choice) {
                            setState(() {
                              rangeChoice = choice;
                            });
                          },
                        ),
                      ),
                      Expanded(
                        child: UtilizationLegends(
                          label1: 'Working',
                          label2: 'Idle',
                          label3: 'Runtime',
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
                Expanded(
                  child: rangeChoice == 1
                      ? CumulativeChart(
                          runTimeCumulative: viewModel.runTimeCumulative,
                          cumulativeChartType: CumulativeChartType.RUNTIME,
                          shouldShowLabel: shouldShowLabel,
                        )
                      : CumulativeChart(
                          fuelBurnedCumulative: viewModel.fuelBurnedCumulative,
                          cumulativeChartType: CumulativeChartType.FUELBURNED,
                          shouldShowLabel: shouldShowLabel,
                        ),
                ),
              ],
            ),
            viewModel.isRefreshing ? InsiteProgressBar() : SizedBox()
          ],
        );
      },
      viewModelBuilder: () => viewModel,
    );
  }
}
