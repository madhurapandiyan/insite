import 'package:flutter/material.dart';
import 'package:insite/core/models/single_asset_operation.dart';
import 'package:insite/core/models/single_asset_operation_chart_data.dart';
import 'package:insite/theme/colors.dart';
import 'package:insite/utils/helper_methods.dart';
import 'package:insite/widgets/dumb_widgets/insite_row_item_text.dart';
import 'package:insite/widgets/smart_widgets/date_range.dart';
import 'package:intl/intl.dart';
import 'package:stacked/stacked.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import 'single_asset_operation_view_model.dart';

class SingleAssetOperationView extends StatefulWidget {
  SingleAssetOperationView({Key key}) : super(key: key);

  @override
  _SingleAssetOperationViewState createState() =>
      _SingleAssetOperationViewState();
}

class _SingleAssetOperationViewState extends State<SingleAssetOperationView> {
  List<DateTime> dateRange;
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
            child: Column(
              children: [
                Padding(
                  padding: EdgeInsets.all(16.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      GestureDetector(
                        onTap: () {},
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
                      Text(
                        (dateRange == null || dateRange.isEmpty)
                            ? '${Utils.parseDate(DateTime.now().subtract(Duration(days: DateTime.now().weekday)))} - ${Utils.parseDate(DateTime.now())}'
                            : '${Utils.parseDate(dateRange.first)} - ${Utils.parseDate(dateRange.last)}',
                        style: TextStyle(
                            color: white,
                            fontWeight: FontWeight.bold,
                            fontSize: 15),
                      ),
                      GestureDetector(
                        onTap: () async {
                          dateRange = await showDialog(
                            context: context,
                            builder: (BuildContext context) => Dialog(
                                backgroundColor: transparent,
                                child: DateRangeWidget()),
                          );
                          setState(() {
                            dateRange = dateRange;
                            viewModel.startDate =
                                '${dateRange.first.month}/${dateRange.first.day}/${dateRange.first.year}';

                            viewModel.endDate =
                                '${dateRange.last.month}/${dateRange.last.day}/${dateRange.last.year}';
                            viewModel.getSingleAssetOperation();
                          });
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
                ),
                assetOperationTable(viewModel.singleAssetOperation),
                SfCartesianChart(
                  series: getDefaultData(viewModel.singleAssetOperation),
                  backgroundColor: ship_grey,
                  plotAreaBorderColor: black,
                  plotAreaBorderWidth: 3.0,
                  primaryXAxis: DateTimeAxis(
                      opposedPosition: true,
                      dateFormat: DateFormat("hh:mm:ss")),
                  primaryYAxis: DateTimeAxis(dateFormat: DateFormat("MMM dd")),
                  legend: Legend(isVisible: false),
                  tooltipBehavior: TooltipBehavior(enable: true),
                  zoomPanBehavior: ZoomPanBehavior(
                      enablePinching: true, enablePanning: true),
                ),
              ],
            ),
          );
        }
      },
      viewModelBuilder: () => SingleAssetOperationViewModel(),
    );
  }

  Table assetOperationTable(SingleAssetOperation assetOperation) {
    DateFormat format = DateFormat('dd/MM/yyyy hh:mm');

    return Table(
      border: TableBorder.all(width: 2.0),
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

  // TODO: Modify Asset Operation Data and Customise Graph

  static List<ScatterSeries<SingleAssetOperationChartData, DateTime>>
      getDefaultData(SingleAssetOperation assetOperation) {
    final List<SingleAssetOperationChartData> chartData =
        <SingleAssetOperationChartData>[];

    List<SingleAssetOperationChartData> markers = [];

    markers.add(SingleAssetOperationChartData(
        assetOperation.assetOperations.assets[0].assetLastReceivedEvent
            .lastReceivedEventTimeLocal,
        assetOperation.assetOperations.assets[0].assetLastReceivedEvent
            .lastReceivedEventTimeLocal));

    return <ScatterSeries<SingleAssetOperationChartData, DateTime>>[
      ScatterSeries<SingleAssetOperationChartData, DateTime>(
        enableTooltip: true,
        color: tango,
        dataSource: chartData,
        borderWidth: 5,
        xValueMapper: (SingleAssetOperationChartData data, _) => data.xaxis,
        // TODO: Change the axis data
        // yValueMapper: (SingleAssetOperationChartData data, _) => data.yaxis,
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
}
