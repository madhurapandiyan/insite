import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';
import 'cumulative_view_model.dart';
          
class CumulativeView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<CumulativeViewModel>.reactive(
      builder: (BuildContext context, CumulativeViewModel viewModel, Widget _) {
        return Scaffold(
          appBar: AppBar(),
          body: Center(
            child: Text('Cumulative View'),
          ),
        );
      },
      viewModelBuilder: () => CumulativeViewModel(),
    );
  }
}
