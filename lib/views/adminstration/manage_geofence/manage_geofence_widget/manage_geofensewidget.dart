import 'dart:async';
import 'dart:ui';
import 'package:flutter/foundation.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import 'package:insite/theme/colors.dart';
import 'package:insite/views/adminstration/manage_geofence/manage_geofence_view_model.dart';
import 'package:insite/views/adminstration/reusable_widget/reusabletapbutton.dart';
import 'package:insite/widgets/dumb_widgets/insite_text.dart';
import 'package:logger/logger.dart';

class ManageGeofenceWidget extends StatefulWidget {
  //const ({ Key? key }) : super(key: key);
  final ManageGeofenceViewModel model;
  final String geofence_name;
  final String geofence_date;
  ManageGeofenceWidget(this.model, this.geofence_name, this.geofence_date);
  @override
  State<ManageGeofenceWidget> createState() => _ManageGeofenceWidgetState();
}

class _ManageGeofenceWidgetState extends State<ManageGeofenceWidget> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var mediaquerry = MediaQuery.of(context);
    return Column(
      children: [
        Card(
          child: Container(
            width: double.maxFinite,
            height: MediaQuery.of(context).size.height * 0.288,
            child: Column(
              children: [
                Container(
                  margin: EdgeInsets.all(8),
                  width: MediaQuery.of(context).size.width * 0.86,
                  height: MediaQuery.of(context).size.height * 0.20,
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
                          child: GestureDetector(
                              onTap: () {
                                Logger().d("button tap");
                                //widget.model.getdata();
                              },
                              child: Reusabletapbutton(
                                  "assets/images/delete_icon.svg", false)),
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
                        text: widget.geofence_name,
                        size: 14,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    Padding(
                        padding: const EdgeInsets.only(right: 14.0),
                        child: InsiteText(
                          text: "End Date : ${widget.geofence_date.toString()}",
                          size: 14,
                          fontWeight: FontWeight.w700,
                        ))
                  ],
                )
              ],
            ),
          ),
        ),
      ],
    );
  }
}
