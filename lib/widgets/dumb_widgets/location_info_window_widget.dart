import 'package:clippy_flutter/triangle.dart';
import 'package:flutter/material.dart';
import 'package:insite/theme/colors.dart';
import 'package:insite/views/location/location_view_model.dart';
import 'package:insite/widgets/dumb_widgets/insite_button.dart';

class LocationInfoWindowWidget extends StatelessWidget {
  final int assetCount;
  final String infoText;
  final VoidCallback onCustomWindowClose;
  final VoidCallback onFleetPageSelectedTap;
  final VoidCallback onTapWithZoom;
  final TYPE type;
  LocationInfoWindowWidget(
      {this.assetCount,
      this.type,
      this.onCustomWindowClose,
      this.onFleetPageSelectedTap,
      this.infoText,
      this.onTapWithZoom});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          height: MediaQuery.of(context).size.height * 0.30,
          decoration: BoxDecoration(
            color: cardcolor,
            borderRadius: BorderRadius.circular(10),
          ),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      "Cluster Info",
                      style: new TextStyle(
                          fontFamily: 'Roboto',
                          fontSize: 13.0,
                          fontWeight: FontWeight.w700,
                          color: silver),
                    ),
                  ),
                  GestureDetector(
                      onTap: onCustomWindowClose,
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Image.asset("assets/images/mapclose.png"),
                      ))
                ],
              ),
              Container(
                width: 216,
                color: thunder,
                child: Padding(
                  padding: EdgeInsets.only(left: 38, top: 5.0, bottom: 5.0),
                  child: Text(
                    assetCount > 1
                        ? assetCount.toString() + " " + "Assets"
                        : "Serialnumber \n $infoText",
                    style: TextStyle(
                        fontFamily: 'Roboto',
                        fontSize: 13.0,
                        fontWeight: FontWeight.w700,
                        color: silver),
                  ),
                ),
              ),
              SizedBox(
                height: 10,
              ),
              InsiteButton(
                  width: MediaQuery.of(context).size.width * 0.30,
                  height: MediaQuery.of(context).size.height * 0.06,
                  fontSize: 12,
                  bgColor: tango,
                  title: assetCount > 1
                      ? type == TYPE.DASHBOARD
                          ? "  Fleet List  "
                          : "  Fleet List  "
                      : "Dashboard",
                  textColor: appbarcolor,
                  onTap: onFleetPageSelectedTap),
              SizedBox(
                height: 10,
              ),
              InsiteButton(
                  width: MediaQuery.of(context).size.width * 0.30,
                  height: MediaQuery.of(context).size.height * 0.06,
                  fontSize: 12,
                  bgColor: tango,
                  title: assetCount > 1
                      ? type == TYPE.DASHBOARD
                          ? " Location "
                          : "Zoom to cluster"
                      : "Details",
                  textColor: appbarcolor,
                  onTap: onTapWithZoom)
            ],
          ),
        ),
        Triangle.isosceles(
          edge: Edge.BOTTOM,
          child: Container(
            color: cardcolor,
            width: 20.0,
            height: 10.0,
          ),
        ),
      ],
    );
  }
}
