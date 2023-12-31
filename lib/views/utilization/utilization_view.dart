import 'package:flutter/material.dart';
import 'package:insite/core/insite_data_provider.dart';
import 'package:insite/theme/colors.dart';
import 'package:insite/utils/enums.dart';
import 'package:insite/utils/helper_methods.dart';
import 'package:insite/views/utilization/tabs/graph_view/utilization_graph_view.dart';
import 'package:insite/views/utilization/tabs/list/utilization_list_view.dart';
import 'package:insite/views/utilization/utilization_view_model.dart';
import 'package:insite/widgets/dumb_widgets/insite_text.dart';
import 'package:insite/widgets/dumb_widgets/toggle_button.dart';
import 'package:insite/widgets/smart_widgets/insite_scaffold.dart';
import 'package:logger/logger.dart';
import 'package:stacked/stacked.dart';

class UtilLizationView extends StatefulWidget {
  @override
  _UtilLizationViewState createState() => _UtilLizationViewState();
}

class _UtilLizationViewState extends State<UtilLizationView> {
    bool isListSelected = true;
  int rangeChoice = 1;
  bool isRangeSelectionVisible = false;

  final GlobalKey<UtilizationListViewState> listViewKey = new GlobalKey();
  final GlobalKey<UtilizationGraphViewState> graphViewKey = new GlobalKey();

  

  void refreshWithFilter() {
    if (isListSelected) {
      listViewKey.currentState!.onFilterApplied();
    } else {
      graphViewKey.currentState!.onFilterApplied();
    }
  }

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<UtilLizationViewModel>.reactive(
        builder:
            (BuildContext context, UtilLizationViewModel viewModel, Widget? _) {
          return InsiteInheritedDataProvider(
            count: viewModel.appliedFilters!.length,
            child: InsiteScaffold(
              screenType: ScreenType.UTILIZATION,
              viewModel: viewModel,
              onFilterApplied: () {
              //  viewModel.clearDashboardFiltersDb();
                viewModel.refresh();
               // refreshWithFilter();
              },
              onRefineApplied: () {
                viewModel.refresh();
                //refreshWithFilter();
              },
              body: Stack(
                children: [
                  Column(
                    children: [
                      viewModel.isListSelected
                          ? Flexible(
                              child: UtilizationListView(
                                key: listViewKey,
                              ),
                            )
                          : Flexible(
                              child: UtilizationGraphView(
                                key: graphViewKey,
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
                          text: Utils.getPageTitle(ScreenType.UTILIZATION),
                          color: Theme.of(context).textTheme.bodyText1!.color,
                          overflow: TextOverflow.ellipsis,
                          fontWeight: FontWeight.bold,
                          size: 16,
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        // Row(
                        //   children: [
                        //     ToggleButton(
                        //         label1: '  list  ',
                        //         label2: '  graph  ',
                        //         optionSelected: (bool value) {
                        //           setState(() {
                        //             isListSelected = value;
                        //           });
                        //         }),
                        //     Spacer(),
                        //   ],
                        // ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          );
        },
        viewModelBuilder: () => UtilLizationViewModel());
  }
}
