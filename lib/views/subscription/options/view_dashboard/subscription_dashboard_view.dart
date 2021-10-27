import 'package:flutter/material.dart';
import 'package:insite/core/insite_data_provider.dart';
import 'package:insite/widgets/dumb_widgets/insite_text.dart';
import 'package:insite/widgets/smart_widgets/insite_scaffold.dart';
import 'package:insite/widgets/smart_widgets/reusable_container_large.dart';
import 'package:stacked/stacked.dart';
import 'subscription_dashboard_view_model.dart';

class View extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<ViewDashboardViewModel>.reactive(
      builder:
          (BuildContext context, ViewDashboardViewModel viewModel, Widget _) {
        return InsiteInheritedDataProvider(
          count: viewModel.appliedFilters.length,
          child: InsiteScaffold(
            viewModel: viewModel,
            //screenType: ScreenType,
            onFilterApplied: () {
              //viewModel.refresh();
            },
            onRefineApplied: () {
              //viewModel.refresh();
            },
            body: SingleChildScrollView(
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 20.0, vertical: 32),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    InsiteText(
                        text: 'DASHBOARD',
                        fontWeight: FontWeight.w700,
                        size: 14.0),
                    SizedBox(
                      height: 20,
                    ),
                    DashBoardContainer(
                      title: "PLANT DISPATCH SUMMARY",
                      subTitle1: "TYPE",
                      subTitle2: "DEVICE COUNT",
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    DashBoardContainer(
                      title: "ACTIVE DEVICES BY MODEL",
                      subTitle1: "MODEL",
                      subTitle2: "DEVICE COUNT",
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
      viewModelBuilder: () => ViewDashboardViewModel(),
    );
  }
}
