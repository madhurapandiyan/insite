import 'dart:async';

import 'package:custom_info_window/custom_info_window.dart';
import 'package:flutter/material.dart';

import 'package:google_maps_controller/google_maps_controller.dart';
import 'package:logger/logger.dart';

class GeofencingMap extends StatefulWidget {
  final List<String> mapType;
  final Function(LatLng) gettingData;
  final String initialValue;
  final Color color;
  final Set<Circle> circle;
  final Set<Polygon> polygon;
  final Set<Polyline> polyline;
  final bool isDrawing;
  final CameraPosition camPosition;
  final Completer<GoogleMapController> completer;

  GeofencingMap({
    this.mapType,
    this.gettingData,
    this.color,
    this.initialValue,
    this.circle,
    this.polygon,
    this.polyline,
    this.isDrawing,
    this.camPosition,
    this.completer,
  });

  @override
  _GeofencingMapState createState() => _GeofencingMapState();
}

class _GeofencingMapState extends State<GeofencingMap> {
  GoogleMapsController controller;

  @override
  Widget build(BuildContext context) {
    return GoogleMaps(
      controller: GoogleMapsController(
        onMapCreated: (controller) {
          widget.completer.complete(controller);
        },
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
        initialCameraPosition: widget.camPosition,
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
