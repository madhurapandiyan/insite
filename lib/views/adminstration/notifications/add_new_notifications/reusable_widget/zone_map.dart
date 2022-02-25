import 'dart:async';

import 'package:flutter/material.dart';
import 'package:google_maps_controller/google_maps_controller.dart';
import 'package:insite/views/add_new_user/reusable_widget/custom_dropdown_widget.dart';
import 'package:insite/widgets/dumb_widgets/insite_button.dart';
import 'package:logger/logger.dart';

class ZoneMap extends StatefulWidget {
  final List<String>? mapType;
  final Function(LatLng)? gettingData;
  final Set<Circle>? circle;
  final bool isDrawing;
  final CameraPosition? camPosition;
  final Completer<GoogleMapController>? completer;
  final Function? onEditing;
  final Function? onDeleting;
  ZoneMap(
      {this.camPosition,
      this.circle,
      this.completer,
      this.gettingData,
      required this.isDrawing,
      this.onEditing,
      this.onDeleting,
      this.mapType});
  @override
  State<ZoneMap> createState() => _ZoneMapState();
}

class _ZoneMapState extends State<ZoneMap> {
  String mapType = "MAP";
  GoogleMapController? googleMapcontroller;
  List<String> items = ['MAP', 'TERRAIN', 'SATELLITE', 'HYBRID'];
  @override
  Widget build(BuildContext context) {
    var mediaquerry = MediaQuery.of(context);
    Logger().d(widget.isDrawing);
    return Stack(
      children: [
        Container(
          height: mediaquerry.size.height * 0.7,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            color: Theme.of(context).backgroundColor,
          ),
          child: ClipRect(
            child: GoogleMaps(
                controller: GoogleMapsController(
                    onMapCreated: (controller) {
                      try {
                        googleMapcontroller = controller;
                      } catch (e) {
                        Logger().e(e.toString());
                      }
                    },
                    zoomControlsEnabled: true,
                    mapType: mapType == items[0]
                        ? MapType.normal
                        : mapType == items[1]
                            ? MapType.terrain
                            : mapType == items[2]
                                ? MapType.satellite
                                : MapType.hybrid,
                    initialCircles: widget.circle,
                    initialCameraPosition: widget.camPosition,
                    onTap: (latlng) {
                      if (widget.isDrawing) {
                        widget.gettingData!(latlng);
                      } else {
                        return;
                      }
                    })),
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                width: 100,
                color: Theme.of(context).cardColor,
                child: CustomDropDownWidget(
                  items: items,
                  onChanged: (value) {
                    setState(() {
                      mapType = value!;
                    });
                  },
                  value: mapType,
                ),
              ),
              Container(
                height: 100,
                child: Row(
                  children: [
                    InsiteButton(
                      onTap: () {
                        widget.onEditing!();
                      },
                      height: 40,
                      bgColor: widget.isDrawing
                          ? Theme.of(context).buttonColor
                          : Theme.of(context).backgroundColor,
                      title: "",
                      icon: Icon(
                        Icons.edit,
                      ),
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    InsiteButton(
                      onTap: () {
                        widget.onDeleting!();
                      },
                      height: 40,
                      bgColor: Theme.of(context).backgroundColor,
                      title: "",
                      icon: Icon(Icons.delete),
                    ),
                  ],
                ),
              )
            ],
          ),
        )
      ],
    );
  }
}
