import 'package:flutter/material.dart';
import 'package:insite/widgets/smart_widgets/cumulative_chart.dart';
import 'package:stacked/stacked.dart';
import 'cumulative_view_model.dart';

class CumulativeView extends StatefulWidget {
  final int rangeChoice;
  final String startDate;
  final String endDate;
  const CumulativeView(
      {Key key, this.rangeChoice, this.startDate, this.endDate})
      : super(key: key);

  @override
  _CumulativeViewState createState() => _CumulativeViewState();
}

class _CumulativeViewState extends State<CumulativeView> {
  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<CumulativeViewModel>.reactive(
      builder: (BuildContext context, CumulativeViewModel viewModel, Widget _) {
        if (viewModel.loading) return CircularProgressIndicator();
        if (widget.rangeChoice == 1)
          return CumulativeChart(
              runTimeCumulative: viewModel.runTimeCumulative);
        else
          return CumulativeChart(
              fuelBurnedCumulative: viewModel.fuelBurnedCumulative);
      },
      viewModelBuilder: () =>
          CumulativeViewModel(widget.startDate, widget.endDate),
    );
  }
}
