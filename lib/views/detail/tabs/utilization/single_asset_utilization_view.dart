import 'package:flutter/material.dart';
import 'package:insite/core/models/single_asset_utilization.dart';
import 'package:insite/theme/colors.dart';
import 'package:insite/views/detail/tabs/utilization/single_asset_utilization_view_model.dart';
import 'package:insite/widgets/smart_widgets/date_range.dart';
import 'package:insite/widgets/smart_widgets/idle_working_graph.dart';
import 'package:insite/widgets/smart_widgets/percentage_widget.dart';
import 'package:intl/intl.dart';
import 'package:stacked/stacked.dart';

class SingleAssetUtilizationView extends StatefulWidget {
  @override
  _SingleAssetUtilizationViewState createState() =>
      _SingleAssetUtilizationViewState();
}

class _SingleAssetUtilizationViewState
    extends State<SingleAssetUtilizationView> {
  bool isListSelected = true;
  String dropdownValue = 'Idle Time - Idle %';
  int rangeChoice = 1;
  String startDate;
  String endDate;
  List<DateTime> dateRange;
  bool isRangeSelectionVisible = true;
  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<SingleAssetUtilizationViewModel>.reactive(
        builder: (BuildContext context,
            SingleAssetUtilizationViewModel viewModel, Widget _) {
          viewModel.startDate = startDate;
          viewModel.endDate = endDate;
          return viewModel.loading
              ? Container(
                  color: tuna,
                  child: Center(
                    child: CircularProgressIndicator(),
                  ),
                )
              : Container(
                  decoration: BoxDecoration(
                    color: mediumgrey,
                    border: Border.all(color: black, width: 0.0),
                    borderRadius: BorderRadius.all(Radius.circular(16)),
                  ),
                  child: isListSelected
                      ? Column(
                          children: [
                            Padding(
                              padding: EdgeInsets.all(16.0),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  toggleButton(),
                                  GestureDetector(
                                    onTap: () async {
                                      dateRange.clear();
                                      dateRange = await showDialog(
                                        context: context,
                                        builder: (BuildContext context) =>
                                            Dialog(
                                                backgroundColor: transparent,
                                                child: DateRangeWidget()),
                                      );
                                      viewModel.startDate =
                                          '${dateRange.first.month}/${dateRange.first.day}/${dateRange.first.year}';

                                      viewModel.endDate =
                                          '${dateRange.last.month}/${dateRange.last.day}/${dateRange.last.year}';
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
                          ],
                        )
                      : Column(
                          children: [
                            Padding(
                              padding: EdgeInsets.all(16.0),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  toggleButton(),
                                  GestureDetector(
                                    onTap: () async {
                                      dateRange = await showDialog(
                                        context: context,
                                        builder: (BuildContext context) =>
                                            Dialog(
                                                backgroundColor: transparent,
                                                child: DateRangeWidget()),
                                      );
                                      viewModel.startDate =
                                          '${dateRange.first.month}/${dateRange.first.day}/${dateRange.first.year}';
                                      viewModel.endDate =
                                          '${dateRange.last.month}/${dateRange.last.day}/${dateRange.last.year}';
                                      viewModel.getSingleAssetUtilization();
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
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                Container(
                                  width:
                                      MediaQuery.of(context).size.width * 0.5,
                                  decoration: BoxDecoration(
                                    color: cardcolor,
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(16)),
                                  ),
                                  child: Padding(
                                    padding: const EdgeInsets.all(6.0),
                                    child: Container(
                                      width: MediaQuery.of(context).size.width *
                                          0.75,
                                      decoration: BoxDecoration(
                                        color: cardcolor,
                                        border: Border.all(
                                            color: black, width: 0.0),
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(16)),
                                      ),
                                      child: Padding(
                                        padding: EdgeInsets.symmetric(
                                            vertical: 4.0, horizontal: 16),
                                        child: Center(
                                          child: Container(
                                            width: MediaQuery.of(context)
                                                    .size
                                                    .width *
                                                0.8,
                                            child: dropDownMenu(),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                                isRangeSelectionVisible
                                    ? rangeSelectionWidget()
                                    : Container(),
                              ],
                            ),
                            dropdownValue.contains('Hours')
                                ? Padding(
                                    padding:
                                        EdgeInsets.only(top: 20, left: 100),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceEvenly,
                                      children: [
                                        Text(
                                          'Idle',
                                          style: TextStyle(
                                            color: white,
                                            fontSize: 15,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                        Text(
                                          'Working',
                                          style: TextStyle(
                                            color: white,
                                            fontSize: 15,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                      ],
                                    ),
                                  )
                                : Container(),
                            Expanded(
                              child: Padding(
                                padding: EdgeInsets.symmetric(vertical: 16.0),
                                child: ListView.builder(
                                  itemCount: getCount(
                                      viewModel.singleAssetUtilization),
                                  itemBuilder:
                                      (BuildContext context, int index) {
                                    if (dropdownValue.contains('Idle %')) {
                                      if (rangeChoice == 1)
                                        return PercentageWidget(
                                            color: sandyBrown,
                                            label:
                                                '${DateFormat('dd/MM/yy').format(viewModel.singleAssetUtilization.daily[index].startDate)}\n${DateFormat('h:mm a').format(viewModel.singleAssetUtilization.daily[index].data.lastReportedTime)}',
                                            percentage: viewModel
                                                        .singleAssetUtilization
                                                        .daily[index]
                                                        .data
                                                        .idleEfficiency ==
                                                    null
                                                ? null
                                                : viewModel
                                                        .singleAssetUtilization
                                                        .daily[index]
                                                        .data
                                                        .idleEfficiency *
                                                    100);
                                      else if (rangeChoice == 2)
                                        return PercentageWidget(
                                            color: sandyBrown,
                                            label:
                                                '${DateFormat('dd/MM/yy').format(viewModel.singleAssetUtilization.weekly[index].startDate)}\n${DateFormat('dd/MM/yy').format(viewModel.singleAssetUtilization.weekly[index].endDate)}',
                                            percentage: viewModel
                                                        .singleAssetUtilization
                                                        .weekly[index]
                                                        .data
                                                        .idleEfficiency ==
                                                    null
                                                ? null
                                                : viewModel
                                                        .singleAssetUtilization
                                                        .weekly[index]
                                                        .data
                                                        .idleEfficiency *
                                                    100);
                                      else
                                        return PercentageWidget(
                                            color: sandyBrown,
                                            label:
                                                '${DateFormat('dd/MM/yy').format(viewModel.singleAssetUtilization.monthly[index].startDate)}\n${DateFormat('dd/MM/yy').format(viewModel.singleAssetUtilization.monthly[index].endDate)}',
                                            percentage: viewModel
                                                        .singleAssetUtilization
                                                        .monthly[index]
                                                        .data
                                                        .idleEfficiency ==
                                                    null
                                                ? null
                                                : viewModel
                                                        .singleAssetUtilization
                                                        .monthly[index]
                                                        .data
                                                        .idleEfficiency *
                                                    100);
                                    } else if (dropdownValue
                                        .contains('Performance %')) {
                                      return PercentageWidget(
                                        color: bermudaGrey,
                                        label:
                                            '${DateFormat('dd/MM/yy').format(viewModel.singleAssetUtilization.daily[index].startDate)}',
                                        percentage: viewModel
                                                    .singleAssetUtilization
                                                    .daily[index]
                                                    .data
                                                    .targetRuntimePerformance ==
                                                null
                                            ? null
                                            : viewModel
                                                    .singleAssetUtilization
                                                    .daily[index]
                                                    .data
                                                    .targetRuntimePerformance *
                                                100,
                                      );
                                    } else if (dropdownValue
                                        .contains('Hours')) {
                                      // RUNTIME HOURS
                                      if (rangeChoice == 1)
                                        return IdleWorkingGraphWidget(
                                          idleLength: viewModel
                                                      .singleAssetUtilization
                                                      .daily[index]
                                                      .data
                                                      .idleHours ==
                                                  null
                                              ? double.infinity
                                              : viewModel
                                                      .singleAssetUtilization
                                                      .daily[index]
                                                      .data
                                                      .idleHours *
                                                  1000,
                                          workingLength: viewModel
                                                      .singleAssetUtilization
                                                      .daily[index]
                                                      .data
                                                      .workingHours ==
                                                  null
                                              ? double.infinity
                                              : viewModel
                                                      .singleAssetUtilization
                                                      .daily[index]
                                                      .data
                                                      .workingHours *
                                                  1000,
                                          label:
                                              '${DateFormat('dd/MM/yy').format(viewModel.singleAssetUtilization.daily[index].startDate)}   \n${DateFormat('h:mm a').format(viewModel.singleAssetUtilization.daily[index].data.lastReportedTime)}',
                                        );
                                      else if (rangeChoice == 2)
                                        return IdleWorkingGraphWidget(
                                          idleLength: viewModel
                                                      .singleAssetUtilization
                                                      .weekly[index]
                                                      .data
                                                      .idleHours ==
                                                  null
                                              ? double.infinity
                                              : viewModel
                                                      .singleAssetUtilization
                                                      .weekly[index]
                                                      .data
                                                      .idleHours *
                                                  1500,
                                          workingLength: viewModel
                                                      .singleAssetUtilization
                                                      .weekly[index]
                                                      .data
                                                      .workingHours ==
                                                  null
                                              ? double.infinity
                                              : viewModel
                                                      .singleAssetUtilization
                                                      .weekly[index]
                                                      .data
                                                      .workingHours *
                                                  1500,
                                          label:
                                              '${DateFormat('dd/MM/yy').format(viewModel.singleAssetUtilization.weekly[index].startDate)}   \n${DateFormat('dd/MM/yy').format(viewModel.singleAssetUtilization.weekly[index].endDate)}',
                                        );
                                      else
                                        return IdleWorkingGraphWidget(
                                          idleLength: viewModel
                                                      .singleAssetUtilization
                                                      .monthly[index]
                                                      .data
                                                      .idleHours ==
                                                  null
                                              ? double.infinity
                                              : viewModel
                                                      .singleAssetUtilization
                                                      .monthly[index]
                                                      .data
                                                      .idleHours *
                                                  5000,
                                          workingLength: viewModel
                                                      .singleAssetUtilization
                                                      .monthly[index]
                                                      .data
                                                      .workingHours ==
                                                  null
                                              ? double.infinity
                                              : viewModel
                                                      .singleAssetUtilization
                                                      .monthly[index]
                                                      .data
                                                      .workingHours *
                                                  5000,
                                          label:
                                              '${DateFormat('dd/MM/yy').format(viewModel.singleAssetUtilization.monthly[index].startDate)}   \n${DateFormat('dd/MM/yy').format(viewModel.singleAssetUtilization.monthly[index].endDate)}',
                                        );
                                    } else {
                                      if (rangeChoice == 1)
                                        return PercentageWidget(
                                            isPercentage: false,
                                            color: periwinkleGrey,
                                            label:
                                                '${DateFormat('dd/MM/yy').format(viewModel.singleAssetUtilization.daily[index].startDate)}\n${DateFormat('h:mm a').format(viewModel.singleAssetUtilization.daily[index].data.lastReportedTime)}',
                                            percentage: viewModel
                                                        .singleAssetUtilization
                                                        .daily[index]
                                                        .data
                                                        .distanceTravelledKilometers ==
                                                    null
                                                ? null
                                                : viewModel
                                                    .singleAssetUtilization
                                                    .daily[index]
                                                    .data
                                                    .distanceTravelledKilometers);
                                      else if (rangeChoice == 2)
                                        return PercentageWidget(
                                            isPercentage: false,
                                            color: periwinkleGrey,
                                            label:
                                                '${DateFormat('dd/MM/yy').format(viewModel.singleAssetUtilization.weekly[index].startDate)}\n${DateFormat('dd/MM/yy').format(viewModel.singleAssetUtilization.weekly[index].endDate)}',
                                            percentage: viewModel
                                                        .singleAssetUtilization
                                                        .weekly[index]
                                                        .data
                                                        .distanceTravelledKilometers ==
                                                    null
                                                ? null
                                                : viewModel
                                                    .singleAssetUtilization
                                                    .weekly[index]
                                                    .data
                                                    .distanceTravelledKilometers);
                                      else
                                        return PercentageWidget(
                                            isPercentage: false,
                                            color: periwinkleGrey,
                                            label:
                                                '${DateFormat('dd/MM/yy').format(viewModel.singleAssetUtilization.monthly[index].startDate)}\n${DateFormat('dd/MM/yy').format(viewModel.singleAssetUtilization.monthly[index].endDate)}',
                                            percentage: viewModel
                                                        .singleAssetUtilization
                                                        .monthly[index]
                                                        .data
                                                        .distanceTravelledKilometers ==
                                                    null
                                                ? null
                                                : viewModel
                                                    .singleAssetUtilization
                                                    .monthly[index]
                                                    .data
                                                    .distanceTravelledKilometers);
                                    }
                                  },
                                ),
                              ),
                            ),
                          ],
                        ),
                );
        },
        viewModelBuilder: () => SingleAssetUtilizationViewModel());
  }

  Widget getGraphWidgetForRuntimePerformance(
      SingleAssetUtilization singleAssetUtilization, int index) {
    if (rangeChoice == 1)
      return PercentageWidget(
          color: sandyBrown,
          label:
              '${singleAssetUtilization.daily[index].startDate.day}/${singleAssetUtilization.daily[index].startDate.month}/${singleAssetUtilization.daily[index].startDate.year}\n',
          percentage: singleAssetUtilization.daily[index].data.runtimeHours ==
                  null
              ? null
              : singleAssetUtilization.daily[index].data.runtimeHours * 100);
    else if (rangeChoice == 2)
      return PercentageWidget(
          color: bermudaGrey,
          label:
              '${singleAssetUtilization.weekly[index].startDate.day}/${singleAssetUtilization.weekly[index].startDate.month}/${singleAssetUtilization.weekly[index].startDate.year}\n${singleAssetUtilization.weekly[index].endDate.day}/${singleAssetUtilization.weekly[index].endDate.month}/${singleAssetUtilization.weekly[index].endDate.year}',
          percentage: singleAssetUtilization.weekly[index].data.runtimeHours ==
                  null
              ? null
              : singleAssetUtilization.weekly[index].data.runtimeHours * 100);
    else
      return PercentageWidget(
          color: bermudaGrey,
          label:
              '${singleAssetUtilization.monthly[index].startDate.day}/${singleAssetUtilization.monthly[index].startDate.month}/${singleAssetUtilization.monthly[index].startDate.year}\n${singleAssetUtilization.monthly[index].endDate.day}/${singleAssetUtilization.monthly[index].endDate.month}/${singleAssetUtilization.monthly[index].endDate.year}',
          percentage: singleAssetUtilization.monthly[index].data.runtimeHours ==
                  null
              ? null
              : singleAssetUtilization.monthly[index].data.runtimeHours * 100);
  }

  // TEST ---
  Container toggleButton() => Container(
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
      );

  int getCount(SingleAssetUtilization data) {
    if (rangeChoice == 1)
      return data.daily.length;
    else if (rangeChoice == 2)
      return data.weekly.length;
    else
      return data.monthly.length;
  }

  Container rangeSelectionWidget() {
    return Container(
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
                  rangeChoice = 1;
                });
              },
              child: Container(
                decoration: BoxDecoration(
                  color: rangeChoice == 1 ? tango : cardcolor,
                  borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(4),
                    topLeft: Radius.circular(4),
                  ),
                ),
                child: Center(
                  child: Text(
                    'Day'.toUpperCase(),
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
                  rangeChoice = 2;
                });
              },
              child: Container(
                decoration: BoxDecoration(
                  color: rangeChoice == 2 ? tango : cardcolor,
                ),
                child: Center(
                  child: Text(
                    'Week'.toUpperCase(),
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
                  rangeChoice = 3;
                });
              },
              child: Container(
                decoration: BoxDecoration(
                  color: rangeChoice == 3 ? tango : cardcolor,
                  borderRadius: BorderRadius.only(
                    bottomRight: Radius.circular(4),
                    topRight: Radius.circular(4),
                  ),
                ),
                child: Center(
                  child: Text(
                    'Month'.toUpperCase(),
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
    );
  }

  DropdownButton<String> dropDownMenu() {
    return DropdownButton(
      value: dropdownValue,
      dropdownColor: cardcolor,
      icon: Icon(
        Icons.keyboard_arrow_down,
        color: white,
      ),
      iconSize: 24,
      elevation: 16,
      style: TextStyle(color: white),
      underline: Container(
        height: 0,
      ),
      onChanged: (String newValue) {
        setState(() {
          dropdownValue = newValue;

          if (dropdownValue.contains('Runtime - Performance %'))
            isRangeSelectionVisible = false;
          else
            isRangeSelectionVisible = true;
        });
      },
      items: <String>[
        'Idle Time - Idle %',
        'Runtime - Performance %',
        'Runtime Hours',
        'Distance Traveled (KMs)'
      ].map<DropdownMenuItem<String>>((String value) {
        return DropdownMenuItem<String>(
          value: value,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                value,
              ),
              // Icon(
              //   Icons.check,
              //   color: white,
              // )
            ],
          ),
        );
      }).toList(),
    );
  }
}
