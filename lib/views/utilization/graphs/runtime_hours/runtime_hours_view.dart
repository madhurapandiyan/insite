import 'package:flutter/material.dart';
import 'package:insite/theme/colors.dart';
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
          WidgetsBinding.instance?.addPostFrameCallback((_) {
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
                            ? ListView.builder(
                                itemCount:
                                    viewModel.utilLizationListData.length,
                                controller: viewModel.scrollController,
                                scrollDirection: Axis.vertical,
                                shrinkWrap: true,
                                itemBuilder: (BuildContext context, int index) {
                                  return PercentageWidget(
                                      label: viewModel
                                          .utilLizationListData[index]
                                          .assetSerialNumber,
                                      value: rangeChoice == 1
                                          ? ('${viewModel.utilLizationListData[index].runtimeHours}')
                                          : rangeChoice == 2
                                              ? ('${viewModel.utilLizationListData[index].workingHours}')
                                              : ('${viewModel.utilLizationListData[index].idleHours}'),
                                      percentage: rangeChoice == 1
                                          ? (viewModel
                                                  .utilLizationListData[index]
                                                  .runtimeHours! /
                                              100)
                                          : rangeChoice == 2
                                              ? (viewModel
                                                      .utilLizationListData[
                                                          index]
                                                      .workingHours! /
                                                  100)
                                              : (viewModel
                                                      .utilLizationListData[
                                                          index]
                                                      .idleHours! /
                                                  10),
                                      color: tango);
                                  // PercentageWidget(
                                  //     value: rangeChoice == 1
                                  //         ? ('${viewModel.utilLizationListData[index].runtimeHours}')
                                  //         : rangeChoice == 2
                                  //             ? ('${viewModel.utilLizationListData[index].workingHours}')
                                  //             : ('${viewModel.utilLizationListData[index].idleHours}'),
                                  //     label: viewModel
                                  //         .utilLizationListData[index]
                                  //         .assetSerialNumber,
                                  //     percentage: rangeChoice == 1
                                  //         ? viewModel
                                  //                     .utilLizationListData[
                                  //                         index]
                                  //                     .runtimeHours!
                                  //                     .runtimeType ==
                                  //                 num
                                  //             ? (viewModel.utilLizationListData[index].runtimeHours! /
                                  //                 100)
                                  //             : (double.parse(viewModel.utilLizationListData[index] as String) /
                                  //                 100)
                                  //         : rangeChoice == 2
                                  //             ? viewModel
                                  //                         .utilLizationListData[
                                  //                             index]
                                  //                         .runtimeHours!
                                  //                         .runtimeType ==
                                  //                     num
                                  //                 ? (viewModel
                                  //                         .utilLizationListData[
                                  //                             index]
                                  //                         .workingHours! /
                                  //                     100)
                                  //                 : (double.parse(viewModel
                                  //                         .utilLizationListData[index]
                                  //                         .workingHours! as String) /
                                  //                     100)
                                  //             : (viewModel.utilLizationListData[index].idleHours! / 10),
                                  //     color: Theme.of(context).buttonColor);
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
