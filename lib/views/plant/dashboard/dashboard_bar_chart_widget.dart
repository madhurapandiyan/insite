import 'package:flutter/material.dart';
import 'package:insite/core/models/assetstatus_model.dart';
import 'package:insite/theme/colors.dart';
import 'package:insite/widgets/dumb_widgets/asset_status_widget.dart';
import 'package:insite/widgets/dumb_widgets/insite_button.dart';
import 'package:insite/widgets/dumb_widgets/insite_progressbar.dart';
import 'package:insite/widgets/dumb_widgets/insite_text.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class DashboardBarChartWidget extends StatefulWidget {
  final List<ChartSampleData> data;
  final String title;
  final String title2;
  final bool isLoading;
  final bool isRefreshing;
  final Function(String) onFilterSelected;
  const DashboardBarChartWidget(
      {Key key,
      this.data,
      this.title2,
      this.title,
      this.isLoading,
      this.onFilterSelected,
      this.isRefreshing})
      : super(key: key);

  @override
  _DashboardBarChartWidgetState createState() =>
      _DashboardBarChartWidgetState();
}

class _DashboardBarChartWidgetState extends State<DashboardBarChartWidget> {
  var colors = [
    emerald,
    mustard,
    burntSienna,
  ];

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height * 0.33;
    return Card(
      child: Container(
        height: height,
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
                      new InsiteText(
                          text: "ASSET DETAILS - TOTAL ASSET",
                          fontWeight: FontWeight.w900,
                          size: 12.0),
                      SizedBox(
                        width: 60.0,
                      ),
                    ],
                  ),
                  !widget.isLoading
                      ? InsiteButton(
                          title: widget.title2,
                          textColor: Colors.white,
                          onTap: () {
                            widget.onFilterSelected("total");
                          },
                        )
                      : SizedBox()
                  // Row(
                  //   children: [
                  //     InsiteText(
                  //       fontWeight: FontWeight.w900,
                  //       text: "ALL ASSETS",
                  //       size: 12,
                  //     ),
                  //     SizedBox(
                  //       width: 35.0,
                  //     ),
                  //     // GestureDetector(
                  //     //   onTap: () => print("button is tapped"),
                  //     //   child: SvgPicture.asset(
                  //     //     "assets/images/menu.svg",
                  //     //     width: 20,
                  //     //     height: 20,
                  //     //   ),
                  //     // ),
                  //   ],
                  // ),
                ],
              ),
            ),
            Divider(
              thickness: 1.0,
              color: Theme.of(context).dividerColor,
            ),
            (widget.isLoading || widget.isRefreshing)
                ? Expanded(child: InsiteProgressBar())
                : Row(
                    children: [
                      Expanded(
                        flex: 2,
                        child: Container(
                          width: MediaQuery.of(context).size.width * 0.20,
                          height: MediaQuery.of(context).size.height * 0.20,
                          padding: EdgeInsets.only(left: 16),
                          alignment: Alignment.center,
                          child: SfCircularChart(
                            palette: <Color>[
                              emerald,
                              mustard,
                              burntSienna,
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
                          alignment: Alignment.center,
                          padding: EdgeInsets.symmetric(vertical: 8),
                          child: ListView.separated(
                              separatorBuilder: (context, index) {
                                return Divider(
                                    thickness: 1.0, color: athenGrey);
                              },
                              shrinkWrap: true,
                              physics: NeverScrollableScrollPhysics(),
                              itemCount: widget.data.length,
                              scrollDirection: Axis.vertical,
                              padding: EdgeInsets.only(right: 10.0),
                              itemBuilder: (context, index) {
                                ChartSampleData assetStatusData =
                                    widget.data[index];
                                return AssetStatusWidget(
                                  chartColor: colors[index],
                                  label: assetStatusData.x,
                                  callBack: () {
                                    widget.onFilterSelected(assetStatusData.z);
                                  },
                                );
                              }),
                        ),
                      )
                    ],
                  ),
          ],
        ),
      ),
    );
  }

  List<DoughnutSeries<ChartSampleData, String>> _getLegendDefaultSeries() {
    if (widget.data != null) {
      for (int i = widget.data.length - 1; i >= 0; i--) {
        if (widget.data[i].y.round() == 0) {
          widget.data.removeAt(i);
        }
      }
    }
    return <DoughnutSeries<ChartSampleData, String>>[
      DoughnutSeries<ChartSampleData, String>(
          dataSource: widget.data,
          xValueMapper: (ChartSampleData data, _) => data.x,
          yValueMapper: (ChartSampleData data, _) => data.y,
          startAngle: 90,
          endAngle: 90,
          radius: '85%',
          dataLabelSettings: DataLabelSettings(
              connectorLineSettings:
                  ConnectorLineSettings(width: 1.5, length: "10%"),
              textStyle: new TextStyle(
                  color: Theme.of(context).textTheme.bodyText1.color,
                  fontSize: 10.0,
                  fontWeight: FontWeight.w700,
                  fontStyle: FontStyle.normal),
              isVisible: true,
              labelPosition: ChartDataLabelPosition.outside,
              labelIntersectAction: LabelIntersectAction.none)),
    ];
  }
}
