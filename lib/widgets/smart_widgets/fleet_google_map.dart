import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:insite/theme/colors.dart';
import 'package:logger/logger.dart';

class FleetGoogleMap extends StatefulWidget {
  final double Latitude;
  final double Longitude;
  FleetGoogleMap({this.Latitude, this.Longitude});

  @override
  _FleetGoogleMapState createState() => _FleetGoogleMapState();
}

class _FleetGoogleMapState extends State<FleetGoogleMap> {
  String _currentSelectedItem = "MAP";
  double zoomVal = 5.0;
  static const LatLng _center = const LatLng(20.5937, 78.9629);
  Completer<GoogleMapController> _controller = Completer();
  LatLng _lastMapPosition = _center;
  Set<Marker> _markers = {};
  MapType currentType = MapType.normal;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: bgcolor,
      body: Container(
        margin: EdgeInsets.all(4.0),
        width: 374.04,
        height: 305.44,
        // color: cardcolor,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10.0),
          boxShadow: [new BoxShadow(blurRadius: 1.0, color: cardcolor)],
          border: Border.all(width: 2.5, color: cardcolor),
          shape: BoxShape.rectangle,
        ),
        child: Stack(
          children: [
            Column(
              children: [
                Padding(
                  padding: const EdgeInsets.only(top: 20, left: 20),
                  child: new Row(
                    children: [
                      SvgPicture.asset("assets/images/arrowdown.svg"),
                      SizedBox(
                        width: 10,
                      ),
                      new Text(
                        "LOCATION",
                        style: new TextStyle(
                            fontWeight: FontWeight.w900,
                            fontFamily: 'Roboto',
                            color: textcolor,
                            fontStyle: FontStyle.normal,
                            fontSize: 12.0),
                      ),
                      SizedBox(
                        width: 60.0,
                      ),
                      Container(
                        width: 118.23,
                        height: 35.18,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.only(
                              topLeft: const Radius.circular(5.0),
                              topRight: const Radius.circular(5.0),
                              bottomLeft: const Radius.circular(5.0),
                              bottomRight: const Radius.circular(5.0)),
                          boxShadow: [
                            new BoxShadow(
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
                                icon: Padding(
                                  padding: const EdgeInsets.only(right: 8.0),
                                  child: Container(
                                    child: SvgPicture.asset(
                                      "assets/images/arrowdown.svg",
                                      width: 10,
                                      height: 10,
                                    ),
                                  ),
                                ),
                                isExpanded: true,
                                hint: new Text(
                                  _currentSelectedItem,
                                ),
                                items: ['MAP', 'TERRAIN', 'SATELLITE', 'HYBRID']
                                    .map((map) => DropdownMenuItem(
                                          value: map,
                                          child: Text(map,
                                              style: new TextStyle(
                                                  fontSize: 11.0,
                                                  fontWeight: FontWeight.bold,
                                                  color: textcolor,
                                                  fontFamily: 'Roboto',
                                                  fontStyle: FontStyle.normal)),
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
                                    decoration: const BoxDecoration(
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
                      GestureDetector(
                        onTap: () => print("button is tapped"),
                        child: SvgPicture.asset(
                          "assets/images/menu.svg",
                          width: 20,
                          height: 20,
                        ),
                      )
                    ],
                  ),
                ),
                SizedBox(
                  height: 5.0,
                ),
                new Container(
                  width: 374.46,
                  height: 60.97,
                  color: greencolor,
                  child: Padding(
                    padding: const EdgeInsets.only(left: 5.0, top: 8.0),
                    child: Text(
                      "To deliver high map performance, the map will only display up to 2,500 assets at one time. Please use a filter to specify a working set of less than 2,500 assets if you have more than 2,500 assets in your account .",
                      style: new TextStyle(
                          fontSize: 11.0,
                          fontWeight: FontWeight.w500,
                          fontFamily: 'Roboto',
                          fontStyle: FontStyle.normal,
                          color: maptextcolor),
                    ),
                  ),
                ),
                Flexible(
                  child: Container(
                      width: 380.9,
                      height: 450.63,
                      child: _googleMap(currentType)),
                ),
                Divider(),
                Padding(
                  padding: const EdgeInsets.only(left: 10.0, top: 5.0),
                  child: new Container(
                    width: 290.5,
                    height: 22.57,
                    child: Text(
                      "87 out of 9661 assets do not have location information",
                      style: new TextStyle(
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
      ),
    );
  }

  Widget _googleMap(type) {
    //Logger().i("map is addded");
    return Container(
      width: 380.9,
      height: 267.46,
      child: Stack(
        children: [
          GoogleMap(
            mapType: _changemap(),
            compassEnabled: true,
            zoomControlsEnabled: false,
            markers: _markers,
            initialCameraPosition:
                CameraPosition(target: LatLng(widget.Latitude, widget.Longitude), zoom: 12),
            onMapCreated: (GoogleMapController controller) {
              _controller.complete(controller);
              _onmapcreated(controller);
            },
            onCameraMove: _oncameramove,
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
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
                      borderRadius: BorderRadius.only(
                          topLeft: const Radius.circular(5.0),
                          topRight: const Radius.circular(5.0),
                          bottomLeft: const Radius.circular(5.0),
                          bottomRight: const Radius.circular(5.0)),
                      boxShadow: [
                        new BoxShadow(
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
                        borderRadius: BorderRadius.only(
                            topLeft: const Radius.circular(5.0),
                            topRight: const Radius.circular(5.0),
                            bottomLeft: const Radius.circular(5.0),
                            bottomRight: const Radius.circular(5.0)),
                        boxShadow: [
                          new BoxShadow(
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
    controller.animateCamera(CameraUpdate.newCameraPosition(
        CameraPosition(target: LatLng(widget.Latitude, widget.Longitude), zoom: zoomVal)));
  }

  Future<void> _plus(double zoomVal) async {
    final GoogleMapController controller = await _controller.future;
    controller.animateCamera(CameraUpdate.newCameraPosition(
        CameraPosition(target: LatLng(widget.Latitude, widget.Longitude), zoom: zoomVal)));
  }

  void _onmapcreated(GoogleMapController controller) {
    setState(() {
      _markers.add(Marker(
          markerId: MarkerId('id-1'), position: LatLng(widget.Latitude, widget.Longitude)));
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
