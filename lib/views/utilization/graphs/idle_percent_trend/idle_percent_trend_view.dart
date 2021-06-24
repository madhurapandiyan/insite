import 'package:flutter/material.dart';
import 'package:insite/theme/colors.dart';
import 'package:insite/widgets/dumb_widgets/utilization_legends.dart';
import 'package:insite/widgets/smart_widgets/idle_trend_graph.dart';
import 'package:insite/widgets/smart_widgets/range_selection_widget.dart';
import 'package:stacked/stacked.dart';
import 'idle_percent_trend_view_model.dart';

class IdlePercentTrendView extends StatefulWidget {
  final int rangeChoice;
  final String startDate;
  final String endDate;
  const IdlePercentTrendView(
      {Key key, this.rangeChoice, this.startDate, this.endDate})
      : super(key: key);

  @override
  IdlePercentTrendViewState createState() => IdlePercentTrendViewState();
}

class IdlePercentTrendViewState extends State<IdlePercentTrendView> {
  int rangeChoice = 1;
  List<String> rangeTexts = ['daily', 'weekly', 'monthly'];
  @override
  void initState() {
    viewModel = IdlePercentTrendViewModel(widget.startDate, widget.endDate);
    super.initState();
  }

  var viewModel;

  @override
  void dispose() {
    viewModel.dispose();
    super.dispose();
  }

  refresh(String startDate, String endDate) {
    viewModel.updateDate(startDate, endDate);
    viewModel.refresh();
  }

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<IdlePercentTrendViewModel>.reactive(
      builder: (BuildContext context, IdlePercentTrendViewModel viewModel,
          Widget _) {
        if (viewModel.loading) return Center(child: CircularProgressIndicator());
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
                          label1: 'Day',
                          label2: 'Week',
                          label3: 'month',
                          rangeChoice: (int choice) {
                            setState(() {
                              rangeChoice = choice;
                              viewModel.range = rangeTexts[rangeChoice - 1];
                              viewModel.getIdlePercentTrend();
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
                  child: IdleTrendGraph(
                      rangeSelection: rangeChoice,
                      idlePercentTrend: viewModel.idlePercentTrend),
                ),
              ],
            ),
            viewModel.isRefreshing
                ? Center(
                    child: CircularProgressIndicator(),
                  )
                : SizedBox()
          ],
        );
      },
      viewModelBuilder: () => viewModel,
    );
  }
}
