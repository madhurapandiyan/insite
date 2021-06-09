import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';
import 'fuel_burn_rate_trend_view_model.dart';
          
class FuelBurnRateTrendView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<FuelBurnRateTrendViewModel>.reactive(
      builder: (BuildContext context, FuelBurnRateTrendViewModel viewModel, Widget _) {
        return Scaffold(
          appBar: AppBar(),
          body: Center(
            child: Text('FuelBurnRateTrend View'),
          ),
        );
      },
      viewModelBuilder: () => FuelBurnRateTrendViewModel(),
    );
  }
}
