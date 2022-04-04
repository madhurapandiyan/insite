import 'package:flutter/material.dart';
import 'package:insite/theme/colors.dart';
import 'package:insite/widgets/dumb_widgets/empty_view.dart';
import 'package:insite/widgets/dumb_widgets/insite_progressbar.dart';
import 'package:insite/widgets/smart_widgets/percentage_widget.dart';
import 'package:stacked/stacked.dart';
import 'distance_travelled_view_model.dart';

class DistanceTravelledView extends StatefulWidget {
  final Function(int)? updateCount;
  const DistanceTravelledView({
    Key? key,
    this.updateCount,
  }) : super(key: key);

  @override
  DistanceTravelledViewState createState() => DistanceTravelledViewState();
}

class DistanceTravelledViewState extends State<DistanceTravelledView> {
  late var viewModel;

  @override
  void initState() {
    viewModel = DistanceTravelledViewModel();
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

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<DistanceTravelledViewModel>.reactive(
      builder: (BuildContext context, DistanceTravelledViewModel viewModel,
          Widget? _) {
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
                                      value: viewModel
                                                  .utilLizationListData[index]
                                                  .distanceTravelledKilometers ==
                                              null
                                          ? 'NA'
                                          : '${viewModel.utilLizationListData[index].distanceTravelledKilometers}',
                                      percentage: viewModel
                                                  .utilLizationListData[index]
                                                  .distanceTravelledKilometers ==
                                              null
                                          ? 0.0
                                          : viewModel
                                                  .utilLizationListData[index]
                                                  .distanceTravelledKilometers! /
                                              1000,
                                      color: creamCan);
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
                  viewModel.isRefreshing ? InsiteProgressBar() : SizedBox()
                ],
              );
      },
      viewModelBuilder: () => viewModel,
    );
  }
}
