import 'package:flutter/material.dart';
import 'package:insite/core/insite_data_provider.dart';
import 'package:insite/utils/enums.dart';
import 'package:insite/views/health/asset/asset_view.dart';
import 'package:insite/views/health/fault/fault_view.dart';
import 'package:insite/widgets/dumb_widgets/toggle_button.dart';
import 'package:insite/widgets/smart_widgets/insite_scaffold.dart';
import 'package:stacked/stacked.dart';
import 'maintenance_view_model.dart';

class MaintenanceView extends StatefulWidget {
  @override
  State<MaintenanceView> createState() => _MaintenanceViewState();
}

class _MaintenanceViewState extends State<MaintenanceView> {
  bool isListSelected = true;

  final GlobalKey<FaultViewState> faultViewKey = new GlobalKey();

  final GlobalKey<AssetViewState> assetViewKey = new GlobalKey();

  void refreshWithFilter() {
    if (isListSelected) {
      faultViewKey.currentState!.onFilterApplied();
    } else {
      assetViewKey.currentState!.onFilterApplied();
    }
  }

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<MaintenanceViewModel>.reactive(
      builder:
          (BuildContext context, MaintenanceViewModel viewModel, Widget? _) {
        return InsiteInheritedDataProvider(
          count: viewModel.appliedFilters!.length,
          child: InsiteScaffold(
            viewModel: viewModel,
            onFilterApplied: () {
              //viewModel.refresh();
              refreshWithFilter();
            },
            onRefineApplied: () {
              // viewModel.refresh();
              refreshWithFilter();
            },
            screenType: ScreenType.MAINTENANCE,
            body: Container(
              child: Stack(
                children: [
                  Column(
                    children: [
                      isListSelected
                          ? Flexible(
                              child: FaultView(
                                key: faultViewKey,
                              ),
                            )
                          : Flexible(
                              child: AssetView(
                                key: assetViewKey,
                              ),
                            ),
                    ],
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        vertical: 10.0, horizontal: 16),
                    child: Row(
                      children: [
                        ToggleButton(
                            label1: 'Fault View',
                            label2: 'Asset View',
                            optionSelected: (bool value) {
                              setState(() {
                                isListSelected = value;
                              });
                            }),
                        Spacer(),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
      viewModelBuilder: () => MaintenanceViewModel(),
    );
  }
}