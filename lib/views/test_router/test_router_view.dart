import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:insite/core/models/asset_location_history.dart';
import 'package:insite/theme/colors.dart';
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
  static const LatLng _center = const LatLng(11.5937, 78.9629);
  Completer<GoogleMapController> _controller = Completer();
  LatLng _lastMapPosition = _center;
  MapType currentType = MapType.normal;

  GoogleMapController mapController;

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
          return Center(
            child: CircularProgressIndicator(),
          );
        } else {
          // DUMMY VALUE
          AssetLocationHistory dummyModel = AssetLocationHistory.fromJson({
            "pagination": {"totalCount": 86, "pageNumber": 1, "pageSize": 25},
            "links": {
              "self":
                  "/AssetLocationHistory/64be6463-d8c1-11e7-80fc-065f15eda309/v2?startTimeLocal=2021-04-19T00:00:00&endTimeLocal=2021-04-21T23:59:59&lastReported=False&pageSize=25&pageNumber=1",
              "next":
                  "/AssetLocationHistory/64be6463-d8c1-11e7-80fc-065f15eda309/v2?startTimeLocal=2021-04-19T00:00:00&endTimeLocal=2021-04-21T23:59:59&lastReported=False&pageSize=25&pageNumber=2"
            },
            "assetLocation": [
              {
                "assetEventHistoryID": 19835865740,
                "assetIdentifier": "64be6463-d8c1-11e7-80fc-065f15eda309",
                "serialNumber": "THEWABD0KH0000004",
                "makeCode": "THC",
                "model": "SHINRAI - BX80",
                "locationEventUTC": "2021-04-21T17:02:00",
                "locationEventLocalTime": "2021-04-21T22:32:00",
                "locationEventLocalTimeZoneAbbrev": "IST",
                "latitude": 15.5190416,
                "longitude": 74.9364233,
                "address": {
                  "streetAddress": "Garag Road  (SH73)",
                  "city": "Dharwad Sub-District",
                  "state": "IN",
                  "county": "Dharwad",
                  "country": "India",
                  "zip": "580011"
                },
                "odometer": 2497.4,
                "hourmeter": 257.45
              },
              {
                "assetEventHistoryID": 19835849059,
                "assetIdentifier": "64be6463-d8c1-11e7-80fc-065f15eda309",
                "serialNumber": "THEWABD0KH0000004",
                "makeCode": "THC",
                "model": "SHINRAI - BX80",
                "locationEventUTC": "2021-04-21T16:01:00",
                "locationEventLocalTime": "2021-04-21T21:31:00",
                "locationEventLocalTimeZoneAbbrev": "IST",
                "latitude": 15.51931,
                "longitude": 74.936535,
                "address": {
                  "streetAddress": "Garag Road  (SH73)",
                  "city": "Dharwad Sub-District",
                  "state": "IN",
                  "county": "Dharwad",
                  "country": "India",
                  "zip": "580011"
                },
                "odometer": 2497.4,
                "hourmeter": 257.45
              },
              {
                "assetEventHistoryID": 19833885356,
                "assetIdentifier": "64be6463-d8c1-11e7-80fc-065f15eda309",
                "serialNumber": "THEWABD0KH0000004",
                "makeCode": "THC",
                "model": "SHINRAI - BX80",
                "locationEventUTC": "2021-04-21T15:00:00",
                "locationEventLocalTime": "2021-04-21T20:30:00",
                "locationEventLocalTimeZoneAbbrev": "IST",
                "latitude": 15.519465,
                "longitude": 74.936475,
                "address": {
                  "streetAddress": "Garag Road  (SH73)",
                  "city": "Dharwad Sub-District",
                  "state": "IN",
                  "county": "Dharwad",
                  "country": "India",
                  "zip": "580011"
                },
                "odometer": 2497.4,
                "hourmeter": 257.45
              },
              {
                "assetEventHistoryID": 19833860297,
                "assetIdentifier": "64be6463-d8c1-11e7-80fc-065f15eda309",
                "serialNumber": "THEWABD0KH0000004",
                "makeCode": "THC",
                "model": "SHINRAI - BX80",
                "locationEventUTC": "2021-04-21T14:00:00",
                "locationEventLocalTime": "2021-04-21T19:30:00",
                "locationEventLocalTimeZoneAbbrev": "IST",
                "latitude": 15.5191916,
                "longitude": 74.936235,
                "address": {
                  "streetAddress": "Garag Road  (SH73)",
                  "city": "Dharwad Sub-District",
                  "state": "IN",
                  "county": "Dharwad",
                  "country": "India",
                  "zip": "580011"
                },
                "odometer": 2497.4,
                "hourmeter": 257.45
              },
              {
                "assetEventHistoryID": 19831552427,
                "assetIdentifier": "64be6463-d8c1-11e7-80fc-065f15eda309",
                "serialNumber": "THEWABD0KH0000004",
                "makeCode": "THC",
                "model": "SHINRAI - BX80",
                "locationEventUTC": "2021-04-21T12:59:00",
                "locationEventLocalTime": "2021-04-21T18:29:00",
                "locationEventLocalTimeZoneAbbrev": "IST",
                "latitude": 15.519435,
                "longitude": 74.936825,
                "address": {
                  "streetAddress": "Garag Road  (SH73)",
                  "city": "Dharwad Sub-District",
                  "state": "IN",
                  "county": "Dharwad",
                  "country": "India",
                  "zip": "580011"
                },
                "odometer": 2497.4,
                "hourmeter": 257.45
              },
              {
                "assetEventHistoryID": 19831537609,
                "assetIdentifier": "64be6463-d8c1-11e7-80fc-065f15eda309",
                "serialNumber": "THEWABD0KH0000004",
                "makeCode": "THC",
                "model": "SHINRAI - BX80",
                "locationEventUTC": "2021-04-21T11:58:00",
                "locationEventLocalTime": "2021-04-21T17:28:00",
                "locationEventLocalTimeZoneAbbrev": "IST",
                "latitude": 15.519215,
                "longitude": 74.9363599,
                "address": {
                  "streetAddress": "Garag Road  (SH73)",
                  "city": "Dharwad Sub-District",
                  "state": "IN",
                  "county": "Dharwad",
                  "country": "India",
                  "zip": "580011"
                },
                "odometer": 2497.4,
                "hourmeter": 257.45
              },
              {
                "assetEventHistoryID": 19829409730,
                "assetIdentifier": "64be6463-d8c1-11e7-80fc-065f15eda309",
                "serialNumber": "THEWABD0KH0000004",
                "makeCode": "THC",
                "model": "SHINRAI - BX80",
                "locationEventUTC": "2021-04-21T10:57:00",
                "locationEventLocalTime": "2021-04-21T16:27:00",
                "locationEventLocalTimeZoneAbbrev": "IST",
                "latitude": 15.51927,
                "longitude": 74.936625,
                "address": {
                  "streetAddress": "Garag Road  (SH73)",
                  "city": "Dharwad Sub-District",
                  "state": "IN",
                  "county": "Dharwad",
                  "country": "India",
                  "zip": "580011"
                },
                "odometer": 2497.4,
                "hourmeter": 257.45
              },
              {
                "assetEventHistoryID": 19829395277,
                "assetIdentifier": "64be6463-d8c1-11e7-80fc-065f15eda309",
                "serialNumber": "THEWABD0KH0000004",
                "makeCode": "THC",
                "model": "SHINRAI - BX80",
                "locationEventUTC": "2021-04-21T09:56:00",
                "locationEventLocalTime": "2021-04-21T15:26:00",
                "locationEventLocalTimeZoneAbbrev": "IST",
                "latitude": 15.5194416,
                "longitude": 74.93666,
                "address": {
                  "streetAddress": "Garag Road  (SH73)",
                  "city": "Dharwad Sub-District",
                  "state": "IN",
                  "county": "Dharwad",
                  "country": "India",
                  "zip": "580011"
                },
                "odometer": 2497.4,
                "hourmeter": 257.45
              },
              {
                "assetEventHistoryID": 19828044136,
                "assetIdentifier": "64be6463-d8c1-11e7-80fc-065f15eda309",
                "serialNumber": "THEWABD0KH0000004",
                "makeCode": "THC",
                "model": "SHINRAI - BX80",
                "locationEventUTC": "2021-04-21T08:56:00",
                "locationEventLocalTime": "2021-04-21T14:26:00",
                "locationEventLocalTimeZoneAbbrev": "IST",
                "latitude": 15.5192816,
                "longitude": 74.9365783,
                "address": {
                  "streetAddress": "Garag Road  (SH73)",
                  "city": "Dharwad Sub-District",
                  "state": "IN",
                  "county": "Dharwad",
                  "country": "India",
                  "zip": "580011"
                },
                "odometer": 2497.4,
                "hourmeter": 257.45
              },
              {
                "assetEventHistoryID": 19828025516,
                "assetIdentifier": "64be6463-d8c1-11e7-80fc-065f15eda309",
                "serialNumber": "THEWABD0KH0000004",
                "makeCode": "THC",
                "model": "SHINRAI - BX80",
                "locationEventUTC": "2021-04-21T08:52:00",
                "locationEventLocalTime": "2021-04-21T14:22:00",
                "locationEventLocalTimeZoneAbbrev": "IST",
                "latitude": 15.5192816,
                "longitude": 74.9365783,
                "address": {
                  "streetAddress": "Garag Road  (SH73)",
                  "city": "Dharwad Sub-District",
                  "state": "IN",
                  "county": "Dharwad",
                  "country": "India",
                  "zip": "580011"
                },
                "assetStatus": "Asset Off",
                "hourmeter": 257.47
              },
              {
                "assetEventHistoryID": 19828020404,
                "assetIdentifier": "64be6463-d8c1-11e7-80fc-065f15eda309",
                "serialNumber": "THEWABD0KH0000004",
                "makeCode": "THC",
                "model": "SHINRAI - BX80",
                "locationEventUTC": "2021-04-21T08:51:00",
                "locationEventLocalTime": "2021-04-21T14:21:00",
                "locationEventLocalTimeZoneAbbrev": "IST",
                "latitude": 15.5192833,
                "longitude": 74.9365833,
                "address": {
                  "streetAddress": "Garag Road  (SH73)",
                  "city": "Dharwad Sub-District",
                  "state": "IN",
                  "county": "Dharwad",
                  "country": "India",
                  "zip": "580011"
                },
                "assetStatus": "Asset On",
                "hourmeter": 257.47
              },
              {
                "assetEventHistoryID": 19828002459,
                "assetIdentifier": "64be6463-d8c1-11e7-80fc-065f15eda309",
                "serialNumber": "THEWABD0KH0000004",
                "makeCode": "THC",
                "model": "SHINRAI - BX80",
                "locationEventUTC": "2021-04-21T08:30:00",
                "locationEventLocalTime": "2021-04-21T14:00:00",
                "locationEventLocalTimeZoneAbbrev": "IST",
                "latitude": 15.5192716,
                "longitude": 74.93647,
                "address": {
                  "streetAddress": "Garag Road  (SH73)",
                  "city": "Dharwad Sub-District",
                  "state": "IN",
                  "county": "Dharwad",
                  "country": "India",
                  "zip": "580011"
                },
                "odometer": 2497.3,
                "hourmeter": 257.4
              },
              {
                "assetEventHistoryID": 19827191768,
                "assetIdentifier": "64be6463-d8c1-11e7-80fc-065f15eda309",
                "serialNumber": "THEWABD0KH0000004",
                "makeCode": "THC",
                "model": "SHINRAI - BX80",
                "locationEventUTC": "2021-04-21T07:29:00",
                "locationEventLocalTime": "2021-04-21T12:59:00",
                "locationEventLocalTimeZoneAbbrev": "IST",
                "latitude": 15.519385,
                "longitude": 74.9362366,
                "address": {
                  "streetAddress": "Garag Road  (SH73)",
                  "city": "Dharwad Sub-District",
                  "state": "IN",
                  "county": "Dharwad",
                  "country": "India",
                  "zip": "580011"
                },
                "odometer": 2497.3,
                "hourmeter": 257.4
              },
              {
                "assetEventHistoryID": 19827179547,
                "assetIdentifier": "64be6463-d8c1-11e7-80fc-065f15eda309",
                "serialNumber": "THEWABD0KH0000004",
                "makeCode": "THC",
                "model": "SHINRAI - BX80",
                "locationEventUTC": "2021-04-21T06:29:00",
                "locationEventLocalTime": "2021-04-21T11:59:00",
                "locationEventLocalTimeZoneAbbrev": "IST",
                "latitude": 15.5193333,
                "longitude": 74.936095,
                "address": {
                  "streetAddress": "Garag Road  (SH73)",
                  "city": "Dharwad Sub-District",
                  "state": "IN",
                  "county": "Dharwad",
                  "country": "India",
                  "zip": "580011"
                },
                "odometer": 2497.3,
                "hourmeter": 257.4
              },
              {
                "assetEventHistoryID": 19825788446,
                "assetIdentifier": "64be6463-d8c1-11e7-80fc-065f15eda309",
                "serialNumber": "THEWABD0KH0000004",
                "makeCode": "THC",
                "model": "SHINRAI - BX80",
                "locationEventUTC": "2021-04-21T05:28:00",
                "locationEventLocalTime": "2021-04-21T10:58:00",
                "locationEventLocalTimeZoneAbbrev": "IST",
                "latitude": 15.5192233,
                "longitude": 74.9361583,
                "address": {
                  "streetAddress": "Garag Road  (SH73)",
                  "city": "Dharwad Sub-District",
                  "state": "IN",
                  "county": "Dharwad",
                  "country": "India",
                  "zip": "580011"
                },
                "odometer": 2497.3,
                "hourmeter": 257.4
              },
              {
                "assetEventHistoryID": 19825735509,
                "assetIdentifier": "64be6463-d8c1-11e7-80fc-065f15eda309",
                "serialNumber": "THEWABD0KH0000004",
                "makeCode": "THC",
                "model": "SHINRAI - BX80",
                "locationEventUTC": "2021-04-21T05:24:00",
                "locationEventLocalTime": "2021-04-21T10:54:00",
                "locationEventLocalTimeZoneAbbrev": "IST",
                "latitude": 15.5192233,
                "longitude": 74.9361583,
                "address": {
                  "streetAddress": "Garag Road  (SH73)",
                  "city": "Dharwad Sub-District",
                  "state": "IN",
                  "county": "Dharwad",
                  "country": "India",
                  "zip": "580011"
                },
                "assetStatus": "Asset On",
                "hourmeter": 257.37
              },
              {
                "assetEventHistoryID": 19825672275,
                "assetIdentifier": "64be6463-d8c1-11e7-80fc-065f15eda309",
                "serialNumber": "THEWABD0KH0000004",
                "makeCode": "THC",
                "model": "SHINRAI - BX80",
                "locationEventUTC": "2021-04-21T05:19:00",
                "locationEventLocalTime": "2021-04-21T10:49:00",
                "locationEventLocalTimeZoneAbbrev": "IST",
                "latitude": 15.5194016,
                "longitude": 74.9365583,
                "address": {
                  "streetAddress": "Garag Road  (SH73)",
                  "city": "Dharwad Sub-District",
                  "state": "IN",
                  "county": "Dharwad",
                  "country": "India",
                  "zip": "580011"
                },
                "odometer": 2497.3,
                "hourmeter": 257.36
              },
              {
                "assetEventHistoryID": 19825616506,
                "assetIdentifier": "64be6463-d8c1-11e7-80fc-065f15eda309",
                "serialNumber": "THEWABD0KH0000004",
                "makeCode": "THC",
                "model": "SHINRAI - BX80",
                "locationEventUTC": "2021-04-21T05:02:00",
                "locationEventLocalTime": "2021-04-21T10:32:00",
                "locationEventLocalTimeZoneAbbrev": "IST",
                "latitude": 15.519935,
                "longitude": 74.937885,
                "address": {
                  "streetAddress": "Garag Road  (SH73)",
                  "city": "Dharwad Sub-District",
                  "state": "IN",
                  "county": "Dharwad",
                  "country": "India",
                  "zip": "580011"
                },
                "odometer": 2497.1,
                "hourmeter": 257.29
              },
              {
                "assetEventHistoryID": 19824840381,
                "assetIdentifier": "64be6463-d8c1-11e7-80fc-065f15eda309",
                "serialNumber": "THEWABD0KH0000004",
                "makeCode": "THC",
                "model": "SHINRAI - BX80",
                "locationEventUTC": "2021-04-21T04:01:00",
                "locationEventLocalTime": "2021-04-21T09:31:00",
                "locationEventLocalTimeZoneAbbrev": "IST",
                "latitude": 15.5200933,
                "longitude": 74.9379866,
                "address": {
                  "streetAddress": "Garag Road  (SH73)",
                  "city": "Dharwad Sub-District",
                  "state": "IN",
                  "county": "Dharwad",
                  "country": "India",
                  "zip": "580011"
                },
                "odometer": 2497.0,
                "hourmeter": 257.29
              },
              {
                "assetEventHistoryID": 19824833179,
                "assetIdentifier": "64be6463-d8c1-11e7-80fc-065f15eda309",
                "serialNumber": "THEWABD0KH0000004",
                "makeCode": "THC",
                "model": "SHINRAI - BX80",
                "locationEventUTC": "2021-04-21T03:00:00",
                "locationEventLocalTime": "2021-04-21T08:30:00",
                "locationEventLocalTimeZoneAbbrev": "IST",
                "latitude": 15.52004,
                "longitude": 74.937925,
                "address": {
                  "streetAddress": "Garag Road  (SH73)",
                  "city": "Dharwad Sub-District",
                  "state": "IN",
                  "county": "Dharwad",
                  "country": "India",
                  "zip": "580011"
                },
                "odometer": 2497.0,
                "hourmeter": 257.29
              },
              {
                "assetEventHistoryID": 19824090938,
                "assetIdentifier": "64be6463-d8c1-11e7-80fc-065f15eda309",
                "serialNumber": "THEWABD0KH0000004",
                "makeCode": "THC",
                "model": "SHINRAI - BX80",
                "locationEventUTC": "2021-04-21T02:00:00",
                "locationEventLocalTime": "2021-04-21T07:30:00",
                "locationEventLocalTimeZoneAbbrev": "IST",
                "latitude": 15.5199233,
                "longitude": 74.9379983,
                "address": {
                  "streetAddress": "Garag Road  (SH73)",
                  "city": "Dharwad Sub-District",
                  "state": "IN",
                  "county": "Dharwad",
                  "country": "India",
                  "zip": "580011"
                },
                "odometer": 2497.0,
                "hourmeter": 257.29
              },
              {
                "assetEventHistoryID": 19824084354,
                "assetIdentifier": "64be6463-d8c1-11e7-80fc-065f15eda309",
                "serialNumber": "THEWABD0KH0000004",
                "makeCode": "THC",
                "model": "SHINRAI - BX80",
                "locationEventUTC": "2021-04-21T00:59:00",
                "locationEventLocalTime": "2021-04-21T06:29:00",
                "locationEventLocalTimeZoneAbbrev": "IST",
                "latitude": 15.5199783,
                "longitude": 74.9379083,
                "address": {
                  "streetAddress": "Garag Road  (SH73)",
                  "city": "Dharwad Sub-District",
                  "state": "IN",
                  "county": "Dharwad",
                  "country": "India",
                  "zip": "580011"
                },
                "odometer": 2497.0,
                "hourmeter": 257.29
              },
              {
                "assetEventHistoryID": 19823097827,
                "assetIdentifier": "64be6463-d8c1-11e7-80fc-065f15eda309",
                "serialNumber": "THEWABD0KH0000004",
                "makeCode": "THC",
                "model": "SHINRAI - BX80",
                "locationEventUTC": "2021-04-20T23:58:00",
                "locationEventLocalTime": "2021-04-21T05:28:00",
                "locationEventLocalTimeZoneAbbrev": "IST",
                "latitude": 15.5200733,
                "longitude": 74.9378866,
                "address": {
                  "streetAddress": "Garag Road  (SH73)",
                  "city": "Dharwad Sub-District",
                  "state": "IN",
                  "county": "Dharwad",
                  "country": "India",
                  "zip": "580011"
                },
                "odometer": 2497.0,
                "hourmeter": 257.29
              },
              {
                "assetEventHistoryID": 19823090234,
                "assetIdentifier": "64be6463-d8c1-11e7-80fc-065f15eda309",
                "serialNumber": "THEWABD0KH0000004",
                "makeCode": "THC",
                "model": "SHINRAI - BX80",
                "locationEventUTC": "2021-04-20T22:57:00",
                "locationEventLocalTime": "2021-04-21T04:27:00",
                "locationEventLocalTimeZoneAbbrev": "IST",
                "latitude": 15.51998,
                "longitude": 74.9378366,
                "address": {
                  "streetAddress": "Garag Road  (SH73)",
                  "city": "Dharwad Sub-District",
                  "state": "IN",
                  "county": "Dharwad",
                  "country": "India",
                  "zip": "580011"
                },
                "odometer": 2497.0,
                "hourmeter": 257.29
              },
              {
                "assetEventHistoryID": 19821862569,
                "assetIdentifier": "64be6463-d8c1-11e7-80fc-065f15eda309",
                "serialNumber": "THEWABD0KH0000004",
                "makeCode": "THC",
                "model": "SHINRAI - BX80",
                "locationEventUTC": "2021-04-20T21:56:00",
                "locationEventLocalTime": "2021-04-21T03:26:00",
                "locationEventLocalTimeZoneAbbrev": "IST",
                "latitude": 15.5200233,
                "longitude": 74.937865,
                "address": {
                  "streetAddress": "Garag Road  (SH73)",
                  "city": "Dharwad Sub-District",
                  "state": "IN",
                  "county": "Dharwad",
                  "country": "India",
                  "zip": "580011"
                },
                "odometer": 2497.0,
                "hourmeter": 257.29
              }
            ]
          });
          // DUMMY VALUE
          int index = 1;
          List<AssetLocation> assetLocationList =
              viewModel.assetLocationHistory.assetLocation;
          for (var assetLocation in assetLocationList) {
            print(
                'LATLNG: ${assetLocation.latitude}, ${assetLocation.longitude}');
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
                // height: 305.44,
                height: 705.44,
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

  _oncameramove(CameraPosition position) {
    _lastMapPosition = position.target;
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
