import 'package:flutter/material.dart';
import 'package:insite/theme/colors.dart';
import 'package:insite/widgets/dumb_widgets/utilization_legends.dart';
import 'package:insite/widgets/smart_widgets/cumulative_chart.dart';
import 'package:insite/widgets/smart_widgets/range_selection_widget.dart';
import 'package:stacked/stacked.dart';
import 'cumulative_view_model.dart';

class CumulativeView extends StatefulWidget {
  final String startDate;
  final String endDate;
  const CumulativeView({Key key, this.startDate, this.endDate})
      : super(key: key);

  @override
  _CumulativeViewState createState() => _CumulativeViewState();
}

class _CumulativeViewState extends State<CumulativeView> {
  int rangeChoice = 1;
  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<CumulativeViewModel>.reactive(
      builder: (BuildContext context, CumulativeViewModel viewModel, Widget _) {
        if (viewModel.loading) return CircularProgressIndicator();

        return Column(
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
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
              child: rangeChoice == 1
                  ? CumulativeChart(
                      runTimeCumulative: viewModel.runTimeCumulative)
                  : CumulativeChart(
                      fuelBurnedCumulative: viewModel.fuelBurnedCumulative,
                    ),
            ),
          ],
        );
      },
      viewModelBuilder: () =>
          CumulativeViewModel(widget.startDate, widget.endDate),
    );
  }
}
