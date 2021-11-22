import 'package:flutter/material.dart';
import 'package:insite/core/insite_data_provider.dart';
import 'package:insite/utils/enums.dart';
import 'package:insite/views/adminstration/reusable_widget/asset_cards_small.dart';
import 'package:insite/widgets/smart_widgets/insite_scaffold.dart';
import 'package:stacked/stacked.dart';
import 'subscription_view_model.dart';

class SubscriptionView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<SubscriptionViewModel>.reactive(
      builder:
          (BuildContext context, SubscriptionViewModel viewModel, Widget _) {
        return InsiteInheritedDataProvider(
          count: viewModel.appliedFilters.length,
          child: InsiteScaffold(
            viewModel: viewModel,
            screenType: ScreenType.SUBSCRIPTION,
            onFilterApplied: () {
              //viewModel.refresh();
            },
            onRefineApplied: () {
              //viewModel.refresh();
            },
            body: SingleChildScrollView(
              child: Column(
                children: [
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
                          headerText: "REGISTRATION",
                          icon: "assets/images/path0.svg",
                          buttonTitle: [
                            AdminAssetsButtonType.values[9],
                          ],
                          height: 10.0,
                          onCallbackSelected: (value) {
                            viewModel.onRespectiveButtonClicked(value);
                          }),
                    ],
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      AssetCardsSmall(
                          headerText: "FLEET STATUS",
                          icon: "assets/images/flet.svg",
                          showExapansionMenu: false,
                          buttonTitle: [
                            AdminAssetsButtonType.values[10],
                          ],
                          height: 20,
                          onCallbackSelected: (value) {
                            // viewModel.onRespectiveButtonClicked(value);
                          }),
                      AssetCardsSmall(
                          headerText: "SMS MANAGEMENT",
                          icon: "assets/images/sms.svg",
                          buttonTitle: [
                            AdminAssetsButtonType.values[11],
                          ],
                          showExapansionMenu: false,
                          height: 25,
                          onCallbackSelected: (value) {
                             viewModel.onRespectiveButtonClicked(value);
                          }),
                    ],
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      AssetCardsSmall(
                          headerText: "REPLACEMENT",
                          icon: "assets/images/export.svg",
                          buttonTitle: [
                            AdminAssetsButtonType.values[12],
                          ],
                          showExapansionMenu: false,
                          height: 20.0,
                          onCallbackSelected: (value) {
                             viewModel.onRespectiveButtonClicked(value);
                          }),
                      AssetCardsSmall(
                          headerText: "TRANSFER HISTORY",
                          icon: "assets/images/transfer.svg",
                          showExapansionMenu: false,
                          buttonTitle: [
                            AdminAssetsButtonType.values[13],
                          ],
                          height: 20.0,
                          onCallbackSelected: (value) {
                            // viewModel.onRespectiveButtonClicked(value);
                          }),
                    ],
                  ),
                ],
              ),
            ),
          ),
        );
      },
      viewModelBuilder: () => SubscriptionViewModel(),
    );
  }
}
