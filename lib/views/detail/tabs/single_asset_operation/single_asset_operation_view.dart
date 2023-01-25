import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:insite/core/models/asset_detail.dart';
import 'package:insite/core/models/single_asset_operation_chart_data.dart';
import 'package:insite/theme/colors.dart';
import 'package:insite/utils/helper_methods.dart';
import 'package:insite/widgets/dumb_widgets/empty_view.dart';
import 'package:insite/widgets/dumb_widgets/insite_button.dart';
import 'package:insite/widgets/dumb_widgets/insite_progressbar.dart';
import 'package:insite/widgets/dumb_widgets/insite_row_item_text.dart';
import 'package:insite/views/date_range/date_range_view.dart';
import 'package:insite/widgets/dumb_widgets/insite_text.dart';
import 'package:intl/intl.dart';
import 'package:logger/logger.dart';
import 'package:stacked/stacked.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';
import 'single_asset_operation_view_model.dart';

class SingleAssetOperationView extends StatefulWidget {
  final AssetDetail? detail;
  SingleAssetOperationView({this.detail});

  @override
  _SingleAssetOperationViewState createState() =>
      _SingleAssetOperationViewState();
}

class _SingleAssetOperationViewState extends State<SingleAssetOperationView> {
  List<DateTime>? dateRange = [];

  final CalendarController calendarController = CalendarController();
  CalendarView? _view = CalendarView.week;

  double sfCalendarTimeIntervalHeight = 40;

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<SingleAssetOperationViewModel>.reactive(
      builder: (BuildContext context, SingleAssetOperationViewModel viewModel,
          Widget? _) {
        if (viewModel.loading) {
          return InsiteProgressBar();
        } else {
          return Container(
            decoration: BoxDecoration(
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(16),
                  topRight: Radius.circular(16),
                ),
                color: Theme.of(context).backgroundColor),
            child: Stack(
              children: [
                Column(
                  children: [
                    Padding(
                      padding: EdgeInsets.all(16.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          InsiteButton(
                            title: "Refresh",
                            width: 90,
                            height: 30,
                            bgColor: Theme.of(context).backgroundColor,
                            textColor:
                                Theme.of(context).textTheme.bodyText1!.color,
                            onTap: () {
                              viewModel.refresh();
                            },
                          ),
                          Row(
                            children: [
                              // InsiteText(
                              //     text: Utils.getDateInFormatddMMyyyy(
                              //             viewModel.startDate) +
                              //         " - " +
                              //         Utils.getDateInFormatddMMyyyy(
                              //             viewModel.endDate),
                              //     fontWeight: FontWeight.bold,
                              //     size: 12),
                              // SizedBox(
                              //   width: 10,
                              // ),
                              InsiteButton(
                                title: Utils.getDateInFormatddMMyyyy(
                                        viewModel.startDate) +
                                    " - " +
                                    Utils.getDateInFormatddMMyyyy(
                                        viewModel.endDate),
                                //width: 90,
                                // bgColor: Theme.of(context).backgroundColor,
                                textColor: Theme.of(context)
                                    .textTheme
                                    .bodyText1!
                                    .color,
                                onTap: () async {
                                  dateRange = await showDialog(
                                    context: context,
                                    builder: (BuildContext context) => Dialog(
                                        backgroundColor: transparent,
                                        child: DateRangeView()),
                                  );
                                  if (dateRange != null &&
                                      dateRange!.isNotEmpty) {
                                    setState(() {
                                      dateRange = dateRange;
                                    });
                                    viewModel.calenderViewChange();
                                    viewModel.refresh();
                                  }
                                },
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    Expanded(
                      child: SingleChildScrollView(
                        child: Column(
                          children: [
                            viewModel.singleAssetOperation != null
                                ? Table(
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
                                            content: viewModel
                                                        .singleAssetOperation!
                                                        .assetOperations!
                                                        .assets!
                                                        .first
                                                        .assetLastReceivedEvent!
                                                        .lastReceivedEventTimeLocal !=
                                                    null
                                                ? Utils.getLastReportedDateOneLocalUTC(
                                                    viewModel
                                                        .singleAssetOperation!
                                                        .assetOperations!
                                                        .assets!
                                                        .first
                                                        .assetLastReceivedEvent!
                                                        .lastReceivedEventTimeLocal)
                                                : "-",
                                          ),
                                          InsiteTableRowItem(
                                            title: 'Distance Travelled',
                                            content: viewModel
                                                        .singleAssetOperation!
                                                        .assetOperations!
                                                        .assets!
                                                        .first
                                                        .distanceTravelledKilometers ==
                                                    null
                                                ? '-'
                                                : '${viewModel.singleAssetOperation!.assetOperations!.assets!.first.distanceTravelledKilometers!.round()} km',
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
                                            title:
                                                'This data was last refreshed on',
                                            content:
                                                Utils.formatCurrentSystemTime(
                                                    DateTime.now().toString()),
                                          ),
                                          InsiteTableRowItem(
                                            title: 'Total Duration ',
                                            content: viewModel
                                                        .singleAssetOperation!
                                                        .assetOperations!
                                                        .assets!
                                                        .first
                                                        .dateRangeRuntimeDuration !=
                                                    null
                                                ? Utils.formatHHmm(Duration(
                                                            seconds: viewModel
                                                                .singleAssetOperation!
                                                                .assetOperations!
                                                                .assets!
                                                                .first
                                                                .dateRangeRuntimeDuration!
                                                                .toInt())
                                                        .inSeconds)
                                                    .toString()
                                                : "-",
                                          ),
                                        ],
                                      ),
                                    ],
                                  )
                                : SizedBox(),
                            viewModel.singleAssetOperation != null
                                ? Stack(
                                    children: [
                                      SfCalendar(
                                        showNavigationArrow: false,
                                        backgroundColor:
                                            Theme.of(context).backgroundColor,
                                        cellBorderColor: Theme.of(context)
                                            .textTheme
                                            .bodyText1!
                                            .color,
                                        showCurrentTimeIndicator: false,
                                        controller: calendarController,
                                        onTap: (calendarTapDetails) {
                                          // Logger().i(
                                          // "on tap ${calendarTapDetails.appointments[0].notes}");
                                          // var title = "Running";
                                          // var startTime =
                                          //     Utils.getLastReportedDateUTC(
                                          //         calendarTapDetails
                                          //             .appointments[0].startTime);
                                          // var endTime =
                                          //     Utils.getLastReportedDateUTC(
                                          //         calendarTapDetails
                                          //             .appointments[0].endTime);
                                          // var duration = (double.parse(
                                          //             calendarTapDetails
                                          //                 .appointments[0].notes) /
                                          //         60)
                                          //     .round();
                                          // var message =
                                          //     "Start:$startTime \n End: $endTime \n Duration: $duration minutes";
                                          // Utils.showInfo(context, title, message);
                                        },
                                        onSelectionChanged:
                                            (calendarSelectionDetails) {},
                                        view: viewModel.calenderView,
                                        //initialDisplayDate: DateTime.tryParse(viewModel.startDate!),
                                        todayHighlightColor:
                                            Theme.of(context).buttonColor,
                                        todayTextStyle: TextStyle(
                                            color: Colors.white,
                                            fontWeight: FontWeight.bold),
                                        timeSlotViewSettings:
                                            TimeSlotViewSettings(
                                          dateFormat: 'd',
                                          dayFormat: 'MMM',
                                          timeIntervalHeight:
                                              sfCalendarTimeIntervalHeight,
                                          timeTextStyle: TextStyle(
                                              color: Theme.of(context)
                                                  .textTheme
                                                  .bodyText1!
                                                  .color),
                                        ),
                                        // minDate:
                                        //     DateTime.tryParse(viewModel.startDate!),
                                        // maxDate:
                                        //     DateTime.tryParse(viewModel.endDate!)!
                                        //         .add(Duration(days: 1)),
                                        onViewChanged: onViewChanged,
                                        viewHeaderStyle: ViewHeaderStyle(
                                          dayTextStyle: TextStyle(
                                              color: Theme.of(context)
                                                  .textTheme
                                                  .bodyText1!
                                                  .color),
                                          dateTextStyle: TextStyle(
                                              color: Theme.of(context)
                                                  .textTheme
                                                  .bodyText1!
                                                  .color),
                                          backgroundColor:
                                              Theme.of(context).backgroundColor,
                                        ),
                                        dataSource: AppointmentDataSource(
                                          getRecursiveAppointments(
                                              viewModel.chartData),
                                        ),
                                      ),
                                      Positioned(
                                        right: 20,
                                        bottom: 20,
                                        child: Column(
                                          children: [
                                            GestureDetector(
                                              onTap: () {
                                                setState(() {
                                                  sfCalendarTimeIntervalHeight +=
                                                      5;
                                                });
                                              },
                                              child: Container(
                                                width: 27.47,
                                                height: 26.97,
                                                decoration: BoxDecoration(
                                                  borderRadius:
                                                      BorderRadius.all(
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
                                            SizedBox(height: 10),
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
                                                  borderRadius:
                                                      BorderRadius.all(
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
                                      // Align(
                                      //   alignment: Alignment.bottomLeft,
                                      //   child: Padding(
                                      //     padding: EdgeInsets.symmetric(
                                      //         vertical: 90, horizontal: 16),
                                      //     child: Column(
                                      //       children: [
                                      //         SizedBox(
                                      //           height: 28.0,
                                      //         ),
                                      //         GestureDetector(
                                      //           onTap: () {
                                      //             setState(() {
                                      //               sfCalendarTimeIntervalHeight +=
                                      //                   5;
                                      //             });
                                      //           },
                                      //           child: Container(
                                      //             width: 27.47,
                                      //             height: 26.97,
                                      //             decoration: BoxDecoration(
                                      //               borderRadius:
                                      //                   BorderRadius.all(
                                      //                       Radius.circular(
                                      //                           5.0)),
                                      //               boxShadow: [
                                      //                 BoxShadow(
                                      //                   blurRadius: 1.0,
                                      //                   color: darkhighlight,
                                      //                 ),
                                      //               ],
                                      //               border: Border.all(
                                      //                   width: 1.0,
                                      //                   color: darkhighlight),
                                      //               shape: BoxShape.rectangle,
                                      //             ),
                                      //             child: SvgPicture.asset(
                                      //               "assets/images/plus.svg",
                                      //             ),
                                      //           ),
                                      //         ),
                                      //         SizedBox(height: 10),
                                      //         GestureDetector(
                                      //           onTap: () {
                                      //             setState(() {
                                      //               if (sfCalendarTimeIntervalHeight >
                                      //                   45)
                                      //                 sfCalendarTimeIntervalHeight -=
                                      //                     5;
                                      //             });
                                      //           },
                                      //           child: Container(
                                      //             width: 27.47,
                                      //             height: 26.97,
                                      //             decoration: BoxDecoration(
                                      //               borderRadius:
                                      //                   BorderRadius.all(
                                      //                       Radius.circular(
                                      //                           5.0)),
                                      //               boxShadow: [
                                      //                 BoxShadow(
                                      //                   blurRadius: 1.0,
                                      //                   color: darkhighlight,
                                      //                 ),
                                      //               ],
                                      //               border: Border.all(
                                      //                   width: 1.0,
                                      //                   color: darkhighlight),
                                      //               shape: BoxShape.rectangle,
                                      //             ),
                                      //             child: SvgPicture.asset(
                                      //               "assets/images/minus.svg",
                                      //             ),
                                      //           ),
                                      //         ),
                                      //       ],
                                      //     ),
                                      //   ),
                                      // ),
                                    ],
                                  )
                                : EmptyView(title: 'No Results'),
                          ],
                        ),
                      ),
                    )
                  ],
                ),
                viewModel.refreshing ? InsiteProgressBar() : SizedBox()
              ],
            ),
          );
        }
      },
      viewModelBuilder: () => SingleAssetOperationViewModel(widget.detail),
    );
  }

  void onViewChanged(ViewChangedDetails visibleDatesChangedDetails) {
    if (_view == calendarController.view ||
        (_view != CalendarView.month &&
            calendarController.view != CalendarView.month)) {
      return;
    }
    SchedulerBinding.instance.addPostFrameCallback((Duration timeStamp) {
      setState(() {
        _view = calendarController.view;
      });
    });
  }

  List<Appointment> getRecursiveAppointments(
      List<SingleAssetOperationChartData> chartData) {
    try {
      final List<Appointment> appointments = <Appointment>[];
      if (chartData.isNotEmpty)
        for (SingleAssetOperationChartData item in chartData) {
          final Appointment chartPlot = Appointment(
            startTime: item.startTime!.toLocal(),
            endTime: item.endTime!.toLocal(),
            color: Theme.of(context).buttonColor,
            subject: "",
            notes: item.duration.toString(),
            //making subject empty
            // subject: item.segmentType,
          );
          appointments.add(chartPlot);
        }
      return appointments;
    } catch (e) {
      Logger().e(e);
      return [];
    }
  }
}

class AppointmentDataSource extends CalendarDataSource {
  AppointmentDataSource(this.source);

  List<Appointment> source;

  @override
  List<dynamic> get appointments => source;
}
