import 'package:flutter/material.dart';
import 'package:insite/assetlist/model.dart';
import 'package:insite/theme/colors.dart';
import 'package:insite/widgets/smart_widgets/asset_item.dart';
import 'package:stacked/stacked.dart';
import 'fleet_view_model.dart';

class FleetView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<FleetViewModel>.reactive(
      builder: (BuildContext context, FleetViewModel viewModel, Widget _) {
        return Scaffold(
            backgroundColor: bgcolor,
            body: ListView.builder(
                itemCount: assetList.length,
                padding: EdgeInsets.all(16),
                itemBuilder: (context, index) {
                  Asset name = assetList[index];
                  return AssetItem(
                    asset: name,
                  );
                }));
      },
      viewModelBuilder: () => FleetViewModel(),
    );
  }
}
