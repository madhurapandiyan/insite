import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:insite/core/models/assetstatus_model.dart';
import 'package:insite/theme/colors.dart';
import 'package:insite/widgets/dumb_widgets/asset_status_usage.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class AssetStatusUsage extends StatefulWidget {
  final List<ChartSampleData> statusChartData;
  final bool isLoading;

  AssetStatusUsage({this.statusChartData, this.isLoading});
  @override
  _AssetStatusUsageState createState() => _AssetStatusUsageState();
}

class _AssetStatusUsageState extends State<AssetStatusUsage> {
  var chartHrsData = [
    "30-40 HRS",
    "20-30 HRS",
    "10-20 HRS",
    "0-20 HRS",
    "30-40 HRS",
    "20-30 HRS",
    "10-20 HRS",
    "0-20 HRS"
  ];
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
    double height = MediaQuery.of(context).size.height * 0.30;
    return Container(
      height: height,
      margin: const EdgeInsets.symmetric(horizontal: 8.0),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10.0),
        boxShadow: [new BoxShadow(blurRadius: 1.0, color: cardcolor)],
        border: Border.all(width: 2.5, color: cardcolor),
        shape: BoxShape.rectangle,
      ),
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(14.0),
            child: new Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    SvgPicture.asset("assets/images/arrowdown.svg"),
                    SizedBox(
                      width: 10,
                    ),
                    new Text(
                      "ASSET USAGE BY HOURS",
                      style: new TextStyle(
                          fontWeight: FontWeight.w900,
                          fontFamily: 'Roboto',
                          color: textcolor,
                          fontStyle: FontStyle.normal,
                          fontSize: 12.0),
                    ),
                  ],
                ),
                Row(
                  children: [
                    SizedBox(
                      width: 60.0,
                    ),
                    GestureDetector(
                      onTap: () => print("button is tapped"),
                      child: SvgPicture.asset(
                        "assets/images/menu.svg",
                        width: 20,
                        height: 20,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          Divider(
            thickness: 1.0,
            color: black,
          ),
          widget.isLoading
              ? Expanded(child: Center(child: CircularProgressIndicator()))
              : new Row(
                children: [
                  Expanded(
                    flex: 1,
                    child: Container(
                      width: 150,
                      height: 150,
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
                        centerX:
                            (MediaQuery.of(context).size.width * 0.18)
                                .toStringAsFixed(0),
                        series: _getLegendDefaultSeries(),
                        tooltipBehavior: TooltipBehavior(enable: true),
                      ),
                    ),
                  ),
                  Expanded(
                    flex: 1,
                    child: Container(
                      height: MediaQuery.of(context).size.height*0.20,
                      child: ListView.separated(
                          separatorBuilder: (context, index) {
                            return Container(
                                width: 127.29,
                                child: Divider(
                                    thickness: 1.0, color: athenGrey));
                          },
                          itemCount: widget.statusChartData.length,
                          shrinkWrap: true,
                          scrollDirection: Axis.vertical,
                          physics: ClampingScrollPhysics(),
                          padding: EdgeInsets.symmetric(horizontal: 5.0),
                          itemBuilder: (context, index) {
                            ChartSampleData assetStatusData =
                                widget.statusChartData[index];
      
                            return AssetStatusUsageWidget(
                              chartHrsData: chartHrsData[index],
                              chartColor: colors[index],
                              assetStatusData: assetStatusData,
                            );
                          }),
                    ),
                  ),
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
