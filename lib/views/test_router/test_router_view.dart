import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:insite/core/models/asset_location_history.dart';
import 'package:insite/theme/colors.dart';
import 'package:insite/widgets/dumb_widgets/insite_progressbar.dart';
import 'package:logger/logger.dart';
import 'package:stacked/stacked.dart';
import 'test_router_view_model.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:custom_info_window/custom_info_window.dart';
import 'package:clippy_flutter/triangle.dart';

class TestRouterView extends StatefulWidget {
  @override
  _TestRouterViewState createState() => _TestRouterViewState();
}

class _TestRouterViewState extends State<TestRouterView> {
  String _currentSelectedItem = "MAP";
  double zoomVal = 5.0;
  Completer<GoogleMapController> _controller = Completer();
  MapType currentType = MapType.normal;

  GoogleMapController mapController;
  BitmapDescriptor mapMarker;

  Set<Marker> _markers = Set();
  CustomInfoWindowController _customInfoWindowController =
      CustomInfoWindowController();

  @override
  void dispose() {
    _customInfoWindowController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<TestRouterViewModel>.reactive(
      builder: (BuildContext context, TestRouterViewModel viewModel, Widget _) {
        if (viewModel.loading) {
          return InsiteProgressBar();
        } else {
          int index = 1;
          List<AssetLocation> assetLocationList =
              viewModel.assetLocationHistory.assetLocation;
          for (var assetLocation in assetLocationList) {
            _markers.add(Marker(
                markerId: MarkerId('${index++}'),
                position:
                    LatLng(assetLocation.latitude, assetLocation.longitude),
                onTap: () {
                  _customInfoWindowController.addInfoWindow(
                    Column(
                      children: [
                        Expanded(
                          child: Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(4),
                              color: tuna,
                            ),
                            child: Column(
                              children: [
                                Container(
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.only(
                                        topLeft: Radius.circular(4),
                                        topRight: Radius.circular(4)),
                                    color: tuna,
                                  ),
                                  child: Column(
                                    children: [
                                      Text(
                                        "Location Reported Time",
                                        style: TextStyle(
                                            fontWeight: FontWeight.w900,
                                            fontFamily: 'Roboto',
                                            color: textcolor,
                                            fontStyle: FontStyle.normal,
                                            fontSize: 10.0),
                                      ),
                                      Text(
                                        assetLocation.locationEventLocalTime
                                                .toString()
                                                .split('T')
                                                .first
                                                .split('-')[2]
                                                .split(' ')
                                                .first +
                                            '/' +
                                            assetLocation.locationEventLocalTime
                                                .toString()
                                                .split('T')
                                                .first
                                                .split('-')[1] +
                                            '/' +
                                            assetLocation.locationEventLocalTime
                                                .toString()
                                                .split('T')
                                                .first
                                                .split('-')[0] +
                                            ' ' +
                                            assetLocation.locationEventLocalTime
                                                .toString()
                                                .split('T')
                                                .last
                                                .split(':')[0]
                                                .split(' ')
                                                .last +
                                            ':' +
                                            assetLocation.locationEventLocalTime
                                                .toString()
                                                .split('T')
                                                .last
                                                .split(':')[1] +
                                            ' ' +
                                            assetLocation
                                                .locationEventLocalTimeZoneAbbrev,
                                        style: TextStyle(
                                            fontFamily: 'Roboto',
                                            color: textcolor,
                                            fontStyle: FontStyle.normal,
                                            fontSize: 8.0),
                                      ),
                                    ],
                                  ),
                                ),
                                Container(
                                  decoration: BoxDecoration(
                                    color: shark,
                                  ),
                                  child: Column(
                                    children: [
                                      Text(
                                        "Location",
                                        style: TextStyle(
                                            fontWeight: FontWeight.w900,
                                            fontFamily: 'Roboto',
                                            color: textcolor,
                                            fontStyle: FontStyle.normal,
                                            fontSize: 10.0),
                                      ),
                                      Text(
                                        assetLocation.address.streetAddress +
                                            ',' +
                                            assetLocation.address.city +
                                            ',' +
                                            assetLocation.address.county +
                                            ',' +
                                            assetLocation.address.state +
                                            ' ' +
                                            assetLocation.address.zip,
                                        style: TextStyle(
                                            fontFamily: 'Roboto',
                                            color: textcolor,
                                            fontStyle: FontStyle.normal,
                                            fontSize: 8.0),
                                      ),
                                    ],
                                  ),
                                ),
                                Container(
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.only(
                                        bottomLeft: Radius.circular(4),
                                        bottomRight: Radius.circular(4)),
                                    color: tuna,
                                  ),
                                  child: Column(
                                    children: [
                                      Text(
                                        "Hours: ${assetLocation.hourmeter} Hrs",
                                        style: TextStyle(
                                            fontFamily: 'Roboto',
                                            color: textcolor,
                                            fontStyle: FontStyle.normal,
                                            fontSize: 8.0),
                                      ),
                                      Text(
                                        "Odometer: ${assetLocation.odometer} Hrs",
                                        style: TextStyle(
                                            fontFamily: 'Roboto',
                                            color: textcolor,
                                            fontStyle: FontStyle.normal,
                                            fontSize: 8.0),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                            width: 100,
                            height: 100,
                          ),
                        ),
                        Triangle.isosceles(
                          edge: Edge.BOTTOM,
                          child: Container(
                            color: tuna,
                            width: 20.0,
                            height: 10.0,
                          ),
                        ),
                      ],
                    ),
                    LatLng(assetLocation.latitude, assetLocation.longitude),
                  );
                }));
          }

          return Scaffold(
            backgroundColor: bgcolor,
            body: Center(
              child: Container(
                margin: EdgeInsets.all(4.0),
                width: 374.04,
                height: 305.44,
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
                          padding: EdgeInsets.only(top: 20, left: 20),
                          child: Row(
                            children: [
                              SvgPicture.asset("assets/images/arrowdown.svg"),
                              SizedBox(
                                width: 10,
                              ),
                              Text(
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
                                  border: Border.all(
                                      width: 1.0, color: Colors.white),
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
                                          padding:
                                              const EdgeInsets.only(right: 8.0),
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
                                        items: [
                                          'MAP',
                                          'TERRAIN',
                                          'SATELLITE',
                                          'HYBRID'
                                        ]
                                            .map((map) => DropdownMenuItem(
                                                  value: map,
                                                  child: Text(map,
                                                      style: new TextStyle(
                                                          fontSize: 11.0,
                                                          fontWeight:
                                                              FontWeight.bold,
                                                          color: textcolor,
                                                          fontFamily: 'Roboto',
                                                          fontStyle: FontStyle
                                                              .normal)),
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
                                                        color:
                                                            Colors.transparent,
                                                        width: 0.0)))),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              Expanded(
                                child: Align(
                                  alignment: Alignment.centerRight,
                                  child: Padding(
                                    padding:
                                        EdgeInsets.symmetric(horizontal: 8.0),
                                    child: GestureDetector(
                                      onTap: () => print("button is tapped"),
                                      child: SvgPicture.asset(
                                        "assets/images/menu.svg",
                                        width: 20,
                                        height: 20,
                                      ),
                                    ),
                                  ),
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
                            child: Container(
                              width: 380.9,
                              height: 267.46,
                              child: Stack(
                                children: [
                                  GoogleMap(
                                    onTap: (position) {
                                      _customInfoWindowController
                                          .hideInfoWindow();
                                    },
                                    onCameraMove: (position) {
                                      _customInfoWindowController
                                          .onCameraMove();
                                    },
                                    onMapCreated:
                                        (GoogleMapController controller) async {
                                      _customInfoWindowController
                                          .googleMapController = controller;
                                    },
                                    mapType: _changemap(),
                                    compassEnabled: true,
                                    zoomControlsEnabled: false,
                                    markers: _markers,
                                    initialCameraPosition: CameraPosition(
                                        target: LatLng(20.5937, 78.9629),
                                        zoom: 12),
                                  ),
                                  CustomInfoWindow(
                                    controller: _customInfoWindowController,
                                    height: 75,
                                    width: 150,
                                    offset: 50,
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
                                                  topLeft:
                                                      const Radius.circular(
                                                          5.0),
                                                  topRight:
                                                      const Radius.circular(
                                                          5.0),
                                                  bottomLeft:
                                                      const Radius.circular(
                                                          5.0),
                                                  bottomRight:
                                                      const Radius.circular(
                                                          5.0)),
                                              boxShadow: [
                                                new BoxShadow(
                                                  blurRadius: 1.0,
                                                  color: darkhighlight,
                                                ),
                                              ],
                                              border: Border.all(
                                                  width: 1.0,
                                                  color: darkhighlight),
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
                                                    topLeft:
                                                        const Radius.circular(
                                                            5.0),
                                                    topRight:
                                                        const Radius.circular(
                                                            5.0),
                                                    bottomLeft:
                                                        const Radius.circular(
                                                            5.0),
                                                    bottomRight:
                                                        const Radius.circular(
                                                            5.0)),
                                                boxShadow: [
                                                  new BoxShadow(
                                                    blurRadius: 1.0,
                                                    color: darkhighlight,
                                                  ),
                                                ],
                                                border: Border.all(
                                                    width: 1.0,
                                                    color: darkhighlight),
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
                            ),
                          ),
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
            ),
          );
        }
      },
      viewModelBuilder: () => TestRouterViewModel(),
    );
  }

  Future<void> _minus(double zoomVal) async {
    final GoogleMapController controller = await _controller.future;
    controller.animateCamera(CameraUpdate.newCameraPosition(
        CameraPosition(target: LatLng(20.5937, 78.9629), zoom: zoomVal)));
  }

  Future<void> _plus(double zoomVal) async {
    final GoogleMapController controller = await _controller.future;
    controller.animateCamera(CameraUpdate.newCameraPosition(
        CameraPosition(target: LatLng(20.5937, 78.9629), zoom: zoomVal)));
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
