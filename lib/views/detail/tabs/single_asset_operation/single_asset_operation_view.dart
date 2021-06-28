import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:insite/core/models/asset_detail.dart';
import 'package:insite/core/models/single_asset_operation.dart';
import 'package:insite/core/models/single_asset_operation_chart_data.dart';
import 'package:insite/core/models/single_asset_utilization.dart';
import 'package:insite/theme/colors.dart';
import 'package:insite/utils/helper_methods.dart';
import 'package:insite/widgets/dumb_widgets/empty_view.dart';
import 'package:insite/widgets/dumb_widgets/insite_row_item_text.dart';
import 'package:insite/views/date_range/date_range_view.dart';
import 'package:intl/intl.dart';
import 'package:stacked/stacked.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import 'single_asset_operation_view_model.dart';

class SingleAssetOperationView extends StatefulWidget {
  final AssetDetail detail;
  SingleAssetOperationView({this.detail});

  @override
  _SingleAssetOperationViewState createState() =>
      _SingleAssetOperationViewState();
}

class _SingleAssetOperationViewState extends State<SingleAssetOperationView> {
  List<DateTime> dateRange;

  final CalendarController calendarController = CalendarController();
  CalendarView _view = CalendarView.week;

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<SingleAssetOperationViewModel>.reactive(
      builder: (BuildContext context, SingleAssetOperationViewModel viewModel,
          Widget _) {
        if (viewModel.loading) {
          return Center(
            child: CircularProgressIndicator(),
          );
        } else {
          return Container(
            decoration: BoxDecoration(
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(16),
                    topRight: Radius.circular(16)),
                color: mediumgrey),
            child: Stack(
              children: [
                Column(
                  children: [
                    Padding(
                      padding: EdgeInsets.all(16.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          GestureDetector(
                            onTap: () {
                              viewModel.refresh();
                            },
                            child: Container(
                              width: 90,
                              height: 30,
                              decoration: BoxDecoration(
                                color: tuna,
                                borderRadius: BorderRadius.all(
                                  Radius.circular(4),
                                ),
                              ),
                              child: Center(
                                child: Text(
                                  'Refresh',
                                  style: TextStyle(
                                    color: white,
                                    fontSize: 12,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                            ),
                          ),
                          Row(
                            children: [
                              Text(
                                (dateRange == null || dateRange.isEmpty)
                                    ? '${Utils.parseDate(DateTime.now().subtract(Duration(days: DateTime.now().weekday)))} - ${Utils.parseDate(DateTime.now())}'
                                    : '${Utils.parseDate(dateRange.first)} - ${Utils.parseDate(dateRange.last)}',
                                style: TextStyle(
                                    color: white,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 12),
                              ),
                              SizedBox(
                                width: 10,
                              ),
                              GestureDetector(
                                onTap: () async {
                                  dateRange = await showDialog(
                                    context: context,
                                    builder: (BuildContext context) => Dialog(
                                        backgroundColor: transparent,
                                        child: DateRangeView()),
                                  );
                                  if (dateRange != null &&
                                      dateRange.isNotEmpty) {
                                    setState(() {
                                      dateRange = dateRange;
                                      viewModel.startDate =
                                          '${dateRange.first.month}/${dateRange.first.day}/${dateRange.first.year}';
                                      viewModel.endDate =
                                          '${dateRange.last.month}/${dateRange.last.day}/${dateRange.last.year}';
                                    });
                                    viewModel.refresh();
                                  }
                                },
                                child: Container(
                                  width: 90,
                                  height: 30,
                                  decoration: BoxDecoration(
                                    color: tuna,
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
                        ],
                      ),
                    ),
                  ],
                ),

                viewModel.singleAssetOperation != null
                    ? assetOperationTable(viewModel.singleAssetOperation)
                    : SizedBox(),
                // viewModel.singleAssetOperation != null
                //     ? SfCartesianChart(
                //         series: getDefaultData(viewModel.singleAssetOperation),
                //         backgroundColor: ship_grey,
                //         plotAreaBorderColor: black,
                //         plotAreaBorderWidth: 3.0,
                //         primaryXAxis: CategoryAxis(),
                //         primaryYAxis: NumericAxis(
                //           // dateFormat: DateFormat("MMM dd"),
                //           opposedPosition: true,
                //           minimum: 0,
                //           maximum: 24,
                //         ),
                //         legend: Legend(isVisible: false),
                //         tooltipBehavior: TooltipBehavior(enable: true),
                //         zoomPanBehavior: ZoomPanBehavior(
                //           enablePinching: true,
                //           enablePanning: true,
                //         ),
                //         isTransposed: true,
                //       )
                //     : SizedBox(),
                Expanded(
                  child: viewModel.singleAssetOperation != null
                      ? SfCalendar(
                          showNavigationArrow: false,
                          backgroundColor: ship_grey,
                          cellBorderColor: black,
                          showCurrentTimeIndicator: false,
                          controller: calendarController,
                          view: CalendarView.week,
                          todayTextStyle: TextStyle(color: ship_grey),
                          timeSlotViewSettings: TimeSlotViewSettings(
                              dateFormat: 'd',
                              dayFormat: 'MMM',
                              timeTextStyle: TextStyle(color: white)),
                          minDate: viewModel.singleAssetOperation
                                  .assetOperations.assets.isEmpty
                              ? DateTime.now().subtract(
                                  Duration(days: DateTime.now().weekday))
                              : viewModel.minDate,
                          maxDate: viewModel.singleAssetOperation
                                  .assetOperations.assets.isEmpty
                              ? DateTime.now()
                              : viewModel.maxDate,
                          onViewChanged: onViewChanged,
                          viewHeaderStyle: ViewHeaderStyle(
                            dayTextStyle: TextStyle(color: white),
                            dateTextStyle: TextStyle(color: white),
                            backgroundColor: tuna,
                          ),
                          dataSource: AppointmentDataSource(
                            getRecursiveAppointments(),
                          ),
                        )
                      : EmptyView(title: 'No data here'),
                ),
                viewModel.refreshing
                    ? Center(
                        child: CircularProgressIndicator(),
                      )
                    : SizedBox()
              ],
            ),
          );
        }
      },
      viewModelBuilder: () => SingleAssetOperationViewModel(widget.detail),
    );
  }

  Table assetOperationTable(SingleAssetOperation assetOperation) {
    DateFormat format = DateFormat('dd/MM/yyyy hh:mm');

    return Table(
      border: TableBorder.all(width: 1.0),
      children: [
        TableRow(
          children: [
            InsiteTableRowItem(
              title: 'Last Event',
              content: assetOperation.assetOperations.assets.first
                      .assetLastReceivedEvent.lastReceivedEvent
                      .contains('Off')
                  ? 'Engine Ignition/ off'
                  : 'Engine Ignition/ on',
            ),
            InsiteTableRowItem(
              title: 'Last Event Time',
              content: format.format(assetOperation.assetOperations.assets.first
                  .assetLastReceivedEvent.lastReceivedEventTimeLocal),
            ),
            InsiteTableRowItem(
              title: 'Distance Travelled',
              content: assetOperation
                      .assetOperations.assets.first.distanceTravelledKilometers
                      .toString()
                      .contains('null')
                  ? '-'
                  : '${assetOperation.assetOperations.assets.first.distanceTravelledKilometers} km',
            ),
          ],
        ),
        TableRow(
          children: [
            InsiteTableRowItem(
              title: 'Last Known Operator',
              content: assetOperation
                          .assetOperations.assets.first.lastKnownOperator ==
                      null
                  ? '-'
                  : assetOperation
                      .assetOperations.assets.first.lastKnownOperator,
            ),
            InsiteTableRowItem(
              title: 'This data was last refreshed on',
              content: format.format(assetOperation.assetOperations.assets.first
                  .assetLastReceivedEvent.lastReceivedEventTimeLocal),
            ),
            InsiteTableRowItem(
              title: '',
              content: '',
            ),
          ],
        ),
      ],
    );
  }

  static List<ScatterSeries<SingleAssetOperationChartData, String>>
      getDefaultData(SingleAssetOperation assetOperation) {
    final List<SingleAssetOperationChartData> chartData =
        <SingleAssetOperationChartData>[];

    for (Asset asset in assetOperation.assetOperations.assets)
      for (AssetLocalDate assetLocalDate in asset.assetLocalDates)
        for (Segment segment in assetLocalDate.segments)
          chartData.add(
            SingleAssetOperationChartData(
              Utils.getDecimalFromTime(segment.startTimeUtc),
              Utils.getDecimalFromTime(segment.endTimeUtc),
              DateFormat('MMM dd').format(assetLocalDate.assetLocalDate),
            ),
          );

    return <ScatterSeries<SingleAssetOperationChartData, String>>[
      ScatterSeries<SingleAssetOperationChartData, String>(
        enableTooltip: true,
        color: tango,
        dataSource: chartData,
        borderWidth: 5,
        xValueMapper: (SingleAssetOperationChartData data, _) => data.localDate,
        yValueMapper: (SingleAssetOperationChartData data, _) => data.startTime,
        markerSettings: MarkerSettings(
          isVisible: true,
          height: 10,
          width: 10,
          shape: DataMarkerType.rectangle,
          borderWidth: 3,
        ),
      ),
      ScatterSeries<SingleAssetOperationChartData, String>(
        enableTooltip: true,
        color: tango,
        dataSource: chartData,
        borderWidth: 5,
        xValueMapper: (SingleAssetOperationChartData data, _) => data.localDate,
        yValueMapper: (SingleAssetOperationChartData data, _) => data.endTime,
        markerSettings: MarkerSettings(
          isVisible: true,
          height: 10,
          width: 10,
          shape: DataMarkerType.rectangle,
          borderWidth: 3,
        ),
      ),
    ];
  }

  void onViewChanged(ViewChangedDetails visibleDatesChangedDetails) {
    if (_view == calendarController.view ||
        (_view != CalendarView.month &&
            calendarController.view != CalendarView.month)) {
      return;
    }
    SchedulerBinding.instance?.addPostFrameCallback((Duration timeStamp) {
      setState(() {
        _view = calendarController.view;

        /// Update the current view when the calendar view changed to
        /// month view or from month view.
      });
    });
  }

  List<Appointment> getRecursiveAppointments() {
    final List<Color> colorCollection = <Color>[];
    colorCollection.add(const Color(0xFF0F8644));
    colorCollection.add(const Color(0xFF8B1FA9));
    colorCollection.add(const Color(0xFFD20100));
    colorCollection.add(const Color(0xFFFC571D));
    colorCollection.add(const Color(0xFF36B37B));
    colorCollection.add(const Color(0xFF01A1EF));
    colorCollection.add(const Color(0xFF3D4FB5));
    colorCollection.add(const Color(0xFFE47C73));
    colorCollection.add(const Color(0xFF636363));
    colorCollection.add(const Color(0xFF0A8043));

    final List<Appointment> appointments = <Appointment>[];
    final Random random = Random();
    // //Recurrence Appointment 1
    final DateTime currentDate = DateTime.now();
    final DateTime startTime =
        DateTime(currentDate.year, currentDate.month, currentDate.day, 9, 0, 0);
    final DateTime endTime = DateTime(
        currentDate.year, currentDate.month, currentDate.day, 11, 0, 0);
    final RecurrenceProperties recurrencePropertiesForAlternativeDay =
        RecurrenceProperties(
            startDate: startTime,
            recurrenceType: RecurrenceType.daily,
            interval: 2,
            recurrenceRange: RecurrenceRange.count,
            recurrenceCount: 20);
    final Appointment alternativeDayAppointment = Appointment(
      startTime: startTime,
      endTime: endTime,
      color: tango,
      subject: 'Engine On/Off',
      // recurrenceRule: SfCalendar.generateRRule(
      //     recurrencePropertiesForAlternativeDay, startTime, endTime));
    );

    appointments.add(alternativeDayAppointment);

    // //Recurrence Appointment 2
    // final DateTime startTime1 = DateTime(
    //     currentDate.year, currentDate.month, currentDate.day, 13, 0, 0);
    // final DateTime endTime1 = DateTime(
    //     currentDate.year, currentDate.month, currentDate.day, 15, 0, 0);
    // final RecurrenceProperties recurrencePropertiesForWeeklyAppointment =
    //     RecurrenceProperties(
    //   startDate: startTime1,
    //   recurrenceType: RecurrenceType.weekly,
    //   recurrenceRange: RecurrenceRange.count,
    //   interval: 1,
    //   weekDays: <WeekDays>[WeekDays.monday],
    //   recurrenceCount: 20,
    // );

    // final Appointment weeklyAppointment = Appointment(
    //     startTime: startTime1,
    //     endTime: endTime1,
    //     color: colorCollection[random.nextInt(9)],
    //     subject: 'product development status',
    //     recurrenceRule: SfCalendar.generateRRule(
    //         recurrencePropertiesForWeeklyAppointment, startTime1, endTime1));

    // appointments.add(weeklyAppointment);

    final DateTime startTime2 =
        DateTime(currentDate.year, currentDate.month, 29, 14, 0, 0);
    final DateTime endTime2 =
        DateTime(currentDate.year, currentDate.month, 29, 15, 30, 0);
    final RecurrenceProperties recurrencePropertiesForMonthlyAppointment =
        RecurrenceProperties(
            startDate: startTime2,
            recurrenceType: RecurrenceType.monthly,
            recurrenceRange: RecurrenceRange.count,
            interval: 1,
            dayOfMonth: 1,
            recurrenceCount: 10);

    final Appointment monthlyAppointment = Appointment(
      startTime: startTime2,
      endTime: endTime2,
      color: tango,
      subject: 'Engine On',
      // recurrenceRule: SfCalendar.generateRRule(
      //     recurrencePropertiesForMonthlyAppointment, startTime2, endTime2));
    );
    appointments.add(monthlyAppointment);

    // final DateTime startTime3 = DateTime(
    //     currentDate.year, currentDate.month, currentDate.day, 12, 0, 0);
    // final DateTime endTime3 = DateTime(
    //     currentDate.year, currentDate.month, currentDate.day, 14, 0, 0);
    // final RecurrenceProperties recurrencePropertiesForYearlyAppointment =
    //     RecurrenceProperties(
    //         startDate: startTime3,
    //         recurrenceType: RecurrenceType.yearly,
    //         recurrenceRange: RecurrenceRange.noEndDate,
    //         interval: 1,
    //         dayOfMonth: 5);

    // final Appointment yearlyAppointment = Appointment(
    //     startTime: startTime3,
    //     endTime: endTime3,
    //     color: colorCollection[random.nextInt(9)],
    //     isAllDay: true,
    //     subject: 'Stephen birthday',
    //     recurrenceRule: SfCalendar.generateRRule(
    //         recurrencePropertiesForYearlyAppointment, startTime3, endTime3));

    // appointments.add(yearlyAppointment);

    // final DateTime startTime4 = DateTime(
    //     currentDate.year, currentDate.month, currentDate.day, 17, 0, 0);
    // final DateTime endTime4 = DateTime(
    //     currentDate.year, currentDate.month, currentDate.day, 18, 0, 0);
    // final RecurrenceProperties recurrencePropertiesForCustomDailyAppointment =
    //     RecurrenceProperties(
    //         startDate: startTime4,
    //         recurrenceType: RecurrenceType.daily,
    //         recurrenceRange: RecurrenceRange.noEndDate,
    //         interval: 1);

    // final Appointment customDailyAppointment = Appointment(
    //   startTime: startTime4,
    //   endTime: endTime4,
    //   color: colorCollection[random.nextInt(9)],
    //   subject: 'General meeting',
    //   recurrenceRule: SfCalendar.generateRRule(
    //       recurrencePropertiesForCustomDailyAppointment, startTime4, endTime4),
    // );

    // appointments.add(customDailyAppointment);

    // final DateTime startTime5 = DateTime(
    //     currentDate.year, currentDate.month, currentDate.day, 12, 0, 0);
    // final DateTime endTime5 = DateTime(
    //     currentDate.year, currentDate.month, currentDate.day, 13, 0, 0);
    // final RecurrenceProperties recurrencePropertiesForCustomWeeklyAppointment =
    //     RecurrenceProperties(
    //         startDate: startTime5,
    //         recurrenceType: RecurrenceType.weekly,
    //         recurrenceRange: RecurrenceRange.endDate,
    //         interval: 1,
    //         weekDays: <WeekDays>[WeekDays.monday, WeekDays.friday],
    //         endDate: DateTime.now().add(const Duration(days: 14)));

    // final Appointment customWeeklyAppointment = Appointment(
    //     startTime: startTime5,
    //     endTime: endTime5,
    //     color: colorCollection[random.nextInt(9)],
    //     subject: 'performance check',
    //     recurrenceRule: SfCalendar.generateRRule(
    //         recurrencePropertiesForCustomWeeklyAppointment,
    //         startTime5,
    //         endTime5));

    // appointments.add(customWeeklyAppointment);

    // final DateTime startTime6 = DateTime(
    //     currentDate.year, currentDate.month, currentDate.day, 16, 0, 0);
    // final DateTime endTime6 = DateTime(
    //     currentDate.year, currentDate.month, currentDate.day, 18, 0, 0);

    // final RecurrenceProperties recurrencePropertiesForCustomMonthlyAppointment =
    //     RecurrenceProperties(
    //         startDate: startTime6,
    //         recurrenceType: RecurrenceType.monthly,
    //         recurrenceRange: RecurrenceRange.count,
    //         interval: 1,
    //         dayOfWeek: DateTime.friday,
    //         week: 4,
    //         recurrenceCount: 12);

    // final Appointment customMonthlyAppointment = Appointment(
    //     startTime: startTime6,
    //     endTime: endTime6,
    //     color: colorCollection[random.nextInt(9)],
    //     subject: 'Sprint end meeting',
    //     recurrenceRule: SfCalendar.generateRRule(
    //         recurrencePropertiesForCustomMonthlyAppointment,
    //         startTime6,
    //         endTime6));

    // appointments.add(customMonthlyAppointment);

    // final DateTime startTime7 = DateTime(
    //     currentDate.year, currentDate.month, currentDate.day, 14, 0, 0);
    // final DateTime endTime7 = DateTime(
    //     currentDate.year, currentDate.month, currentDate.day, 15, 0, 0);
    // final RecurrenceProperties recurrencePropertiesForCustomYearlyAppointment =
    //     RecurrenceProperties(
    //         startDate: startTime7,
    //         recurrenceType: RecurrenceType.yearly,
    //         recurrenceRange: RecurrenceRange.count,
    //         interval: 2,
    //         month: DateTime.february,
    //         week: 2,
    //         dayOfWeek: DateTime.sunday,
    //         recurrenceCount: 10);

    // final Appointment customYearlyAppointment = Appointment(
    //     startTime: startTime7,
    //     endTime: endTime7,
    //     color: colorCollection[random.nextInt(9)],
    //     subject: 'Alumini meet',
    //     recurrenceRule: SfCalendar.generateRRule(
    //         recurrencePropertiesForCustomYearlyAppointment,
    //         startTime7,
    //         endTime7));

    // appointments.add(customYearlyAppointment);
    return appointments;
  }
}

class AppointmentDataSource extends CalendarDataSource {
  AppointmentDataSource(this.source);

  List<Appointment> source;

  @override
  List<dynamic> get appointments => source;
}
