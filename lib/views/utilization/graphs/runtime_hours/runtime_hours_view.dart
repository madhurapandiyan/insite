import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';
import 'runtime_hours_view_model.dart';
          
class RuntimeHoursView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<RuntimeHoursViewModel>.reactive(
      builder: (BuildContext context, RuntimeHoursViewModel viewModel, Widget _) {
        return Scaffold(
          appBar: AppBar(),
          body: Center(
            child: Text('RuntimeHours View'),
          ),
        );
      },
      viewModelBuilder: () => RuntimeHoursViewModel(),
    );
  }
}
