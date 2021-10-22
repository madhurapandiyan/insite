import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:insite/core/base/insite_view_model.dart';
import 'package:insite/theme/colors.dart';
import 'package:insite/views/adminstration/manage_geofence/manage_geofence_view_model.dart';
import 'package:insite/widgets/dumb_widgets/insite_button.dart';
import 'package:insite/widgets/dumb_widgets/insite_text.dart';
import 'package:logger/logger.dart';
import 'package:syncfusion_flutter_maps/maps.dart';

class ManageGeofenceWidget extends StatefulWidget {
  //const ({ Key? key }) : super(key: key);
  final ManageGeofenceViewModel model;
  ManageGeofenceWidget(this.model);
  @override
  State<ManageGeofenceWidget> createState() => _ManageGeofenceWidgetState();
}

class _ManageGeofenceWidgetState extends State<ManageGeofenceWidget> {
  bool isloading = true;
  Completer<GoogleMapController> _controller = Completer();

  static const LatLng _center = const LatLng(45.521563, -122.677433);

  void _onMapCreated(GoogleMapController controller) {
    _controller.complete(controller);
  }

  MapShapeSource _dataSource;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _dataSource = MapShapeSource.asset("assets/custom.geo.json");
  }

  @override
  Widget build(BuildContext context) {
    var mediaquerry = MediaQuery.of(context);
    return Column(
      children: [
        Container(
          padding: EdgeInsets.all(20),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              InsiteText(
                text: "Manage Geofence",
                fontWeight: FontWeight.w700,
                size: 20,
              ),
              InsiteButton(
                title: "ADD GEOFENCE",
                height: mediaquerry.size.height * 0.05,
                width: mediaquerry.size.width * 0.4,
              )
            ],
          ),
        ),
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
                        child: SfMaps(layers: [
                          MapShapeLayer(
                            source: _dataSource,
                            sublayers: [
                              MapPolygonLayer(
                                  polygons: List.generate(
                                      widget.model.dat.length,
                                      (index) => MapPolygon(points: widget.model.dat)).toSet())
                            ],
                          ),
                        ]),
                      ),
                      Positioned(
                        top: 6,
                        right: 6,
                        child: Align(
                          alignment: Alignment.topRight,
                          child: GestureDetector(
                            onTap: () {
                              print("button is tapped");
                            },
                            child: Container(
                              width: 40,
                              height: 40,
                              decoration: BoxDecoration(
                                boxShadow: [
                                  new BoxShadow(blurRadius: 1.0, color: tuna)
                                ],
                                border: Border.all(width: 2.5, color: tuna),
                                borderRadius: BorderRadius.circular(10),
                                shape: BoxShape.rectangle,
                              ),
                              child: SvgPicture.asset(
                                "assets/images/delete_icon.svg",
                                fit: BoxFit.none,
                              ),
                            ),
                          ),
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
                        text: "Geofence 123",
                        size: 14,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    Padding(
                        padding: const EdgeInsets.only(right: 14.0),
                        child: InsiteText(
                          text: "End Date : No End Date",
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
