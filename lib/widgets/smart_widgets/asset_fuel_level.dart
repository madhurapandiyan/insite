import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:insite/core/models/assetstatus_model.dart';
import 'package:insite/core/models/filter_data.dart';
import 'package:insite/theme/colors.dart';
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
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 10),
      height: 230,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10.0),
        boxShadow: [new BoxShadow(blurRadius: 1.0, color: cardcolor)],
        border: Border.all(width: 2.5, color: cardcolor),
        shape: BoxShape.rectangle,
      ),
      child: Stack(
        children: [
          SingleChildScrollView(
            child: Column(children: [
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
                          "FUEL LEVEL",
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
                          width: 210,
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
                    )
                  ],
                ),
              ),
              Divider(
                thickness: 1.0,
                color: black,
              ),
              widget.isLoading
                  ? Expanded(child: Center(child: CircularProgressIndicator()))
                  : Padding(
                      padding: const EdgeInsets.only(top: 3),
                      child: Row(
                        children: [
                          Expanded(
                            flex: 3,
                            child: Container(
                                width: 175,
                                height: 175,
                                child: SfCircularChart(
                                  palette: <Color>[
                                    burntSienna,
                                    lightRose,
                                    mustard,
                                    emerald
                                  ],
                                  legend: Legend(isVisible: false),
                                  centerY: '70%',
                                  series: _getSemiDoughnutSeries(),
                                  tooltipBehavior:
                                      TooltipBehavior(enable: true),
                                )),
                          ),
                          Expanded(
                            flex: 2,
                            child: SingleChildScrollView(
                              child: Container(
                                child: ListView.separated(
                                    separatorBuilder: (context, index) {
                                      return Container(
                                          width: 127.29,
                                          child: Divider(
                                              thickness: 1.0,
                                              color: athenGrey));
                                    },
                                    itemCount: widget.chartData.length,
                                    shrinkWrap: true,
                                    physics: NeverScrollableScrollPhysics(),
                                    padding:
                                        EdgeInsets.symmetric(horizontal: 5.0),
                                    itemBuilder: (context, index) {
                                      ChartSampleData data =
                                          widget.chartData[index];
                                      return AssetStatusWidget(
                                        chartColor: color[index],
                                        chartData: data,
                                        callBack: (value) {
                                          widget.onFilterSelected(FilterData(
                                              isSelected: true,
                                              count: value.y.toString(),
                                              title: value.x.toString(),
                                              type: FilterType.FUEL_LEVEL));
                                        },
                                      );
                                    }),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
            ]),
          ),
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
