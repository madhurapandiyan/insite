import 'package:flutter/material.dart';
import 'package:insite/core/models/assetstatus_model.dart';
import 'package:insite/core/models/filter_data.dart';
import 'package:insite/theme/colors.dart';
import 'package:insite/utils/helper_methods.dart';
import 'package:insite/widgets/dumb_widgets/asset_status_widget.dart';
import 'package:insite/widgets/dumb_widgets/insite_progressbar.dart';
import 'package:insite/widgets/dumb_widgets/insite_text.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class AssetFuelLevel extends StatefulWidget {
  final List<ChartSampleData> chartData;
  final bool isLoading;
  final bool isRefreshing;
  final Function(FilterData) onFilterSelected;

  AssetFuelLevel(
      {this.chartData,
      this.isLoading,
      this.onFilterSelected,
      this.isRefreshing});

  @override
  _AssetFuelLevelState createState() => _AssetFuelLevelState();
}

class _AssetFuelLevelState extends State<AssetFuelLevel> {
  var colors = [burntSienna, lightRose, mustard, emerald, emerald];

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var color = [
      burntSienna,
      lightRose,
      mustard,
      emerald,
      lightRose,
      persianIndigo,
      maptextcolor,
      sandyBrown,
    ];
    double height = MediaQuery.of(context).size.height * 0.32;
    return Card(
      margin: EdgeInsets.symmetric(horizontal: 8),
      child: Container(
        height: height,
        child: Column(children: [
          Padding(
            padding: const EdgeInsets.all(14.0),
            child: new Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    // SvgPicture.asset("assets/images/arrowdown.svg"),
                    SizedBox(
                      width: 10,
                    ),
                    InsiteText(
                      text: "FUEL LEVEL",
                      fontWeight: FontWeight.w900,
                      size: 12,
                    ),
                    SizedBox(
                      width: 60,
                    )
                  ],
                ),
                Row(
                  children: [
                    InsiteText(
                      text: 'ALL ASSETS',
                      fontWeight: FontWeight.w900,
                      size: 12,
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
            color: Theme.of(context).dividerColor,
          ),
          (widget.isLoading || widget.isRefreshing)
              ? Expanded(child: InsiteProgressBar())
              : Row(
                  children: [
                    Expanded(
                      flex: 2,
                      child: Container(
                          alignment: Alignment.center,
                          width: MediaQuery.of(context).size.width * 0.20,
                          height: MediaQuery.of(context).size.height * 0.20,
                          child: SfCircularChart(
                            centerX: (MediaQuery.of(context).size.width * 0.24)
                                .toStringAsFixed(0),
                            centerY: (MediaQuery.of(context).size.height * 0.12)
                                .toStringAsFixed(0),
                            palette: <Color>[
                              burntSienna,
                              lightRose,
                              mustard,
                              emerald
                            ],
                            legend: Legend(isVisible: false),
                            series: _getSemiDoughnutSeries(),
                            tooltipBehavior: TooltipBehavior(enable: true),
                          )),
                    ),
                    Flexible(
                      child: Container(
                        height: MediaQuery.of(context).size.height * 0.20,
                        child: ListView.separated(
                            separatorBuilder: (context, index) {
                              return Container(
                                  width: 127.29,
                                  child: Divider(
                                      thickness: 1.0, color: athenGrey));
                            },
                            itemCount: widget.chartData.length,
                            shrinkWrap: true,
                            scrollDirection: Axis.vertical,
                            padding: EdgeInsets.symmetric(horizontal: 5.0),
                            itemBuilder: (context, index) {
                              ChartSampleData data = widget.chartData[index];
                              return AssetStatusWidget(
                                chartColor: color[index],
                                label: Utils.getFuleLevelWidgetLabel(
                                    data.x, false),
                                callBack: () {
                                  if (data.y > 0) {
                                    widget.onFilterSelected(FilterData(
                                        isSelected: true,
                                        count: data.y.toString(),
                                        title: data.x.toString(),
                                        type: FilterType.FUEL_LEVEL));
                                  }
                                },
                              );
                            }),
                      ),
                    ),
                  ],
                ),
        ]),
      ),
    );
  }

  _getSemiDoughnutSeries() {
    return <DoughnutSeries<ChartSampleData, String>>[
      DoughnutSeries<ChartSampleData, String>(
          dataSource: widget.chartData,
          radius: '85%',
          startAngle: 270,
          endAngle: 90,
          dataLabelMapper: (ChartSampleData data, _) => data.z,
          xValueMapper: (ChartSampleData data, _) => data.x,
          yValueMapper: (ChartSampleData data, _) => data.y,
          dataLabelSettings: DataLabelSettings(
              connectorLineSettings:
                  ConnectorLineSettings(width: 1.5, length: "10%"),
              color: cardcolor,
              textStyle: new TextStyle(
                  color: textcolor,
                  fontSize: 10.0,
                  fontWeight: FontWeight.w700,
                  fontFamily: 'Roboto',
                  fontStyle: FontStyle.normal),
              isVisible: true,
              labelPosition: ChartDataLabelPosition.outside,
              labelIntersectAction: LabelIntersectAction.none))
    ];
  }
}
