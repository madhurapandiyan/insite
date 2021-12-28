import 'dart:async';
import 'dart:ui';
import 'package:custom_info_window/custom_info_window.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:insite/theme/colors.dart';
import 'package:insite/utils/enums.dart';
import 'package:insite/views/location/location_view_model.dart';
import 'package:flutter_map_marker_cluster/flutter_map_marker_cluster.dart'
    as cluster;
import 'package:insite/widgets/dumb_widgets/insite_progressbar.dart';
import 'package:insite/widgets/dumb_widgets/insite_text.dart';
import 'package:logger/logger.dart';
import 'package:stacked/stacked.dart';

class GoogleMapHomeWidget extends StatefulWidget {
  final bool? isRefreshing;
  GoogleMapHomeWidget({
    this.isRefreshing,
    Key? key,
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
      builder: (BuildContext context, LocationViewModel viewModel, Widget? _) {
        return Card(
          margin: EdgeInsets.symmetric(horizontal: 8),
          child: Container(
              height: MediaQuery.of(context).size.height * 0.50,
              child: Column(
                children: [
                  Padding(
                    padding: EdgeInsets.only(
                        top: 10, left: 10, right: 10, bottom: 10),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            SvgPicture.asset("assets/images/arrowdown.svg"),
                            SizedBox(
                              width: 10,
                            ),
                            InsiteText(
                                text: "LOCATION",
                                fontWeight: FontWeight.w900,
                                size: 12.0),
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
                                border: Border.all(
                                    width: 1.0,
                                    color: Theme.of(context)
                                        .textTheme
                                        .bodyText1!
                                        .color!),
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
                                            color: Theme.of(context)
                                                .iconTheme
                                                .color,
                                            height: 10,
                                          ),
                                        ),
                                      ),
                                      isExpanded: true,
                                      hint: Text(
                                        _currentSelectedItem,
                                        style: TextStyle(
                                            color: Theme.of(context)
                                                .textTheme
                                                .bodyText1!
                                                .color!),
                                      ),
                                      items: [
                                        'MAP',
                                        'TERRAIN',
                                        'SATELLITE',
                                        'HYBRID'
                                      ]
                                          .map((map) => DropdownMenuItem(
                                                value: map,
                                                child: InsiteText(
                                                  text: map,
                                                  size: 11.0,
                                                  fontWeight: FontWeight.bold,
                                                ),
                                              ))
                                          .toList(),
                                      value: _currentSelectedItem,
                                      onChanged: (String? value) {
                                        setState(() {
                                          _currentSelectedItem = value!;
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
                  viewModel.showLabel
                      ? Container(
                          height: MediaQuery.of(context).size.height * 0.11,
                          color: greencolor,
                          child: Padding(
                            padding: EdgeInsets.only(left: 5.0, top: 8.0),
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Expanded(
                                  child: InsiteText(
                                    text:
                                        "To deliver high map performance, the map will only display up to 2,500 assets at one time. Please use a filter to specify a working set of less than 2,500 assets if you have more than 2,500 assets in your account .",
                                    size: 11.0,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                                GestureDetector(
                                    onTap: () {
                                      viewModel.updateLabelVisibility(false);
                                    },
                                    child: Padding(
                                      padding: const EdgeInsets.only(
                                          right: 8.0, bottom: 8),
                                      child: Image.asset(
                                          "assets/images/mapclose.png",
                                          width: 10,
                                          height: 10,
                                          color: Colors.black),
                                    )),
                              ],
                            ),
                          ),
                        )
                      : SizedBox(),
                  (viewModel.loading)
                      ? Expanded(
                          child: InsiteProgressBar(),
                        )
                      : Expanded(
                          flex: 1,
                          child: Container(
                              height: MediaQuery.of(context).size.height * 0.45,
                              child: Container(
                                height:
                                    MediaQuery.of(context).size.height * 0.28,
                                decoration: BoxDecoration(
                                  color: Theme.of(context).backgroundColor,
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(10)),
                                ),
                                child: Stack(
                                  children: [
                                    ClipRRect(
                                      borderRadius: BorderRadius.only(
                                          bottomLeft: Radius.circular(10),
                                          bottomRight: Radius.circular(10)),
                                      child: GoogleMap(
                                        onLongPress: (argument) {},
                                        onCameraMoveStarted: () {},
                                        onCameraMove: (position) {
                                          viewModel.customInfoWindowController.onCameraMove!();
                                          viewModel.manager != null
                                              ? viewModel.manager!
                                                  .onCameraMove(position)
                                              : SizedBox();
                                        },
                                        gestureRecognizers: <
                                            Factory<
                                                OneSequenceGestureRecognizer>>[
                                          new Factory<
                                              OneSequenceGestureRecognizer>(
                                            () => new EagerGestureRecognizer(),
                                          ),
                                        ].toSet(),
                                        onMapCreated: (GoogleMapController
                                            controller) async {
                                          viewModel.customInfoWindowController
                                              .googleMapController = controller;
                                          viewModel.controller
                                              .complete(controller);
                                          viewModel.manager != null
                                              ? viewModel.manager!
                                                  .setMapId(controller.mapId)
                                              : SizedBox();
                                          viewModel.zoomToMarkers();
                                        },
                                        onTap: (argument) {
                                          viewModel.customInfoWindowController.hideInfoWindow!();
                                        },
                                        onCameraIdle: () {
                                          if (viewModel.manager != null) {
                                            viewModel.manager!.updateMap();
                                          }
                                        },
                                        mapType: _changemap(),
                                        compassEnabled: true,
                                        zoomControlsEnabled: false,
                                        markers: viewModel.markers,
                                        initialCameraPosition: viewModel
                                                        .assetLocation !=
                                                    null &&
                                                viewModel.assetLocation!
                                                    .mapRecords!.isNotEmpty
                                            ? CameraPosition(
                                                target: LatLng(
                                                    viewModel
                                                        .assetLocation!
                                                        .mapRecords!
                                                        .first!
                                                        .lastReportedLocationLatitude!,
                                                    viewModel
                                                        .assetLocation!
                                                        .mapRecords!
                                                        .first!
                                                        .lastReportedLocationLongitude!),
                                                zoom: 5)
                                            : CameraPosition(
                                                target: LatLng(30.666, 76.8127),
                                                zoom: 4),
                                      ),
                                    ),
                                    CustomInfoWindow(
                                      controller:
                                          viewModel.customInfoWindowController,
                                      width: MediaQuery.of(context).size.width *
                                          0.42,
                                      height:
                                          MediaQuery.of(context).size.height *
                                              0.36,
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
                                              viewModel
                                                  .customInfoWindowController.hideInfoWindow!();
                                              zoomVal++;
                                              _plus(
                                                  zoomVal,
                                                  LatLng(
                                                      viewModel
                                                          .assetLocation!
                                                          .mapRecords!
                                                          .first!
                                                          .lastReportedLocationLatitude!,
                                                      viewModel
                                                          .assetLocation!
                                                          .mapRecords!
                                                          .first!
                                                          .lastReportedLocationLongitude!),
                                                  viewModel);
                                            },
                                            child: Container(
                                              width: 27.47,
                                              height: 26.97,
                                              decoration: BoxDecoration(
                                                color: Theme.of(context)
                                                    .backgroundColor,
                                                borderRadius: BorderRadius.all(
                                                    Radius.circular(5.0)),
                                                boxShadow: [
                                                  BoxShadow(
                                                    blurRadius: 1.0,
                                                    color: Theme.of(context)
                                                        .textTheme
                                                        .bodyText1!
                                                        .color!,
                                                  ),
                                                ],
                                                border: Border.all(
                                                    width: 1.0,
                                                    color: Theme.of(context)
                                                        .textTheme
                                                        .bodyText1!
                                                        .color!),
                                                shape: BoxShape.rectangle,
                                              ),
                                              child: SvgPicture.asset(
                                                "assets/images/plus.svg",
                                                color: Theme.of(context)
                                                    .iconTheme
                                                    .color,
                                              ),
                                            ),
                                          ),
                                          SizedBox(
                                            height: 5.0,
                                          ),
                                          GestureDetector(
                                              onTap: () {
                                                print("button is tapped");
                                                viewModel
                                                    .customInfoWindowController.hideInfoWindow!();
                                                zoomVal--;
                                                _minus(
                                                    zoomVal,
                                                    LatLng(
                                                      viewModel
                                                          .assetLocation!
                                                          .mapRecords!
                                                          .first!
                                                          .lastReportedLocationLatitude!,
                                                      viewModel
                                                          .assetLocation!
                                                          .mapRecords!
                                                          .first!
                                                          .lastReportedLocationLongitude!,
                                                    ),
                                                    viewModel);
                                              },
                                              child: Container(
                                                width: 27.47,
                                                height: 26.97,
                                                decoration: BoxDecoration(
                                                  borderRadius:
                                                      BorderRadius.all(
                                                          Radius.circular(5.0)),
                                                  boxShadow: [
                                                    BoxShadow(
                                                      blurRadius: 1.0,
                                                      color: Theme.of(context)
                                                          .textTheme
                                                          .bodyText1!
                                                          .color!,
                                                    ),
                                                  ],
                                                  color: Theme.of(context)
                                                      .backgroundColor,
                                                  border: Border.all(
                                                      width: 1.0,
                                                      color: Theme.of(context)
                                                          .textTheme
                                                          .bodyText1!
                                                          .color!),
                                                  shape: BoxShape.rectangle,
                                                ),
                                                child: SvgPicture.asset(
                                                  "assets/images/minus.svg",
                                                  color: Theme.of(context)
                                                      .iconTheme
                                                      .color,
                                                ),
                                              )),
                                        ],
                                      ),
                                    ),
                                    viewModel.refreshing
                                        ? InsiteProgressBar()
                                        : SizedBox()
                                  ],
                                ),
                              )
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
                              //         return FloatingActionButton(
                              //           onPressed: () {
                              //               _popupController.showPopupFor(markers[0]);
                              //               print("on ClusterTap ${markers.length}");
                              //             },
                              //           child:
                              //        Container(
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

                              //           ),
                              //         ));
                              //       },
                              //     ),
                              //     MarkerLayerOptions(
                              //         markers: allMarkers.sublist(
                              //             0, min(allMarkers.length, _sliderVal))),
                              //  ],
                              //  ),
                              ),
                        ),
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
              )),
        );
      },
      viewModelBuilder: () => viewModel,
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

  getAssetLocationHomeData() async {
    await viewModel.getAssetLocationHome();
  }

  getAssetLocationHomeFilterData(dropDownValue) async {
    await viewModel.getLocationFilterData(dropDownValue);
  }
}
