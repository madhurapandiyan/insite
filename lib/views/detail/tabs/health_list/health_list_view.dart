import 'package:flutter/material.dart';
import 'package:insite/core/models/health_list_response.dart';
import 'package:insite/theme/colors.dart';
import 'package:insite/widgets/dumb_widgets/health_list_item.dart';

import 'package:stacked/stacked.dart';
import 'health_list_view_model.dart';

class HealthListView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<HealthListViewModel>.reactive(
      builder: (BuildContext context, HealthListViewModel viewModel, Widget _) {
        return Scaffold(
            body: Container(
          color: bgcolor,
          child: viewModel.healthListDataLoading
              ? Center(
                  child: CircularProgressIndicator(),
                )
              : Expanded(
                  child: ListView.builder(
                  shrinkWrap: true,
                  scrollDirection: Axis.vertical,
                  itemCount: viewModel.faults.length,
                  itemBuilder: (context, index) {
                    Fault faultElement = viewModel.faults[index];
                    return HealthListItem(
                      faultElement: faultElement,
                    );
                  },
                )),
        ));
      },
      viewModelBuilder: () => HealthListViewModel(),
    );
  }
}
