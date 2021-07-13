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
                Column(
                  children: [
                    isListSelected
                        ? Flexible(
                            child: SingleAssetUtilizationListView(
                                detail: widget.detail))
                        : Flexible(
                            child: SingleAssetUtilizationGraphView(
                                detail: widget.detail)),
                  ],
                ),
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
}
