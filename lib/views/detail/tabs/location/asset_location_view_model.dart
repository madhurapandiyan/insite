import 'dart:io';
import 'package:clippy_flutter/triangle.dart';
import 'package:custom_info_window/custom_info_window.dart';
import 'package:insite/core/base/insite_view_model.dart';
import 'package:insite/core/locator.dart';
import 'package:insite/core/logger.dart';
import 'package:insite/core/models/asset_detail.dart';
import 'package:insite/core/models/health_list_response.dart';
import 'package:insite/core/services/asset_location_history_service.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:insite/core/models/asset_location_history.dart';
import 'package:insite/core/services/fault_service.dart';
import 'package:insite/theme/colors.dart';
import 'package:insite/utils/enums.dart';
import 'package:insite/utils/helper_methods.dart';
import 'package:insite/views/detail/tabs/location/single_location_info_view.dart';
import 'package:insite/widgets/dumb_widgets/insite_text.dart';
import 'package:logger/logger.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class AssetLocationViewModel extends InsiteViewModel {
  Logger log;

  var _assetLocationHistoryService = locator<AssetLocationHistoryService>();
  var _faultService = locator<FaultService>();

  AssetLocationHistory _assetLocationHistory;
  AssetLocationHistory get assetLocationHistory => _assetLocationHistory;
  CustomInfoWindowController customInfoWindowController =
      CustomInfoWindowController();

  HealthListResponse _healthListResponse;
  HealthListResponse get healthListResponse => _healthListResponse;

  bool _loading = true;
  bool get loading => _loading;

  bool _refreshing = false;
  bool get refreshing => _refreshing;

  Set<Marker> markers = Set();
  List<LatLng> latlngs = [];
  int index = 1;

  AssetDetail _assetDetail;
  AssetDetail get assetDetail => _assetDetail;

  ScreenType _pageType = ScreenType.LOCATION;
  ScreenType get pageType => _pageType;

  AssetLocationViewModel(detail, type) {
    this._assetDetail = detail;
    this._pageType = type;
    this.log = getLogger(this.runtimeType.toString());
    setUp();
    _assetLocationHistoryService.setUp();
    _faultService.setUp();
    customInfoWindowController = CustomInfoWindowController();
    Future.delayed(Duration(seconds: 1), () {
      if (_pageType == ScreenType.HEALTH) {
        getFaultAssetLocationHistoryResult();
      } else {
        getAssetLocationHistoryResult();
      }
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
              SingleInfoView(
                assetLocation: assetLocation,
              ),
              LatLng(assetLocation.latitude, assetLocation.longitude),
            );
          }));
    }
    print("markers length ${markers.length}");
  }

  getFaultAssetLocationHistoryResult() async {
    await getDateRangeFilterData();
    await getSelectedFilterData();
    HealthListResponse result = await _faultService.getAssetViewLocationSummary(
        assetDetail.assetUid,
        Utils.getDateInFormatyyyyMMddTHHmmssZStart(startDate),
        Utils.getDateInFormatyyyyMMddTHHmmssZEnd(endDate),
        null,
        5000,
        appliedFilters);
    if (result != null) {
      _healthListResponse = result;
      updateMarkersForFault();
    }
    _loading = false;
    notifyListeners();
  }

  refreshForAssetView() async {
    await getDateRangeFilterData();
    await getSelectedFilterData();
    markers.clear();
    latlngs.cast();
    _refreshing = true;
    notifyListeners();
    HealthListResponse result = await _faultService.getAssetViewLocationSummary(
        assetDetail.assetUid,
        Utils.getDateInFormatyyyyMMddTHHmmssZ(startDate),
        Utils.getDateInFormatyyyyMMddTHHmmssZ(endDate),
        null,
        2500,
        appliedFilters);
    if (result != null) {
      _healthListResponse = result;
      updateMarkersForFault();
    }
    _loading = false;
    _refreshing = false;
    notifyListeners();
  }

  updateMarkersForFault() {
    markers.clear();
    latlngs.clear();
    for (var assetLocation in _healthListResponse.assetData.faults) {
      if (assetLocation.lastReportedLocationLatitude != null &&
          assetLocation.lastReportedLocationLongitude != null) {
        latlngs.add(LatLng(assetLocation.lastReportedLocationLatitude,
            assetLocation.lastReportedLocationLongitude));
        markers.add(Marker(
            markerId: MarkerId('${index++}'),
            position: LatLng(assetLocation.lastReportedLocationLatitude,
                assetLocation.lastReportedLocationLongitude),
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
                                    assetLocation.lastReportedTimeUTC != null
                                        ? Utils.getLastReportedDateOne(
                                            assetLocation.lastReportedTimeUTC)
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
                                    assetLocation.lastReportedLocation != null
                                        ? assetLocation.lastReportedLocation
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
                                color: shark,
                              ),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    "Description :",
                                    style: TextStyle(
                                        fontWeight: FontWeight.w900,
                                        fontFamily: 'Roboto',
                                        color: textcolor,
                                        fontStyle: FontStyle.normal,
                                        fontSize: 10.0),
                                  ),
                                  Text(
                                    assetLocation.description != null
                                        ? assetLocation.description
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
                                color: shark,
                              ),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    "Fault Code :",
                                    style: TextStyle(
                                        fontWeight: FontWeight.w900,
                                        fontFamily: 'Roboto',
                                        color: textcolor,
                                        fontStyle: FontStyle.normal,
                                        fontSize: 10.0),
                                  ),
                                  Text(
                                    assetLocation.faultCode != null
                                        ? assetLocation.faultCode
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
                                color: shark,
                              ),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  InsiteText(
                                      text: "Source :",
                                      fontWeight: FontWeight.w900,
                                      size: 10.0),
                                  InsiteText(
                                      text: assetLocation.source != null
                                          ? assetLocation.source
                                          : "",
                                      size: 8.0),
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
                LatLng(assetLocation.lastReportedLocationLatitude,
                    assetLocation.lastReportedLocationLongitude),
              );
            }));
      }
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
