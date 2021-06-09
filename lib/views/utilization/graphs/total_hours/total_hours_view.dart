import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';
import 'total_hours_view_model.dart';
          
class TotalHoursView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<TotalHoursViewModel>.reactive(
      builder: (BuildContext context, TotalHoursViewModel viewModel, Widget _) {
        return Scaffold(
          appBar: AppBar(),
          body: Center(
            child: Text('TotalHours View'),
          ),
        );
      },
      viewModelBuilder: () => TotalHoursViewModel(),
    );
  }
}
