import 'dart:async';

import 'package:clippy_flutter/clippy_flutter.dart';
import 'package:custom_info_window/custom_info_window.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:insite/core/models/asset_location.dart';
import 'package:insite/theme/colors.dart';
import 'package:insite/utils/helper_methods.dart';
import 'package:insite/widgets/smart_widgets/date_range.dart';
import 'package:intl/intl.dart';
import 'package:logger/logger.dart';
import 'package:stacked/stacked.dart';
import 'location_view_model.dart';

class LocationView extends StatefulWidget {
  LocationView();

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
    return ViewModelBuilder<LocationViewModel>.reactive(
      builder: (BuildContext context, LocationViewModel viewModel, Widget _) {
        if (viewModel.loading) {
          return Scaffold(
              appBar: AppBar(),
              backgroundColor: bgcolor,
              body: Center(
                child: CircularProgressIndicator(),
              ));
        } else {
          int index = 1;
          List<MapRecord> assetLocationList =
              viewModel.assetLocation.mapRecords;

          for (var assetLocation in assetLocationList) {
            _markers.add(Marker(
                markerId: MarkerId('${index++}'),
                position: LatLng(assetLocation.lastReportedLocationLatitude,
                    assetLocation.lastReportedLocationLongitude),
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
                                Text(
                                  "${assetLocation.assetSerialNumber}",
                                  style: TextStyle(
                                      fontWeight: FontWeight.w900,
                                      fontFamily: 'Roboto',
                                      color: textcolor,
                                      fontStyle: FontStyle.normal,
                                      fontSize: 10.0),
                                ),
                                Text(
                                  "Make/Model",
                                  style: TextStyle(
                                      fontWeight: FontWeight.w900,
                                      fontFamily: 'Roboto',
                                      color: textcolor,
                                      fontStyle: FontStyle.normal,
                                      fontSize: 10.0),
                                ),
                                Text(
                                  "${assetLocation.model}",
                                  style: TextStyle(
                                      fontWeight: FontWeight.w900,
                                      fontFamily: 'Roboto',
                                      color: textcolor,
                                      fontStyle: FontStyle.normal,
                                      fontSize: 10.0),
                                ),
                                Text(
                                  "Asset Status",
                                  style: TextStyle(
                                      fontWeight: FontWeight.w900,
                                      fontFamily: 'Roboto',
                                      color: textcolor,
                                      fontStyle: FontStyle.normal,
                                      fontSize: 10.0),
                                ),
                                Text(
                                  "${assetLocation.status}",
                                  style: TextStyle(
                                      fontWeight: FontWeight.w900,
                                      fontFamily: 'Roboto',
                                      color: textcolor,
                                      fontStyle: FontStyle.normal,
                                      fontSize: 10.0),
                                ),
                                Text(
                                  "Geofence",
                                  style: TextStyle(
                                      fontWeight: FontWeight.w900,
                                      fontFamily: 'Roboto',
                                      color: textcolor,
                                      fontStyle: FontStyle.normal,
                                      fontSize: 10.0),
                                ),
                                Text(
                                  (assetLocation.geofences == null ||
                                          assetLocation.geofences.length == 0)
                                      ? ''
                                      : "${assetLocation.geofences}",
                                  style: TextStyle(
                                      fontWeight: FontWeight.w900,
                                      fontFamily: 'Roboto',
                                      color: textcolor,
                                      fontStyle: FontStyle.normal,
                                      fontSize: 10.0),
                                ),
                                Text(
                                  "Hours",
                                  style: TextStyle(
                                      fontWeight: FontWeight.w900,
                                      fontFamily: 'Roboto',
                                      color: textcolor,
                                      fontStyle: FontStyle.normal,
                                      fontSize: 10.0),
                                ),
                                Text(
                                  "${assetLocation.hourMeter} hrs",
                                  style: TextStyle(
                                      fontWeight: FontWeight.w900,
                                      fontFamily: 'Roboto',
                                      color: textcolor,
                                      fontStyle: FontStyle.normal,
                                      fontSize: 10.0),
                                ),
                                Text(
                                  "Last Reported Time",
                                  style: TextStyle(
                                      fontWeight: FontWeight.w900,
                                      fontFamily: 'Roboto',
                                      color: textcolor,
                                      fontStyle: FontStyle.normal,
                                      fontSize: 10.0),
                                ),
                                Text(
                                  assetLocation.lastReportedUtc == null
                                      ? ''
                                      : "${DateFormat('h:mma').format(assetLocation.lastReportedUtc)}",
                                  style: TextStyle(
                                      fontWeight: FontWeight.w900,
                                      fontFamily: 'Roboto',
                                      color: textcolor,
                                      fontStyle: FontStyle.normal,
                                      fontSize: 10.0),
                                ),
                                Text(
                                  "Fuel % remaining",
                                  style: TextStyle(
                                      fontWeight: FontWeight.w900,
                                      fontFamily: 'Roboto',
                                      color: textcolor,
                                      fontStyle: FontStyle.normal,
                                      fontSize: 10.0),
                                ),
                                Text(
                                  "${assetLocation.fuelLevelLastReported}%",
                                  style: TextStyle(
                                      fontWeight: FontWeight.w900,
                                      fontFamily: 'Roboto',
                                      color: textcolor,
                                      fontStyle: FontStyle.normal,
                                      fontSize: 10.0),
                                ),
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
                                  "${assetLocation.lastReportedLocation}",
                                  style: TextStyle(
                                      fontWeight: FontWeight.w900,
                                      fontFamily: 'Roboto',
                                      color: textcolor,
                                      fontStyle: FontStyle.normal,
                                      fontSize: 10.0),
                                ),
                              ],
                            ),
                          )),
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
                      LatLng(assetLocation.lastReportedLocationLatitude,
                          assetLocation.lastReportedLocationLongitude));
                }));
          }

          return Scaffold(
            appBar: AppBar(),
            backgroundColor: bgcolor,
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
                                child: DateRangeWidget()),
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
                        onTap: (position) {
                          _customInfoWindowController.hideInfoWindow();
                        },
                        onCameraMove: (position) {
                          _customInfoWindowController.onCameraMove();
                        },
                        onMapCreated: (GoogleMapController controller) async {
                          _customInfoWindowController.googleMapController =
                              controller;
                        },
                        mapType: _changemap(),
                        compassEnabled: true,
                        zoomControlsEnabled: false,
                        markers: _markers,
                        initialCameraPosition: CameraPosition(
                            target: LatLng(
                                viewModel.assetLocation.mapRecords[0]
                                    .lastReportedLocationLatitude,
                                viewModel.assetLocation.mapRecords[0]
                                    .lastReportedLocationLongitude),
                            zoom: 5),
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
                                  print("button is tapped");
                                  zoomVal--;
                                  _minus(zoomVal);
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
        }
      },
      viewModelBuilder: () => LocationViewModel(),
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
