import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';
import 'total_fuel_burned_view_model.dart';
          
class TotalFuelBurnedView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<TotalFuelBurnedViewModel>.reactive(
      builder: (BuildContext context, TotalFuelBurnedViewModel viewModel, Widget _) {
        return Scaffold(
          appBar: AppBar(),
          body: Center(
            child: Text('TotalFuelBurned View'),
          ),
        );
      },
      viewModelBuilder: () => TotalFuelBurnedViewModel(),
    );
  }
}
