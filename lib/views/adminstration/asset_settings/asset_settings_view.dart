import 'package:charts_flutter/flutter.dart';
import 'package:flutter/material.dart';
import 'package:insite/core/models/asset_settings.dart';
import 'package:insite/theme/colors.dart';
import 'package:insite/utils/enums.dart';
import 'package:insite/views/adminstration/reusable_widget/manage_asset_configuration_card.dart';
import 'package:insite/widgets/dumb_widgets/insite_text.dart';
import 'package:insite/widgets/smart_widgets/insite_scaffold.dart';
import 'package:stacked/stacked.dart';
import 'asset_settings_view_model.dart';

class AssetSettingsView extends StatefulWidget {
  @override
  _AssetSettingsViewState createState() => _AssetSettingsViewState();
}

class _AssetSettingsViewState extends State<AssetSettingsView> {
  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<AssetSettingsViewModel>.reactive(
      builder:
          (BuildContext context, AssetSettingsViewModel viewModel, Widget _) {
        return InsiteScaffold(
            viewModel: viewModel,
            body: Container(
              color: bgcolor,
              child: Column(
                children: [
                  SizedBox(
                    height: 40,
                  ),
                  Row(
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(left: 16.0),
                        child: InsiteText(
                          text: "manage asset configuration".toUpperCase(),
                          fontWeight: FontWeight.w700,
                          size: 14,
                          color: textcolor,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 36,
                  ),
                  Expanded(
                    child: ListView.builder(
                      itemCount: viewModel.asset.length,
                      itemBuilder: (_, index) {
                        AssetSetting assetSetting = viewModel.asset[index];
                        return ManageAssetConfigurationCard(
                          assetSetting: assetSetting,
                        );
                      },
                    ),
                  )
                ],
              ),
            ));
      },
      viewModelBuilder: () => AssetSettingsViewModel(),
    );
  }
}
