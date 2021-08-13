import 'package:flutter/material.dart';
import 'package:insite/core/models/assetstatus_model.dart';
import 'package:insite/core/models/filter_data.dart';
import 'package:insite/theme/colors.dart';
import 'package:insite/utils/helper_methods.dart';
import 'package:insite/widgets/dumb_widgets/asset_status_widget.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class AssetFuelLevel extends StatefulWidget {
  final List<ChartSampleData> chartData;
  final bool isLoading;
  final Function(FilterData) onFilterSelected;

  AssetFuelLevel({this.chartData, this.isLoading, this.onFilterSelected});

  @override
  _AssetFuelLevelState createState() => _AssetFuelLevelState();
}

class _AssetFuelLevelState extends State<AssetFuelLevel> {
  var colors = [burntSienna, lightRose, mustard, emerald];

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var color = [burntSienna, lightRose, mustard, emerald, emerald];
    double height = MediaQuery.of(context).size.height * 0.32;
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 8),
      height: height,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10.0),
        boxShadow: [new BoxShadow(blurRadius: 1.0, color: cardcolor)],
        border: Border.all(width: 2.5, color: cardcolor),
        shape: BoxShape.rectangle,
      ),
      child: Stack(
        children: [
          Column(children: [
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
                      new Text(
                        "FUEL LEVEL",
                        style: new TextStyle(
                            fontWeight: FontWeight.w900,
                            fontFamily: 'Roboto',
                            color: textcolor,
                            fontStyle: FontStyle.normal,
                            fontSize: 12.0),
                      ),
                      SizedBox(
                        width: 60,
                      )
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
            widget.isLoading
                ? Expanded(child: Center(child: CircularProgressIndicator()))
                : Row(
                    children: [
                      Expanded(
                        flex: 2,
                        child: Container(
                            alignment: Alignment.center,
                            width: MediaQuery.of(context).size.width * 0.20,
                            height: MediaQuery.of(context).size.height * 0.20,
                            child: SfCircularChart(
                              centerX:
                                  (MediaQuery.of(context).size.width * 0.24)
                                      .toStringAsFixed(0),
                              centerY:
                                  (MediaQuery.of(context).size.height * 0.12)
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
                      Expanded(
                        child: Container(
                          child: ListView.separated(
                              separatorBuilder: (context, index) {
                                return Container(
                                    width: 127.29,
                                    child: Divider(
                                        thickness: 1.0, color: athenGrey));
                              },
                              itemCount: widget.chartData.length,
                              shrinkWrap: true,
                              physics: NeverScrollableScrollPhysics(),
                              padding: EdgeInsets.symmetric(horizontal: 5.0),
                              itemBuilder: (context, index) {
                                ChartSampleData data = widget.chartData[index];
                                return AssetStatusWidget(
                                  chartColor: color[index],
                                  label: Utils.getFuleLevelWidgetLabel(
                                      data.x, false),
                                  callBack: () {
                                    widget.onFilterSelected(FilterData(
                                        isSelected: true,
                                        count: data.y.toString(),
                                        title: data.x.toString(),
                                        type: FilterType.FUEL_LEVEL));
                                  },
                                );
                              }),
                        ),
                      ),
                    ],
                  ),
          ]),
        ],
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
          //dataLabelMapper: (ChartSampleData data, _)=>d,
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

  getCount(int data){
    int result=data;
    print("@@@:$result");

  }
  
}
