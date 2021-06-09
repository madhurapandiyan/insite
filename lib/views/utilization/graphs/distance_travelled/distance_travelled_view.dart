import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';
import 'distance_travelled_view_model.dart';
          
class DistanceTravelledView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<DistanceTravelledViewModel>.reactive(
      builder: (BuildContext context, DistanceTravelledViewModel viewModel, Widget _) {
        return Scaffold(
          appBar: AppBar(),
          body: Center(
            child: Text('DistanceTravelled View'),
          ),
        );
      },
      viewModelBuilder: () => DistanceTravelledViewModel(),
    );
  }
}
