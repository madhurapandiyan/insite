import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:insite/core/models/assetstatus_model.dart';
import 'package:insite/core/models/filter_data.dart';
import 'package:insite/theme/colors.dart';
import 'package:insite/widgets/dumb_widgets/asset_status_widget.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class AssetStatus extends StatefulWidget {
  final List<ChartSampleData> statusChartData;
  final bool isLoading;
  final bool isRefreshing;
  final Function(FilterData) onFilterSelected;
  AssetStatus({this.statusChartData, this.isLoading, this.onFilterSelected,this.isRefreshing});

  @override
  _AssetStatusState createState() => _AssetStatusState();
}

class _AssetStatusState extends State<AssetStatus> {
  var colors = [
    emerald,
    burntSienna,
    mustard,
    textcolor,
    lightRose,
    persianIndigo,
    maptextcolor,
    sandyBrown
  ];
  @override
  Widget build(BuildContext context) {
    // double width=MediaQuery.of(context).size.width*1.30;
    double height = MediaQuery.of(context).size.height * 0.33;
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 8.0),
      // width: width,
      height: height,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10.0),
        boxShadow: [new BoxShadow(blurRadius: 1.0, color: cardcolor)],
        border: Border.all(width: 2.5, color: cardcolor),
        shape: BoxShape.rectangle,
      ),
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    // SvgPicture.asset("assets/images/arrowdown.svg"),
                    SizedBox(
                      width: 10,
                    ),
                    new Text(
                      "ASSET STATUS",
                      style: new TextStyle(
                          fontWeight: FontWeight.w900,
                          fontFamily: 'Roboto',
                          color: textcolor,
                          fontStyle: FontStyle.normal,
                          fontSize: 12.0),
                    ),
                    SizedBox(
                      width: 60.0,
                    ),
                  ],
                ),
                Row(
                  children: [
                    new Text(
                      'ALL ASSETS',
                      style: new TextStyle(
                          fontWeight: FontWeight.w900,
                          fontFamily: 'Roboto',
                          color: textcolor,
                          fontStyle: FontStyle.normal,
                          fontSize: 12.0),
                    ),
                    SizedBox(
                      width: 35.0,
                    ),
                    // GestureDetector(
                    //   onTap: () => print("button is tapped"),
                    //   child: SvgPicture.asset(
                    //     "assets/images/menu.svg",
                    //     width: 20,
                    //     height: 20,
                    //   ),
                    // ),
                  ],
                ),
              ],
            ),
          ),
          Divider(
            thickness: 1.0,
            color: black,
          ),
          (widget.isLoading || widget.isRefreshing)
              ? Expanded(child: Center(child: CircularProgressIndicator()))
              : Row(
                  children: [
                    Expanded(
                      flex: 2,
                      child: Container(
                        width: MediaQuery.of(context).size.width * 0.20,
                        height: MediaQuery.of(context).size.height * 0.20,
                        alignment: Alignment.center,
                        child: SfCircularChart(
                          palette: <Color>[
                            emerald,
                            burntSienna,
                            mustard,
                            textcolor,
                            lightRose,
                            persianIndigo,
                            maptextcolor,
                            sandyBrown
                          ],
                          legend: Legend(
                              isVisible: false,
                              overflowMode: LegendItemOverflowMode.wrap),
                          series: _getLegendDefaultSeries(),
                          centerX: (MediaQuery.of(context).size.width * 0.21)
                              .toStringAsFixed(0),
                          centerY: (MediaQuery.of(context).size.height * 0.10)
                              .toStringAsFixed(0),
                          tooltipBehavior: TooltipBehavior(enable: true),
                        ),
                      ),
                    ),
                    Flexible(
                      child: Container(
                        height: MediaQuery.of(context).size.height * 0.20,
                        alignment: Alignment.center,
                        padding: EdgeInsets.symmetric(vertical: 8),
                        child: ListView.separated(
                            separatorBuilder: (context, index) {
                              return Divider(thickness: 1.0, color: athenGrey);
                            },
                            shrinkWrap: true,
                            itemCount: widget.statusChartData.length,
                            scrollDirection: Axis.vertical,
                            padding: EdgeInsets.symmetric(horizontal: 5.0),
                            itemBuilder: (context, index) {
                              ChartSampleData assetStatusData =
                                  widget.statusChartData[index];
                              return AssetStatusWidget(
                                chartColor: colors[index],
                                label: assetStatusData.x,
                                callBack: () {
                                  widget.onFilterSelected(FilterData(
                                      isSelected: true,
                                      count: assetStatusData.y.toString(),
                                      title: assetStatusData.x,
                                      type: FilterType.ALL_ASSETS));
                                },
                              );
                            }),
                      ),
                    )
                  ],
                ),
        ],
      ),
    );
  }

  List<DoughnutSeries<ChartSampleData, String>> _getLegendDefaultSeries() {
    if (widget.statusChartData != null) {
      for (int i = widget.statusChartData.length - 1; i >= 0; i--) {
        if (widget.statusChartData[i].y.round() == 0) {
          widget.statusChartData.removeAt(i);
        }
      }
    }
    return <DoughnutSeries<ChartSampleData, String>>[
      DoughnutSeries<ChartSampleData, String>(
          dataSource: widget.statusChartData,
          xValueMapper: (ChartSampleData data, _) => data.x,
          yValueMapper: (ChartSampleData data, _) => data.y,
          startAngle: 90,
          endAngle: 90,
          radius: '85%',
          dataLabelSettings: DataLabelSettings(
              connectorLineSettings:
                  ConnectorLineSettings(width: 1.5, length: "10%"),
              textStyle: new TextStyle(
                  color: textcolor,
                  fontSize: 10.0,
                  fontWeight: FontWeight.w700,
                  fontFamily: 'Roboto',
                  fontStyle: FontStyle.normal),
              isVisible: true,
              labelPosition: ChartDataLabelPosition.outside,
              labelIntersectAction: LabelIntersectAction.none)),
    ];
  }
}
