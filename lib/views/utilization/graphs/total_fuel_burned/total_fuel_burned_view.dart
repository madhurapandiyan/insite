import 'package:flutter/material.dart';
import 'package:insite/widgets/smart_widgets/total_fuel_burned_graph.dart';
import 'package:stacked/stacked.dart';
import 'total_fuel_burned_view_model.dart';

class TotalFuelBurnedView extends StatefulWidget {
  final int rangeChoice;
  const TotalFuelBurnedView({Key key, this.rangeChoice}) : super(key: key);

  @override
  _TotalFuelBurnedViewState createState() => _TotalFuelBurnedViewState();
}

class _TotalFuelBurnedViewState extends State<TotalFuelBurnedView> {
  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<TotalFuelBurnedViewModel>.reactive(
      builder:
          (BuildContext context, TotalFuelBurnedViewModel viewModel, Widget _) {
        if (viewModel.loading) return CircularProgressIndicator();
        if (widget.rangeChoice == 1) {
          viewModel.range = 'daily';
          viewModel.getTotalFuelBurned();

          return TotalFuelBurnedGraph(
              rangeSelection: widget.rangeChoice,
              totalFuelBurned: viewModel.totalFuelBurned);
        }
        if (widget.rangeChoice == 2) {
          viewModel.range = 'weekly';
          viewModel.getTotalFuelBurned();

          return TotalFuelBurnedGraph(
              rangeSelection: widget.rangeChoice,
              totalFuelBurned: viewModel.totalFuelBurned);
        } else {
          viewModel.range = 'monthly';
          viewModel.getTotalFuelBurned();

          return TotalFuelBurnedGraph(
              rangeSelection: widget.rangeChoice,
              totalFuelBurned: viewModel.totalFuelBurned);
        }
      },
      viewModelBuilder: () => TotalFuelBurnedViewModel(),
    );
  }
}
