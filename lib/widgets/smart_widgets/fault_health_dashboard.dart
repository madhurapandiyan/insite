import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:insite/core/models/asset_status.dart';
import 'package:insite/theme/colors.dart';
import 'package:insite/widgets/dumb_widgets/fault_health_widget.dart';
import 'package:insite/widgets/smart_widgets/fault_dropdown_widget.dart';

class FaultHealthDashboard extends StatefulWidget {
  final List<Count> countData;
  final bool loading;
  FaultHealthDashboard({this.countData,this.loading});

  @override
  _FaultHealthDashboardState createState() => _FaultHealthDashboardState();
}

class _FaultHealthDashboardState extends State<FaultHealthDashboard> {
  var buttonColor = [burntSienna, emerald, mustard];
  var level = ["HIGH", "MEDIUM", "LOW"];

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          // margin: EdgeInsets.all(5),
          height: MediaQuery.of(context).size.height * 0.38,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(10.0),
                topRight: Radius.circular(10.0)),
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
                        SvgPicture.asset("assets/images/arrowdown.svg"),
                        SizedBox(
                          width: 10,
                        ),
                        new Text(
                          "FAULT CODES",
                          style: TextStyle(
                              fontWeight: FontWeight.w900,
                              fontFamily: 'Roboto',
                              color: textcolor,
                              fontStyle: FontStyle.normal,
                              fontSize: 11.0),
                        ),
                      ],
                    ),
                    Row(
                      children: [
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
              Container(
                  margin: EdgeInsets.all(5),
                  height: MediaQuery.of(context).size.height * .05,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(5.0),
                    boxShadow: [
                      new BoxShadow(blurRadius: 1.0, color: cardcolor)
                    ],
                    border: Border.all(width: 2.5, color: silver),
                    shape: BoxShape.rectangle,
                  ),
                  child: FaultDropDown()),
              SizedBox(
                height: 8,
              ),
              widget.loading?
              Expanded(child: Center(
                child: CircularProgressIndicator(),
              )):
              Expanded(
                child: ListView.separated(
                    separatorBuilder: (context, index) {
                      return Container(
                          width: 363,
                          child: Divider(thickness: 1.0, color: black));
                    },
                    itemCount: widget.countData.length,
                    shrinkWrap: true,
                    scrollDirection: Axis.vertical,
                    padding: EdgeInsets.symmetric(horizontal: 5.0),
                    itemBuilder: (context, index) {
                      Count count = widget.countData[index];
                      return FaultWidget(
                        data: count,
                        buttonColor: buttonColor[index],
                        level: level[index],
                      );
                    }),
              ),
              SizedBox(
                height: 10,
              ),
              Container(
                width: double.maxFinite,
                height: MediaQuery.of(context).size.height * 0.05,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(10.0),
                      bottomRight: Radius.circular(10.0)),
                  boxShadow: [new BoxShadow(blurRadius: 1.0, color: black)],
                  border: Border.all(width: 2.5, color: black),
                  shape: BoxShape.rectangle,
                ),
                child: Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Text("VIEWING DATA FOR 7 DAYS",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          fontWeight: FontWeight.w900,
                          fontFamily: 'Roboto',
                          color: textcolor,
                          fontStyle: FontStyle.normal,
                          fontSize: 11.0)),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
