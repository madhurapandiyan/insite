import 'dart:async';

import 'package:clippy_flutter/triangle.dart';
import 'package:custom_info_window/custom_info_window.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:insite/core/models/asset_location_history.dart';
import 'package:insite/theme/colors.dart';
import 'package:insite/views/detail/tabs/location/asset_location_view_model.dart';
import 'package:insite/widgets/smart_widgets/date_range.dart';
import 'package:logger/logger.dart';
import 'package:stacked/stacked.dart';

class AssetLocationView extends StatefulWidget {
  AssetLocationView({Key key}) : super(key: key);

  @override
  _AssetLocationViewState createState() => _AssetLocationViewState();
}

class _AssetLocationViewState extends State<AssetLocationView> {
  String _currentSelectedItem = "MAP";
  double zoomVal = 5.0;
  Completer<GoogleMapController> _controller = Completer();
  MapType currentType = MapType.normal;

  List<DateTime> dateRange;

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
    return ViewModelBuilder<AssetLocationViewModel>.reactive(
      builder:
          (BuildContext context, AssetLocationViewModel viewModel, Widget _) {
        if (viewModel.loading) {
          return Center(
            child: CircularProgressIndicator(),
          );
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

          return Container(
            child: Center(
              child: Container(
                margin: EdgeInsets.all(4.0),
                width: double.infinity,
                height: 510,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10.0),
                  boxShadow: [BoxShadow(blurRadius: 1.0, color: mediumgrey)],
                  border: Border.all(width: 2.5, color: cardcolor),
                  shape: BoxShape.rectangle,
                ),
                child: Column(
                  children: [
                    Padding(
                      padding: EdgeInsets.all(16.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          GestureDetector(
                            onTap: () {},
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
                                ? '${parseDate(DateTime.now().subtract(Duration(days: DateTime.now().weekday)))} - ${parseDate(DateTime.now())}'
                                : '${parseDate(dateRange.first)} - ${parseDate(dateRange.last)}',
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
                                    child: DateRangeWidget()),
                              );
                              setState(() {
                                dateRange = dateRange;
                                viewModel.startDate =
                                    '${dateRange.first.month}/${dateRange.first.day}/${dateRange.first.year}';

                                viewModel.endDate =
                                    '${dateRange.last.month}/${dateRange.last.day}/${dateRange.last.year}';
                                viewModel.getAssetLocationHistoryResult();
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
                            onTap: (position) {
                              _customInfoWindowController.hideInfoWindow();
                            },
                            onCameraMove: (position) {
                              _customInfoWindowController.onCameraMove();
                            },
                            onMapCreated:
                                (GoogleMapController controller) async {
                              _customInfoWindowController.googleMapController =
                                  controller;
                            },
                            mapType: _changemap(),
                            compassEnabled: true,
                            zoomControlsEnabled: false,
                            markers: _markers,
                            initialCameraPosition: CameraPosition(
                                target: LatLng(
                                    viewModel.assetLocationHistory
                                        .assetLocation[0].latitude,
                                    viewModel.assetLocationHistory
                                        .assetLocation[0].longitude),
                                zoom: 18),
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
                                      borderRadius: BorderRadius.all(
                                          Radius.circular(5.0)),
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
                                      print("button is tapped");
                                      zoomVal--;
                                      _minus(zoomVal);
                                    },
                                    child: Container(
                                      width: 27.47,
                                      height: 26.97,
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(5.0)),
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
              ),
            ),
          );
        }
      },
      viewModelBuilder: () => AssetLocationViewModel(),
    );
  }

  String parseDate(DateTime dateTime) {
    return '${dateTime.day}/${dateTime.month}/${dateTime.year}';
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
