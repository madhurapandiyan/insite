import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:insite/theme/colors.dart';
import 'package:insite/views/adminstration/manage_geofence/static_map.dart/staticmapapi.dart';
import 'package:insite/widgets/dumb_widgets/insite_button.dart';
import 'package:insite/widgets/dumb_widgets/insite_text.dart';

class ManageGeofenceWidget extends StatefulWidget {
  //const ({ Key? key }) : super(key: key);
  final Function(dynamic, dynamic)? ondeleting;
  final bool? isFav;
  final String? geofenceName;
  final String? geofenceDate;
  final String? geofenceUID;
  final String? encodedPolyline;
  final VoidCallback? callBack;
  final Function? onNavigation;
  final Function(String?)? onFavourite;
  ManageGeofenceWidget(
      {this.geofenceName,
      this.geofenceDate,
      this.callBack,
      this.isFav,
      this.ondeleting,
      this.encodedPolyline,
      this.geofenceUID,
      this.onNavigation,
      this.onFavourite});
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
    return GestureDetector(
      onTap: () {
        widget.onNavigation!();
      },
      child: Card(
        //margin: EdgeInsets.symmetric(horizontal: 4),
        child: Column(
          children: [
            Container(
              margin: EdgeInsets.only(top: 8, right: 8, left: 8),
              width: mediaQuery.size.width * 0.86,
              height: mediaQuery.size.height * 0.25,
              decoration: BoxDecoration(
                border: Border.all(width: 2.5, color: bgcolor),
                borderRadius: BorderRadius.circular(10),
              ),
              child: Stack(
                children: [
                  ClipRRect(
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(10),
                        topRight: Radius.circular(10),
                        bottomRight: Radius.circular(10),
                        bottomLeft: Radius.circular(10),
                      ),
                      child: Image.network(
                          StaticMap().generatedimg(widget.encodedPolyline),
                          width: double.infinity,
                          fit: BoxFit.cover)),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        InsiteButton(
                            bgColor: tuna,
                            height: MediaQuery.of(context).size.height * 0.05,
                            title: "",
                            onTap: () {
                              widget.onFavourite!(widget.geofenceUID);
                            },
                            icon: Icon(

                              Icons.favorite,
                              color: widget.isFav! ? Theme.of(context).buttonColor : white,
                            )),
                        InsiteButton(
                            height: MediaQuery.of(context).size.height * 0.05,
                           // bgColor: tuna,
                            title: "",
                            onTap: () {
                              widget.ondeleting!(widget.geofenceUID,
                                  DateTime.now().toUtc().toString());
                            },
                            icon: Icon(
                              Icons.delete,
                              color: appbarcolor,
                            )),
                      ],
                    ),
                  )
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: Row(
                children: [
                  Expanded(
                    flex: 2,
                    child: InsiteText(
                      text: widget.geofenceName,
                      size: 14,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  InsiteText(
                    text:
                        "End Date : ${widget.geofenceDate == null ? "No End Date" : widget.geofenceDate}",
                    size: 14,
                    fontWeight: FontWeight.w700,
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
