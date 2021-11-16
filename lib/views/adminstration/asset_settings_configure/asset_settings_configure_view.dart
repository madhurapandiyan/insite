import 'package:flutter/material.dart';
import 'package:insite/views/add_new_user/reusable_widget/custom_dropdown_widget.dart';
import 'package:insite/widgets/dumb_widgets/insite_text.dart';
import 'package:insite/widgets/smart_widgets/insite_scaffold.dart';
import 'package:stacked/stacked.dart';
import 'asset_settings_configure_view_model.dart';

class AssetSettingsConfigureView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<AssetSettingsConfigureViewModel>.reactive(
      builder: (BuildContext context, AssetSettingsConfigureViewModel viewModel,
          Widget _) {
        return InsiteScaffold(
            viewModel: viewModel,
            body: Column(
              children: [
                SizedBox(
                  height: 30,
                ),
                Row(
                  children: [
                    SizedBox(
                      width: 10,
                    ),
                    InsiteText(
                      text: "Configure",
                      fontWeight: FontWeight.w700,
                      size: 14,
                    ),
                    SizedBox(
                      width: 10,
                    ),
                  ],
                )
              ],
            ));
      },
      viewModelBuilder: () => AssetSettingsConfigureViewModel(),
    );
  }
}
