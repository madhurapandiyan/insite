import 'package:flutter/material.dart';
import 'package:insite/core/insite_data_provider.dart';
import 'package:insite/utils/enums.dart';
import 'package:insite/widgets/smart_widgets/asset_card_large.dart';
import 'package:insite/widgets/smart_widgets/insite_scaffold.dart';
import 'package:stacked/stacked.dart';
import 'replacement_view_model.dart';

class ReplacementView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<ReplacementViewModel>.reactive(
      builder:
          (BuildContext context, ReplacementViewModel viewModel, Widget _) {
        return InsiteInheritedDataProvider(
          //count: viewModel.appliedFilters.length,
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
                        headerText: 'SMS MANAGEMENT',
                        icon: "assets/images/message.svg",
                        height: 30,
                        buttonTitle: [
                          AdminAssetsButtonType.values[22],
                          AdminAssetsButtonType.values[23],
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
      viewModelBuilder: () => ReplacementViewModel(),
    );
  }
}
