import 'package:flutter/material.dart';
import 'package:insite/theme/colors.dart';
import 'package:insite/widgets/dumb_widgets/insite_button.dart';
import 'package:table_calendar/table_calendar.dart';

class DateRangeWidget extends StatefulWidget {
  @override
  _DateRangeWidgetState createState() => _DateRangeWidgetState();

  const DateRangeWidget({
    Key key,
  }) : super(key: key);
}

class _DateRangeWidgetState extends State<DateRangeWidget> {
  DefaultDateRange selectedDateRange;
  DateTime fromDate, toDate;
  DateTime customFromDate, customToDate;
  DateTime _selectedDay;
  CustomDatePick currentCustomDatePick = CustomDatePick.customNoDate;
  bool isCalenderVisible = false;
  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width * 0.8,
      height: MediaQuery.of(context).size.height * 0.75,
      decoration: BoxDecoration(
        color: tuna,
        border: Border.all(color: black, width: 0.0),
        borderRadius: BorderRadius.all(Radius.circular(16)),
      ),
      child: Padding(
        padding: EdgeInsets.all(20.0),
        child: Column(
          children: [
            Row(
              children: [
                Text(
                  'Date Range'.toUpperCase(),
                  style: TextStyle(
                      color: white, fontWeight: FontWeight.bold, fontSize: 15),
                ),
                Expanded(
                  child: Container(),
                ),
                Text(
                  (fromDate == null || toDate == null)
                      ? ''
                      : '${parseDate(fromDate)} - ${parseDate(toDate)}',
                  style: TextStyle(
                      color: white, fontWeight: FontWeight.bold, fontSize: 15),
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
                dateRangeCard(context, DefaultDateRange.today, 0.25, 'Today'),
                SizedBox(
                  width: 10,
                ),
                dateRangeCard(
                    context, DefaultDateRange.yesterday, 0.3, 'Yesterday'),
              ],
            ),
            SizedBox(
              height: 10,
            ),
            Row(
              children: [
                dateRangeCard(context, DefaultDateRange.currentWeek, 0.35,
                    'Current Week'),
                SizedBox(
                  width: 10,
                ),
                dateRangeCard(context, DefaultDateRange.previousWeek, 0.3,
                    'Previous Week'),
              ],
            ),
            SizedBox(
              height: 10,
            ),
            Row(
              children: [
                dateRangeCard(context, DefaultDateRange.lastSevenDays, 0.3,
                    'Last 7 days'),
                SizedBox(
                  width: 10,
                ),
                dateRangeCard(context, DefaultDateRange.lastThirtyDays, 0.3,
                    'Last 30 days'),
              ],
            ),
            SizedBox(
              height: 10,
            ),
            Row(
              children: [
                dateRangeCard(context, DefaultDateRange.currentMonth, 0.3,
                    'Current Month'),
                SizedBox(
                  width: 10,
                ),
                dateRangeCard(context, DefaultDateRange.previousMonth, 0.3,
                    'Previous Month'),
              ],
            ),
            SizedBox(
              height: 30,
            ),
            Align(
              alignment: Alignment.centerLeft,
              child: Text(
                'Custom'.toUpperCase(),
                style: TextStyle(
                  color: white,
                  fontSize: 15,
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
                              fontSize: 15,
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
                              selectedDateRange = DefaultDateRange.custom;
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
                                    : parseDate(customFromDate).toUpperCase(),
                                style: TextStyle(
                                  color: white,
                                  fontSize: 15,
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
                              fontSize: 15,
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
                              selectedDateRange = DefaultDateRange.custom;
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
                                    : parseDate(customToDate).toUpperCase(),
                                style: TextStyle(
                                  color: white,
                                  fontSize: 15,
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
                      child: TableCalendar(
                        rowHeight: 35,
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
                    )
                  : Container(),
            ),
            Row(
              children: [
                InsiteButton(
                  width: 75,
                  height: 40,
                  onTap: () {
                    if (fromDate != null && toDate != null) {}
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
                  onTap: () {},
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
  }

  String parseDate(DateTime dateTime) {
    return '${dateTime.day}/${dateTime.month}/${dateTime.year}';
  }

  DateTime calcFromDate(DefaultDateRange defaultDateRange) {
    switch (defaultDateRange) {
      case DefaultDateRange.today:
        return DateTime.now();
        break;
      case DefaultDateRange.yesterday:
        return (DateTime.now().subtract(Duration(days: 1)));
        break;
      case DefaultDateRange.currentWeek:
        return (DateTime.now()
            .subtract(Duration(days: DateTime.now().weekday)));
        break;
      case DefaultDateRange.lastSevenDays:
        return (DateTime.now().subtract(Duration(days: 7)));
        break;
      case DefaultDateRange.lastThirtyDays:
        return (DateTime.now().subtract(Duration(days: 30)));
        break;
      case DefaultDateRange.currentMonth:
        return (DateTime.utc(DateTime.now().year, DateTime.now().month, 1));
        break;
      default:
        return null;
        break;
    }
  }

  GestureDetector dateRangeCard(BuildContext context,
      DefaultDateRange defaultDateRange, double width, String label) {
    return GestureDetector(
      onTap: () {
        setState(() {
          selectedDateRange = defaultDateRange;
          isCalenderVisible = false;
          currentCustomDatePick = CustomDatePick.customNoDate;
          customFromDate = null;
          customToDate = null;
          _selectedDay = null;

          if (selectedDateRange == DefaultDateRange.previousWeek) {
            fromDate = DateTime.now()
                .subtract(Duration(days: DateTime.now().weekday + 7));
            toDate = fromDate.add(Duration(days: 6));
          } else if (selectedDateRange == DefaultDateRange.previousMonth) {
            fromDate =
                DateTime.utc(DateTime.now().year, DateTime.now().month - 1, 1);
            toDate = DateTime.utc(DateTime.now().year, DateTime.now().month, 0);
          } else {
            toDate = DateTime.now();
            fromDate = calcFromDate(defaultDateRange);
          }
        });
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

enum DefaultDateRange {
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
