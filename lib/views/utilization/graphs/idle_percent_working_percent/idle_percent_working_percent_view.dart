import 'package:flutter/material.dart';
import 'package:insite/theme/colors.dart';
import 'package:insite/widgets/smart_widgets/percentage_widget.dart';
import 'package:stacked/stacked.dart';
import 'idle_percent_working_percent_view_model.dart';

class IdlePercentWorkingPercentView extends StatefulWidget {
  final int rangeChoice;
  final String startDate;
  final String endDate;
  const IdlePercentWorkingPercentView(
      {Key key, this.rangeChoice, this.startDate, this.endDate})
      : super(key: key);

  @override
  _IdlePercentWorkingPercentViewState createState() =>
      _IdlePercentWorkingPercentViewState();
}

class _IdlePercentWorkingPercentViewState
    extends State<IdlePercentWorkingPercentView> {
  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<IdlePercentWorkingPercentViewModel>.reactive(
      builder: (BuildContext context,
          IdlePercentWorkingPercentViewModel viewModel, Widget _) {
        if (viewModel.loading) return CircularProgressIndicator();
        return ListView.builder(
            itemCount: viewModel.utilLizationListData.length,
            controller: viewModel.scrollController,
            scrollDirection: Axis.vertical,
            shrinkWrap: true,
            itemBuilder: (BuildContext context, int index) {
              if (widget.rangeChoice == 1) {
                return PercentageWidget(
                    label:
                        viewModel.utilLizationListData[index].assetSerialNumber,
                    percentage: viewModel
                                .utilLizationListData[index].idleEfficiency ==
                            null
                        ? null
                        : viewModel.utilLizationListData[index].idleEfficiency *
                            100,
                    color: sandyBrown);
              } else {
                return PercentageWidget(
                    label:
                        viewModel.utilLizationListData[index].assetSerialNumber,
                    percentage: viewModel.utilLizationListData[index]
                                .workingEfficiency ==
                            null
                        ? null
                        : viewModel
                                .utilLizationListData[index].workingEfficiency *
                            100,
                    color: olivine);
              }
            });
      },
      viewModelBuilder: () =>
          IdlePercentWorkingPercentViewModel(widget.startDate, widget.endDate),
    );
  }
}
