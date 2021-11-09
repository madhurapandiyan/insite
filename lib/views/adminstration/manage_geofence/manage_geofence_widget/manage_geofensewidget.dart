import 'dart:ui';
import 'package:flutter/material.dart';

import 'package:insite/theme/colors.dart';
import 'package:insite/widgets/dumb_widgets/insite_button.dart';
import 'package:insite/widgets/dumb_widgets/insite_text.dart';
import 'package:intl/intl.dart';

class ManageGeofenceWidget extends StatefulWidget {
  //const ({ Key? key }) : super(key: key);
  final Function(dynamic, dynamic) ondeleting;
  final String geofenceName;
  final String geofenceDate;
  final String geofenceUID;
  bool isLoading;
  final Function onNavigation;
  ManageGeofenceWidget(
      {this.geofenceName,
      this.geofenceDate,
      this.ondeleting,
      this.geofenceUID,
      this.isLoading,this.onNavigation});
  @override
  State<ManageGeofenceWidget> createState() => _ManageGeofenceWidgetState();
}

class _ManageGeofenceWidgetState extends State<ManageGeofenceWidget> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var mediaQuery = MediaQuery.of(context);
    return Column(
      children: [
        InkWell(
          onTap: widget.onNavigation,
          child: Card(
            child: Container(
              width: double.maxFinite,
              height: mediaQuery.size.height * 0.288,
              child: Column(
                children: [
                  Container(
                    margin: EdgeInsets.all(8),
                    width: mediaQuery.size.width * 0.86,
                    height: mediaQuery.size.height * 0.20,
                    decoration: BoxDecoration(
                      boxShadow: [new BoxShadow(blurRadius: 1.0, color: bgcolor)],
                      border: Border.all(width: 2.5, color: bgcolor),
                      borderRadius: BorderRadius.circular(10),
                      shape: BoxShape.rectangle,
                    ),
                    child: Stack(
                      children: [
                        SizedBox(
                          height: 16,
                        ),
                        ClipRRect(
                            borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(10),
                              topRight: Radius.circular(10),
                              bottomRight: Radius.circular(10),
                              bottomLeft: Radius.circular(10),
                            ),
                            child: Image.asset("assets/images/dummy.png")),
                        Positioned(
                          top: 6,
                          right: 6,
                          child: Align(
                            alignment: Alignment.topRight,
                            child: InsiteButton(
                                bgColor: tuna,
                                title: "",
                                onTap: () {
                                  widget.ondeleting(widget.geofenceUID,
                                      DateTime.now().toUtc().toString());
                                },
                                icon: Icon(
                                  Icons.delete,
                                  color: appbarcolor,
                                )),
                          ),
                        )
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 8,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(left: 14.0),
                        child: InsiteText(
                          text: widget.geofenceName,
                          size: 14,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                      Padding(
                          padding: const EdgeInsets.only(right: 14.0),
                          child: InsiteText(
                            text: "End Date : ${widget.geofenceDate==null?"No End Date":widget.geofenceDate }",
                            size: 14,
                            fontWeight: FontWeight.w700,
                          ))
                    ],
                  )
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}
