import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:insite/theme/colors.dart';
import 'package:insite/widgets/dumb_widgets/insite_text.dart';

class ManageGeofenceWidget extends StatefulWidget {
  //const ({ Key? key }) : super(key: key);

  @override
  State<ManageGeofenceWidget> createState() => _ManageGeofenceWidgetState();
}

class _ManageGeofenceWidgetState extends State<ManageGeofenceWidget> {
  Completer<GoogleMapController> _controller = Completer();

  static const LatLng _center = const LatLng(45.521563, -122.677433);

  void _onMapCreated(GoogleMapController controller) {
    _controller.complete(controller);
  }

  @override
  Widget build(BuildContext context) {
    return Card(
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
                    child: GoogleMap(
                        onMapCreated: _onMapCreated,
                        zoomControlsEnabled: false,
                        initialCameraPosition: CameraPosition(
                          target: _center,
                          zoom: 11.0,
                        )),
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
    );
  }
}
