import 'package:flutter/material.dart';
import 'package:insite/theme/colors.dart';
import 'package:insite/utils/helper_methods.dart';
import 'package:insite/widgets/dumb_widgets/empty_view.dart';
import 'package:insite/widgets/dumb_widgets/insite_progressbar.dart';
import 'package:insite/widgets/smart_widgets/percentage_widget.dart';
import 'package:insite/widgets/smart_widgets/range_selection_widget.dart';
import 'package:stacked/stacked.dart';
import 'runtime_hours_view_model.dart';

class RuntimeHoursView extends StatefulWidget {
  final Function(int)? updateCount;
  const RuntimeHoursView({
    Key? key,
    this.updateCount,
  }) : super(key: key);

  @override
  RuntimeHoursViewState createState() => RuntimeHoursViewState();
}

class RuntimeHoursViewState extends State<RuntimeHoursView> {
  late var viewModel;
  @override
  void initState() {
    viewModel = RuntimeHoursViewModel();
    super.initState();
  }

  @override
  void dispose() {
    viewModel.dispose();
    super.dispose();
  }

  int rangeChoice = 1;

  refresh() {
    viewModel.refresh();
  }

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<RuntimeHoursViewModel>.reactive(
      builder:
          (BuildContext context, RuntimeHoursViewModel viewModel, Widget? _) {
        if (viewModel.update) {
          WidgetsBinding.instance!.addPostFrameCallback((_) {
            widget.updateCount!(viewModel.utilLizationListData.length);
            viewModel.updateCountToFalse();
          });
        }
        return viewModel.loading
            ? InsiteProgressBar()
            : Stack(
                children: [
                  Column(
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
                        child: viewModel.utilLizationListData.isNotEmpty
                            ? ListView.separated(
                                separatorBuilder: (ctx, i) {
                                  return SizedBox(
                                    height: 10,
                                  );
                                },
                                itemCount:
                                    viewModel.utilLizationListData.length,
                                controller: viewModel.scrollController,
                                scrollDirection: Axis.vertical,
                                shrinkWrap: true,
                                itemBuilder: (BuildContext context, int index) {
                                  // return CustomBarChart(
                                  //   label: viewModel.utilLizationListData[index]
                                  //       .assetSerialNumber,
                                  //   percentage: Utils.hoursToPercentCalculate(
                                  //           viewModel
                                  //               .utilLizationListData[index]
                                  //               .runtimeHours) /
                                  //       100,
                                  // );

                                  return CustomPercentageWidget(
                                      trailText: "",
                                      // trailText: rangeChoice == 1
                                      //     ? viewModel
                                      //         .utilLizationListData[index]
                                      //         .runtimeHours
                                      //         .toString()
                                      //     : rangeChoice == 2
                                      //         ? viewModel
                                      //             .utilLizationListData[index]
                                      //             .workingHours
                                      //             .toString()
                                      //         : viewModel
                                      //             .utilLizationListData[index]
                                      //             .idleHours
                                      //             .toString(),
                                      value: rangeChoice == 1
                                          ? ('${viewModel.utilLizationListData[index].runtimeHours}')
                                          : rangeChoice == 2
                                              ? ('${viewModel.utilLizationListData[index].workingHours}')
                                              : ('${viewModel.utilLizationListData[index].idleHours}'),
                                      label: viewModel
                                          .utilLizationListData[index]
                                          .assetSerialNumber,
                                      percentage: rangeChoice == 1
                                          ? Utils.hoursToPercentCalculate(
                                              viewModel
                                                  .utilLizationListData[index]
                                                  .runtimeHours)
                                          : rangeChoice == 2
                                              ? Utils.hoursToPercentCalculate(
                                                  viewModel
                                                      .utilLizationListData[
                                                          index]
                                                      .workingHours)
                                              : Utils.hoursToPercentCalculate(
                                                  viewModel
                                                      .utilLizationListData[
                                                          index]
                                                      .idleHours),
                                      color: Theme.of(context).buttonColor);
                                })
                            : EmptyView(
                                title: "No Assets Found",
                              ),
                      ),
                      viewModel.loadingMore
                          ? Padding(
                              padding: EdgeInsets.all(8),
                              child: InsiteProgressBar(),
                            )
                          : SizedBox(),
                    ],
                  ),
                  viewModel.isRefreshing
                      ? Center(
                          child: InsiteProgressBar(),
                        )
                      : SizedBox()
                ],
              );
      },
      viewModelBuilder: () => viewModel,
    );
  }
}
