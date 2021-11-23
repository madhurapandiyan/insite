import 'package:flutter/material.dart';
import 'package:insite/core/insite_data_provider.dart';
import 'package:insite/widgets/dumb_widgets/empty_view.dart';
import 'package:insite/widgets/dumb_widgets/insite_progressbar.dart';
import 'package:insite/widgets/dumb_widgets/insite_text.dart';
import 'package:insite/widgets/smart_widgets/insite_scaffold.dart';
import 'package:insite/widgets/smart_widgets/reusable_container_large.dart';
import 'package:insite/widgets/smart_widgets/insite_title_count_row.dart';
import 'package:stacked/stacked.dart';
import 'subscription_dashboard_view_model.dart';

class SubscriptionDashboardView extends StatefulWidget {
  @override
  _SubscriptionDashboardViewState createState() =>
      _SubscriptionDashboardViewState();
}

class _SubscriptionDashboardViewState extends State<SubscriptionDashboardView> {
  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<SubscriptionDashboardViewModel>.reactive(
      builder: (BuildContext context, SubscriptionDashboardViewModel viewModel,
          Widget _) {
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
                      height: MediaQuery.of(context).size.height * 0.55,
                      title: "PLANT DISPATCH SUMMARY",
                      subTitle1: "TYPE",
                      subTitle2: "DEVICE COUNT",
                      cards: Expanded(
                          child: MediaQuery.removePadding(
                        context: (context),
                        removeBottom: true,
                        removeTop: true,
                        child: viewModel.loading
                            ? InsiteProgressBar()
                            : viewModel.results.isNotEmpty
                                ? ListView.builder(
                                    shrinkWrap: true,
                                    physics: NeverScrollableScrollPhysics(),
                                    itemCount: viewModel.names.length,
                                    itemBuilder: (context, index) {
                                      return InsiteTitleCountRow(
                                        name: viewModel.names[index],
                                        count: viewModel.results[index]
                                            .toStringAsFixed(0),
                                        filter: viewModel.names[index],
                                        onClicked: () {
                                          viewModel.gotoDetailsPage(
                                              viewModel.filters[index]);
                                        },
                                      );
                                    })
                                : EmptyView(
                                    title: "No Results",
                                  ),
                      )),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    DashBoardContainer(
                      title: "ACTIVE DEVICES BY MODEL",
                      subTitle1: "MODEL",
                      subTitle2: "DEVICE COUNT",
                      height: viewModel.modelNames.isNotEmpty
                          ? MediaQuery.of(context).size.height * 1.2
                          : MediaQuery.of(context).size.height * 0.6,
                      cards: Expanded(
                          child: MediaQuery.removePadding(
                        context: (context),
                        removeBottom: true,
                        removeTop: true,
                        child: viewModel.loading
                            ? InsiteProgressBar()
                            : viewModel.modelNames.isNotEmpty
                                ? ListView.builder(
                                    shrinkWrap: true,
                                    physics: NeverScrollableScrollPhysics(),
                                    itemCount: viewModel.modelNames.length,
                                    itemBuilder: (context, index) {
                                      return InsiteTitleCountRow(
                                        name: viewModel.modelNames[index],
                                        count: viewModel.modelCount[index]
                                            .toStringAsFixed(0),
                                        filter: viewModel.modelNames[index],
                                        onClicked: () {
                                          viewModel.gotoModelsPage(
                                              viewModel.modelNames[index]);
                                        },
                                      );
                                    })
                                : EmptyView(
                                    title: "No Results",
                                  ),
                      )),
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
      viewModelBuilder: () => SubscriptionDashboardViewModel(),
    );
  }
}
