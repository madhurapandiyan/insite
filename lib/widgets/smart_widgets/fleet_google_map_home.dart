import 'dart:async';
import 'dart:ui';
import 'package:clippy_flutter/triangle.dart';
import 'package:custom_info_window/custom_info_window.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_maps_cluster_manager/google_maps_cluster_manager.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:insite/core/models/asset_location.dart';
import 'package:insite/core/models/marker.dart';
import 'package:insite/theme/colors.dart';
import 'package:insite/views/home/home_view.dart';
import 'package:insite/widgets/dumb_widgets/insite_button.dart';
import 'package:logger/logger.dart';

class FleetGoogleMapHome extends StatefulWidget {
  final List<MapRecord> assetLocation;
  final String status;
  final isLoading;
  final ScreenType screenType;
  FleetGoogleMapHome({
    this.assetLocation,
    this.status,
    this.screenType,
    this.isLoading,
  });

  @override
  _FleetGoogleMapState createState() => _FleetGoogleMapState();
}

class _FleetGoogleMapState extends State<FleetGoogleMapHome> {
  String _currentSelectedItem = "MAP";
  double zoomVal = 5.0;
  int index = 1;
  Completer<GoogleMapController> _controller = Completer();
  ClusterManager _manager;
  Set<Marker> markers = {};
  MapType currentType = MapType.normal;
  CustomInfoWindowController customInfoWindowController =
      CustomInfoWindowController();
  List<ClusterItem<InsiteMarker>> clusterMarkers = [];

  @override
  void initState() {
    _manager = _initClusterManager();
    super.initState();
  }

  @override
  void dispose() {
    customInfoWindowController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    for (var assetLocation in widget.assetLocation) {
      clusterMarkers.add(
        ClusterItem(
            LatLng(assetLocation.lastReportedLocationLatitude,
                assetLocation.lastReportedLocationLongitude),
            item: InsiteMarker(
              markerId: MarkerId('${index++}'),
              position: LatLng(assetLocation.lastReportedLocationLatitude,
                  assetLocation.lastReportedLocationLongitude),
            )),
      );
    }
    return Container(
        width: 374.04,
        height: 305.44,
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
                          SvgPicture.asset("assets/images/arrowdown.svg"),
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
                                fontSize: 12.0),
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
                                                      fontWeight:
                                                          FontWeight.bold,
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
                    ],
                  ),
                ),
                SizedBox(
                  height: 5.0,
                ),
                Container(
                  width: 374.46,
                  height: 60.97,
                  color: greencolor,
                  child: Padding(
                    padding: EdgeInsets.only(left: 5.0, top: 8.0),
                    child: Text(
                      "To deliver high map performance, the map will only display up to 2,500 assets at one time. Please use a filter to specify a working set of less than 2,500 assets if you have more than 2,500 assets in your account .",
                      style: TextStyle(
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
        ));
  }

  Widget _googleMap(type) {
    return Container(
      width: 380.9,
      height: 267.46,
      decoration: BoxDecoration(
        color: tuna,
        borderRadius: BorderRadius.all(Radius.circular(10)),
      ),
      child: Stack(
        children: [
          GoogleMap(
            mapType: _changemap(),
            compassEnabled: true,
            markers: markers,
            zoomControlsEnabled: false,
            onCameraMove: (position) {
              customInfoWindowController.onCameraMove();
              _manager.onCameraMove(position);
            },
            initialCameraPosition: CameraPosition(
                zoom: 5,
                target: LatLng(
                  widget.assetLocation.first.lastReportedLocationLatitude,
                  widget.assetLocation.first.lastReportedLocationLongitude,
                )),
            onMapCreated: (GoogleMapController controller) async {
              customInfoWindowController.googleMapController = controller;

              _controller.complete(controller);
              _manager.setMapController(controller);
            },
            onCameraIdle: _manager.updateMap,
          ),
          CustomInfoWindow(
            controller: customInfoWindowController,
            height: MediaQuery.of(context).size.width * 0.45,
            width: MediaQuery.of(context).size.height * 0.40,
            offset: 1,
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
                    _plus(
                        zoomVal,
                        LatLng(
                            widget.assetLocation.first
                                .lastReportedLocationLatitude,
                            widget.assetLocation.first
                                .lastReportedLocationLongitude));
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
                      _minus(
                          zoomVal,
                          LatLng(
                              widget.assetLocation.first
                                  .lastReportedLocationLatitude,
                              widget.assetLocation.first
                                  .lastReportedLocationLongitude));
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

  ClusterManager _initClusterManager() {
    return ClusterManager<InsiteMarker>(clusterMarkers, _updateMarkers,
        markerBuilder: _markerBuilder,
        initialZoom: 5,
        stopClusteringZoom: 10.0);
  }

  void _updateMarkers(Set<Marker> markers) {
    print('Updated ${markers.length} markers');
    setState(() {
      this.markers = markers;
    });
  }

  Future<Marker> Function(Cluster<InsiteMarker>) get _markerBuilder =>
      (cluster) async {
        return Marker(
          markerId: MarkerId(cluster.getId()),
          position: cluster.location,
          onTap: () {
            customInfoWindowController.addInfoWindow(
                Column(
                  children: [
                    Container(
                      width: 250,
                      height: 250,
                      decoration: BoxDecoration(
                        color: cardcolor,
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Column(
                        children: [
                          Row(
                            children: [
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Text(
                                  "Cluster Info",
                                  style: new TextStyle(
                                      fontFamily: 'Roboto',
                                      fontSize: 13.0,
                                      fontWeight: FontWeight.w700,
                                      color: silver),
                                ),
                              ),
                              SizedBox(
                                width: 50.0,
                              ),
                              GestureDetector(
                                  onTap: () {
                                    customInfoWindowController.hideInfoWindow();
                                  },
                                  child:
                                      Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Image.asset("assets/images/mapclose.png"),
                                      ))
                            ],
                          ),
                          Divider(),
                          Container(
                            width: 216,
                            height: 32,
                            color: thunder,
                            child: Padding(
                              padding: EdgeInsets.only(
                                  left: 38, top: 5.0, bottom: 5.0),
                              child: Text(
                                cluster.count.toString() + "Assets",
                                style: TextStyle(
                                    fontFamily: 'Roboto',
                                    fontSize: 13.0,
                                    fontWeight: FontWeight.w700,
                                    color: silver),
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 16,
                          ),
                          Column(
                            children: [
                              InsiteButton(
                                width: 120,
                                height: 40,
                                bgColor: tango,
                                title: "Fleet List",
                                textColor: appbarcolor,
                                onTap: () {
                                  print("button is tapped");
                                },
                              ),
                              SizedBox(
                                height: 15,
                              ),
                              InsiteButton(
                                width: 120,
                                height: 40,
                                bgColor: tango,
                                title: "Zoom to cluster",
                                textColor: appbarcolor,
                                onTap: () {
                                  print("button is tapped");
                                },
                              )
                            ],
                          )
                        ],
                      ),
                    ),
                    Triangle.isosceles(
                      edge: Edge.BOTTOM,
                      child: Container(
                        color: cardcolor,
                        width: 20.0,
                        height: 10.0,
                      ),
                    ),
                  ],
                ),
                LatLng(cluster.location.latitude, cluster.location.longitude));
          },
          icon: await _getMarkerBitmap(cluster.isMultiple ? 125 : 75,
              text: cluster.count.toString()),
        );
      };

  Future<BitmapDescriptor> _getMarkerBitmap(int size, {String text}) async {
    if (kIsWeb) size = (size / 2).floor();

    final PictureRecorder pictureRecorder = PictureRecorder();
    final Canvas canvas = Canvas(pictureRecorder);
    final Paint paint1 = Paint()..color = Colors.white;
    final Paint paint2 = Paint()..color = Colors.blue;

    canvas.drawCircle(Offset(size / 2, size / 2), size / 2.0, paint1);
    canvas.drawCircle(Offset(size / 2, size / 2), size / 2.2, paint2);
    canvas.drawCircle(Offset(size / 2, size / 2), size / 2.8, paint1);

    if (text != null) {
      TextPainter painter = TextPainter(textDirection: TextDirection.ltr);
      painter.text = TextSpan(
        text: text,
        style: TextStyle(
            fontSize: size / 3,
            color: darkGrey,
            fontStyle: FontStyle.normal,
            fontWeight: FontWeight.w400),
      );
      painter.layout();
      painter.paint(
        canvas,
        Offset(size / 2 - painter.width / 2, size / 2 - painter.height / 2),
      );
    }

    final img = await pictureRecorder.endRecording().toImage(size, size);
    final data = await img.toByteData(format: ImageByteFormat.png) as ByteData;

    return BitmapDescriptor.fromBytes(data.buffer.asUint8List());
  }

  Future<void> _minus(double zoomVal, LatLng targetPosition) async {
    final GoogleMapController controller = await _controller.future;
    controller.animateCamera(CameraUpdate.newCameraPosition(
        CameraPosition(target: targetPosition, zoom: zoomVal)));
  }

  Future<void> _plus(double zoomVal, LatLng targetPosition) async {
    final GoogleMapController controller = await _controller.future;
    controller.animateCamera(CameraUpdate.newCameraPosition(
        CameraPosition(target: targetPosition, zoom: zoomVal)));
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
