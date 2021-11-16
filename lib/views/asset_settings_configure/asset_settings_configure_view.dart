import 'package:flutter/material.dart';
import 'package:insite/views/adminstration/asset_settings_configure/asset_settings_configure_view_model.dart';
import 'package:stacked/stacked.dart';

          
class AssetSettingsConfigureView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<AssetSettingsConfigureViewModel>.reactive(
      builder: (BuildContext context, AssetSettingsConfigureViewModel viewModel, Widget _) {
        return Scaffold(
          appBar: AppBar(),
          body: Center(
            child: Text('AssetSettingsConfigure View'),
          ),
        );
      },
      viewModelBuilder: () => AssetSettingsConfigureViewModel(),
    );
  }
}
