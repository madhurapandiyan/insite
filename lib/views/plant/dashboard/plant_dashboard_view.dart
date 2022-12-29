import 'package:flutter/material.dart';
import 'package:insite/core/insite_data_provider.dart';
import 'package:insite/widgets/dumb_widgets/insite_text.dart';
import 'package:insite/widgets/smart_widgets/insite_scaffold.dart';
import 'package:stacked/stacked.dart';
import 'dashboard_bar_chart_widget.dart';
import 'dashboard_pie_chart_widget.dart';
import 'plant_dashboard_view_model.dart';

class PlantDashboardView extends StatefulWidget {
  @override
  _PlantDashboardViewState createState() => _PlantDashboardViewState();
}

class _PlantDashboardViewState extends State<PlantDashboardView> {
  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<PlantDashboardViewModel>.reactive(
      builder:
          (BuildContext context, PlantDashboardViewModel viewModel, Widget? _) {
        return InsiteInheritedDataProvider(
          count: viewModel.appliedFilters!.length,
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
              child: Container(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 8.0),
                      child: InsiteText(
                          text: 'DASHBOARD',
                          fontWeight: FontWeight.w700,
                          size: 14.0),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 8.0),
                      child: DashboardBarChartWidget(
                        isLoading: viewModel.loading,
                        data: viewModel.statusChartData,
                        isRefreshing: false,
                        title: "",
                        title2: viewModel.results.isNotEmpty
                            ? viewModel.results[0]!.toStringAsFixed(0)
                            : viewModel.totalcount.toString(),
                        onFilterSelected: (value) {
                          viewModel.gotoDetailsPage(value!);
                        },
                      ),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 8.0),
                      child: DashboardPieChartWidget(
                        isLoading: viewModel.loading,
                        data: viewModel.activatedChartData,
                        isRefreshing: false,
                        title: "",
                        title2: viewModel.results.isNotEmpty
                            ? viewModel.results[0].toString()
                            : "",
                        onFilterSelected: (value) {
                          viewModel.gotoCalendarDetailsPage(value!);
                        },
                      ),
                    )
                  ],
                ),
              ),
            ),
          ),
        );
      },
      viewModelBuilder: () => PlantDashboardViewModel(),
    );
  }
}
