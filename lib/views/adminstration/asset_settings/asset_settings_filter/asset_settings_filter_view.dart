import 'package:flutter/material.dart';
import 'package:insite/views/adminstration/asset_settings/asset_settings_filter/custom_widgets/estimated_burn_rate_widget.dart';
import 'package:insite/views/adminstration/asset_settings/asset_settings_filter/custom_widgets/estimated_mileage_widget.dart';
import 'package:insite/views/adminstration/asset_settings/asset_settings_filter/custom_widgets/estimated_payload_cycle.dart';
import 'package:insite/views/adminstration/asset_settings/asset_settings_filter/custom_widgets/estimated_runtime_widgets.dart';
import 'package:insite/views/adminstration/asset_settings/asset_settings_filter/custom_widgets/estimated_volume_widget.dart';
import 'package:insite/views/adminstration/asset_settings/asset_settings_filter/filter_item_widget.dart';
import 'package:insite/widgets/dumb_widgets/insite_progressbar.dart';
import 'package:stacked/stacked.dart';
import 'asset_settings_filter_view_model.dart';

class AssetSettingsFilterView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<AssetSettingsFilterViewModel>.reactive(
      builder: (BuildContext context, AssetSettingsFilterViewModel viewModel,
          Widget _) {
        return Container(
            height: MediaQuery.of(context).size.height * 0.68,
            decoration: BoxDecoration(
                color: Theme.of(context).backgroundColor,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(8),
                  topRight: Radius.circular(8),
                  bottomLeft: Radius.circular(8),
                  bottomRight: Radius.circular(8),
                ),
                border: Border.all(
                    color: Theme.of(context).textTheme.bodyText1.color)),
            child: SingleChildScrollView(
              child: Column(
                children: [
                  SizedBox(
                    height: 8,
                  ),
                  FilterItemWidget(
                    text: "set estimated runtime/idling targets".toUpperCase(),
                    body: EstimatedRunTimeWidget(),
                  ),
                  SizedBox(
                    height: 8,
                  ),
                  FilterItemWidget(
                    text: "set estimated fuel burn rate".toUpperCase(),
                    body: EstimatedBurnRateWidget(),
                  ),
                  SizedBox(
                    height: 8,
                  ),
                  FilterItemWidget(
                    text: "set estimated mileage".toUpperCase(),
                    body: EstimatedMileage(),
                  ),
                  SizedBox(
                    height: 8,
                  ),
                  FilterItemWidget(
                    text: "set estimated voume per cycle".toUpperCase(),
                    body: EstimatedVolumeWidget(),
                  ),
                  SizedBox(
                    height: 8,
                  ),
                  FilterItemWidget(
                    text: "set estimated payload per cycle".toUpperCase(),
                    body: EstimatedPayLoadPerCycle(),
                  )
                ],
              ),
            ));
      },
      viewModelBuilder: () => AssetSettingsFilterViewModel(),
    );
  }
}
