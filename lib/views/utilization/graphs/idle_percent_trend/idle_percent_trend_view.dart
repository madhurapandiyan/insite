import 'package:flutter/material.dart';
import 'package:insite/widgets/smart_widgets/idle_trend_graph.dart';
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
  _IdlePercentTrendViewState createState() => _IdlePercentTrendViewState();
}

class _IdlePercentTrendViewState extends State<IdlePercentTrendView> {
  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<IdlePercentTrendViewModel>.reactive(
      builder: (BuildContext context, IdlePercentTrendViewModel viewModel,
          Widget _) {
        if (viewModel.loading) return CircularProgressIndicator();
        if (widget.rangeChoice == 1) {
          viewModel.range = 'daily';
          viewModel.getIdlePercentTrend();

          return IdleTrendGraph(
              rangeSelection: widget.rangeChoice,
              idlePercentTrend: viewModel.idlePercentTrend);
        } else if (widget.rangeChoice == 2) {
          viewModel.range = 'weekly';
          viewModel.getIdlePercentTrend();

          return IdleTrendGraph(
              rangeSelection: widget.rangeChoice,
              idlePercentTrend: viewModel.idlePercentTrend);
        } else {
          viewModel.range = 'monthly';
          viewModel.getIdlePercentTrend();

          return IdleTrendGraph(
              rangeSelection: widget.rangeChoice,
              idlePercentTrend: viewModel.idlePercentTrend);
        }
      },
      viewModelBuilder: () =>
          IdlePercentTrendViewModel(widget.startDate, widget.endDate),
    );
  }
}
