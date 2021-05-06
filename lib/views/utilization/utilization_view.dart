import 'package:flutter/material.dart';
import 'package:insite/core/models/utilization_data.dart';
import 'package:insite/theme/colors.dart';
import 'package:insite/views/home/home_view.dart';
import 'package:insite/views/utilization/utilization_view_model.dart';
import 'package:insite/widgets/dumb_widgets/empty_view.dart';
import 'package:insite/widgets/smart_widgets/asset_utilizationlist.dart';
import 'package:insite/widgets/smart_widgets/insite_scaffold.dart';
import 'package:stacked/stacked.dart';

class UtilLizationView extends StatefulWidget {
  @override
  _UtilLizationViewState createState() => _UtilLizationViewState();
}

class _UtilLizationViewState extends State<UtilLizationView> {
  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<UtilLizationViewModel>.reactive(
        builder:
            (BuildContext context, UtilLizationViewModel viewModel, Widget _) {
          return InsiteScaffold(
            screenType: ScreenType.UTILIZATION,
            body: Container(
              color: bgcolor,
              child: viewModel.loading
                  ? Center(
                      child: CircularProgressIndicator(),
                    )
                  : viewModel.utilLizationList.isNotEmpty
                      ? Column(
                          children: [
                            Expanded(
                                child: ListView.separated(
                                    separatorBuilder: (context, index) {
                                      return Divider();
                                    },
                                    shrinkWrap: true,
                                    physics: ClampingScrollPhysics(),
                                    scrollDirection: Axis.vertical,
                                    itemCount:
                                        viewModel.utilLizationList.length,
                                    padding: EdgeInsets.only(
                                        top: 30.0, left: 5.0, right: 5.0),
                                    itemBuilder: (context, index) {
                                      UtilizationData utilizationData =
                                          viewModel.utilLizationList[index];
                                      return AssetOperation(
                                          data: utilizationData);
                                    }))
                          ],
                        )
                      : EmptyView(title: "No Results"),
            ),
          );
        },
        viewModelBuilder: () => UtilLizationViewModel());
  }
}