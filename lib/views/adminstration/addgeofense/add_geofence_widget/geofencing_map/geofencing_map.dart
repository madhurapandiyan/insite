import 'dart:async';
import 'package:flutter/material.dart';
import 'package:google_maps_controller/google_maps_controller.dart';
import 'package:logger/logger.dart';

class GeofencingMap extends StatefulWidget {
  final List<String>? mapType;
  final Function(LatLng)? gettingData;
  final String? initialValue;
  final Color? color;
  final Set<Circle>? circle;
  final Set<Polygon?>? polygon;
  final Set<Polyline?>? polyline;
  final bool? isDrawing;
  final CameraPosition? camPosition;
  final Completer<GoogleMapController>? completer;
  final Function(CameraPosition)? onPan;

  GeofencingMap(
      {this.mapType,
      this.gettingData,
      this.color,
      this.initialValue,
      this.circle,
      this.polygon,
      this.polyline,
      this.isDrawing,
      this.camPosition,
      this.completer,
      this.onPan});

  @override
  _GeofencingMapState createState() => _GeofencingMapState();
}

class _GeofencingMapState extends State<GeofencingMap> {
  GoogleMapsController? controller;

  @override
  Widget build(BuildContext context) {
    return GoogleMaps(
      controller: GoogleMapsController(
          onMapCreated: (controller) {
            widget.completer!.complete(controller);
          },
          zoomControlsEnabled: false,
          zoomGesturesEnabled: true,
          mapType: mapType(widget.initialValue),
          initialCircles: widget.circle,
          initialCameraPosition: widget.camPosition,
          initialPolygons:
              widget.circle!.isEmpty ? null : widget.polygon as Set<Polygon>?,
          initialPolylines: widget.polyline!.isEmpty
              ? null
              : widget.polyline as Set<Polyline>?,
          onTap: widget.isDrawing!
              ? (latlng) {
                  widget.gettingData!(latlng);
                }
              : (_) {}),
    );
  }

  MapType mapType(String? initialValue) {
    Logger().w(initialValue);
    switch (initialValue) {
      case "MAP":
        Logger().i("map is in normal type ");
        return MapType.normal;

      case "TERRAIN":
        Logger().i("map is in terrain type");
        return MapType.terrain;

      case "SATELLITE":
        Logger().i("map is in satellite type ");
        return MapType.hybrid;

      case "HYBRID":
        Logger().i("map is in hybrid type ");
        return MapType.satellite;
      default:
        return MapType.normal;
    }
  }
}
