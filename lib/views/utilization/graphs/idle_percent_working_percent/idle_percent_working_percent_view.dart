import 'package:flutter/material.dart';
import 'package:insite/theme/colors.dart';
import 'package:insite/widgets/smart_widgets/percentage_widget.dart';
import 'package:insite/widgets/smart_widgets/range_selection_widget.dart';
import 'package:stacked/stacked.dart';
import 'idle_percent_working_percent_view_model.dart';

class IdlePercentWorkingPercentView extends StatefulWidget {
  const IdlePercentWorkingPercentView({
    Key key,
  }) : super(key: key);

  @override
  IdlePercentWorkingPercentViewState createState() =>
      IdlePercentWorkingPercentViewState();
}

class IdlePercentWorkingPercentViewState
    extends State<IdlePercentWorkingPercentView> {
  var viewModel;

  @override
  void initState() {
    viewModel = IdlePercentWorkingPercentViewModel();
    super.initState();
  }

  @override
  void dispose() {
    viewModel.dispose();
    super.dispose();
  }

  refresh() {
    viewModel.refresh();
  }

  int rangeChoice = 1;
  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<IdlePercentWorkingPercentViewModel>.reactive(
      builder: (BuildContext context,
          IdlePercentWorkingPercentViewModel viewModel, Widget _) {
        if (viewModel.loading)
          return Center(child: CircularProgressIndicator());
        return Stack(
          children: [
            Column(
              children: [
                Padding(
                  padding: EdgeInsets.all(16.0),
                  child: Align(
                    alignment: Alignment.centerLeft,
                    child: RangeSelectionWidget(
                      label1: 'Idle',
                      label2: 'Working',
                      label3: null,
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
                            label: viewModel
                                .utilLizationListData[index].assetSerialNumber,
                            percentage: rangeChoice == 1
                                ? viewModel.utilLizationListData[index]
                                            .idleEfficiency ==
                                        null
                                    ? null
                                    : viewModel.utilLizationListData[index]
                                            .idleEfficiency *
                                        100
                                : viewModel.utilLizationListData[index]
                                            .workingEfficiency ==
                                        null
                                    ? null
                                    : viewModel.utilLizationListData[index]
                                            .workingEfficiency *
                                        100,
                            color: rangeChoice == 1 ? sandyBrown : olivine);
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
