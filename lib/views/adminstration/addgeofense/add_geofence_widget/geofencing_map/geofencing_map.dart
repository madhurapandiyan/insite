import 'package:flutter/material.dart';

import 'package:insite/views/adminstration/addgeofense/addgeofense_view_model.dart';
import 'package:logger/logger.dart';
import 'package:google_maps_controller/google_maps_controller.dart';

class GeofencingMap extends StatefulWidget {
  final List<String> mapType;
  final Function(LatLng) gettingData;
  final String initialValue;
  final Color color;
  final Set<Circle> circle;
  final Set<Polygon> polygon;
  final Set<Polyline> polyline;
  final bool isDrawing;

  GeofencingMap(
      {this.mapType,
      this.gettingData,
      this.color,
      this.initialValue,
      this.circle,
      this.polygon,
      this.polyline,
      this.isDrawing});

  @override
  _GeofencingMapState createState() => _GeofencingMapState();
}

class _GeofencingMapState extends State<GeofencingMap> {
  GoogleMapsController controller;
  CameraPosition centerPosition;

  @override
  void initState() {
    super.initState();
    centerPosition = CameraPosition(target: LatLng(30.666, 76.8127));
  }

  @override
  Widget build(BuildContext context) {
    return GoogleMaps(
      controller: GoogleMapsController(
        // onMapCreated: (controller) {
        //   widget.model.customInfoWindowController.googleMapController =
        //       controller;
        //   widget.model.contro.complete(controller);
        // },
        zoomControlsEnabled: false,
        zoomGesturesEnabled: true,
        mapType: widget.initialValue == widget.mapType[0]
            ? MapType.normal
            : widget.initialValue == widget.mapType[1]
                ? MapType.terrain
                : widget.initialValue == widget.mapType[2]
                    ? MapType.satellite
                    : MapType.hybrid,
        initialCircles: widget.circle,
        initialCameraPosition: centerPosition,
        initialPolygons: widget.circle.isEmpty ? null : widget.polygon,
        initialPolylines: widget.polyline.isEmpty ? null : widget.polyline,
        onTap: widget.isDrawing
            ? (latlng) {
                widget.gettingData(latlng);
              }
            : null,
      ),
    );
  }
}
