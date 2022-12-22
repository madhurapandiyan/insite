import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:insite/theme/colors.dart';
import 'package:insite/utils/date.dart';
import 'package:insite/utils/enums.dart';
import 'package:insite/utils/helper_methods.dart';
import 'package:insite/views/date_range/date_range_view_model.dart';
import 'package:insite/widgets/dumb_widgets/insite_button.dart';
import 'package:insite/widgets/dumb_widgets/insite_progressbar.dart';
import 'package:insite/widgets/dumb_widgets/insite_text.dart';
import 'package:intl/intl.dart';
import 'package:logger/logger.dart';
import 'package:stacked/stacked.dart';
import 'package:table_calendar/table_calendar.dart';

class DateRangeView extends StatefulWidget {
  @override
  _DateRangeViewState createState() => _DateRangeViewState();

  const DateRangeView({Key? key}) : super(key: key);
}

class _DateRangeViewState extends State<DateRangeView> {
  DateTime? fromDate, toDate;
  DateTime? customFromDate, customToDate;
  DateTime? _selectedDay;
  CustomDatePick currentCustomDatePick = CustomDatePick.customNoDate;
  bool isCalenderVisible = false;
  bool customCalenderIndex = false;
  CalendarFormat _calendarFormat = CalendarFormat.month;
  DateFormat dateFormat = DateFormat("dd-MM-yyyy");

  showFromToDatePicker(
      {CustomDatePick? currentCustomDatePick,
      DateTime? startDate,
      DateTime? endDate,
      required BuildContext ctx,
      DateRangeViewModel? viewModel}) {
    showDatePicker(
            context: ctx,
            initialDate: currentCustomDatePick == CustomDatePick.customFromDate
                ? startDate!
                : endDate!,
            firstDate: currentCustomDatePick == CustomDatePick.customFromDate
                ? DateTime.utc(1999, 01, 01)
                : customFromDate == null
                    ? endDate!
                    : customFromDate!,
            lastDate: DateTime(9999))
        .then((selectedDay) {
      setState(() {
        viewModel!.selectedDateRange=DateRangeType.unselectedDateRange;
        _selectedDay = selectedDay;
        if (currentCustomDatePick == CustomDatePick.customFromDate) {
          Logger().w(customFromDate);
          Logger().v(customToDate);
          customFromDate = _selectedDay;
          fromDate = _selectedDay;
        }
        if (currentCustomDatePick == CustomDatePick.customToDate) {
          customToDate = _selectedDay;
          toDate = _selectedDay;
          Logger().wtf(customToDate);
          if (fromDate == null) {
            Utils.showToast("Please select start date ");
          } else {
            if (toDate!.isBefore(fromDate!)) {
              Utils.showToast("End date cannot be less than start date.");
            }
          }
        }
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<DateRangeViewModel>.reactive(
      builder: (BuildContext context, DateRangeViewModel viewModel, Widget? _) {
       
        return  viewModel.isLoading?Center(child: CircularProgressIndicator(),):
         Container(
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
                Column(
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
                              onLabelClicked(
                                  viewModel, DateRangeType.yesterday);
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
                              onLabelClicked(
                                  viewModel, DateRangeType.currentWeek);
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
                              onLabelClicked(
                                  viewModel, DateRangeType.previousWeek);
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
                              onLabelClicked(
                                  viewModel, DateRangeType.currentMonth);
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
                  ],
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
                            viewModel.startDate == null
                                ? InsiteButton(
                                    width: double.infinity,
                                    height: 40,
                                    textColor: white,
                                    // bgColor:
                                    //     widget.screenType == ScreenType.MAINTENANCE
                                    //         ? Theme.of(context)
                                    //             .buttonColor
                                    //             .withOpacity(0.5)
                                    //         : null,
                                    onTap: () {
                                      Logger().wtf(viewModel.startDate!);
                                      showFromToDatePicker(
                                        viewModel: viewModel,
                                          ctx: context,
                                          currentCustomDatePick:
                                              CustomDatePick.customFromDate,
                                          endDate: DateTime.parse(
                                              viewModel.endDate!),
                                          startDate: DateTime.parse(
                                              viewModel.startDate!));

                                      // setState(() {
                                      //   fromDate = null;
                                      //   isCalenderVisible = true;
                                      //   viewModel.selectedDateRange =
                                      //       DateRangeType.custom;
                                      //   _selectedDay = null;
                                      //   currentCustomDatePick =
                                      //       CustomDatePick.customFromDate;
                                      // });
                                    },
                                    title: customFromDate == null
                                        ? Utils.getDateFormat(viewModel.userPref?.dateFormat)?.toUpperCase()
                                        :  Utils.getDateFormatForDatePicker(
                                            customFromDate!.toString(),viewModel.userPref),
                                        // DateFormat("dd-MM-yyyy")
                                        //     .format(customFromDate!),
                                  )
                                : InsiteButton(
                                    title: customFromDate == null
                                        ?Utils.getDateFormatForDatePicker(
                                            viewModel.startDate,viewModel.userPref)
                                        :  Utils.getDateFormatForDatePicker(
                                            customFromDate!.toString(),viewModel.userPref),
                                        //dateFormat.format(customFromDate!),
                                    fontSize: 12,
                                    onTap: () {
                                      showFromToDatePicker(
                                        viewModel: viewModel,
                                          ctx: context,
                                          currentCustomDatePick:
                                              CustomDatePick.customFromDate,
                                          endDate: DateTime.parse(
                                              viewModel.endDate!),
                                          startDate: DateTime.parse(
                                              viewModel.startDate!));
                                    })
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
                            viewModel.endDate == null
                                ? InsiteButton(
                                    width: double.infinity,
                                    height: 40,
                                    textColor: white,
                                    onTap: () {
                                      showFromToDatePicker(
                                        viewModel: viewModel,
                                          ctx: context,
                                          currentCustomDatePick:
                                              CustomDatePick.customToDate,
                                          endDate: DateTime.parse(
                                              viewModel.endDate!),
                                          startDate: DateTime.parse(
                                              viewModel.startDate!));
                                    },
                                    title: customToDate == null
                                        ? Utils.getDateFormat(viewModel.userPref)?.toUpperCase()
                                        :Utils.getDateFormatForDatePicker(customToDate!.toString(), viewModel.userPref)
                                        // DateFormat("dd-MM-yyyy")
                                         //   .format(customToDate!),
                                  )
                                : InsiteButton(
                                    title: customToDate == null
                                        ? Utils.getDateFormatForDatePicker(
                                            viewModel.endDate,viewModel.userPref)
                                        : Utils.getDateFormatForDatePicker(customToDate!.toString(),viewModel.userPref),
                                        //dateFormat.format(customToDate!),
                                    fontSize: 12,
                                  
                                    onTap: () {
                                      showFromToDatePicker(
                                        viewModel: viewModel,
                                          ctx: context,
                                          currentCustomDatePick:
                                              CustomDatePick.customToDate,
                                          endDate: DateTime.parse(
                                              viewModel.endDate!),
                                          startDate: DateTime.parse(
                                              viewModel.startDate!));
                                    },
                                  )
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: 20,
                ),
                // Expanded(
                //   child: isCalenderVisible
                //       ? Container(
                //           height: 200,
                //           child:
                //               // SingleChildScrollView(
                //               //     child: DatePickerDialog(
                //               //         initialDate: DateTime.now(),
                //               //         firstDate: DateTime.now(),
                //               //         lastDate: DateTime.now()))
                //               Material(
                //                   child: SingleChildScrollView(
                //             child: TableCalendar(
                //               rowHeight: 35,
                //               calendarFormat: _calendarFormat,
                //               onFormatChanged: (format) {
                //                 setState(() {
                //                   _calendarFormat = format;
                //                 });
                //               },
                //               firstDay: currentCustomDatePick ==
                //                       CustomDatePick.customFromDate
                //                   ? DateTime.utc(1999, 01, 01)
                //                   : customFromDate!,
                //               lastDay: DateTime.now(),
                //               focusedDay: DateTime.utc(2022, 01, 31),
                //               selectedDayPredicate: (day) {
                //                 return isSameDay(_selectedDay, day);
                //               },
                //               onDaySelected: (selectedDay, focusedDay) {
                //                 setState(() {
                //                   _selectedDay = selectedDay;
                //                   if (currentCustomDatePick ==
                //                       CustomDatePick.customFromDate) {
                //                     customFromDate = _selectedDay;
                //                     fromDate = _selectedDay;
                //                   }
                //                   if (currentCustomDatePick ==
                //                       CustomDatePick.customToDate) {
                //                     customToDate = _selectedDay;
                //                     toDate = _selectedDay;
                //                     if (toDate!.isBefore(fromDate!)) {
                //                       Utils.showToast(
                //                           "End date cannot be less than start date.");
                //                     }
                //                   }
                //                 });
                //               },
                //             ),
                //           )),
                //         )
                //       : Container(),
                // ),
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
                                //'${fromDate!.year}-${fromDate!.month}-${fromDate!.day}'
                                DateFormat("yyyy-MM-dd").format(fromDate!),
                                //'${toDate!.year}-${toDate!.month}-${toDate!.day}'
                                DateFormat("yyyy-MM-dd").format(toDate!),
                                describeEnum(viewModel.selectedDateRange));
                            Future.delayed(Duration(milliseconds: 500), () {
                              Navigator.pop(context, [fromDate!, toDate!]);
                            });
                          } else {
                            if (DateUtil.isBothDateSame(fromDate!, toDate!)) {
                              Logger().i("if date equal");
                              await viewModel.updateDateRange(
                                  DateFormat("yyyy-MM-dd").format(fromDate!),
                                  // '${fromDate!.year}-${fromDate!.month}-${fromDate!.day}',
                                  DateFormat("yyyy-MM-dd").format(toDate!),
                                  //'${toDate!.year}-${toDate!.month}-${toDate!.day}',
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
                                    DateFormat("yyyy-MM-dd").format(fromDate!),
                                    //'${fromDate!.year}-${fromDate!.month}-${fromDate!.day}',
                                    DateFormat("yyyy-MM-dd").format(toDate!),
                                    //'${toDate!.year}-${toDate!.month}-${toDate!.day}',
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

class DateRangeMaintenanceView extends StatefulWidget {
  const DateRangeMaintenanceView({Key? key}) : super(key: key);

  @override
  State<DateRangeMaintenanceView> createState() =>
      _DateRangeMaintenanceViewState();
}

class _DateRangeMaintenanceViewState extends State<DateRangeMaintenanceView> {
  showFromToDatePicker(BuildContext? ctx, bool isFromDate,
      {DateRangeMaintenanceViewModel? model}) async {
    try {
      var data = await showDatePicker(
          context: ctx!,
          initialDate:
              isFromDate ? DateTime.now() : DateTime.parse(model!.endDate!),
          firstDate: DateTime.now(),
          lastDate: DateTime(9999));
      model!.onEndDateSelected(Utils.getDateFormatForDatePicker(data!.toString(),model.userPref), data);
      //model!.onEndDateSelected(DateFormat("dd-MM-yyyy").format(data!), data);
    } catch (e) {
      Logger().e(e.toString());
    }
  }

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder.reactive(
      builder: (BuildContext context, DateRangeMaintenanceViewModel viewModel,
          Widget? _) {
        return viewModel.isLoading
            ? Center(
                child: InsiteProgressBar(),
              )
            : Container(
                width: MediaQuery.of(context).size.width * 0.9,
                height: MediaQuery.of(context).size.height * 0.25,
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
                                    // bgColor:
                                    //     widget.screenType == ScreenType.MAINTENANCE
                                    //         ? Theme.of(context)
                                    //             .buttonColor
                                    //             .withOpacity(0.5)
                                    //         : null,
                                    onTap: () {
                                      //showFromToDatePicker(context, true, model: viewModel);
                                    },
                                    title:Utils.getDateFormatForDatePicker(DateTime.now().toString(),viewModel.userPref)
                                    //  DateFormat("dd-MM-yyyy")
                                    //     .format(DateTime.now()),
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
                                      showFromToDatePicker(context, true,
                                          model: viewModel);
                                    },
                                    title: viewModel.pickedDate == null
                                        ? Utils.getDateFormat(viewModel.userPref)?.toUpperCase()
                                        : 
                                        viewModel.pickedDate,
                                       // Utils.getDateFormatForDatePicker(viewModel.pickedDate, viewModel.userPref),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 20),
                      Row(
                        children: [
                          InsiteButton(
                            width: 75,
                            height: 40,
                            onTap: () async {
                              await viewModel.onApply();
                              Navigator.pop(context, [viewModel.endDate]);
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
      viewModelBuilder: () => DateRangeMaintenanceViewModel(),
    );
  }
}
