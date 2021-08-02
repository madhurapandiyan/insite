import 'package:flutter/material.dart';
import 'package:insite/core/models/fault.dart';
import 'package:insite/widgets/dumb_widgets/empty_view.dart';
import 'package:insite/widgets/dumb_widgets/health_asset_list_item.dart';
import 'package:stacked/stacked.dart';

import 'asset_view_model.dart';

class AssetView extends StatefulWidget {
  AssetView({Key key}) : super(key: key);

  @override
  AssetViewState createState() => AssetViewState();
}

class AssetViewState extends State<AssetView> {
  onFilterApplied() {
    // viewModel.refresh();
  }
  var viewModel;

  @override
  void initState() {
    viewModel = AssetViewModel();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<AssetViewModel>.reactive(
      viewModelBuilder: () => viewModel,
      builder: (BuildContext context, AssetViewModel model, Widget _) {
        return Column(
          children: [
            SizedBox(
              height: 60,
            ),
            Expanded(
              child: model.loading
                  ? Container(child: Center(child: CircularProgressIndicator()))
                  : model.faults.isNotEmpty
                      ? ListView.builder(
                          itemCount: model.faults.length,
                          shrinkWrap: true,
                          itemBuilder: (context, index) {
                            Fault fault = model.faults[index];
                            return HealthAssetListItem(
                              fault: fault,
                              onCallback: () {
                                viewModel.onDetailPageSelected(fault);
                              },
                            );
                          },
                        )
                      : EmptyView(
                          title: "No Assets Found",
                        ),
            ),
          ],
        );
      },
    );
  }
}
