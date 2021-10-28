import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';
import 'subscription_dashboard_details_view_model.dart';

class SubDashBoardDetailsView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<SubDashBoardDetailsViewModel>.reactive(
      builder: (BuildContext context, SubDashBoardDetailsViewModel viewModel,
          Widget _) {
        return Scaffold(
          appBar: AppBar(),
          body: Center(
            child: Text('SubDashBoardDetails View'),
          ),
        );
      },
      viewModelBuilder: () => SubDashBoardDetailsViewModel(),
    );
  }
}
