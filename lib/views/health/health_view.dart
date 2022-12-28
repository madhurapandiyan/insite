import 'package:flutter/material.dart';
import 'package:insite/core/insite_data_provider.dart';
import 'package:insite/theme/colors.dart';
import 'package:insite/utils/enums.dart';
import 'package:insite/utils/helper_methods.dart';
import 'package:insite/views/health/asset/asset_view.dart';
import 'package:insite/views/health/fault/fault_view.dart';
import 'package:insite/widgets/dumb_widgets/insite_text.dart';
import 'package:insite/widgets/dumb_widgets/toggle_button.dart';
import 'package:insite/widgets/smart_widgets/insite_scaffold.dart';
import 'package:stacked/stacked.dart';
import 'health_view_model.dart';

class HealthView extends StatefulWidget {
  @override
  _HealthViewState createState() => _HealthViewState();
}

class _HealthViewState extends State<HealthView> {
  @override
  void initState() {
    super.initState();
  }

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
    return ViewModelBuilder<HealthViewModel>.reactive(
      builder: (BuildContext context, HealthViewModel viewModel, Widget? _) {
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
            screenType: ScreenType.HEALTH,
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
                          : 
                          Flexible(
                              child:
                               AssetView(
                                key: assetViewKey,
                              ),
                            ),
                    ],
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        vertical: 10.0, horizontal: 16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        InsiteTextOverFlow(
                          text: Utils.getPageTitle(ScreenType.HEALTH),
                          color: Theme.of(context).textTheme.bodyText1!.color,
                          overflow: TextOverflow.ellipsis,
                          fontWeight: FontWeight.bold,
                          size: 16,
                        ),
                        SizedBox(height: 10,),
                        Row(
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
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
      viewModelBuilder: () => HealthViewModel(),
    );
  }
}
