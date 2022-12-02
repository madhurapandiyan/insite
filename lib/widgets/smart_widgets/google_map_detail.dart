import 'dart:async';
import 'package:custom_info_window/custom_info_window.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:insite/core/models/asset_detail.dart';
import 'package:insite/core/models/user_preference.dart';
import 'package:insite/theme/colors.dart';
import 'package:insite/utils/enums.dart';
import 'package:insite/utils/helper_methods.dart';
import 'package:insite/views/preference/model/time_zone.dart';
import 'package:insite/widgets/dumb_widgets/insite_progressbar.dart';
import 'package:insite/widgets/dumb_widgets/insite_row_item_text.dart';
import 'package:insite/widgets/dumb_widgets/insite_text.dart';
import 'package:logger/logger.dart';

class GoogleMapDetailWidget extends StatefulWidget {
  final UserPreference? userPreference;
  final UserPreferedData?userPreferedData;
  final double? latitude;
  final double? longitude;
  final LatLng? initLocation;
  final String? status;
  final isLoading;
  final ScreenType? screenType;
  final VoidCallback? onMarkerTap;
  final String? location;
  final AssetDetail? details;
  GoogleMapDetailWidget(
      {required this.latitude,
      required this.longitude,
      this.status,
      this.onMarkerTap,
      this.screenType,
      this.location,
      this.isLoading,
      this.initLocation,
      this.details, this.userPreference, this.userPreferedData});

  @override
  _GoogleMapDetailWidgetState createState() => _GoogleMapDetailWidgetState();
}

class _GoogleMapDetailWidgetState extends State<GoogleMapDetailWidget> {
  String? _currentSelectedItem = 'SATELLITE';
  double zoomVal = 5.0;
  Completer<GoogleMapController> _controller = Completer();
  LatLng? _lastMapPosition;
  Set<Marker> _markers = {};
  MapType currentType = MapType.normal;
  CustomInfoWindowController _customInfoWindowController =
      CustomInfoWindowController();

  @override
  void initState() {
    super.initState();
    _lastMapPosition = (widget.latitude == null && widget.longitude == null)
        ? widget.initLocation
        : LatLng(widget.latitude!, widget.longitude!);
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Container(
        height: MediaQuery.of(context).size.height * 0.50,
        child: Stack(
          children: [
            Column(
              children: [
                Padding(
                  padding:
                      EdgeInsets.only(top: 10, left: 10, right: 10, bottom: 10),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          // SvgPicture.asset("assets/images/arrowdown.svg"),
                          SizedBox(
                            width: 10,
                          ),
                          InsiteText(
                              text: "LOCATION",
                              fontWeight: FontWeight.w900,
                              size: 15.0),
                        ],
                      ),
                      Row(
                        children: [
                          Container(
                            width: 118.23,
                            height: 35.18,
                            decoration: BoxDecoration(
                              color: Theme.of(context).backgroundColor,
                              borderRadius:
                                  BorderRadius.all(Radius.circular(5.0)),
                              boxShadow: [
                                BoxShadow(
                                  blurRadius: 1.0,
                                  color: cardcolor,
                                ),
                              ],
                              border:
                                  Border.all(width: 1.0, color: Colors.white),
                              shape: BoxShape.rectangle,
                            ),
                            child: Row(
                              children: [
                                SizedBox(
                                  width: 8.0,
                                ),
                                Expanded(
                                  flex: 1,
                                  child: DropdownButton(
                                    dropdownColor:
                                        Theme.of(context).backgroundColor,
                                    icon: Padding(
                                      padding: EdgeInsets.only(right: 8.0),
                                      child: Container(
                                        child: SvgPicture.asset(
                                          "assets/images/arrowdown.svg",
                                          width: 10,
                                          height: 10,
                                          color:
                                              Theme.of(context).iconTheme.color,
                                        ),
                                      ),
                                    ),
                                    isExpanded: true,
                                    hint: InsiteText(
                                        text: _currentSelectedItem,
                                        color: Theme.of(context)
                                            .textTheme
                                            .bodyText1!
                                            .color),
                                    items: [
                                      'SATELLITE',
                                      'MAP',
                                      'TERRAIN',
                                      'HYBRID'
                                    ]
                                        .map((map) => DropdownMenuItem(
                                              value: map,
                                              child: InsiteText(
                                                  text: map,
                                                  size: 11.0,
                                                  fontWeight: FontWeight.bold,
                                                  color: Theme.of(context)
                                                      .textTheme
                                                      .bodyText1!
                                                      .color),
                                            ))
                                        .toList(),
                                    value: _currentSelectedItem,
                                    onChanged: (dynamic value) {
                                      setState(() {
                                        _currentSelectedItem = value;
                                      });
                                    },
                                    underline: Container(
                                        height: 1.0,
                                        decoration: BoxDecoration(
                                            border: Border(
                                                bottom: BorderSide(
                                                    color: Colors.transparent,
                                                    width: 0.0)))),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          SizedBox(
                            width: 40.0,
                          ),
                          // GestureDetector(
                          //   onTap: () => print("button is tapped"),
                          //   child: SvgPicture.asset(
                          //     "assets/images/menu.svg",
                          //     width: 20,
                          //     height: 20,
                          //   ),
                          // )
                        ],
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: 5.0,
                ),
                // Container(
                //   height: MediaQuery.of(context).size.height * 0.10,
                //   color: greencolor,
                //   child: Padding(
                //     padding: EdgeInsets.only(left: 5.0, top: 8.0),
                //     child: Text(
                //       "To deliver high map performance, the map will only display up to 2,500 assets at one time. Please use a filter to specify a working set of less than 2,500 assets if you have more than 2,500 assets in your account .",
                //       style: TextStyle(
                //           fontSize: 11.0,
                //           fontWeight: FontWeight.w500,
                //           fontFamily: 'Roboto',
                //           fontStyle: FontStyle.normal,
                //           color: maptextcolor),
                //     ),
                //   ),
                // ),
                widget.isLoading
                    ? Expanded(child: InsiteProgressBar())
                    : Flexible(
                        child: Container(
                            height: MediaQuery.of(context).size.height * 0.45,
                            child: _googleMap(currentType)),
                      ),
                Divider(),
                Padding(
                  padding: EdgeInsets.only(left: 10.0, top: 5.0),
                  child: Container(
                    width: 290.5,
                    height: 22.57,
                    child: InsiteText(
                      text: widget.status,
                      size: 10.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                )
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _googleMap(type) {
    return Container(
      height: MediaQuery.of(context).size.height * 0.28,
      decoration: BoxDecoration(
        color: Theme.of(context).backgroundColor,
        borderRadius: BorderRadius.all(Radius.circular(10)),
      ),
      child: Stack(
        children: [
          GoogleMap(
            mapType: _changemap(),
            compassEnabled: true,
            zoomControlsEnabled: false,
            mapToolbarEnabled: false,
            markers: _markers,
            gestureRecognizers: <Factory<OneSequenceGestureRecognizer>>[
              new Factory<OneSequenceGestureRecognizer>(
                () => new EagerGestureRecognizer(),
              ),
            ].toSet(),
            initialCameraPosition: CameraPosition(
                target: (widget.latitude == null && widget.longitude == null)
                    ? LatLng(30.666, 76.8127)
                    : LatLng(widget.latitude!, widget.longitude!),
                zoom: (widget.latitude == null && widget.longitude == null)
                    ? 3
                    : 12),
            onMapCreated: (GoogleMapController controller) {
              _controller.complete(controller);
              _onmapcreated(controller);

              _customInfoWindowController.googleMapController = controller;
            },
            onCameraMove: _oncameramove,
          ),
          CustomInfoWindow(
            controller: _customInfoWindowController,
            height: 200,
            width: 200,
          ),
          Padding(
            padding: EdgeInsets.all(8.0),
            child: Column(
              children: [
                SizedBox(
                  height: 28.0,
                ),
                GestureDetector(
                  onTap: () {
                    print("button is tapped");
                    zoomVal++;
                    _plus(zoomVal);
                  },
                  child: Container(
                    width: 27.47,
                    height: 26.97,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(5.0)),
                      boxShadow: [
                        BoxShadow(
                            blurRadius: 1.0,
                            color:
                                Theme.of(context).textTheme.bodyText1!.color!),
                      ],
                      color: Theme.of(context).backgroundColor,
                      border: Border.all(
                          width: 1.0,
                          color: Theme.of(context).textTheme.bodyText1!.color!),
                      shape: BoxShape.rectangle,
                    ),
                    child: SvgPicture.asset(
                      "assets/images/plus.svg",
                      color: Theme.of(context).iconTheme.color,
                    ),
                  ),
                ),
                SizedBox(
                  height: 5.0,
                ),
                GestureDetector(
                    onTap: () {
                      print("button is tapped");
                      zoomVal--;
                      _minus(zoomVal);
                    },
                    child: Container(
                      width: 27.47,
                      height: 26.97,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.all(Radius.circular(5.0)),
                        color: Theme.of(context).backgroundColor,
                        boxShadow: [
                          BoxShadow(
                            blurRadius: 1.0,
                            color:
                                Theme.of(context).textTheme.bodyText1!.color!,
                          ),
                        ],
                        border: Border.all(
                            width: 1.0,
                            color:
                                Theme.of(context).textTheme.bodyText1!.color!),
                        shape: BoxShape.rectangle,
                      ),
                      child: SvgPicture.asset(
                        "assets/images/minus.svg",
                        color: Theme.of(context).iconTheme.color,
                      ),
                    )),
              ],
            ),
          )
        ],
      ),
    );
  }

  _oncameramove(CameraPosition position) {
    _customInfoWindowController.onCameraMove!();
    _lastMapPosition = position.target;
  }

  Future<void> _minus(double zoomVal) async {
    final GoogleMapController controller = await _controller.future;
    controller.animateCamera(CameraUpdate.newCameraPosition(CameraPosition(
        target: (widget.latitude == null && widget.longitude == null)
            ? widget.initLocation!
            : LatLng(widget.latitude!, widget.longitude!),
        zoom: zoomVal)));
  }

  Future<void> _plus(double zoomVal) async {
    final GoogleMapController controller = await _controller.future;
    controller.animateCamera(CameraUpdate.newCameraPosition(CameraPosition(
        target: (widget.latitude == null && widget.longitude == null)
            ? widget.initLocation!
            : LatLng(widget.latitude!, widget.longitude!),
        zoom: zoomVal)));
  }

  void _onmapcreated(GoogleMapController controller) {
    setState(() {
      _markers.clear();
      if (widget.latitude != null && widget.longitude != null)
        _markers.add(Marker(
            onTap: () {
              addInfoWindow();
            },
            markerId: MarkerId('id-1'),
            onDragStart: (latlng) {
              Logger().wtf(latlng);
              _oncameramove(CameraPosition(target: latlng));
            },
            // infoWindow: InfoWindow(
            //   title: widget.location != null ? widget.location : "",
            //   onTap: () {
            //     widget.onMarkerTap!();
            //   },
            // ),
            position: LatLng(widget.latitude!, widget.longitude!)));
    });
  }

  addInfoWindow() {
    _customInfoWindowController.addInfoWindow!(
        Card(
          child: Container(
            height: 200,
            width: 300,
            padding: EdgeInsets.all(5),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    FittedBox(
                      child: InsiteText(
                        text: widget.details?.assetSerialNumber ?? "-",
                        fontWeight: FontWeight.bold,
                        size: 14,
                      ),
                    ),
                    IconButton(
                        onPressed: () {
                          widget.onMarkerTap!();
                          _customInfoWindowController.hideInfoWindow!();
                        },
                        icon: Icon(
                          Icons.exit_to_app_rounded,
                          color: Theme.of(context).buttonColor,
                        )),
                    IconButton(
                        onPressed: () {
                          _customInfoWindowController.hideInfoWindow!();
                        },
                        icon: Icon(
                          Icons.close,
                          color: Theme.of(context).buttonColor,
                        )),
                  ],
                ),
                Divider(
                  color: Theme.of(context).dividerColor,
                  thickness: 1,
                ),
                Expanded(
                  child: ListView(
                    children: [
                      InsiteTableRowItem(
                        title: "Model",
                        content: widget.details?.model ?? "-",
                      ),
                      InsiteTableRowItem(
                        title: "Asset Status",
                        content: widget.details?.status ?? "-",
                      ),
                      InsiteTableRowItem(
                          title: "Hours",
                          content: widget.details?.hourMeter ?? "-"),
                      InsiteTableRowItem(
                        title: "Last Reported Time",
                        content: Utils.getDateUTC(widget.details?.lastReportedTimeUtc ?? "-", widget.userPreference, widget.userPreferedData),
                      ),
                      InsiteTableRowItem(
                        title: "Fuel % Remaining",
                        content: widget.details?.fuelLevelLastReported,
                      ),
                      InsiteTableRowItem(
                        title: "Location",
                        content:Utils.getLocationDisplay(widget.userPreference?.locationDisplay)?
                         widget.details?.lastReportedLocation:"${ widget.details?.lastReportedLocationLatitude}/${ widget.details?.lastReportedLocationLongitude}",
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
        _markers.first.position);
  }

  MapType _changemap() {
    switch (_currentSelectedItem) {
      case "MAP":
        Logger().i("map is in normal type ");
        return MapType.normal;

      case "TERRAIN":
        Logger().i("map is in terrain type");
        return MapType.terrain;

      case "SATELLITE":
        Logger().i("map is in satellite type ");
        return MapType.satellite;

      case "HYBRID":
        Logger().i("map is in hybrid type ");
        return MapType.hybrid;
      default:
        return MapType.normal;
    }
  }
}
