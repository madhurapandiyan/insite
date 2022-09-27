import 'dart:async';
import 'package:custom_info_window/custom_info_window.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_cluster_manager/google_maps_cluster_manager.dart';
import 'package:google_maps_controller/google_maps_controller.dart';

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
  final Set<Marker>? markers;

  final CustomInfoWindowController? customInfoWindowController;
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
    this.onPan,
    this.markers,
    this.customInfoWindowController,
  });

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
            widget.customInfoWindowController!.googleMapController = controller;
          },
          onCameraMove: (position) {
            widget.customInfoWindowController!.onCameraMove!();
          },
          zoomControlsEnabled: false,
          zoomGesturesEnabled: true,
          mapType: widget.initialValue == widget.mapType![0]
              ? MapType.normal
              : widget.initialValue == widget.mapType![1]
                  ? MapType.terrain
                  : widget.initialValue == widget.mapType![2]
                      ? MapType.satellite
                      : MapType.hybrid,
          initialCircles: widget.circle,
          initialCameraPosition: widget.camPosition,
          initialPolygons:
              widget.circle!.isEmpty ? null : widget.polygon as Set<Polygon>?,
          initialPolylines: widget.polyline!.isEmpty
              ? null
              : widget.polyline as Set<Polyline>?,
          initialMarkers: widget.markers,
          onTap: widget.isDrawing!
              ? (latlng) {
                  widget.gettingData!(latlng);
                }
              : (_) {}),
    );
  }
}
