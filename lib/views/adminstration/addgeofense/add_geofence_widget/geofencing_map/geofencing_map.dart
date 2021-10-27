import 'package:flutter/material.dart';

import 'package:insite/views/adminstration/addgeofense/addgeofense_view_model.dart';
import 'package:logger/logger.dart';
import 'package:google_maps_controller/google_maps_controller.dart';

class GeofencingMap extends StatefulWidget {
  final AddgeofenseViewModel model;
  final String initialvalue;
  final Color color;
  final double zoomlev;

  GeofencingMap(this.model, this.color, this.initialvalue, this.zoomlev);

  @override
  _GeofencingMapState createState() => _GeofencingMapState();
}

class _GeofencingMapState extends State<GeofencingMap> {
  GoogleMapsController controller;
  CameraPosition centerposition;

  @override
  void initState() {
    super.initState();

    centerposition = CameraPosition(
      target: LatLng(37.42796133580664, -122.085749655962),
      zoom: widget.zoomlev,
    );
  }

  Set<Polygon> polygon = {};
  Set<Polyline> polyline = {};
  List<LatLng> list = [];

  @override
  Widget build(BuildContext context) {
    Logger().e(widget.zoomlev);
    return GoogleMaps(
      controller: GoogleMapsController(
        zoomControlsEnabled: false,
        zoomGesturesEnabled: true,
        mapType: widget.initialvalue == widget.model.maptype[0]
            ? MapType.normal
            : widget.initialvalue == widget.model.maptype[1]
                ? MapType.terrain
                : widget.initialvalue == widget.model.maptype[2]
                    ? MapType.satellite
                    : MapType.hybrid,
        initialCircles: widget.model.circle,
        initialCameraPosition: centerposition,
        initialPolygons:
            widget.model.polygon.isEmpty ? null : widget.model.polygon,
        initialPolylines:
            widget.model.polyline.isEmpty ? null : widget.model.polyline,
        onTap: widget.model.isdrawingpolygon
            ? (latlng) {
                widget.model.ongettinglatlong(latlng);
              }
            : null,
      ),
    );
  }
}
