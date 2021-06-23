import 'package:flutter/material.dart';
import 'package:insite/core/models/asset_detail.dart';
import 'package:insite/theme/colors.dart';
import 'package:insite/views/detail/tabs/utilization/single_asset_utilization_view_model.dart';
import 'package:insite/views/detail/tabs/utilization/tabs/graph/single_asset_utilization_graph_view.dart';
import 'package:insite/views/detail/tabs/utilization/tabs/list/single_asset_utilization_list_view.dart';
import 'package:insite/widgets/dumb_widgets/toggle_button.dart';
import 'package:stacked/stacked.dart';

class SingleAssetUtilizationView extends StatefulWidget {
  final AssetDetail detail;
  SingleAssetUtilizationView({this.detail});

  @override
  _SingleAssetUtilizationViewState createState() =>
      _SingleAssetUtilizationViewState();
}

class _SingleAssetUtilizationViewState
    extends State<SingleAssetUtilizationView> {
  bool isListSelected = true;

  List<DateTime> dateRange = [];
  List<DateTime> selectedDateRange = [
    DateTime.now().subtract(Duration(days: DateTime.now().weekday)),
    DateTime.now()
  ];

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<SingleAssetUtilizationViewModel>.reactive(
        builder: (BuildContext context,
            SingleAssetUtilizationViewModel viewModel, Widget _) {
          return Container(
            decoration: BoxDecoration(
              color: mediumgrey,
              border: Border.all(color: black, width: 0.0),
              borderRadius: BorderRadius.all(Radius.circular(16)),
            ),
            child: Stack(
              children: [
                isListSelected
                    ? Expanded(
                        child: SingleAssetUtilizationListView(
                            detail: widget.detail))
                    : Expanded(
                        child: SingleAssetUtilizationGraphView(
                            detail: widget.detail)),
                Padding(
                  padding: EdgeInsets.all(16.0),
                  child: Row(
                    children: [
                      ToggleButton(
                          label1: 'list',
                          label2: 'graph',
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
          );
        },
        viewModelBuilder: () => SingleAssetUtilizationViewModel());
  }

  // Widget getGraphWidgetForRuntimePerformance(
  //     SingleAssetUtilization singleAssetUtilization, int index) {
  //   if (rangeChoice == 1)
  //     return PercentageWidget(
  //         color: sandyBrown,
  //         label:
  //             '${singleAssetUtilization.daily[index].startDate.day}/${singleAssetUtilization.daily[index].startDate.month}/${singleAssetUtilization.daily[index].startDate.year}\n',
  //         percentage: singleAssetUtilization.daily[index].data.runtimeHours ==
  //                 null
  //             ? null
  //             : singleAssetUtilization.daily[index].data.runtimeHours * 100);
  //   else if (rangeChoice == 2)
  //     return PercentageWidget(
  //         color: bermudaGrey,
  //         label:
  //             '${singleAssetUtilization.weekly[index].startDate.day}/${singleAssetUtilization.weekly[index].startDate.month}/${singleAssetUtilization.weekly[index].startDate.year}\n${singleAssetUtilization.weekly[index].endDate.day}/${singleAssetUtilization.weekly[index].endDate.month}/${singleAssetUtilization.weekly[index].endDate.year}',
  //         percentage: singleAssetUtilization.weekly[index].data.runtimeHours ==
  //                 null
  //             ? null
  //             : singleAssetUtilization.weekly[index].data.runtimeHours * 100);
  //   else
  //     return PercentageWidget(
  //         color: bermudaGrey,
  //         label:
  //             '${singleAssetUtilization.monthly[index].startDate.day}/${singleAssetUtilization.monthly[index].startDate.month}/${singleAssetUtilization.monthly[index].startDate.year}\n${singleAssetUtilization.monthly[index].endDate.day}/${singleAssetUtilization.monthly[index].endDate.month}/${singleAssetUtilization.monthly[index].endDate.year}',
  //         percentage: singleAssetUtilization.monthly[index].data.runtimeHours ==
  //                 null
  //             ? null
  //             : singleAssetUtilization.monthly[index].data.runtimeHours * 100);
  // }
}
