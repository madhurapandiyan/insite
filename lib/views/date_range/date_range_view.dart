import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:insite/theme/colors.dart';
import 'package:insite/utils/date.dart';
import 'package:insite/utils/enums.dart';
import 'package:insite/utils/helper_methods.dart';
import 'package:insite/views/date_range/date_range_view_model.dart';
import 'package:insite/widgets/dumb_widgets/insite_button.dart';
import 'package:insite/widgets/dumb_widgets/insite_text.dart';
import 'package:logger/logger.dart';
import 'package:stacked/stacked.dart';
import 'package:table_calendar/table_calendar.dart';

class DateRangeView extends StatefulWidget {
  @override
  _DateRangeViewState createState() => _DateRangeViewState();

  const DateRangeView({
    Key? key,
  }) : super(key: key);
}

class _DateRangeViewState extends State<DateRangeView> {
  DateTime? fromDate, toDate;
  DateTime? customFromDate, customToDate;
  DateTime? _selectedDay;
  CustomDatePick currentCustomDatePick = CustomDatePick.customNoDate;
  bool isCalenderVisible = false;
  bool customCalenderIndex = false;
  CalendarFormat _calendarFormat = CalendarFormat.month;

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<DateRangeViewModel>.reactive(
      builder: (BuildContext context, DateRangeViewModel viewModel, Widget? _) {
        return Container(
          width: MediaQuery.of(context).size.width * 0.9,
          height: MediaQuery.of(context).size.height * 0.95,
          decoration: BoxDecoration(
            color: Theme.of(context).backgroundColor,
            border: Border.all(
                color: Theme.of(context).textTheme.bodyText1!.color!,
                width: 0.0),
            borderRadius: BorderRadius.all(Radius.circular(16)),
          ),
          child: Padding(
            padding: EdgeInsets.all(16.0),
            child: Column(
              children: [
                Row(
                  children: [
                    InsiteText(
                        text: 'Date Range'.toUpperCase(),
                        fontWeight: FontWeight.bold,
                        size: 14),
                    Expanded(
                      child: Container(),
                    ),
                    InsiteText(
                        text: (fromDate == null || toDate == null)
                            ? ''
                            : '${Utils.parseDate(fromDate!)} - ${Utils.parseDate(toDate!)}',
                        fontWeight: FontWeight.bold,
                        size: 14),
                  ],
                ),
                Padding(
                  padding: EdgeInsets.symmetric(vertical: 10),
                  child: Divider(
                    color: Theme.of(context).dividerColor,
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
                              child: InsiteText(
                                text: 'From:'.toUpperCase(),
                                size: 12,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            InsiteButton(
                              width: double.infinity,
                              height: 40,
                              textColor: white,
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
                              title: customFromDate == null
                                  ? 'dd-mm-yyyy'.toUpperCase()
                                  : Utils.parseDate(customFromDate!)
                                      .toUpperCase(),
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
                              child: InsiteText(
                                text: 'To:'.toUpperCase(),
                                size: 12,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            InsiteButton(
                              width: double.infinity,
                              height: 40,
                              textColor: white,
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
                              title: customToDate == null
                                  ? 'dd-mm-yyyy'.toUpperCase()
                                  : Utils.parseDate(customToDate!)
                                      .toUpperCase(),
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
                              lastDay: DateTime.now(),
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
                                    if (toDate!.isBefore(fromDate!)) {
                                      Utils.showToast(
                                          "End date cannot be less than start date.");
                                    }
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
                        Logger().i("fromdate todate $fromDate $toDate");
                        if (fromDate != null && toDate != null) {
                          if (viewModel.selectedDateRange ==
                              DateRangeType.today) {
                          await viewModel.updateDateRange(
                                '${fromDate!.year}-${fromDate!.month}-${fromDate!.day}',
                                '${toDate!.year}-${toDate!.month}-${toDate!.day}',
                                describeEnum(viewModel.selectedDateRange));
                            Future.delayed(Duration(milliseconds: 500), () {
                              Navigator.pop(context, [fromDate!, toDate!]);
                            });
                          } else {
                         
                            if (DateUtil.isBothDateSame(fromDate!, toDate!)) {
                              Logger().i("if date equal");
                              await viewModel.updateDateRange(
                                  '${fromDate!.year}-${fromDate!.month}-${fromDate!.day}',
                                  '${toDate!.year}-${toDate!.month}-${toDate!.day}',
                                  describeEnum(viewModel.selectedDateRange));
                              Future.delayed(Duration(milliseconds: 500), () {
                                Navigator.pop(context, [fromDate!, toDate!]);
                              });
                            } else {
                              Logger().i("if date not equal");
                              if (toDate!.isBefore(fromDate!)) {
                                Utils.showToast(
                                    "End date cannot be less than start date.");
                              } else {
                          
                                await viewModel.updateDateRange(
                                    '${fromDate!.year}-${fromDate!.month}-${fromDate!.day}',
                                    '${toDate!.year}-${toDate!.month}-${toDate!.day}',
                                    describeEnum(viewModel.selectedDateRange));
                                Future.delayed(Duration(milliseconds: 500), () {
                                  Navigator.pop(context, [fromDate!, toDate!]);
                                });
                              }
                            }
                          }
                        }
                      },
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
                      bgColor: Theme.of(context).backgroundColor,
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
      toDate = fromDate!.add(Duration(days: 6));
    } else if (viewModel.selectedDateRange == DateRangeType.previousMonth) {
      fromDate = DateTime.utc(DateTime.now().year, DateTime.now().month - 1, 1);
      toDate = DateTime.utc(DateTime.now().year, DateTime.now().month, 0);
    } else if (viewModel.selectedDateRange == DateRangeType.yesterday) {
      fromDate = DateUtil.calcFromDate(defaultDateRange);
      toDate = DateUtil.calcFromDate(defaultDateRange);
    } else {
      toDate = DateTime.now();
      fromDate = DateUtil.calcFromDate(defaultDateRange);
    }
    setState(() {});
  }
}

class RangeLabel extends StatelessWidget {
  final DateRangeType? defaultDateRange;
  final DateRangeType? selectedDateRange;
  final double? width;
  final String? label;
  final VoidCallback? onTapCallback;
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
        onTapCallback!();
      },
      child: Container(
        width: MediaQuery.of(context).size.width * width!,
        height: 40,
        decoration: BoxDecoration(
          color: (defaultDateRange == selectedDateRange)
              ? Theme.of(context).buttonColor
              : Theme.of(context).backgroundColor,
          border: Border.all(
              color: Theme.of(context).textTheme.bodyText1!.color!, width: 0.0),
          borderRadius: BorderRadius.all(
            Radius.circular(8),
          ),
        ),
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 8.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              InsiteText(
                text: label!.toUpperCase(),
                size: 12,
                color: defaultDateRange == selectedDateRange ? white : null,
                fontWeight: FontWeight.bold,
              ),
              (defaultDateRange == selectedDateRange)
                  ? Icon(
                      Icons.check,
                      color: Theme.of(context).iconTheme.color,
                    )
                  : Container(),
            ],
          ),
        ),
      ),
    );
  }
}
