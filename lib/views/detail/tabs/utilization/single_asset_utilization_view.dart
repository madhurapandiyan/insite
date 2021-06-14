import 'package:flutter/material.dart';
import 'package:insite/core/models/asset_detail.dart';
import 'package:insite/theme/colors.dart';
import 'package:insite/views/detail/tabs/utilization/single_asset_utilization_view_model.dart';
import 'package:insite/views/detail/tabs/utilization/tabs/graph/single_asset_utilization_graph_view.dart';
import 'package:insite/views/detail/tabs/utilization/tabs/list/single_asset_utilization_list_view.dart';
import 'package:insite/widgets/smart_widgets/date_range.dart';
import 'package:stacked/stacked.dart';

class SingleAssetUtilizationView extends StatefulWidget {
  final AssetDetail detail;
  SingleAssetUtilizationView({this.detail});

  @override
  _SingleAssetUtilizationViewState createState() =>
      _SingleAssetUtilizationViewState();
}

class _SingleAssetUtilizationViewState
    extends State<SingleAssetUtilizationView> {
  bool isListSelected = true;

  List<DateTime> dateRange = [];
  List<DateTime> selectedDateRange = [
    DateTime.now().subtract(Duration(days: DateTime.now().weekday)),
    DateTime.now()
  ];

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<SingleAssetUtilizationViewModel>.reactive(
        builder: (BuildContext context,
            SingleAssetUtilizationViewModel viewModel, Widget _) {
          return Container(
            decoration: BoxDecoration(
              color: mediumgrey,
              border: Border.all(color: black, width: 0.0),
              borderRadius: BorderRadius.all(Radius.circular(16)),
            ),
            child: Column(
              children: [
                Padding(
                  padding: EdgeInsets.all(16.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                        width: 130,
                        height: 30,
                        decoration: BoxDecoration(
                          color: white,
                          borderRadius: BorderRadius.all(
                            Radius.circular(8),
                          ),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Expanded(
                              child: GestureDetector(
                                onTap: () {
                                  setState(() {
                                    isListSelected = true;
                                  });
                                },
                                child: Container(
                                  decoration: BoxDecoration(
                                    color: isListSelected ? tango : cardcolor,
                                    borderRadius: BorderRadius.only(
                                      bottomLeft: Radius.circular(4),
                                      topLeft: Radius.circular(4),
                                    ),
                                  ),
                                  child: Center(
                                    child: Text(
                                      'List'.toUpperCase(),
                                      style: TextStyle(
                                        color: white,
                                        fontSize: 12,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            Expanded(
                              child: GestureDetector(
                                onTap: () {
                                  setState(() {
                                    isListSelected = false;
                                  });
                                },
                                child: Container(
                                  decoration: BoxDecoration(
                                    color: isListSelected ? cardcolor : tango,
                                    borderRadius: BorderRadius.only(
                                      bottomRight: Radius.circular(4),
                                      topRight: Radius.circular(4),
                                    ),
                                  ),
                                  child: Center(
                                    child: Text(
                                      'Graph'.toUpperCase(),
                                      style: TextStyle(
                                        color: white,
                                        fontSize: 12,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      GestureDetector(
                        onTap: () async {
                          dateRange = await showDialog(
                            context: context,
                            builder: (BuildContext context) => Dialog(
                                backgroundColor: transparent,
                                child: DateRangeWidget()),
                          );
                          if (dateRange.isNotEmpty) {
                            setState(() {
                              selectedDateRange = dateRange;
                            });
                          }
                        },
                        child: Container(
                          width: 90,
                          height: 30,
                          decoration: BoxDecoration(
                            color: cardcolor,
                            borderRadius: BorderRadius.all(
                              Radius.circular(4),
                            ),
                          ),
                          child: Center(
                            child: Text(
                              'Date Range',
                              style: TextStyle(
                                color: white,
                                fontSize: 12,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                isListSelected
                    ? SingleAssetUtilizationListView(
                        detail: widget.detail,
                        dateRange: selectedDateRange,
                      )
                    : SingleAssetUtilizationGraphView(
                        detail: widget.detail,
                        dateRange: selectedDateRange,
                      ),
              ],
            ),
          );
        },
        viewModelBuilder: () => SingleAssetUtilizationViewModel());
  }

  // Widget getGraphWidgetForRuntimePerformance(
  //     SingleAssetUtilization singleAssetUtilization, int index) {
  //   if (rangeChoice == 1)
  //     return PercentageWidget(
  //         color: sandyBrown,
  //         label:
  //             '${singleAssetUtilization.daily[index].startDate.day}/${singleAssetUtilization.daily[index].startDate.month}/${singleAssetUtilization.daily[index].startDate.year}\n',
  //         percentage: singleAssetUtilization.daily[index].data.runtimeHours ==
  //                 null
  //             ? null
  //             : singleAssetUtilization.daily[index].data.runtimeHours * 100);
  //   else if (rangeChoice == 2)
  //     return PercentageWidget(
  //         color: bermudaGrey,
  //         label:
  //             '${singleAssetUtilization.weekly[index].startDate.day}/${singleAssetUtilization.weekly[index].startDate.month}/${singleAssetUtilization.weekly[index].startDate.year}\n${singleAssetUtilization.weekly[index].endDate.day}/${singleAssetUtilization.weekly[index].endDate.month}/${singleAssetUtilization.weekly[index].endDate.year}',
  //         percentage: singleAssetUtilization.weekly[index].data.runtimeHours ==
  //                 null
  //             ? null
  //             : singleAssetUtilization.weekly[index].data.runtimeHours * 100);
  //   else
  //     return PercentageWidget(
  //         color: bermudaGrey,
  //         label:
  //             '${singleAssetUtilization.monthly[index].startDate.day}/${singleAssetUtilization.monthly[index].startDate.month}/${singleAssetUtilization.monthly[index].startDate.year}\n${singleAssetUtilization.monthly[index].endDate.day}/${singleAssetUtilization.monthly[index].endDate.month}/${singleAssetUtilization.monthly[index].endDate.year}',
  //         percentage: singleAssetUtilization.monthly[index].data.runtimeHours ==
  //                 null
  //             ? null
  //             : singleAssetUtilization.monthly[index].data.runtimeHours * 100);
  // }
}
