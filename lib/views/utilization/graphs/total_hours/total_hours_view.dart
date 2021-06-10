import 'package:flutter/material.dart';
import 'package:insite/widgets/smart_widgets/total_hours_chart.dart';
import 'package:stacked/stacked.dart';
import 'total_hours_view_model.dart';

class TotalHoursView extends StatefulWidget {
  final int rangeChoice;
  final String startDate;
  final String endDate;
  const TotalHoursView(
      {Key key, this.rangeChoice, this.startDate, this.endDate})
      : super(key: key);

  @override
  _TotalHoursViewState createState() => _TotalHoursViewState();
}

class _TotalHoursViewState extends State<TotalHoursView> {
  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<TotalHoursViewModel>.reactive(
      builder: (BuildContext context, TotalHoursViewModel viewModel, Widget _) {
        if (viewModel.loading) return CircularProgressIndicator();
        if (widget.rangeChoice == 1) {
          viewModel.range = 'daily';
          viewModel.getTotalHours();

          return TotalHoursChart(
              rangeSelection: widget.rangeChoice,
              totalHours: viewModel.totalHours);
        } else if (widget.rangeChoice == 2) {
          viewModel.range = 'weekly';
          viewModel.getTotalHours();

          return TotalHoursChart(
              rangeSelection: widget.rangeChoice,
              totalHours: viewModel.totalHours);
        } else {
          viewModel.range = 'monthly';
          viewModel.getTotalHours();

          return TotalHoursChart(
              rangeSelection: widget.rangeChoice,
              totalHours: viewModel.totalHours);
        }
      },
      viewModelBuilder: () =>
          TotalHoursViewModel(widget.startDate, widget.endDate),
    );
  }
}
