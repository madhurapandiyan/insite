import 'package:flutter/material.dart';
import 'package:insite/theme/colors.dart';
import 'package:stacked/stacked.dart';
import 'splash_view_model.dart';

class SplashView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<SplashViewModel>.reactive(
      builder: (BuildContext context, SplashViewModel viewModel, Widget _) {
        return Scaffold(
          backgroundColor: tango,
          body: Center(
            child: CircularProgressIndicator(),
          ),
        );
      },
      viewModelBuilder: () => SplashViewModel(),
    );
  }
}
