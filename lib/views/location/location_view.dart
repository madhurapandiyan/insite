import 'dart:async';
import 'dart:ui';
import 'package:clippy_flutter/triangle.dart';
import 'package:custom_info_window/custom_info_window.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_maps_cluster_manager/google_maps_cluster_manager.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:insite/core/models/asset_location.dart';
import 'package:insite/core/models/marker.dart';
import 'package:insite/theme/colors.dart';
import 'package:insite/utils/helper_methods.dart';
import 'package:insite/views/home/home_view.dart';
import 'package:insite/views/location/location_view_model.dart';
import 'package:insite/widgets/dumb_widgets/insite_button.dart';
import 'package:insite/views/date_range/date_range_view.dart';
import 'package:insite/widgets/smart_widgets/insite_scaffold.dart';
import 'package:logger/logger.dart';
import 'package:stacked/stacked.dart';

class LocationView extends StatefulWidget {
  @override
  _LocationViewState createState() => _LocationViewState();
}

class _LocationViewState extends State<LocationView> {
  String _currentSelectedItem = "MAP";

  double zoomVal = 5.0;
  Completer<GoogleMapController> _controller = Completer();
  MapType currentType = MapType.normal;

  List<DateTime> dateRange;

  GoogleMapController mapController;
  BitmapDescriptor mapMarker;

  Set<Marker> markers = Set();
  CustomInfoWindowController customInfoWindowController =
      CustomInfoWindowController();
  List<ClusterItem<InsiteMarker>> clusterMarkers = [];

  ClusterManager _manager;
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
    return ViewModelBuilder<LocationViewModel>.reactive(
      builder: (BuildContext context, LocationViewModel viewModel, Widget _) {
        if (viewModel.loading) {
          return InsiteScaffold(
              viewModel: viewModel,
              screenType: ScreenType.LOCATION,
              onFilterApplied: () {},
              body: Center(
                child: CircularProgressIndicator(),
              ));
        } else if (viewModel.assetLocation != null) {
          int index = 1;
          List<MapRecord> assetLocationList =
              viewModel.assetLocation.mapRecords;
          for (var assetLocation in assetLocationList) {
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
          return InsiteScaffold(
            viewModel: viewModel,
            screenType: ScreenType.LOCATION,
            body: Column(
              children: [
                Padding(
                  padding: EdgeInsets.all(16.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      GestureDetector(
                        onTap: () {
                          Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(
                                  builder: (BuildContext context) =>
                                      super.widget));
                        },
                        child: Container(
                          width: 90,
                          height: 30,
                          decoration: BoxDecoration(
                            color: tuna,
                            borderRadius: BorderRadius.all(
                              Radius.circular(4),
                            ),
                          ),
                          child: Center(
                            child: Text(
                              'Refresh',
                              style: TextStyle(
                                color: white,
                                fontSize: 12,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ),
                      ),
                      Text(
                        (dateRange == null || dateRange.isEmpty)
                            ? '${Utils.parseDate(DateTime.now().subtract(Duration(days: DateTime.now().weekday)))} - ${Utils.parseDate(DateTime.now())}'
                            : '${Utils.parseDate(dateRange.first)} - ${Utils.parseDate(dateRange.last)}',
                        style: TextStyle(
                            color: white,
                            fontWeight: FontWeight.bold,
                            fontSize: 15),
                      ),
                      GestureDetector(
                        onTap: () async {
                          dateRange = await showDialog(
                            context: context,
                            builder: (BuildContext context) => Dialog(
                                backgroundColor: transparent,
                                child: DateRangeView()),
                          );
                          setState(() {
                            dateRange = dateRange;
                            viewModel.startDate =
                                '${dateRange.first.month}/${dateRange.first.day}/${dateRange.first.year}';

                            viewModel.endDate =
                                '${dateRange.last.month}/${dateRange.last.day}/${dateRange.last.year}';
                            // viewModel.getAssetLocationHistoryResult();
                          });
                        },
                        child: Container(
                          width: 90,
                          height: 30,
                          decoration: BoxDecoration(
                            color: tuna,
                            borderRadius: BorderRadius.all(
                              Radius.circular(4),
                            ),
                          ),
                          child: Center(
                            child: Text(
                              'Date Range',
                              style: TextStyle(
                                color: white,
                                fontSize: 12,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Expanded(
                  child: Stack(
                    children: [
                      GoogleMap(
                        onCameraMove: (position) {
                          customInfoWindowController.onCameraMove();
                          _manager.onCameraMove(position);
                        },
                        onMapCreated: (GoogleMapController controller) async {
                          customInfoWindowController.googleMapController =
                              controller;
                          _controller.complete(controller);
                          _manager.setMapController(controller);
                        },
                        onCameraIdle: _manager.updateMap,
                        mapType: _changemap(),
                        compassEnabled: true,
                        zoomControlsEnabled: false,
                        markers: markers,
                        initialCameraPosition: CameraPosition(
                            target: LatLng(
                                viewModel.assetLocation.mapRecords.first
                                    .lastReportedLocationLatitude,
                                viewModel.assetLocation.mapRecords.first
                                    .lastReportedLocationLongitude),
                            zoom: 5),
                      ),
                      CustomInfoWindow(
                        controller: customInfoWindowController,
                        width: MediaQuery.of(context).size.width*0.42,
                        height:MediaQuery.of(context).size.height*0.35,
                        offset: 1,
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
                                zoomVal++;
                                _plus(
                                  zoomVal,
                                  LatLng(
                                      viewModel.assetLocation.mapRecords.first
                                          .lastReportedLocationLatitude,
                                      viewModel.assetLocation.mapRecords.first
                                          .lastReportedLocationLongitude),
                                );
                              },
                              child: Container(
                                width: 27.47,
                                height: 26.97,
                                decoration: BoxDecoration(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(5.0)),
                                  boxShadow: [
                                    BoxShadow(
                                      blurRadius: 1.0,
                                      color: darkhighlight,
                                    ),
                                  ],
                                  border: Border.all(
                                      width: 1.0, color: darkhighlight),
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
                                  zoomVal--;
                                  _minus(
                                    zoomVal,
                                    LatLng(
                                        viewModel.assetLocation.mapRecords.first
                                            .lastReportedLocationLatitude,
                                        viewModel.assetLocation.mapRecords.first
                                            .lastReportedLocationLongitude),
                                  );
                                },
                                child: Container(
                                  width: 27.47,
                                  height: 26.97,
                                  decoration: BoxDecoration(
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(5.0)),
                                    boxShadow: [
                                      BoxShadow(
                                        blurRadius: 1.0,
                                        color: darkhighlight,
                                      ),
                                    ],
                                    border: Border.all(
                                        width: 1.0, color: darkhighlight),
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
              ],
            ),
          );
        } else {
          return Container();
        }
      },
      viewModelBuilder: () => LocationViewModel(TYPE.LOCATION),
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
                                  child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Image.asset(
                                        "assets/images/mapclose.png"),
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
              text: cluster.isMultiple ? cluster.count.toString() : null),
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
