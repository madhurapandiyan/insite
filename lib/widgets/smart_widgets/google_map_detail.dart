import 'dart:async';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:insite/theme/colors.dart';
import 'package:insite/utils/enums.dart';
import 'package:insite/widgets/dumb_widgets/insite_progressbar.dart';
import 'package:logger/logger.dart';

class GoogleMapDetailWidget extends StatefulWidget {
  final double latitude;
  final double longitude;
  final LatLng initLocation;
  final String status;
  final isLoading;
  final ScreenType screenType;
  final VoidCallback onMarkerTap;
  final String location;
  GoogleMapDetailWidget(
      {@required this.latitude,
      @required this.longitude,
      this.status,
      this.onMarkerTap,
      this.screenType,
      this.location,
      this.isLoading,
      this.initLocation});

  @override
  _GoogleMapDetailWidgetState createState() => _GoogleMapDetailWidgetState();
}

class _GoogleMapDetailWidgetState extends State<GoogleMapDetailWidget> {
  String _currentSelectedItem = "MAP";
  double zoomVal = 5.0;
  Completer<GoogleMapController> _controller = Completer();
  LatLng _lastMapPosition;
  Set<Marker> _markers = {};
  MapType currentType = MapType.normal;

  @override
  void initState() {
    super.initState();
    _lastMapPosition = (widget.latitude == null && widget.longitude == null)
        ? widget.initLocation
        : LatLng(widget.latitude, widget.longitude);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height * 0.50,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10.0),
        boxShadow: [BoxShadow(blurRadius: 1.0, color: cardcolor)],
        border: Border.all(width: 2.5, color: cardcolor),
        shape: BoxShape.rectangle,
      ),
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
                        Text(
                          "LOCATION",
                          style: TextStyle(
                              fontWeight: FontWeight.w900,
                              fontFamily: 'Roboto',
                              color: textcolor,
                              fontStyle: FontStyle.normal,
                              fontSize: 15.0),
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        Container(
                          width: 118.23,
                          height: 35.18,
                          decoration: BoxDecoration(
                            borderRadius:
                                BorderRadius.all(Radius.circular(5.0)),
                            boxShadow: [
                              BoxShadow(
                                blurRadius: 1.0,
                                color: cardcolor,
                              ),
                            ],
                            border: Border.all(width: 1.0, color: Colors.white),
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
                                  dropdownColor: cardcolor,
                                  icon: Padding(
                                    padding: EdgeInsets.only(right: 8.0),
                                    child: Container(
                                      child: SvgPicture.asset(
                                        "assets/images/arrowdown.svg",
                                        width: 10,
                                        height: 10,
                                      ),
                                    ),
                                  ),
                                  isExpanded: true,
                                  hint: Text(
                                    _currentSelectedItem,
                                  ),
                                  items: [
                                    'MAP',
                                    'TERRAIN',
                                    'SATELLITE',
                                    'HYBRID'
                                  ]
                                      .map((map) => DropdownMenuItem(
                                            value: map,
                                            child: Text(map,
                                                style: TextStyle(
                                                    fontSize: 11.0,
                                                    fontWeight: FontWeight.bold,
                                                    color: textcolor,
                                                    fontFamily: 'Roboto',
                                                    fontStyle:
                                                        FontStyle.normal)),
                                          ))
                                      .toList(),
                                  value: _currentSelectedItem,
                                  onChanged: (value) {
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
                  child: Text(
                    widget.status,
                    style: TextStyle(
                        fontSize: 10.0,
                        fontWeight: FontWeight.bold,
                        fontStyle: FontStyle.normal,
                        fontFamily: 'Roboto',
                        color: textcolor),
                  ),
                ),
              )
            ],
          ),
        ],
      ),
    );
  }

  Widget _googleMap(type) {
    return Container(
      height: MediaQuery.of(context).size.height * 0.28,
      decoration: BoxDecoration(
        color: tuna,
        borderRadius: BorderRadius.all(Radius.circular(10)),
      ),
      child: Stack(
        children: [
          GoogleMap(
            mapType: _changemap(),
            compassEnabled: true,
            zoomControlsEnabled: false,
            markers: _markers,
            initialCameraPosition: CameraPosition(
                target: (widget.latitude == null && widget.longitude == null)
                    ? LatLng(30.666, 76.8127)
                    : LatLng(widget.latitude, widget.longitude),
                zoom: (widget.latitude == null && widget.longitude == null)
                    ? 3
                    : 12),
            onMapCreated: (GoogleMapController controller) {
              _controller.complete(controller);
              _onmapcreated(controller);
            },
            onCameraMove: _oncameramove,
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
                          color: darkhighlight,
                        ),
                      ],
                      border: Border.all(width: 1.0, color: darkhighlight),
                      shape: BoxShape.rectangle,
                    ),
                    child: SvgPicture.asset(
                      "assets/images/plus.svg",
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
                        boxShadow: [
                          BoxShadow(
                            blurRadius: 1.0,
                            color: darkhighlight,
                          ),
                        ],
                        border: Border.all(width: 1.0, color: darkhighlight),
                        shape: BoxShape.rectangle,
                      ),
                      child: SvgPicture.asset(
                        "assets/images/minus.svg",
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
    _lastMapPosition = position.target;
  }

  Future<void> _minus(double zoomVal) async {
    final GoogleMapController controller = await _controller.future;
    controller.animateCamera(CameraUpdate.newCameraPosition(CameraPosition(
        target: (widget.latitude == null && widget.longitude == null)
            ? widget.initLocation
            : LatLng(widget.latitude, widget.longitude),
        zoom: zoomVal)));
  }

  Future<void> _plus(double zoomVal) async {
    final GoogleMapController controller = await _controller.future;
    controller.animateCamera(CameraUpdate.newCameraPosition(CameraPosition(
        target: (widget.latitude == null && widget.longitude == null)
            ? widget.initLocation
            : LatLng(widget.latitude, widget.longitude),
        zoom: zoomVal)));
  }

  void _onmapcreated(GoogleMapController controller) {
    setState(() {
      _markers.clear();
      if (widget.latitude != null && widget.longitude != null)
        _markers.add(Marker(
            markerId: MarkerId('id-1'),
            infoWindow: InfoWindow(
              title: widget.location != null ? widget.location : "",
              onTap: () {
                widget.onMarkerTap();
              },
            ),
            position: LatLng(widget.latitude, widget.longitude)));
    });
  }

  MapType _changemap() {
    switch (_currentSelectedItem) {
      case "MAP":
        Logger().i("map is in normal type ");
        return MapType.normal;
        break;
      case "TERRAIN":
        Logger().i("map is in terrain type");
        return MapType.terrain;
        break;
      case "SATELLITE":
        Logger().i("map is in satellite type ");
        return MapType.satellite;
        break;
      case "HYBRID":
        Logger().i("map is in hybrid type ");
        return MapType.hybrid;
      default:
        return MapType.normal;
    }
  }
}
