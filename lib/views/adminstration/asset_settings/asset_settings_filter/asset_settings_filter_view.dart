import 'package:flutter/material.dart';
import 'package:insite/utils/enums.dart';
import 'package:insite/views/adminstration/asset_settings/estimated_burn_rate/estimated_burn_rate_view.dart';
import 'package:insite/views/adminstration/asset_settings/estimated_payload_mileage_volume/estimated_mileage_widget.dart';
import 'package:insite/views/adminstration/asset_settings/estimated_payload_mileage_volume/estimated_payload_cycle.dart';
import 'package:insite/views/adminstration/asset_settings/estimated_payload_mileage_volume/estimated_volume_widget.dart';
import 'package:insite/views/adminstration/asset_settings/targetcycle_volume_payload/targetcycle_volume_payload_view.dart';
import 'package:insite/views/adminstration/asset_settings/asset_settings_filter/filter_item_widget.dart';
import 'package:insite/views/adminstration/asset_settings/estimated_runtime/estimated_runtime_view.dart';
import 'package:insite/widgets/smart_widgets/insite_scaffold.dart';
import 'package:stacked/stacked.dart';
import 'asset_settings_filter_view_model.dart';

class AssetSettingsFilterView extends StatefulWidget {
  final List<String>? assetUids;

  AssetSettingsFilterView({this.assetUids});

  @override
  _AssetSettingsFilterViewState createState() =>
      _AssetSettingsFilterViewState();
}

class _AssetSettingsFilterViewState extends State<AssetSettingsFilterView> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<AssetSettingsFilterViewModel>.reactive(
      builder: (BuildContext context, AssetSettingsFilterViewModel viewModel,
          Widget? _) {
        return InsiteScaffold(
          viewModel: viewModel,
          screenType: ScreenType.ASSET_SETTINGS_FILTER,
          body: Container(
              height: MediaQuery.of(context).size.height * 0.95,
              decoration: BoxDecoration(
                  color: Theme.of(context).backgroundColor,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(8),
                    topRight: Radius.circular(8),
                    bottomLeft: Radius.circular(8),
                    bottomRight: Radius.circular(8),
                  ),
                  border: Border.all(
                      color: Theme.of(context).textTheme.bodyText1!.color!)),
              child: ListView(
                children: [
                  SizedBox(
                    height: 8,
                  ),
                  FilterItemWidget(
                    text: "set estimated runtime/idling targets".toUpperCase(),
                    body: EstimatedRunTimeWidgetView(
                      assetUids: widget.assetUids,
                    ),
                  ),
                  // SizedBox(
                  //   height: 8,
                  // ),
                  // FilterItemWidget(
                  //   text: "set estimated fuel burn rate".toUpperCase(),
                  //   body: EstimatedBurnRateWidget(
                  //     assetUids: widget.assetUids,
                  //   ),
                  // ),
                  // SizedBox(
                  //   height: 8,
                  // ),
                  // FilterItemWidget(
                  //   text: "set estimated mileage".toUpperCase(),
                  //   body: EstimatedMileage(
                  //     // assetSetting: widget.assetSetting,
                  //     assetUids: widget.assetUids,
                  //   ),
                  // ),
                  // SizedBox(
                  //   height: 8,
                  // ),
                  // FilterItemWidget(
                  //   text: "set estimated voume per cycle".toUpperCase(),
                  //   body: EstimatedVolumeWidget(
                  //       //assetSetting: widget.assetSetting,
                  //       ),
                  // ),
                  // SizedBox(
                  //   height: 8,
                  // ),
                  // FilterItemWidget(
                  //   text: "set estimated payload per cycle".toUpperCase(),
                  //   body: EstimatedPayLoadPerCycle(
                  //       //  assetSetting: widget.assetSetting,
                  //       ),
                  // ),
                  // SizedBox(
                  //   height: 8,
                  // ),
                  // FilterItemWidget(
                  //   text: "set target cycles/estimated volume/payload"
                  //       .toUpperCase(),
                  //   body: TargetCycleVolumePayloadWidget(
                  //     assetUids: widget.assetUids,
                  //   ),
                  // )
                ],
              )),
        );
      },
      viewModelBuilder: () => AssetSettingsFilterViewModel(),
    );
  }
}
