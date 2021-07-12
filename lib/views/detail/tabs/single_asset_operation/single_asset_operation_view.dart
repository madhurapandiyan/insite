import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:insite/core/models/asset_detail.dart';
import 'package:insite/core/models/single_asset_operation.dart';
import 'package:insite/core/models/single_asset_operation_chart_data.dart';
import 'package:insite/theme/colors.dart';
import 'package:insite/utils/helper_methods.dart';
import 'package:insite/widgets/dumb_widgets/empty_view.dart';
import 'package:insite/widgets/dumb_widgets/insite_row_item_text.dart';
import 'package:insite/views/date_range/date_range_view.dart';
import 'package:stacked/stacked.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';
import 'single_asset_operation_view_model.dart';

class SingleAssetOperationView extends StatefulWidget {
  final AssetDetail detail;
  SingleAssetOperationView({this.detail});

  @override
  _SingleAssetOperationViewState createState() =>
      _SingleAssetOperationViewState();
}

class _SingleAssetOperationViewState extends State<SingleAssetOperationView> {
  List<DateTime> dateRange = [];

  final CalendarController calendarController = CalendarController();
  CalendarView _view = CalendarView.week;

  double sfCalendarTimeIntervalHeight = 40;

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
                    viewModel.singleAssetOperation != null
                        ? assetOperationTable(viewModel.singleAssetOperation)
                        : SizedBox(),
                    Expanded(
                      child: viewModel.singleAssetOperation != null
                          ? Stack(
                              children: [
                                SfCalendar(
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
                                    timeIntervalHeight:
                                        sfCalendarTimeIntervalHeight,
                                    timeTextStyle: TextStyle(color: white),
                                  ),
                                  minDate: viewModel
                                          .singleAssetOperation
                                          .assetOperations
                                          .assets
                                          .first
                                          .assetLocalDates
                                          .isEmpty
                                      ? DateTime.now().subtract(Duration(
                                          days: DateTime.now().weekday))
                                      : viewModel.minDate,
                                  maxDate: viewModel
                                          .singleAssetOperation
                                          .assetOperations
                                          .assets
                                          .first
                                          .assetLocalDates
                                          .isEmpty
                                      ? DateTime.now()
                                      : viewModel.maxDate,
                                  onViewChanged: onViewChanged,
                                  viewHeaderStyle: ViewHeaderStyle(
                                    dayTextStyle: TextStyle(color: white),
                                    dateTextStyle: TextStyle(color: white),
                                    backgroundColor: tuna,
                                  ),
                                  dataSource: AppointmentDataSource(
                                    getRecursiveAppointments(
                                        viewModel.chartData),
                                  ),
                                ),
                                Align(
                                  alignment: Alignment.topRight,
                                  child: Padding(
                                    padding: EdgeInsets.symmetric(
                                        vertical: 90, horizontal: 16),
                                    child: Column(
                                      children: [
                                        SizedBox(
                                          height: 28.0,
                                        ),
                                        GestureDetector(
                                          onTap: () {
                                            setState(() {
                                              sfCalendarTimeIntervalHeight += 5;
                                            });
                                          },
                                          child: Container(
                                            width: 27.47,
                                            height: 26.97,
                                            decoration: BoxDecoration(
                                              borderRadius: BorderRadius.all(
                                                  Radius.circular(5.0)),
                                              boxShadow: [
                                                BoxShadow(
                                                  blurRadius: 1.0,
                                                  color: darkhighlight,
                                                ),
                                              ],
                                              border: Border.all(
                                                  width: 1.0,
                                                  color: darkhighlight),
                                              shape: BoxShape.rectangle,
                                            ),
                                            child: SvgPicture.asset(
                                              "assets/images/plus.svg",
                                            ),
                                          ),
                                        ),
                                        SizedBox(
                                          height: 15.0,
                                        ),
                                        GestureDetector(
                                          onTap: () {
                                            setState(() {
                                              if (sfCalendarTimeIntervalHeight >
                                                  45)
                                                sfCalendarTimeIntervalHeight -=
                                                    5;
                                            });
                                          },
                                          child: Container(
                                            width: 27.47,
                                            height: 26.97,
                                            decoration: BoxDecoration(
                                              borderRadius: BorderRadius.all(
                                                  Radius.circular(5.0)),
                                              boxShadow: [
                                                BoxShadow(
                                                  blurRadius: 1.0,
                                                  color: darkhighlight,
                                                ),
                                              ],
                                              border: Border.all(
                                                  width: 1.0,
                                                  color: darkhighlight),
                                              shape: BoxShape.rectangle,
                                            ),
                                            child: SvgPicture.asset(
                                              "assets/images/minus.svg",
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ],
                            )
                          : EmptyView(title: 'No data here'),
                    ),
                  ],
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
    return Table(
      border: TableBorder.all(width: 1.0),
      children: [
        TableRow(
          children: [
            // InsiteTableRowItem(
            //   title: 'Last Event',
            //   content: assetOperation.assetOperations.assets.first
            //           .assetLastReceivedEvent.lastReceivedEvent
            //           .contains('Off')
            //       ? 'Engine Ignition/ off'
            //       : 'Engine Ignition/ on',
            // ),
            InsiteTableRowItem(
              title: 'Last Event Time',
              content: Utils.getLastReportedDateOneUTC(assetOperation
                  .assetOperations
                  .assets
                  .first
                  .assetLastReceivedEvent
                  .lastReceivedEventTimeLocal),
            ),
            InsiteTableRowItem(
              title: 'Distance Travelled',
              content: assetOperation.assetOperations.assets.first
                          .distanceTravelledKilometers ==
                      null
                  ? '-'
                  : '${assetOperation.assetOperations.assets.first.distanceTravelledKilometers} km',
            ),
          ],
        ),
        TableRow(
          children: [
            // InsiteTableRowItem(
            //   title: 'Last Known Operator',
            //   content: assetOperation.assetOperations.assets.first
            //               .lastKnownOperator.runtimeType ==
            //           String
            //       ? assetOperation.assetOperations.assets.first
            //           .lastKnownOperator.runtimeType
            //       : '-',
            // ),
            InsiteTableRowItem(
              title: 'This data was last refreshed on',
              content: assetOperation.assetOperations.assets.first
                          .assetLastReceivedEvent.lastReceivedEventTimeLocal ==
                      null
                  ? '-'
                  : Utils.getLastReportedDateOneUTC(assetOperation
                      .assetOperations
                      .assets
                      .first
                      .assetLastReceivedEvent
                      .lastReceivedEventTimeLocal),
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

  void onViewChanged(ViewChangedDetails visibleDatesChangedDetails) {
    if (_view == calendarController.view ||
        (_view != CalendarView.month &&
            calendarController.view != CalendarView.month)) {
      return;
    }
    SchedulerBinding.instance?.addPostFrameCallback((Duration timeStamp) {
      setState(() {
        _view = calendarController.view;
      });
    });
  }

  List<Appointment> getRecursiveAppointments(
      List<SingleAssetOperationChartData> chartData) {
    final List<Appointment> appointments = <Appointment>[];

    if (chartData.isNotEmpty)
      for (SingleAssetOperationChartData item in chartData) {
        final Appointment chartPlot = Appointment(
          startTime: item.startTime,
          endTime: item.endTime,
          color: tango,
          subject: item.segmentType,
        );

        appointments.add(chartPlot);
      }

    return appointments;
  }
}

class AppointmentDataSource extends CalendarDataSource {
  AppointmentDataSource(this.source);

  List<Appointment> source;

  @override
  List<dynamic> get appointments => source;
}
