import 'package:flutter/material.dart';
import 'package:insite/core/insite_data_provider.dart';
import 'package:insite/theme/colors.dart';
import 'package:insite/widgets/dumb_widgets/insite_progressbar.dart';
import 'package:insite/widgets/dumb_widgets/insite_text.dart';
import 'package:insite/widgets/smart_widgets/insite_scaffold.dart';
import 'package:insite/widgets/smart_widgets/insite_title_count_row.dart';
import 'package:insite/widgets/smart_widgets/reusable_container_large.dart';
import 'package:stacked/stacked.dart';
import 'plant_hierachy_view_model.dart';

class PlantHierachyView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<PlantHierachyViewModel>.reactive(
      builder:
          (BuildContext context, PlantHierachyViewModel viewModel, Widget _) {
        return InsiteInheritedDataProvider(
          count: viewModel.appliedFilters.length,
          child: InsiteScaffold(
              viewModel: viewModel,
              onFilterApplied: () {
                //viewModel.refresh();
              },
              onRefineApplied: () {
                //viewModel.refresh();
              },
              body: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      height: 30.0,
                    ),
                    InsiteText(
                      text: "HEIRARCHY",
                      fontWeight: FontWeight.w700,
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Card(
                      child: Container(
                        height: MediaQuery.of(context).size.height * 0.45,
                        width: double.infinity,
                        decoration: BoxDecoration(
                          color: Theme.of(context).cardColor,
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Container(
                              height: 50,
                              width: double.infinity,
                              decoration: BoxDecoration(
                                  color: Theme.of(context).indicatorColor,
                                  borderRadius: BorderRadius.only(
                                      topRight: Radius.circular(10),
                                      topLeft: Radius.circular(10))),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.all(15.0),
                                    child: InsiteText(
                                        text: "ASSET DETAILS",
                                        fontWeight: FontWeight.w700,
                                        size: 12.0),
                                  ),
                                ],
                              ),
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            viewModel.loading
                                ? InsiteProgressBar()
                                : Expanded(
                                    child: MediaQuery.removePadding(
                                    context: (context),
                                    removeBottom: true,
                                    removeTop: true,
                                    child: ListView.builder(
                                        itemCount: viewModel.assetCount.length,
                                        itemBuilder: (context, index) {
                                          return InsiteTitleCountRow(
                                              onClicked: () {
                                                viewModel.gotoDetailsPage(
                                                    viewModel
                                                        .filterType[index]);
                                              },
                                              name: viewModel.assetType[index],
                                              count: viewModel.assetCount[index]
                                                  .toStringAsFixed(1),
                                              filter:
                                                  viewModel.filterType[index]);
                                        }),
                                  )),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              )),
        );
      },
      viewModelBuilder: () => PlantHierachyViewModel(),
    );
  }
}
