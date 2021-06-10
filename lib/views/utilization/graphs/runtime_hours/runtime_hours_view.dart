import 'package:flutter/material.dart';
import 'package:insite/theme/colors.dart';
import 'package:insite/widgets/smart_widgets/percentage_widget.dart';
import 'package:stacked/stacked.dart';
import 'runtime_hours_view_model.dart';

class RuntimeHoursView extends StatefulWidget {
  final int rangeChoice;
  final String startDate;
  final String endDate;
  const RuntimeHoursView(
      {Key key, this.rangeChoice, this.startDate, this.endDate})
      : super(key: key);

  @override
  _RuntimeHoursViewState createState() => _RuntimeHoursViewState();
}

class _RuntimeHoursViewState extends State<RuntimeHoursView> {
  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<RuntimeHoursViewModel>.reactive(
      builder:
          (BuildContext context, RuntimeHoursViewModel viewModel, Widget _) {
        if (viewModel.loading) return CircularProgressIndicator();
        return ListView.builder(
            itemCount: viewModel.utilLizationListData.length,
            itemBuilder: (BuildContext context, int index) {
              if (widget.rangeChoice == 1)
                return PercentageWidget(
                    value:
                        '${viewModel.utilLizationListData[index].runtimeHours}',
                    label:
                        viewModel.utilLizationListData[index].assetSerialNumber,
                    percentage:
                        viewModel.utilLizationListData[index].runtimeHours /
                            100,
                    color: sandyBrown);
              else if (widget.rangeChoice == 2)
                return PercentageWidget(
                    value:
                        '${viewModel.utilLizationListData[index].workingHours}',
                    label:
                        viewModel.utilLizationListData[index].assetSerialNumber,
                    percentage:
                        viewModel.utilLizationListData[index].workingHours /
                            100,
                    color: sandyBrown);
              else
                return PercentageWidget(
                    value: '${viewModel.utilLizationListData[index].idleHours}',
                    label:
                        viewModel.utilLizationListData[index].assetSerialNumber,
                    percentage:
                        viewModel.utilLizationListData[index].idleHours / 10,
                    color: sandyBrown);
            });
      },
      viewModelBuilder: () =>
          RuntimeHoursViewModel(widget.startDate, widget.endDate),
    );
  }
}
