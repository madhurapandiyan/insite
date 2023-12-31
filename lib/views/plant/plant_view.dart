import 'package:flutter/material.dart';
import 'package:insite/core/insite_data_provider.dart';
import 'package:insite/utils/enums.dart';
import 'package:insite/utils/helper_methods.dart';
import 'package:insite/views/adminstration/reusable_widget/asset_cards_small.dart';
import 'package:insite/views/adminstration/reusable_widget/asset_setting_widget.dart';
import 'package:insite/widgets/dumb_widgets/insite_text.dart';
import 'package:insite/widgets/smart_widgets/insite_scaffold.dart';
import 'package:stacked/stacked.dart';
import 'plant_view_model.dart';

class PlantView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<PlantViewModel>.reactive(
      builder: (BuildContext context, PlantViewModel viewModel, Widget? _) {
        return InsiteInheritedDataProvider(
          count: viewModel.appliedFilters!.length,
          child: InsiteScaffold(
              viewModel: viewModel,
              screenType: ScreenType.PLANT,
              onFilterApplied: () {
                //viewModel.refresh();
              },
              onRefineApplied: () {
                //viewModel.refresh();
              },
              body: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(left: 16, top: 16),
                      child: InsiteTextOverFlow(
                        text: Utils.getPageTitle(ScreenType.PLANT),
                        color: Theme.of(context).textTheme.bodyText1!.color,
                        overflow: TextOverflow.ellipsis,
                        fontWeight: FontWeight.bold,
                        size: 16,
                      ),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        AssetCardsSmall(
                            headerText: "DASHBOARD",
                            showExapansionMenu: false,
                            icon: "assets/images/dashboard.svg",
                            buttonTitle: [
                              AdminAssetsButtonType.values[8],
                            ],
                            height: 25.0,
                            onCallbackSelected: (value) {
                              viewModel.onRespectiveButtonClicked(value);
                            }),
                        AssetCardsSmall(
                            showExapansionMenu: false,
                            headerText: "HIERARCHY",
                            icon: "assets/images/hier.svg",
                            buttonTitle: [
                              AdminAssetsButtonType.values[18],
                            ],
                            height: 20.0,
                            onCallbackSelected: (value) {
                              viewModel.onRespectiveButtonClicked(value);
                            }),
                      ],
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Center(
                      child: AssetSettingWidget(
                        icon: "assets/images/assessment.svg",
                        showExapansionMenu: false,
                        headerText: "ASSET CREATION",
                        buttonText: "asset creation",
                        onButtonClicked: () {
                          viewModel.goToPlantAssetCreationPage();
                        },
                      ),
                    ),
                  ],
                ),
              )),
        );
      },
      viewModelBuilder: () => PlantViewModel(),
    );
  }
}
