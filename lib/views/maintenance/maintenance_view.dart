import 'package:flutter/material.dart';
import 'package:insite/core/insite_data_provider.dart';
import 'package:insite/utils/enums.dart';
import 'package:insite/utils/helper_methods.dart';
import 'package:insite/views/health/asset/asset_view.dart';
import 'package:insite/views/health/fault/fault_view.dart';
import 'package:insite/views/maintenance/asset/asset_view.dart';
import 'package:insite/views/maintenance/main/main_view.dart';
import 'package:insite/widgets/dumb_widgets/insite_text.dart';
import 'package:insite/widgets/dumb_widgets/toggle_button.dart';
import 'package:insite/widgets/smart_widgets/insite_scaffold.dart';
import 'package:logger/logger.dart';
import 'package:stacked/stacked.dart';
import 'maintenance_view_model.dart';

class MaintenanceView extends StatefulWidget {
  @override
  State<MaintenanceView> createState() => _MaintenanceViewState();
}

class _MaintenanceViewState extends State<MaintenanceView> {
  bool isListSelected = true;

  final GlobalKey<MainViewState> mainViewKey = new GlobalKey();

  final GlobalKey<AssetMaintenanceViewState> assetMaintenaceViewKey =
      new GlobalKey();

  void refreshWithFilter() {
    if (isListSelected) {
      mainViewKey.currentState!.onFilterApplied();
    } else {
      assetMaintenaceViewKey.currentState!.onFilterApplied();
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
              viewModel.refresh();
              refreshWithFilter();
            },
            onRefineApplied: () {
              viewModel.refresh();
              refreshWithFilter();
            },
            screenType: ScreenType.MAINTENANCE,
            body: Container(
              child: Column(
                children: [
                  
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        vertical: 10.0, horizontal: 16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        InsiteTextOverFlow(
                          text: Utils.getPageTitle(ScreenType.MAINTENANCE),
                          color: Theme.of(context).textTheme.bodyText1!.color,
                          overflow: TextOverflow.ellipsis,
                          fontWeight: FontWeight.bold,
                          size: 16,
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(
                            vertical: 10.0,
                          ),
                          child: Row(
                            children: [
                              ToggleButton(
                                  label1: 'Maintenance View',
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
                  isListSelected
                      ? Flexible(
                          child: MainView(
                            key: mainViewKey,
                          ),
                        )
                      : Flexible(
                          child: AssetMaintenanceView(
                            key: assetMaintenaceViewKey,
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
