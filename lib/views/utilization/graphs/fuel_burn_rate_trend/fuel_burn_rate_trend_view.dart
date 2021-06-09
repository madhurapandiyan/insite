import 'package:flutter/material.dart';
import 'package:insite/widgets/smart_widgets/fuel_burn_rate_graph.dart';
import 'package:stacked/stacked.dart';
import 'fuel_burn_rate_trend_view_model.dart';

class FuelBurnRateTrendView extends StatefulWidget {
  final int rangeChoice;
  const FuelBurnRateTrendView({Key key, this.rangeChoice}) : super(key: key);

  @override
  _FuelBurnRateTrendViewState createState() => _FuelBurnRateTrendViewState();
}

class _FuelBurnRateTrendViewState extends State<FuelBurnRateTrendView> {
  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<FuelBurnRateTrendViewModel>.reactive(
      builder: (BuildContext context, FuelBurnRateTrendViewModel viewModel,
          Widget _) {
        if (viewModel.loading) return CircularProgressIndicator();
        if (widget.rangeChoice == 1) {
          viewModel.range = 'daily';
          viewModel.getFuelBurnRateTrend();

          return FuelBurnRateGraph(
              rangeSelection: widget.rangeChoice,
              fuelBurnRateTrend: viewModel.fuelBurnRateTrend);
        } else if (widget.rangeChoice == 2) {
          viewModel.range = 'weekly';
          viewModel.getFuelBurnRateTrend();

          return FuelBurnRateGraph(
              rangeSelection: widget.rangeChoice,
              fuelBurnRateTrend: viewModel.fuelBurnRateTrend);
        } else {
          viewModel.range = 'monthly';
          viewModel.getFuelBurnRateTrend();

          return FuelBurnRateGraph(
              rangeSelection: widget.rangeChoice,
              fuelBurnRateTrend: viewModel.fuelBurnRateTrend);
        }
      },
      viewModelBuilder: () => FuelBurnRateTrendViewModel(),
    );
  }
}
