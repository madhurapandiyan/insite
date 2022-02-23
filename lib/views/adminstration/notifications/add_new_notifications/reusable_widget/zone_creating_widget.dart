import 'dart:async';

import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:insite/views/add_new_user/reusable_widget/custom_text_box.dart';
import 'package:insite/views/adminstration/notifications/add_new_notifications/reusable_widget/zone_map.dart';
import 'package:insite/widgets/dumb_widgets/insite_button.dart';
import 'package:insite/widgets/dumb_widgets/insite_text.dart';

class ZoneCreatingWidget extends StatefulWidget {
  final Function? onEditing;
  final Function? onDeleting;
  final CameraPosition? centerPosition;
  final Completer<GoogleMapController>? googleMapController;
  final bool isDrawing;
  final Function(LatLng)? onInclusionZoneCreating;
  final Set<Circle>? circle;
  final double? radius;
  final Function(double)? onSliderChange;
  final Function? onCancel;
  final Function? onCreate;
  final TextEditingController? controller;
  ZoneCreatingWidget(
      {this.centerPosition,
      this.circle,
      this.googleMapController,
      required this.isDrawing,
      this.onDeleting,
      this.onEditing,
      this.onInclusionZoneCreating,
      this.onSliderChange,
      this.radius,
      this.onCancel,
      this.onCreate,
      this.controller});

  @override
  State<ZoneCreatingWidget> createState() => _ZoneCreatingWidgetState();
}

class _ZoneCreatingWidgetState extends State<ZoneCreatingWidget> {
  @override
  Widget build(BuildContext context) {
    var mediaquerry = MediaQuery.of(context);
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Container(
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                InsiteText(
                  text: "Zone Name",
                ),
                SizedBox(
                  height: 10,
                ),
                CustomTextBox(
                  controller: widget.controller,
                ),
                SizedBox(
                  height: 10,
                ),
                ZoneMap(
                  onEditing: () {
                    widget.onEditing!();
                  },
                  onDeleting: () {
                    widget.onDeleting!();
                  },
                  camPosition: widget.centerPosition,
                  completer: widget.googleMapController,
                  isDrawing: widget.isDrawing,
                  circle: widget.circle,
                  gettingData: (latlng) {
                    widget.onInclusionZoneCreating!(latlng);
                  },
                ),
                SizedBox(
                  height: 10,
                ),
                InsiteText(
                  text: "Radius",
                ),
                SizedBox(
                  height: 10,
                ),
                Container(
                  child: Slider(
                      activeColor: Theme.of(context).buttonColor,
                      min: 50000,
                      max: 1000000,
                      value: widget.radius!,
                      onChanged: (value) {
                        widget.onSliderChange!(value);
                      }),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    InsiteButton(
                      onTap: () {
                        widget.onCancel!();
                      },
                      width: 100,
                      title: "Cancel",
                      bgColor: Theme.of(context).splashColor,
                    ),
                    SizedBox(
                      width: 20,
                    ),
                    InsiteButton(
                      onTap: () {
                        widget.onCreate!();
                      },
                      width: 100,
                      title: "Create",
                    )
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
