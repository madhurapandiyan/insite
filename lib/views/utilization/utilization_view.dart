import 'package:flutter/material.dart';
import 'package:insite/core/models/utilization.dart';
import 'package:insite/theme/colors.dart';
import 'package:insite/views/home/home_view.dart';
import 'package:insite/views/utilization/utilization_list_item.dart';
import 'package:insite/views/utilization/utilization_view_model.dart';
import 'package:insite/widgets/dumb_widgets/empty_view.dart';
import 'package:insite/widgets/smart_widgets/date_range.dart';
import 'package:insite/widgets/smart_widgets/insite_scaffold.dart';
import 'package:insite/widgets/smart_widgets/percentage_widget.dart';
import 'package:stacked/stacked.dart';

class UtilLizationView extends StatefulWidget {
  @override
  _UtilLizationViewState createState() => _UtilLizationViewState();
}

class _UtilLizationViewState extends State<UtilLizationView> {
  bool isListSelected = true;
  String dropdownValue = 'Idle % / Working %';
  int rangeChoice = 1;
  String startDate;
  String endDate;
  List<DateTime> dateRange = [];
  bool isRangeSelectionVisible = false;
  bool isDistanceTravelled = false;
  bool isCumulative = false;
  bool isIdleWorking = true;
  bool isRuntimeHours = false;
  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<UtilLizationViewModel>.reactive(
        builder:
            (BuildContext context, UtilLizationViewModel viewModel, Widget _) {
          return InsiteScaffold(
            screenType: ScreenType.UTILIZATION,
            viewModel: viewModel,
            body: Container(
              color: bgcolor,
              child: viewModel.loading
                  ? Center(
                      child: CircularProgressIndicator(),
                    )
                  // : viewModel.utilLizationList.isNotEmpty
                  : viewModel.utilLizationListData != null
                      ? Container(
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
                                              dateRange = [];
                                              dateRange = await showDialog(
                                                context: context,
                                                builder: (BuildContext
                                                        context) =>
                                                    Dialog(
                                                        backgroundColor:
                                                            transparent,
                                                        child:
                                                            DateRangeWidget()),
                                              );
                                              if (dateRange.isNotEmpty) {
                                                viewModel.startDate =
                                                    '${dateRange.first.month}/${dateRange.first.day}/${dateRange.first.year}';

                                                viewModel.endDate =
                                                    '${dateRange.last.month}/${dateRange.last.day}/${dateRange.last.year}';
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
                                    Expanded(
                                        child: ListView.separated(
                                            separatorBuilder: (context, index) {
                                              return Divider();
                                            },
                                            shrinkWrap: true,
                                            physics: ClampingScrollPhysics(),
                                            scrollDirection: Axis.vertical,
                                            itemCount: viewModel
                                                .utilLizationListData.length,
                                            padding: EdgeInsets.only(
                                                left: 8.0, right: 8.0),
                                            itemBuilder: (context, index) {
                                              AssetResult utilizationData =
                                                  viewModel
                                                          .utilLizationListData[
                                                      index];
                                              return UtilizationListItem(
                                                data: utilizationData,
                                                isShowingInDetailPage: false,
                                                onCallback: () {
                                                  viewModel
                                                      .onDetailPageSelected(
                                                          utilizationData);
                                                },
                                              );
                                            }))
                                  ],
                                )
                              // GRAPH VIEW
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
                                              dateRange = [];
                                              dateRange = await showDialog(
                                                context: context,
                                                builder: (BuildContext
                                                        context) =>
                                                    Dialog(
                                                        backgroundColor:
                                                            transparent,
                                                        child:
                                                            DateRangeWidget()),
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
                                    Padding(
                                      padding: EdgeInsets.all(16.0),
                                      child: Text(
                                        'Runtime Hours / Working Hours / Idle Hours: Value includes data occurring outside of selected date range.',
                                        style: TextStyle(
                                          color: white,
                                          fontSize: 12,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ),
                                    Container(
                                      width: MediaQuery.of(context).size.width *
                                          0.9,
                                      decoration: BoxDecoration(
                                        color: cardcolor,
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(8)),
                                      ),
                                      child: Padding(
                                        padding: const EdgeInsets.all(6.0),
                                        child: Container(
                                          width: MediaQuery.of(context)
                                                  .size
                                                  .width *
                                              0.75,
                                          decoration: BoxDecoration(
                                            color: cardcolor,
                                            border: Border.all(
                                                color: black, width: 0.0),
                                            borderRadius: BorderRadius.all(
                                                Radius.circular(8)),
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
                                    Padding(
                                      padding: EdgeInsets.all(16.0),
                                      child: Align(
                                        alignment: Alignment.centerLeft,
                                        child: isRuntimeHours
                                            ? rangeSelectionWidget('Runtime',
                                                'Working', 'idle', true)
                                            : isRangeSelectionVisible
                                                ? rangeSelectionWidget('Day',
                                                    'Week', 'month', true)
                                                : isIdleWorking
                                                    ? rangeSelectionWidget(
                                                        'Idle',
                                                        'Working',
                                                        '',
                                                        false)
                                                    : isCumulative
                                                        ? rangeSelectionWidget(
                                                            'Runtime',
                                                            'Fuel Burned',
                                                            '',
                                                            false)
                                                        : Container(),
                                      ),
                                    ),
                                    // GRAPH LIST WIDGET
                                    Expanded(
                                        child: Padding(
                                      padding:
                                          EdgeInsets.symmetric(vertical: 8.0),
                                      child: ListView.builder(
                                          itemCount: viewModel
                                              .utilization.assetResults.length,
                                          itemBuilder: (BuildContext context,
                                              int index) {
                                            if (isIdleWorking) {
                                              if (rangeChoice == 1)
                                                return PercentageWidget(
                                                    label: viewModel
                                                        .utilization
                                                        .assetResults[index]
                                                        .assetSerialNumber,
                                                    percentage: viewModel
                                                                .utilization
                                                                .assetResults[
                                                                    index]
                                                                .idleEfficiency ==
                                                            null
                                                        ? null
                                                        : viewModel
                                                                .utilization
                                                                .assetResults[
                                                                    index]
                                                                .idleEfficiency *
                                                            100,
                                                    color: sandyBrown);
                                              else
                                                return PercentageWidget(
                                                    label: viewModel
                                                        .utilization
                                                        .assetResults[index]
                                                        .assetSerialNumber,
                                                    percentage: viewModel
                                                                .utilization
                                                                .assetResults[
                                                                    index]
                                                                .workingEfficiency ==
                                                            null
                                                        ? null
                                                        : viewModel
                                                                .utilization
                                                                .assetResults[
                                                                    index]
                                                                .workingEfficiency *
                                                            100,
                                                    color: olivine);
                                            } else if (isRuntimeHours) {
                                              return Container();
                                            } else if (isDistanceTravelled) {
                                              return PercentageWidget(
                                                  label: viewModel
                                                      .utilization
                                                      .assetResults[index]
                                                      .assetSerialNumber,
                                                  value:
                                                      '${viewModel.utilLizationListData[index].distanceTravelledKilometers}',
                                                  percentage: viewModel
                                                          .utilization
                                                          .assetResults[index]
                                                          .distanceTravelledKilometers /
                                                      10,
                                                  color: creamCan);
                                            } else if (isCumulative) {
                                              return Container();
                                            } else {
                                              return Container();
                                            }
                                          }),
                                    ))
                                  ],
                                ),
                        )
                      : EmptyView(title: "No Results"),
            ),
          );
        },
        viewModelBuilder: () => UtilLizationViewModel(true));
  }

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
          rangeChoice = 1;

          (dropdownValue.contains('Total Hours') ||
                  dropdownValue.contains('Total Fuel Burned (Liters)') ||
                  dropdownValue.contains('Idle % Trend') ||
                  dropdownValue.contains('Fuel Burn Rate Trend'))
              ? isRangeSelectionVisible = true
              : isRangeSelectionVisible = false;

          (dropdownValue.contains('Runtime Hours'))
              ? isRuntimeHours = true
              : isRuntimeHours = false;

          (dropdownValue.contains('Distance Traveled (Kilometers)'))
              ? isDistanceTravelled = true
              : isDistanceTravelled = false;

          (dropdownValue.contains('Idle % / Working %'))
              ? isIdleWorking = true
              : isIdleWorking = false;

          (dropdownValue.contains('Cumulative'))
              ? isCumulative = true
              : isCumulative = false;
        });
      },
      items: <String>[
        'Idle % / Working %',
        'Runtime Hours',
        'Distance Traveled (Kilometers)',
        'Cumulative',
        'Total Hours',
        'Total Fuel Burned (Liters)',
        'Idle % Trend',
        'Fuel Burn Rate Trend'
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

  Container rangeSelectionWidget(
      String label1, String label2, String label3, bool isThirdVisible) {
    return Container(
      width: 190,
      height: 35,
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
                    label1.toUpperCase(),
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
                  borderRadius: isThirdVisible
                      ? BorderRadius.only()
                      : BorderRadius.only(
                          bottomRight: Radius.circular(4),
                          topRight: Radius.circular(4),
                        ),
                ),
                child: Center(
                  child: Text(
                    label2.toUpperCase(),
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
          isThirdVisible
              ? Expanded(
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
                          label3.toUpperCase(),
                          style: TextStyle(
                            color: white,
                            fontSize: 12,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                  ),
                )
              : Container(),
        ],
      ),
    );
  }
}
