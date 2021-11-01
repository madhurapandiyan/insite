import 'package:flutter/material.dart';

import 'package:insite/views/adminstration/addgeofense/addgeofense_view_model.dart';
import 'package:logger/logger.dart';
import 'package:google_maps_controller/google_maps_controller.dart';

class GeofencingMap extends StatefulWidget {
  final List<String> maptype;
  final Function(LatLng) gettingdata;
  final String initialvalue;
  final Color color;
  final Set<Circle> circle;
  final Set<Polygon> polygon;
  final Set<Polyline> polyline;
  final bool isdrawing;

  GeofencingMap(
      {this.maptype,
      this.gettingdata,
      this.color,
      this.initialvalue,
      this.circle,
      this.polygon,
      this.polyline,
      this.isdrawing});

  @override
  _GeofencingMapState createState() => _GeofencingMapState();
}

class _GeofencingMapState extends State<GeofencingMap> {
  GoogleMapsController controller;
  CameraPosition centerposition;

  @override
  void initState() {
    super.initState();
    centerposition = CameraPosition(target: LatLng(30.666, 76.8127));
  }

  @override
  Widget build(BuildContext context) {
    //Logger().e(widget.zoomlev);
    return GoogleMaps(
      controller: GoogleMapsController(
        // onMapCreated: (controller) {
        //   widget.model.customInfoWindowController.googleMapController =
        //       controller;
        //   widget.model.contro.complete(controller);
        // },
        zoomControlsEnabled: false,
        zoomGesturesEnabled: true,
        mapType: widget.initialvalue == widget.maptype[0]
            ? MapType.normal
            : widget.initialvalue == widget.maptype[1]
                ? MapType.terrain
                : widget.initialvalue == widget.maptype[2]
                    ? MapType.satellite
                    : MapType.hybrid,
        initialCircles: widget.circle,
        initialCameraPosition: centerposition,
        initialPolygons: widget.circle.isEmpty ? null : widget.polygon,
        initialPolylines: widget.polyline.isEmpty ? null : widget.polyline,
        onTap: widget.isdrawing
            ? (latlng) {
                widget.gettingdata(latlng);
              }
            : null,
      ),
    );
  }
}
