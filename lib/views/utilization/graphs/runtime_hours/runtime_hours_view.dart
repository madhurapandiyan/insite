import 'package:flutter/material.dart';
import 'package:insite/theme/colors.dart';
import 'package:insite/widgets/smart_widgets/percentage_widget.dart';
import 'package:insite/widgets/smart_widgets/range_selection_widget.dart';
import 'package:stacked/stacked.dart';
import 'runtime_hours_view_model.dart';

class RuntimeHoursView extends StatefulWidget {
  final String startDate;
  final String endDate;
  const RuntimeHoursView({Key key, this.startDate, this.endDate})
      : super(key: key);

  @override
  _RuntimeHoursViewState createState() => _RuntimeHoursViewState();
}

class _RuntimeHoursViewState extends State<RuntimeHoursView> {
  int rangeChoice = 1;
  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<RuntimeHoursViewModel>.reactive(
      builder:
          (BuildContext context, RuntimeHoursViewModel viewModel, Widget _) {
        if (viewModel.loading) return CircularProgressIndicator();
        return Column(
          children: [
            Padding(
              padding: EdgeInsets.all(16.0),
              child: Align(
                alignment: Alignment.centerLeft,
                child: RangeSelectionWidget(
                  label1: 'Runtime',
                  label2: 'Working',
                  label3: 'idle',
                  rangeChoice: (int choice) {
                    setState(() {
                      rangeChoice = choice;
                    });
                  },
                ),
              ),
            ),
            Expanded(
              child: ListView.builder(
                  itemCount: viewModel.utilLizationListData.length,
                  controller: viewModel.scrollController,
                  scrollDirection: Axis.vertical,
                  shrinkWrap: true,
                  itemBuilder: (BuildContext context, int index) {
                    return PercentageWidget(
                        value: rangeChoice == 1
                            ? ('${viewModel.utilLizationListData[index].runtimeHours}')
                            : rangeChoice == 2
                                ? ('${viewModel.utilLizationListData[index].workingHours}')
                                : ('${viewModel.utilLizationListData[index].idleHours}'),
                        label: viewModel
                            .utilLizationListData[index].assetSerialNumber,
                        percentage: rangeChoice == 1
                            ? (viewModel
                                    .utilLizationListData[index].runtimeHours /
                                100)
                            : rangeChoice == 2
                                ? (viewModel.utilLizationListData[index]
                                        .workingHours /
                                    100)
                                : (viewModel
                                        .utilLizationListData[index].idleHours /
                                    10),
                        color: sandyBrown);
                  }),
            ),
          ],
        );
      },
      viewModelBuilder: () =>
          RuntimeHoursViewModel(widget.startDate, widget.endDate),
    );
  }
}
