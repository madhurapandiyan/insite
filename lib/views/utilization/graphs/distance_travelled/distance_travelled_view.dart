import 'package:flutter/material.dart';
import 'package:insite/theme/colors.dart';
import 'package:insite/widgets/smart_widgets/percentage_widget.dart';
import 'package:stacked/stacked.dart';
import 'distance_travelled_view_model.dart';

class DistanceTravelledView extends StatefulWidget {
  final String startDate;
  final String endDate;
  const DistanceTravelledView({Key key, this.startDate, this.endDate})
      : super(key: key);

  @override
  DistanceTravelledViewState createState() => DistanceTravelledViewState();
}

class DistanceTravelledViewState extends State<DistanceTravelledView> {
  var viewModel;

  @override
  void initState() {
    viewModel = DistanceTravelledViewModel(widget.startDate, widget.endDate);
    super.initState();
  }

  @override
  void dispose() {
    viewModel.dispose();
    super.dispose();
  }

  refresh(String startDate, String endDate) {
    viewModel.updateDate(startDate, endDate);
    viewModel.refresh();
  }

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<DistanceTravelledViewModel>.reactive(
      builder: (BuildContext context, DistanceTravelledViewModel viewModel,
          Widget _) {
        if (viewModel.loading) return Center(child: CircularProgressIndicator());
        return Stack(
          children: [
            Column(
              children: [
                Expanded(
                  child: ListView.builder(
                      itemCount: viewModel.utilLizationListData.length,
                      controller: viewModel.scrollController,
                      scrollDirection: Axis.vertical,
                      shrinkWrap: true,
                      itemBuilder: (BuildContext context, int index) {
                        return PercentageWidget(
                            label: viewModel
                                .utilLizationListData[index].assetSerialNumber,
                            value: viewModel.utilLizationListData[index]
                                        .distanceTravelledKilometers ==
                                    null
                                ? 'NA'
                                : '${viewModel.utilLizationListData[index].distanceTravelledKilometers}',
                            percentage: viewModel.utilLizationListData[index]
                                        .distanceTravelledKilometers ==
                                    null
                                ? 0
                                : viewModel.utilLizationListData[index]
                                        .distanceTravelledKilometers /
                                    1000,
                            color: creamCan);
                      }),
                ),
                viewModel.loadingMore
                    ? Padding(
                        padding: EdgeInsets.all(8),
                        child: CircularProgressIndicator(),
                      )
                    : SizedBox(),
              ],
            ),
            viewModel.isRefreshing
                ? Center(
                    child: CircularProgressIndicator(),
                  )
                : SizedBox()
          ],
        );
      },
      viewModelBuilder: () => viewModel,
    );
  }
}
