import 'package:flutter/material.dart';
import 'package:insite/core/insite_data_provider.dart';
import 'package:insite/utils/enums.dart';
import 'package:insite/views/adminstration/reusable_widget/asset_cards_small.dart';
import 'package:insite/widgets/smart_widgets/asset_card_large.dart';
import 'package:insite/widgets/smart_widgets/insite_scaffold.dart';
import 'package:stacked/stacked.dart';
import 'sub_registration_view_model.dart';

class SubRegistrationView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<SubRegistrationViewModel>.reactive(
      builder:
          (BuildContext context, SubRegistrationViewModel viewModel, Widget _) {
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
                padding: const EdgeInsets.symmetric(
                  vertical: 30.0,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Center(
                      child: AssetCardsLarge(
                        headerText: 'REGISTRATION',
                        icon: "assets/images/path0.svg",
                        height: 20,
                        buttonTitle: [
                          AdminAssetsButtonType.values[14],
                          AdminAssetsButtonType.values[15],
                          AdminAssetsButtonType.values[16],
                          AdminAssetsButtonType.values[17],
                        ],
                        onCallbackSelected: (value) {
                          viewModel.onRespectiveButtonClicked(value);
                        },
                      ),
                    ),
                  ],
                ),
              )),
        );
      },
      viewModelBuilder: () => SubRegistrationViewModel(),
    );
  }
}
