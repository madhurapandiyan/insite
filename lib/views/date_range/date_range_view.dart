import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:insite/theme/colors.dart';
import 'package:insite/utils/helper_methods.dart';
import 'package:insite/views/date_range/date_range_view_model.dart';
import 'package:insite/widgets/dumb_widgets/insite_button.dart';
import 'package:stacked/stacked.dart';
import 'package:table_calendar/table_calendar.dart';

class DateRangeView extends StatefulWidget {
  @override
  _DateRangeViewState createState() => _DateRangeViewState();

  const DateRangeView({
    Key key,
  }) : super(key: key);
}

class _DateRangeViewState extends State<DateRangeView> {
  DateTime fromDate, toDate;
  DateTime customFromDate, customToDate;
  DateTime _selectedDay;
  CustomDatePick currentCustomDatePick = CustomDatePick.customNoDate;
  bool isCalenderVisible = false;
  bool customCalenderIndex = false;
  CalendarFormat _calendarFormat = CalendarFormat.month;

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<DateRangeViewModel>.reactive(
      builder: (BuildContext context, DateRangeViewModel viewModel, Widget _) {
        return Container(
          width: MediaQuery.of(context).size.width * 0.9,
          height: MediaQuery.of(context).size.height * 0.95,
          decoration: BoxDecoration(
            color: tuna,
            border: Border.all(color: black, width: 0.0),
            borderRadius: BorderRadius.all(Radius.circular(16)),
          ),
          child: Padding(
            padding: EdgeInsets.all(16.0),
            child: Column(
              children: [
                Row(
                  children: [
                    Text(
                      'Date Range'.toUpperCase(),
                      style: TextStyle(
                          color: white,
                          fontWeight: FontWeight.bold,
                          fontSize: 15),
                    ),
                    Expanded(
                      child: Container(),
                    ),
                    Text(
                      (fromDate == null || toDate == null)
                          ? ''
                          : '${Utils.parseDate(fromDate)} - ${Utils.parseDate(toDate)}',
                      style: TextStyle(
                          color: white,
                          fontWeight: FontWeight.bold,
                          fontSize: 15),
                    ),
                  ],
                ),
                Padding(
                  padding: EdgeInsets.symmetric(vertical: 10),
                  child: Divider(
                    color: ship_grey,
                    thickness: 3,
                  ),
                ),
                Row(
                  children: [
                    RangeLabel(
                        defaultDateRange: DateRangeType.today,
                        width: 0.25,
                        onTapCallback: () {
                          onLabelClicked(viewModel, DateRangeType.today);
                        },
                        selectedDateRange: viewModel.selectedDateRange,
                        label: "Today"),
                    SizedBox(
                      width: 10,
                    ),
                    RangeLabel(
                        defaultDateRange: DateRangeType.yesterday,
                        width: 0.3,
                        onTapCallback: () {
                          onLabelClicked(viewModel, DateRangeType.yesterday);
                        },
                        selectedDateRange: viewModel.selectedDateRange,
                        label: "Yesterday"),
                  ],
                ),
                SizedBox(
                  height: 10,
                ),
                Row(
                  children: [
                    RangeLabel(
                        defaultDateRange: DateRangeType.currentWeek,
                        width: 0.35,
                        onTapCallback: () {
                          onLabelClicked(viewModel, DateRangeType.currentWeek);
                        },
                        selectedDateRange: viewModel.selectedDateRange,
                        label: "Current Week"),
                  ],
                ),
                SizedBox(
                  height: 10,
                ),
                Row(
                  children: [
                    RangeLabel(
                        defaultDateRange: DateRangeType.previousWeek,
                        width: 0.35,
                        onTapCallback: () {
                          onLabelClicked(viewModel, DateRangeType.previousWeek);
                        },
                        selectedDateRange: viewModel.selectedDateRange,
                        label: "Previous Week"),
                  ],
                ),
                SizedBox(
                  height: 10,
                ),
                Row(
                  children: [
                    RangeLabel(
                        defaultDateRange: DateRangeType.lastSevenDays,
                        width: 0.3,
                        onTapCallback: () {
                          onLabelClicked(
                              viewModel, DateRangeType.lastSevenDays);
                        },
                        selectedDateRange: viewModel.selectedDateRange,
                        label: "Last 7 days"),
                    SizedBox(
                      width: 10,
                    ),
                    RangeLabel(
                        defaultDateRange: DateRangeType.lastThirtyDays,
                        width: 0.35,
                        onTapCallback: () {
                          onLabelClicked(
                              viewModel, DateRangeType.lastThirtyDays);
                        },
                        selectedDateRange: viewModel.selectedDateRange,
                        label: "Last 30 days"),
                  ],
                ),
                SizedBox(
                  height: 10,
                ),
                Row(
                  children: [
                    RangeLabel(
                        defaultDateRange: DateRangeType.currentMonth,
                        width: 0.38,
                        onTapCallback: () {
                          onLabelClicked(viewModel, DateRangeType.currentMonth);
                        },
                        selectedDateRange: viewModel.selectedDateRange,
                        label: "Current Month"),
                  ],
                ),
                SizedBox(
                  height: 10,
                ),
                Row(
                  children: [
                    RangeLabel(
                        defaultDateRange: DateRangeType.previousMonth,
                        width: 0.38,
                        onTapCallback: () {
                          onLabelClicked(
                              viewModel, DateRangeType.previousMonth);
                        },
                        selectedDateRange: viewModel.selectedDateRange,
                        label: "Previous Month"),
                  ],
                ),
                SizedBox(
                  height: 10,
                ),
                Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    'Custom'.toUpperCase(),
                    style: TextStyle(
                      color: white,
                      fontSize: 12,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                Row(
                  children: [
                    Expanded(
                      child: Padding(
                        padding: EdgeInsets.only(top: 8.0),
                        child: Column(
                          children: [
                            Align(
                              alignment: Alignment.centerLeft,
                              child: Text(
                                'From:'.toUpperCase(),
                                style: TextStyle(
                                  color: white,
                                  fontSize: 12,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            GestureDetector(
                              onTap: () {
                                setState(() {
                                  fromDate = null;
                                  isCalenderVisible = true;
                                  viewModel.selectedDateRange =
                                      DateRangeType.custom;
                                  _selectedDay = null;
                                  currentCustomDatePick =
                                      CustomDatePick.customFromDate;
                                });
                              },
                              child: Container(
                                width: double.infinity,
                                height: 40,
                                decoration: BoxDecoration(
                                  color: ship_grey,
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(8)),
                                ),
                                child: Center(
                                  child: Text(
                                    customFromDate == null
                                        ? 'dd/mm/yy'.toUpperCase()
                                        : Utils.parseDate(customFromDate)
                                            .toUpperCase(),
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
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    Expanded(
                      child: Padding(
                        padding: EdgeInsets.only(top: 8.0),
                        child: Column(
                          children: [
                            Align(
                              alignment: Alignment.centerLeft,
                              child: Text(
                                'To:'.toUpperCase(),
                                style: TextStyle(
                                  color: white,
                                  fontSize: 12,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            GestureDetector(
                              onTap: () {
                                setState(() {
                                  toDate = null;
                                  isCalenderVisible = true;
                                  viewModel.selectedDateRange =
                                      DateRangeType.custom;
                                  _selectedDay = null;
                                  currentCustomDatePick =
                                      CustomDatePick.customToDate;
                                });
                              },
                              child: Container(
                                width: double.infinity,
                                height: 40,
                                decoration: BoxDecoration(
                                  color: ship_grey,
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(8)),
                                ),
                                child: Center(
                                  child: Text(
                                    customToDate == null
                                        ? 'dd/mm/yy'.toUpperCase()
                                        : Utils.parseDate(customToDate)
                                            .toUpperCase(),
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
                    ),
                  ],
                ),
                Expanded(
                  child: isCalenderVisible
                      ? Container(
                          child: Material(
                              child: SingleChildScrollView(
                            child: TableCalendar(
                              rowHeight: 35,
                              calendarFormat: _calendarFormat,
                              onFormatChanged: (format) {
                                setState(() {
                                  _calendarFormat = format;
                                });
                              },
                              firstDay: DateTime.utc(2010, 10, 16),
                              lastDay: DateTime.utc(2030, 3, 14),
                              focusedDay: DateTime.now(),
                              selectedDayPredicate: (day) {
                                return isSameDay(_selectedDay, day);
                              },
                              onDaySelected: (selectedDay, focusedDay) {
                                setState(() {
                                  _selectedDay = selectedDay;
                                  if (currentCustomDatePick ==
                                      CustomDatePick.customFromDate) {
                                    customFromDate = _selectedDay;
                                    fromDate = _selectedDay;
                                  }
                                  if (currentCustomDatePick ==
                                      CustomDatePick.customToDate) {
                                    customToDate = _selectedDay;
                                    toDate = _selectedDay;
                                  }
                                });
                              },
                            ),
                          )),
                        )
                      : Container(),
                ),
                Row(
                  children: [
                    InsiteButton(
                      width: 75,
                      height: 40,
                      onTap: () async {
                        if (fromDate != null && toDate != null) {
                          await viewModel.updateDateRange(
                              '${fromDate.year}-${fromDate.month}-${fromDate.day}',
                              '${toDate.year}-${toDate.month}-${toDate.day}',
                              describeEnum(viewModel.selectedDateRange));
                          Navigator.pop(context, [fromDate, toDate]);
                        }
                      },
                      bgColor: tango,
                      textColor: white,
                      title: 'Apply',
                    ),
                    SizedBox(
                      width: 20,
                    ),
                    InsiteButton(
                      width: 75,
                      height: 40,
                      onTap: () {
                        Navigator.pop(context);
                      },
                      bgColor: ship_grey,
                      textColor: white,
                      title: 'Cancel',
                    )
                  ],
                ),
              ],
            ),
          ),
        );
      },
      viewModelBuilder: () => DateRangeViewModel(),
    );
  }

  DateTime calcFromDate(DateRangeType defaultDateRange) {
    switch (defaultDateRange) {
      case DateRangeType.today:
        return DateTime.now();
        break;
      case DateRangeType.yesterday:
        return (DateTime.now().subtract(Duration(days: 1)));
        break;
      case DateRangeType.currentWeek:
        return (DateTime.now()
            .subtract(Duration(days: DateTime.now().weekday - 1)));
        break;
      case DateRangeType.lastSevenDays:
        return (DateTime.now().subtract(Duration(days: 6)));
        break;
      case DateRangeType.lastThirtyDays:
        return (DateTime.now().subtract(Duration(days: 29)));
        break;
      case DateRangeType.currentMonth:
        return (DateTime.utc(DateTime.now().year, DateTime.now().month, 1));
        break;
      default:
        return null;
        break;
    }
  }

  void onLabelClicked(
      DateRangeViewModel viewModel, DateRangeType defaultDateRange) {
    viewModel.selectedDateRange = defaultDateRange;
    isCalenderVisible = false;
    currentCustomDatePick = CustomDatePick.customNoDate;
    customFromDate = null;
    customToDate = null;
    _selectedDay = null;
    if (viewModel.selectedDateRange == DateRangeType.previousWeek) {
      fromDate =
          DateTime.now().subtract(Duration(days: DateTime.now().weekday + 6));
      toDate = fromDate.add(Duration(days: 6));
    } else if (viewModel.selectedDateRange == DateRangeType.previousMonth) {
      fromDate = DateTime.utc(DateTime.now().year, DateTime.now().month - 1, 1);
      toDate = DateTime.utc(DateTime.now().year, DateTime.now().month, 0);
    } else if (viewModel.selectedDateRange == DateRangeType.yesterday) {
      fromDate = calcFromDate(defaultDateRange);
      toDate = calcFromDate(defaultDateRange);
    } else {
      toDate = DateTime.now();
      fromDate = calcFromDate(defaultDateRange);
    }
    setState(() {});
  }
}

class RangeLabel extends StatelessWidget {
  final DateRangeType defaultDateRange;
  final DateRangeType selectedDateRange;
  final double width;
  final String label;
  final VoidCallback onTapCallback;
  const RangeLabel(
      {this.defaultDateRange,
      this.selectedDateRange,
      this.width,
      this.label,
      this.onTapCallback});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        onTapCallback();
      },
      child: Container(
        width: MediaQuery.of(context).size.width * width,
        height: 40,
        decoration: BoxDecoration(
          color: (defaultDateRange == selectedDateRange) ? tango : black,
          border: Border.all(color: transparent, width: 0.0),
          borderRadius: BorderRadius.all(
            Radius.circular(8),
          ),
        ),
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 8.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                label.toUpperCase(),
                style: TextStyle(
                  color: white,
                  fontSize: 12,
                  fontWeight: FontWeight.bold,
                ),
              ),
              (defaultDateRange == selectedDateRange)
                  ? Icon(
                      Icons.check,
                      color: white,
                    )
                  : Container(),
            ],
          ),
        ),
      ),
    );
  }
}

enum DateRangeType {
  today,
  yesterday,
  currentWeek,
  previousWeek,
  lastSevenDays,
  lastThirtyDays,
  currentMonth,
  previousMonth,
  custom
}

enum CustomDatePick { customFromDate, customToDate, customNoDate }