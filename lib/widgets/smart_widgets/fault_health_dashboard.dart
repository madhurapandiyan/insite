import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:insite/core/models/single_asset_fault_response.dart';
import 'package:insite/theme/colors.dart';
import 'package:insite/widgets/dumb_widgets/fault_health_widget.dart';

class 
FaultHealthDashboard extends StatefulWidget {
  final List<CountData> countData;
  final bool loading;
  FaultHealthDashboard({this.countData, this.loading});

  @override
  _FaultHealthDashboardState createState() => _FaultHealthDashboardState();
}

class _FaultHealthDashboardState extends State<FaultHealthDashboard> {

  var buttonColor = [burntSienna, Colors.orange, mustard];
  var level = ["HIGH", "MEDIUM", "LOW"];

  @override
  Widget build(BuildContext context) {
    
    return Container(
      height: MediaQuery.of(context).size.height * 0.38,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.all(
          Radius.circular(10.0),
        ),
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
          // Container(
          //     margin: EdgeInsets.symmetric(horizontal: 10, vertical: 4),
          //     height: MediaQuery.of(context).size.height * .05,
          //     decoration: BoxDecoration(
          //       borderRadius: BorderRadius.circular(5.0),
          //       boxShadow: [
          //         new BoxShadow(blurRadius: 1.0, color: cardcolor)
          //       ],
          //       border: Border.all(width: 2.5, color: silver),
          //       shape: BoxShape.rectangle,
          //     ),
          //     child: FaultDropDown()),
          SizedBox(
            height: 10,
          ),
          widget.loading
              ? Expanded(
                  child: Center(
                  child: CircularProgressIndicator(),
                ))
              : Expanded(
                  child: ListView.separated(
                      separatorBuilder: (context, index) {
                        return Container(
                            child: Divider(thickness: 1.0, color: black));
                      },
                      itemCount: widget.countData.length,
                      shrinkWrap: true,
                      scrollDirection: Axis.vertical,
                      padding: EdgeInsets.symmetric(horizontal: 10.0),
                      itemBuilder: (context, index) {
                        CountData countResponse = widget.countData[index];
                        return FaultWidget(
                          data: countResponse,
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
    );
  }
}
