import 'dart:io';
import 'package:clippy_flutter/triangle.dart';
import 'package:custom_info_window/custom_info_window.dart';
import 'package:insite/core/base/insite_view_model.dart';
import 'package:insite/core/locator.dart';
import 'package:insite/core/logger.dart';
import 'package:insite/core/models/asset_detail.dart';
import 'package:insite/core/services/asset_location_history_service.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:insite/core/models/asset_location_history.dart';
import 'package:insite/theme/colors.dart';
import 'package:logger/logger.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class AssetLocationViewModel extends InsiteViewModel {
  Logger log;

  var _assetLocationHistoryService = locator<AssetLocationHistoryService>();

  AssetLocationHistory _assetLocationHistory;
  AssetLocationHistory get assetLocationHistory => _assetLocationHistory;
  CustomInfoWindowController customInfoWindowController =
      CustomInfoWindowController();

  bool _loading = true;
  bool get loading => _loading;

  bool _refreshing = false;
  bool get refreshing => _refreshing;

  Set<Marker> markers = Set();
  List<LatLng> latlngs = [];
  int index = 1;

  AssetDetail _assetDetail;
  AssetDetail get assetDetail => _assetDetail;

  AssetLocationViewModel(detail) {
    this._assetDetail = detail;
    this.log = getLogger(this.runtimeType.toString());
    setUp();
    _assetLocationHistoryService.setUp();
    customInfoWindowController = CustomInfoWindowController();
    Future.delayed(Duration(seconds: 1), () {
      getAssetLocationHistoryResult();
    });
  }

  getAssetLocationHistoryResult() async {
    await getDateRangeFilterData();
    AssetLocationHistory result = await _assetLocationHistoryService
        .getAssetLocationHistory(startDate, endDate, assetDetail.assetUid);
    if (result != null) {
      _assetLocationHistory = result;
      updateMarkers();
    }
    _loading = false;
    notifyListeners();
  }

  refresh() async {
    await getDateRangeFilterData();
    markers.clear();
    latlngs.cast();
    _refreshing = true;
    notifyListeners();
    AssetLocationHistory result = await _assetLocationHistoryService
        .getAssetLocationHistory(startDate, endDate, assetDetail.assetUid);
    if (result != null) {
      _assetLocationHistory = result;
      updateMarkers();
    }
    _loading = false;
    _refreshing = false;
    notifyListeners();
  }

  updateMarkers() {
    markers.clear();
    latlngs.clear();
    for (var assetLocation in assetLocationHistory.assetLocation) {
      latlngs.add(LatLng(assetLocation.latitude, assetLocation.longitude));
      markers.add(Marker(
          markerId: MarkerId('${index++}'),
          position: LatLng(assetLocation.latitude, assetLocation.longitude),
          onTap: () {
            customInfoWindowController.addInfoWindow(
              Column(
                children: [
                  Expanded(
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(4),
                        color: tuna,
                      ),
                      padding: EdgeInsets.all(8),
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
                              crossAxisAlignment: CrossAxisAlignment.start,
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
                          SizedBox(
                            height: 10,
                          ),
                          Container(
                            decoration: BoxDecoration(
                              color: shark,
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
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
                                  assetLocation.address != null
                                      ? getAddressText(assetLocation.address)
                                      : "",
                                  style: TextStyle(
                                      fontFamily: 'Roboto',
                                      color: textcolor,
                                      fontStyle: FontStyle.normal,
                                      fontSize: 8.0),
                                ),
                              ],
                            ),
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.only(
                                  bottomLeft: Radius.circular(4),
                                  bottomRight: Radius.circular(4)),
                              color: tuna,
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
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
    print("markers length ${markers.length}");
  }
  // INFO WINDOW

  bool _showInfoWindow;
  bool _tempHidden;
  AssetLocation _assetLocation;
  double _leftMargin;
  double _topMargin;

  void rebuildInfoWindow() {
    notifyListeners();
  }

  String getAddressText(Address address) {
    print("getAddressText ${address.streetAddress}");
    String text = "";
    text = address.streetAddress != null
        ? address.streetAddress
        : "" + ',' + address.city != null
            ? address.city
            : "" + ',' + address.county != null
                ? address.county
                : "" + ',' + address.state != null
                    ? address.state
                    : "" + ' ' + address.zip != null
                        ? address.zip
                        : "";
    return text;
  }

  void updateLocation(AssetLocation location) {
    _assetLocation = location;
  }

  void updateVisibility(bool visibility) {
    _showInfoWindow = visibility;
  }

  void updateInfoWindow(BuildContext context, GoogleMapController mapController,
      LatLng location, double infoWindowWidth, double markerOffSet) async {
    ScreenCoordinate screenCoordinate =
        await mapController.getScreenCoordinate(location);
    double devicePixelRatio =
        Platform.isAndroid ? MediaQuery.of(context).devicePixelRatio : 1.0;
    double left = (screenCoordinate.x.toDouble() / devicePixelRatio) -
        (infoWindowWidth / 2);
    double top =
        (screenCoordinate.x.toDouble() / devicePixelRatio) - markerOffSet;

    if (left < 0 || top < 0)
      _tempHidden = true;
    else {
      _tempHidden = false;
      _leftMargin = left;
      _topMargin = top;
    }
  }

  bool get showInfoWindow =>
      (_showInfoWindow == true && _tempHidden == false) ? true : false;

  double get leftMargin => _leftMargin;
  double get topMargin => _topMargin;
  AssetLocation get assetLocation => _assetLocation;

  LatLngBounds getBound() {
    assert(latlngs.isNotEmpty);
    double x0, x1, y0, y1;
    for (LatLng latLng in latlngs) {
      if (x0 == null) {
        x0 = x1 = latLng.latitude;
        y0 = y1 = latLng.longitude;
      } else {
        if (latLng.latitude > x1) x1 = latLng.latitude;
        if (latLng.latitude < x0) x0 = latLng.latitude;
        if (latLng.longitude > y1) y1 = latLng.longitude;
        if (latLng.longitude < y0) y0 = latLng.longitude;
      }
    }
    return LatLngBounds(northeast: LatLng(x1, y1), southwest: LatLng(x0, y0));
  }
}
