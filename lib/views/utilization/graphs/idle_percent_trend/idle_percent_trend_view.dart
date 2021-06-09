import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';
import 'idle_percent_trend_view_model.dart';
          
class IdlePercentTrendView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<IdlePercentTrendViewModel>.reactive(
      builder: (BuildContext context, IdlePercentTrendViewModel viewModel, Widget _) {
        return Scaffold(
          appBar: AppBar(),
          body: Center(
            child: Text('IdlePercentTrend View'),
          ),
        );
      },
      viewModelBuilder: () => IdlePercentTrendViewModel(),
    );
  }
}
