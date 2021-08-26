import 'dart:async';
import 'dart:ui';
import 'package:custom_info_window/custom_info_window.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart' as flutter_map;
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:insite/core/models/asset_location.dart';
import 'package:insite/theme/colors.dart';
import 'package:insite/utils/enums.dart';
import 'package:insite/views/location/location_view_model.dart';
import 'package:flutter_map_marker_cluster/flutter_map_marker_cluster.dart'
    as cluster;
import 'package:logger/logger.dart';
import 'package:stacked/stacked.dart';

class GoogleMapHomeWidget extends StatefulWidget {
  final bool isRefreshing;
  GoogleMapHomeWidget({
    this.isRefreshing,
    Key key,
  }) : super(key: key);
  @override
  GoogleMapHomeWidgetState createState() => GoogleMapHomeWidgetState();
}

class GoogleMapHomeWidgetState extends State<GoogleMapHomeWidget> {
  String _currentSelectedItem = "MAP";
  double zoomVal = 5.0;
  var viewModel;
  MapType currentType = MapType.normal;
  @override
  void initState() {
    super.initState();
    viewModel = LocationViewModel(ScreenType.DASHBOARD);
  }

  @override
  void dispose() {
    super.dispose();
  }

  final cluster.PopupController _popupController = cluster.PopupController();

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<LocationViewModel>.reactive(
      builder: (BuildContext context, LocationViewModel viewModel, Widget _) {
        return Container(
            height: MediaQuery.of(context).size.height * 0.50,
            margin: EdgeInsets.symmetric(horizontal: 8),
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
                      padding: EdgeInsets.only(
                          top: 10, left: 10, right: 10, bottom: 10),
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
                                            decoration: BoxDecoration(
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
                    Container(
                      height: MediaQuery.of(context).size.height * 0.10,
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
                    (viewModel.loading || widget.isRefreshing)
                        ? Expanded(
                            child: Center(
                              child: CircularProgressIndicator(),
                            ),
                          )
                        : Expanded(
                            flex: 1,
                            child: Container(
                                height:
                                    MediaQuery.of(context).size.height * 0.45,
                                child: _googleMap(currentType, viewModel)
                                // child: flutter_map.FlutterMap(
                                //   options: flutter_map.MapOptions(
                                //     center: latlng.LatLng(50, 20),
                                //     plugins: [cluster.MarkerClusterPlugin()],
                                //     onTap: (_) {
                                //       _popupController.hidePopup();
                                //     },
                                //     zoom: 5.0,
                                //     interactiveFlags:
                                //         flutter_map.InteractiveFlag.all -
                                //             flutter_map.InteractiveFlag.rotate,
                                //   ),
                                //   layers: [
                                //     flutter_map.TileLayerOptions(
                                //       urlTemplate:
                                //           'https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png',
                                //       subdomains: ['a', 'b', 'c'],
                                //     ),
                                //     cluster.MarkerClusterLayerOptions(
                                //       maxClusterRadius: 120,
                                //       size: Size(40, 40),
                                //       fitBoundsOptions:
                                //           flutter_map.FitBoundsOptions(
                                //         padding: EdgeInsets.all(50),
                                //       ),
                                //       onClusterTap: (clusterNode) {
                                //         print(
                                //             "onClusterTap ${clusterNode.point.latitude}");
                                //         _popupController
                                //             .showPopupFor(flutter_map.Marker(
                                //           point: clusterNode.point,
                                //           builder: (context) {
                                //             return Container(
                                //               width: 200,
                                //               height: 100,
                                //               color: cardBackgroundOne,
                                //               child: GestureDetector(
                                //                 onTap: () {
                                //                   debugPrint('Popup tap!');
                                //                 },
                                //                 child: Text(
                                //                   'popup for marker at ${clusterNode.point}',
                                //                 ),
                                //               ),
                                //             );
                                //           },
                                //         ));
                                //       },
                                //       zoomToBoundsOnClick: false,
                                //       markers: viewModel.allMarkers,
                                //       polygonOptions: cluster.PolygonOptions(
                                //           borderColor: Colors.blueAccent,
                                //           color: Colors.black12,
                                //           borderStrokeWidth: 3),
                                //       popupOptions: cluster.PopupOptions(
                                //           popupSnap: cluster.PopupSnap.markerTop,
                                //           popupController: _popupController,
                                //           popupBuilder: (_, marker) {
                                //             print("popup");
                                //             return Container(
                                //               width: 200,
                                //               height: 100,
                                //               color: Colors.white,
                                //               child: GestureDetector(
                                //                 onTap: () =>
                                //                     debugPrint('Popup tap!'),
                                //                 child: Text(
                                //                   'Container popup for marker at ${marker.point}',
                                //                 ),
                                //               ),
                                //             );
                                //           }),
                                //       builder: (context, markers) {
                                //         // return FloatingActionButton(
                                //         //   child:
                                //         return Container(
                                //           width: 40,
                                //           decoration: ShapeDecoration(
                                //             color: Colors.black,
                                //             shape: CircleBorder(),
                                //           ),
                                //           alignment: Alignment.center,
                                //           height: 40,
                                //           child: Text(
                                //             markers.length.toString(),
                                //             style: TextStyle(color: Colors.white),
                                //             // onPressed: () {
                                //             //   _popupController.showPopupFor(markers[0]);
                                //             //   print("on ClusterTap ${markers.length}");
                                //             // },
                                //           ),
                                //         );
                                //       },
                                //     ),
                                //     // MarkerLayerOptions(
                                //     //     markers: allMarkers.sublist(
                                //     //         0, min(allMarkers.length, _sliderVal))),
                                //   ],
                                // ),
                                ),
                          ),
                    Divider(),
                    // Padding(
                    //   padding: EdgeInsets.only(left: 10.0, top: 5.0),
                    //   child: Container(
                    //     width: 290.5,
                    //     height: 22.57,
                    //     child: Text(
                    //       '',
                    //       style: TextStyle(
                    //           fontSize: 10.0,
                    //           fontWeight: FontWeight.bold,
                    //           fontStyle: FontStyle.normal,
                    //           fontFamily: 'Roboto',
                    //           color: textcolor),
                    //     ),
                    //   ),
                    // )
                  ],
                ),
              ],
            ));
      },
      viewModelBuilder: () => viewModel,
    );
  }

  Widget _googleMap(type, LocationViewModel viewModel) {
    return Container(
      height: MediaQuery.of(context).size.height * 0.28,
      decoration: BoxDecoration(
        color: tuna,
        borderRadius: BorderRadius.all(Radius.circular(10)),
      ),
      child: Stack(
        children: [
          GoogleMap(
            onCameraMove: (position) {
              viewModel.customInfoWindowController.onCameraMove();
              viewModel.manager != null
                  ? viewModel.manager.onCameraMove(position)
                  : SizedBox();
            },
            gestureRecognizers: <Factory<OneSequenceGestureRecognizer>>[
              new Factory<OneSequenceGestureRecognizer>(
                () => new EagerGestureRecognizer(),
              ),
            ].toSet(),
            onMapCreated: (GoogleMapController controller) async {
              viewModel.customInfoWindowController.googleMapController =
                  controller;
              viewModel.controller.complete(controller);
              viewModel.manager != null
                  ? viewModel.manager.setMapController(controller)
                  : SizedBox();
              viewModel.zoomToMarkers();
            },
            onTap: (argument) {
              viewModel.customInfoWindowController.hideInfoWindow();
            },
            onCameraIdle:
                viewModel.manager != null ? viewModel.manager.updateMap : null,
            mapType: _changemap(),
            compassEnabled: true,
            zoomControlsEnabled: false,
            markers: viewModel.markers,
            initialCameraPosition: viewModel.assetLocation != null &&
                    viewModel.assetLocation.mapRecords.isNotEmpty
                ? CameraPosition(
                    target: LatLng(
                        viewModel.assetLocation.mapRecords.first
                            .lastReportedLocationLatitude,
                        viewModel.assetLocation.mapRecords.first
                            .lastReportedLocationLongitude),
                    zoom: 5)
                : CameraPosition(target: LatLng(30.666, 76.8127), zoom: 4),
          ),
          CustomInfoWindow(
            controller: viewModel.customInfoWindowController,
            width: MediaQuery.of(context).size.width * 0.42,
            height: MediaQuery.of(context).size.height * 0.36,
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
                    viewModel.customInfoWindowController.hideInfoWindow();
                    zoomVal++;
                    _plus(
                        zoomVal,
                        LatLng(
                            viewModel.assetLocation.mapRecords.first
                                .lastReportedLocationLatitude,
                            viewModel.assetLocation.mapRecords.first
                                .lastReportedLocationLongitude),
                        viewModel);
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
                      viewModel.customInfoWindowController.hideInfoWindow();
                      zoomVal--;
                      _minus(
                          zoomVal,
                          LatLng(
                            viewModel.assetLocation.mapRecords.first
                                .lastReportedLocationLatitude,
                            viewModel.assetLocation.mapRecords.first
                                .lastReportedLocationLongitude,
                          ),
                          viewModel);
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

  Widget _flutterMap() {
    return Container();
  }

  Future<void> _minus(double zoomVal, LatLng targetPosition,
      LocationViewModel viewModel) async {
    final GoogleMapController controller = await viewModel.controller.future;
    controller.animateCamera(CameraUpdate.newCameraPosition(
        CameraPosition(target: targetPosition, zoom: zoomVal)));
  }

  Future<void> _plus(double zoomVal, LatLng targetPosition,
      LocationViewModel viewModel) async {
    final GoogleMapController controller = await viewModel.controller.future;
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

  getLocationFilterData(dropDownValue) async {
    await viewModel.getLocationFilterData(dropDownValue);
  }
}
