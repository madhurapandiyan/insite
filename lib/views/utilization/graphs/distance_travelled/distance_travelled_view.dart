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
  _DistanceTravelledViewState createState() => _DistanceTravelledViewState();
}

class _DistanceTravelledViewState extends State<DistanceTravelledView> {
  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<DistanceTravelledViewModel>.reactive(
      builder: (BuildContext context, DistanceTravelledViewModel viewModel,
          Widget _) {
        if (viewModel.loading) return CircularProgressIndicator();
        return ListView.builder(
            itemCount: viewModel.utilLizationListData.length,
            itemBuilder: (BuildContext context, int index) {
              return PercentageWidget(
                  label:
                      viewModel.utilLizationListData[index].assetSerialNumber,
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
            });
      },
      viewModelBuilder: () =>
          DistanceTravelledViewModel(widget.startDate, widget.endDate),
    );
  }
}
