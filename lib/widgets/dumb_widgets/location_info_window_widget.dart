import 'package:clippy_flutter/triangle.dart';
import 'package:custom_info_window/custom_info_window.dart';
import 'package:flutter/material.dart';
import 'package:insite/theme/colors.dart';
import 'package:insite/widgets/dumb_widgets/insite_button.dart';

class LocationInfoWindowWidget extends StatelessWidget {
  final String text;
  final VoidCallback onCustomWindowClose;
  final VoidCallback onFleetPageSelectedTap;
  final VoidCallback onTapWithZoom;

  LocationInfoWindowWidget({
    this.text,
    this.onCustomWindowClose,
     this.onFleetPageSelectedTap,
     this.onTapWithZoom
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          //  width: 250,
          height: MediaQuery.of(context).size.height * 0.30,
          decoration: BoxDecoration(
            color: cardcolor,
            borderRadius: BorderRadius.circular(10),
          ),
          child: Column(
            children: [
              Row(
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
                  SizedBox(
                    width: 50.0,
                  ),
                  GestureDetector(
                      onTap:onCustomWindowClose,
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Image.asset("assets/images/mapclose.png"),
                      ))
                ],
              ),
              Divider(),
              Container(
                width: 216,
                height: 32,
                color: thunder,
                child: Padding(
                  padding: EdgeInsets.only(left: 38, top: 5.0, bottom: 5.0),
                  child: Text(
                    text + " " + "Assets",
                    style: TextStyle(
                        fontFamily: 'Roboto',
                        fontSize: 13.0,
                        fontWeight: FontWeight.w700,
                        color: silver),
                  ),
                ),
              ),
              SizedBox(
                height: 16,
              ),
              Column(
                children: [
                  InsiteButton(
                    width: 120,
                    height: 40,
                    bgColor: tango,
                    title: "Fleet List",
                    textColor: appbarcolor,
                    onTap:onFleetPageSelectedTap
                  ),
                  SizedBox(
                    height: 15,
                  ),
                  InsiteButton(
                    width: 120,
                    height: 40,
                    bgColor: tango,
                    title: "Zoom to cluster",
                    textColor: appbarcolor,
                    onTap:onTapWithZoom
                  )
                ],
              )
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
