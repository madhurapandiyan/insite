import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';
import 'idle_percent_working_percent_view_model.dart';
          
class IdlePercentWorkingPercentView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<IdlePercentWorkingPercentViewModel>.reactive(
      builder: (BuildContext context, IdlePercentWorkingPercentViewModel viewModel, Widget _) {
        return Scaffold(
          appBar: AppBar(),
          body: Center(
            child: Text('IdlePercentWorkingPercent View'),
          ),
        );
      },
      viewModelBuilder: () => IdlePercentWorkingPercentViewModel(),
    );
  }
}
