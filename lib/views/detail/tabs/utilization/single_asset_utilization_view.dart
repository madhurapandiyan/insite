import 'package:flutter/material.dart';
import 'package:insite/core/models/asset_detail.dart';
import 'package:insite/utils/enums.dart';
import 'package:insite/views/detail/tabs/utilization/single_asset_utilization_view_model.dart';
import 'package:insite/views/detail/tabs/utilization/tabs/graph/single_asset_utilization_graph_view.dart';
import 'package:insite/views/detail/tabs/utilization/tabs/list/single_asset_utilization_list_view.dart';
import 'package:insite/widgets/dumb_widgets/toggle_button.dart';
import 'package:logger/logger.dart';
import 'package:stacked/stacked.dart';

class SingleAssetUtilizationView extends StatefulWidget {
  final AssetDetail? detail;
  SingleAssetUtilizationView({this.detail});

  @override
  _SingleAssetUtilizationViewState createState() =>
      _SingleAssetUtilizationViewState();
}

class _SingleAssetUtilizationViewState
    extends State<SingleAssetUtilizationView> {
  bool isListSelected = true;
  ProductFamilyType productFamilyType = ProductFamilyType.ALL;
  @override
  void initState() {
    Logger()
        .d("selected asset product familiy ${widget.detail!.productFamily}");
    if (widget.detail!.productFamily == "BACKHOE LOADER") {
      productFamilyType = ProductFamilyType.BACKHOE_LOADER;
    } else if (widget.detail!.productFamily == "EXCAVATOR") {
      productFamilyType = ProductFamilyType.EXCAVATOR;
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<SingleAssetUtilizationViewModel>.reactive(
        builder: (BuildContext context,
            SingleAssetUtilizationViewModel viewModel, Widget? _) {
          return Container(
            decoration: BoxDecoration(
              color: Theme.of(context).backgroundColor,
              border: Border.all(
                  color: Theme.of(context).textTheme.bodyText1!.color!,
                  width: 0.0),
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
                Container(
                  padding: EdgeInsets.all(16.0),
                  margin: EdgeInsets.only(
                      top: productFamilyType != ProductFamilyType.ALL &&
                              isListSelected
                          ? 24
                          : 0),
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
