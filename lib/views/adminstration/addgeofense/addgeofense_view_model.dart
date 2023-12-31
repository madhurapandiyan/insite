import 'dart:async';
import 'dart:ui';
import 'package:custom_info_window/custom_info_window.dart';
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart' as flutter_map;
import 'package:geobase/geobase.dart' as geobase;
import 'package:geodesy/geodesy.dart' as geodesy;
import 'package:google_maps_cluster_manager/google_maps_cluster_manager.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:insite/core/models/geofence_title_name.dart';
import 'package:insite/core/models/marker.dart';
import 'package:insite/utils/helper_methods.dart';
import 'package:latlong2/latlong.dart' as latlng;
import 'package:geocore/geocore.dart' as Geo;
import 'package:insite/core/base/insite_view_model.dart';
import 'package:insite/core/locator.dart';
import 'package:insite/core/models/asset_location.dart';
import 'package:insite/core/services/geofence_service.dart';
import 'package:insite/theme/colors.dart';
import 'package:insite/views/adminstration/addgeofense/exception_handle.dart';
import 'package:insite/views/adminstration/addgeofense/model/addgeofencemodel.dart';
import 'package:insite/views/adminstration/addgeofense/model/geofencemodel.dart';
import 'package:insite/views/adminstration/addgeofense/model/geofencepayload.dart';
import 'package:insite/views/adminstration/addgeofense/model/materialmodel.dart';
import 'package:insite/views/adminstration/addgeofense/model/materialmodel.dart'
    as m;
import 'package:insite/views/adminstration/manage_geofence/manage_geofence_view.dart';
import 'package:load/load.dart';
import 'package:logger/logger.dart';
import 'package:insite/core/logger.dart';

import 'package:stacked_services/stacked_services.dart';

import '../../../core/services/graphql_schemas_service.dart';

class AddgeofenseViewModel extends InsiteViewModel {
  final Geofenceservice? _geofenceService = locator<Geofenceservice>();
  NavigationService? _navigationService = locator<NavigationService>();
  GraphqlSchemaService? graphqlSchemaService = locator<GraphqlSchemaService>();
  Logger? log;

  AddgeofenseViewModel() {
    _geofenceService!.setUp();
    getUserPreference();
    this.log = getLogger(this.runtimeType.toString());

    _geofenceService!.setUp();
    isVisionlinkCheck = isVisionLink;
    if (isVisionlinkCheck!) {
      getMaterialData();
    }
  }
  double zoomValue = 1;
  CustomInfoWindowController _customInfoWindowController =
      CustomInfoWindowController();
  CustomInfoWindowController get customInfoWindowController =>
      _customInfoWindowController;
  Set<Marker> markers = Set();
  List<LatLng> latlngs = [];

  Geofencepayload? geofenceRequestPayload;

  bool isTitleExist = false;

  String? dropDownValue = "S/N";

  late Addgeofencemodel addGeofencePayLoad;

  late GeofenceModelWithMaterialData geofenceWithMaterialData;

  MapRecord? _assetLocation;
  MapRecord? get assetLocation => _assetLocation;

  String? finalPolygonWKTstring;
  Set<Circle>? _circle = {};
  Set<Circle>? get circle => _circle;

  Set<Polygon>? _polygon = {};
  Set<Polygon>? get polygon => _polygon;

  Set<Polyline>? _polyline = {};
  Set<Polyline>? get polyline => _polyline;

  List<LatLng> _listOfLatLong = [];
  List<LatLng> get listOfLatLong => _listOfLatLong;

  List<geodesy.LatLng> _listOfLatLongGeodesic = [];

  List<LatLng?> correctedListofLatlang = [];
  List<geodesy.LatLng> correctedListofLatlangGeodesy = [];

  bool? isVisionlinkCheck;

  bool isDrawingPolygon = false;

  bool isPolygonsCreated = true;

  bool isLoading = true;

  bool isSearching = false;

  bool isNoendDate = false;
  bool _allowAccessToSecurity = false;
  bool get allowAccessToSecurity => _allowAccessToSecurity;

  Color color = tango;

  int? colorValue;

  Materialmodel? _materialData;
  Materialmodel? get materialData => _materialData;

  List<List<num>> listOfNumber = [];

  double? onZoomLatitude;
  double? onZoomLongitude;
  double? lastLattitude = 0.0;

  List<m.Material> materialModelList = [];
  DateTime? backFillDate;
  String? endingDate;
  DateTime actionUTC = DateTime.now();
  //String geofenceType = "Generic";
  String? materialUID;
  String fetchedGeofenceName = "null";
  String? fetchedGeofenceUid;
  String? titleText;
  String? descriptionText;
  String? targetText;
  String? fetchedGeofenceType;
  String? initialValue = "Generic";
  var titleController = TextEditingController();
  var descriptionController = TextEditingController();
  var targetController = TextEditingController();
  var titleFocus = FocusNode();
  var descriptionFocus = FocusNode();
  var targetFocus = FocusNode();

  List<String> dropDownlist = [
    "Generic",
    "AvoidanceZone",
    "CutZone",
    "Borrow",
    "stockpile",
    "FillZone",
    "Waste",
    "Landfill"
  ];

  String? initialName = "select";
  String initialMapType = "HYBRID";
  List<String> mapType = ['MAP', 'TERRAIN', 'SATELLITE', 'HYBRID'];

  Completer<GoogleMapController> googleMapController = Completer();
  CameraPosition centerPosition =
      CameraPosition(target: LatLng(30.666, 76.8127), zoom: 1);

  LatLng? lastLatLong;

//navigation
  onRespectivePageNavigation() {
    _navigationService!.navigateToView(ManageGeofenceView());
  }

  onDropDownValue(String? value) {
    dropDownValue = value;
    notifyListeners();
  }

//datepick
  onBackFillDatePicked(DateTime value) {
    backFillDate = value;
    notifyListeners();
  }

  onEndDatePicked(DateTime value) {
    endingDate = Utils.getDateFormatForDatePicker(value.toString(), userPref);

    notifyListeners();
  }

//zoom functions
  Future<void> plus(double zoomVal) async {
    final controller = await googleMapController.future;
    controller.animateCamera(CameraUpdate.newCameraPosition(CameraPosition(
        target: LatLng(onZoomLatitude ?? 30.666, onZoomLongitude ?? 76.8127),
        zoom: zoomVal)));
    notifyListeners();
  }

  Future<void> minus(double zoomVal) async {
    final GoogleMapController controller = await googleMapController.future;
    controller.animateCamera(CameraUpdate.newCameraPosition(CameraPosition(
        target: LatLng(onZoomLatitude == null ? 30.666 : onZoomLatitude!,
            onZoomLongitude == null ? 76.8127 : onZoomLongitude!),
        zoom: zoomVal)));
    notifyListeners();
  }

//choosing Color
  onColorPicked(Color value) {
    color = value;
    onChangePolygonColor();
    notifyListeners();
  }

  onChangePolygonColor() {
    if (_listOfLatLong.isNotEmpty) {
      Logger().w(color.red);
      _polygon!.clear();
      _polyline!.clear();
      _circle!.clear();
      Polyline userPolyline;
      Polygon userPolygon;
      LatLng lastLatLng = _listOfLatLong.first;
      _listOfLatLong.add(lastLatLng);
      Logger().wtf(_listOfLatLong);
      for (var i = 0; i < _listOfLatLong.length; i++) {
        userPolyline = Polyline(
          jointType: JointType.round,
          endCap: Cap.roundCap,
          startCap: Cap.buttCap,
          width: 3,
          points: _listOfLatLong,
          polylineId: PolylineId(DateTime.now().toString()),
          consumeTapEvents: true,
          color: color,
          visible: true,
        );

        userPolygon = Polygon(
            strokeColor: color.withOpacity(0.2),
            geodesic: true,
            strokeWidth: 3,
            polygonId: PolygonId(DateTime.now().toString()),
            fillColor: color.withOpacity(0.2),
            visible: true,
            points: _listOfLatLong);
        _polygon!.add(userPolygon);
        _polyline!.add(userPolyline);
      }

      notifyListeners();
    }
  }

  onChoosingColor() {
    try {
      String colorString = color.toString();
      late String colorValueString;
      if (colorString.contains("Color(0xff") && colorString.contains(")")) {
        colorValueString = colorString.replaceAll("Color(0xff", "");
        colorValueString = colorValueString.replaceAll(")", "");
        //colorValue = int.parse(colorValueString);
      }
      colorValue = int.parse(colorValueString, radix: 16);
      notifyListeners();
    } catch (e) {
      Logger().e(e.toString());
    }
  }

  onLocationSelected(MapRecord? data) async {
    try {
      // double parsedLatitude = double.parse(locationLatitude);
      // double parsedLongitude = double.parse(locationLongitude);
      // onZoomLatitude = parsedLatitude;
      // onZoomLongitude = parsedLongitude;
      _customInfoWindowController.hideInfoWindow!();
      LatLng pickedLatLong = LatLng(data!.lastReportedLocationLatitude!,
          data.lastReportedLocationLatitude!);
      centerPosition = CameraPosition(target: pickedLatLong, zoom: 10);
      var contro = await googleMapController.future;
      contro.animateCamera(CameraUpdate.newCameraPosition(centerPosition));
      _assetLocation = data;
      markers.clear();
      markers.add(Marker(
        markerId: MarkerId(DateTime.now().toString()),
        icon: await _getMarkerBitmap(125, text: "1"),
        position: pickedLatLong,
        onTap: () {
          _customInfoWindowController.addInfoWindow!(
              Container(
                color: white,
                width: 100,
                height: 50,
                child: Center(child: Text(_assetLocation!.assetSerialNumber!)),
              ),
              pickedLatLong);
        },
      ));
      notifyListeners();
    } catch (e) {
      Logger().e(e.toString());
    }
  }

  onLocationSearchedSerialNo(LatLng pos) async {
    try {
      // double parsedLatitude = double.parse(locationLatitude);
      // double parsedLongitude = double.parse(locationLongitude);
      // onZoomLatitude = parsedLatitude;
      // onZoomLongitude = parsedLongitude;
      markers.clear();
      _customInfoWindowController.hideInfoWindow!();
      LatLng pickedLatLong = pos;
      centerPosition = CameraPosition(target: pickedLatLong, zoom: 10);
      var contro = await googleMapController.future;
      contro.animateCamera(CameraUpdate.newCameraPosition(centerPosition));
      notifyListeners();
    } catch (e) {
      Logger().e(e.toString());
    }
  }

  onLocationSearchApply() {
    isSearching = !isSearching;
    notifyListeners();
  }

  onDropDownValueChanged(String value) {
    initialValue = value;
    Logger().w(initialValue);
    notifyListeners();
  }

  onCheckBoxChecked() {
    isNoendDate = !isNoendDate;
    endingDate = null;
    backFillDate = null;
    notifyListeners();
  }

  onDropDownMapTypeChange(String value) {
    initialMapType = value;
    notifyListeners();
  }

  onEditButtonClicked() {
    isDrawingPolygon = !isDrawingPolygon;
    _polygon!.clear();
    _polyline!.clear();
    _circle!.clear();
    _listOfLatLong.clear();
    notifyListeners();
  }

  onSearching() {
    isSearching = !isSearching;
    notifyListeners();
  }

  onGettingLatLang(LatLng userLatlong) {
    geodesy.Geodesy geodesic = geodesy.Geodesy();
    Logger().wtf(userLatlong);
    Polyline userPolyline;
    Polygon userPolygon;
    Circle userCircle;
    double latitude1 = userLatlong.longitude;
    double longitude1 = userLatlong.latitude;
    Logger().wtf("$longitude1 longitude");
    Logger().wtf("$latitude1 latitude");
    LatLng correctedLatLong = LatLng(longitude1, latitude1);
    Logger().v(correctedLatLong.toJson());
    geodesy.LatLng correctedLatLongGeodesy =
        geodesy.LatLng(longitude1, latitude1);
    // polyUtils.LatLng correctedLatLongpolyUtils =
    //  polyUtils.LatLng(latitude1, longitude1);
    // point.Point polypoints =
    //     point.Point(x: userLatlong.longitude, y: userLatlong.latitude);
    lastLatLong = correctedLatLong;
    _listOfLatLong.add(userLatlong);
    correctedListofLatlang.add(correctedLatLong);
    // if (correctedListofLatlang.length >= 3) {
    //   Logger().e(correctedListofLatlangGeodesy.length);
    //   var checking = geodesic.isGeoPointInPolygon(
    //       correctedLatLongGeodesy, correctedListofLatlangGeodesy);
    //   Logger().e(checking);
    //   if (checking) {
    //     correctedListofLatlangGeodesy.add(correctedLatLongGeodesy);
    //   }
    // } else {
    //   correctedListofLatlangGeodesy.add(correctedLatLongGeodesy);
    // }

    // if (correctedListofLatlangGeodesy.length >= 3) {
    //   var containsLocation = polyUtils.PolygonUtil.isLocationOnEdge(point, polygon, geodesic);
    //   Logger().e(containsLocation);
    //  // Logger().w(polypoints.y);
    //  // var isPolygon = point.Poly.isPointInPolygon(polypoints, points);
    //   if (containsLocation) {
    //     lastLatLong = correctedLatLong;
    //     _listOfLatLong.add(userLatlong);
    //     correctedListofLatlang.add(correctedLatLong);
    //     correctedListofLatlangGeodesy.add(correctedLatLongGeodesy);
    //     points.add(polypoints);
    //   } else {
    //     Fluttertoast.showToast(msg: "no");
    //     return;
    //   }
    // } else {

    //   correctedListofLatlangGeodesy.add(correctedLatLongGeodesy);
    //   correctedListofLatlangGeodesyPoly.add(correctedLatLongpolyUtils);
    //   points.add(polypoints);
    // }

    // if (correctedListofLatlangGeodesy.length >= 3) {
    //   correctedListofLatlangGeodesy.add(correctedLatLongGeodesy);
    //   var isGeoPointInPolygon = geodesic.isGeoPointInPolygon(
    //       correctedLatLongGeodesy, correctedListofLatlangGeodesy);
    //   if (isGeoPointInPolygon) {
    //     Fluttertoast.showToast(msg: "no");
    //     Logger().e("point is not in polygon");
    //     return;
    //   } else {
    //     Logger().v("point is in polygon");
    //     _listOfLatLong.add(userLatlong);
    //     correctedListofLatlang.add(correctedLatLong);
    //     correctedListofLatlangGeodesy.add(correctedLatLongGeodesy);
    //   }
    // } else {
    //   _listOfLatLong.add(userLatlong);
    //   correctedListofLatlang.add(correctedLatLong);
    //   correctedListofLatlangGeodesy.add(correctedLatLongGeodesy);
    // }

    // if (latitude1 < latLngIntersection.longitude &&
    //     longitude1 < latLngIntersection.latitude) {
    //   Fluttertoast.showToast(msg: "polygons can't be intersect");
    //   correctedListofLatlang.removeAt(correctedListofLatlang.length-1);
    //   return;
    // }

// if (isGeoPointInPolygon) {
    //   Logger().e(correctedLatLongGeodesy.toJson());
    //   correctedListofLatlangGeodesy.removeLast();
    //   _listOfLatLong.removeLast();
    //   Logger().i(correctedListofLatlangGeodesy);
    //   Fluttertoast.showToast(msg: "please draw the valid polygon");
    //   return;
    // } else {}

    onZoomLatitude = userLatlong.latitude;
    onZoomLongitude = userLatlong.longitude;

    userPolyline = Polyline(
      geodesic: true,
      jointType: JointType.round,
      endCap: Cap.roundCap,
      startCap: Cap.buttCap,
      width: 3,
      points: _listOfLatLong,
      polylineId: PolylineId(DateTime.now().toString()),
      consumeTapEvents: true,
      color: color.withOpacity(0.2),
      visible: true,
    );
    userPolygon = Polygon(
        strokeColor: color,
        geodesic: true,
        strokeWidth: 3,
        polygonId: PolygonId(DateTime.now().toString()),
        fillColor: color.withOpacity(0.2),
        visible: true,
        points: _listOfLatLong);
    userCircle = Circle(
        radius: 20000,
        strokeWidth: 5,
        strokeColor: color,
        visible: true,
        circleId: CircleId(DateTime.now().toString()),
        center: userLatlong,
        fillColor: Colors.transparent);
    _polygon!.add(userPolygon);
    _polyline!.add(userPolyline);
    _circle!.add(userCircle);
    //colorValue = int.parse(color.toString());
    isPolygonsCreated = false;

    notifyListeners();
  }

  getMaterialData() async {
    try {
      _materialData = await _geofenceService!.getMaterialModelData();
      for (var i = 0; i < _materialData!.materials!.length; i++) {
        m.Material extractedMaterial = _materialData!.materials![i];
        materialModelList.add(extractedMaterial);
      }

      Logger().e(materialModelList.length);
    } on DioError catch (e) {
      Logger().e(e);
      final val = DioException.fromDioError(e);
      Logger().e(val.message);
      snackbarService!.showSnackbar(message: val.message!);
    }
    notifyListeners();
  }

  materialSelection(String value) {
    Logger().i("query typeed " + value);
    for (var i = 0; i < _materialData!.materials!.length; i++) {
      m.Material extractedMaterial = _materialData!.materials![i];
      materialModelList.add(extractedMaterial);
    }
    Logger().e(materialModelList.length);
    Logger().d(materialModelList);
    if (value != null) {
      if (value.trim().isNotEmpty) {
        List<m.Material> tempList = [];
        tempList.clear();
        materialModelList.forEach((item) {
          if (item.name!.contains(value.toUpperCase())) tempList.add(item);
        });
        materialModelList = tempList;
        notifyListeners();
      } else {
        return materialModelList;
      }
    }
    notifyListeners();
  }

  convertingPolyOBJtoWKT() {
    try {
      var writer = geobase.WKT.geometry;
      var encoder = writer.encoder();
      listOfNumber.clear();
      lastLatLong = correctedListofLatlang.first;
      correctedListofLatlang.add(lastLatLong);
      List<geobase.Geographic> data = [];
      List<List<double>> pts = [];
      for (var i = 0; i < correctedListofLatlang.length; i++) {
        double latitude = correctedListofLatlang[i]!.latitude;
        double longitude = correctedListofLatlang[i]!.longitude;
        data.add(geobase.Geographic(lon: longitude, lat: latitude));
        List<double> json = [longitude, latitude];
        pts.add(json);
      }
      geobase.Polygon.build(pts).toText();
      Logger().i(pts);
      encoder.writer.polygon(pts, type: geobase.Coords.xy);
      finalPolygonWKTstring = encoder.toText();
      print(finalPolygonWKTstring);
      // listOfNumber.forEach((element) {
      //   element.forEach((values) {
      //     data.add(Geographic(lon: lon, lat: lat));
      //   });
      // });

      //   List<geo.Point2> listOfPoints = [];
      //   geo.PointSeries pointSeries;
      //   geo.LineString<geo.Point<num>> lineStringSeries;
      //   List<geo.LineString<geo.Point<num>>> listOfLineSeries = [];
      //   for (var i = 0; i < listOfNumber.length; i++) {
      //     geo.Point2 point = geo.Point2.geometry.newFrom(listOfNumber[i]);
      //     listOfPoints.add(point);
      //   }
      //   pointSeries = geo.PointSeries.make(listOfNumber, geo.Point2.geometry);
      //   lineStringSeries = geo.LineString(pointSeries);
      //   listOfLineSeries.add(lineStringSeries);
      //   String finalPolygonOBJ = "POLYGON((${lineStringSeries.toString()}))";
      //   if (finalPolygonOBJ.contains("((LineString<Point<num>>([Point2(")) {
      //     String polygonWKT1 = finalPolygonOBJ.replaceAll(
      //         "((LineString<Point<num>>([Point2(", "((");
      //     if (polygonWKT1.contains("), Point2(")) {
      //       String polygonWKT2 = polygonWKT1.replaceAll("), Point2(", ",");
      //       if (polygonWKT2.contains(", ")) {
      //         String polygonWKT3 = polygonWKT2.replaceAll(", ", " ");
      //         if (polygonWKT3.contains(")])")) {
      //           finalPolygonWKTstring = polygonWKT3.replaceAll(")])", "");
      //           print(finalPolygonWKTstring);
      //         }
      //       }
      //     }
      //   }
      //   correctedListofLatlang.clear();
      //   listOfNumber.clear();
      //   listOfLatLong.clear();
    } catch (e) {
      Logger().e(e.toString());
      throw e;
    }
    // Logger().d("parsing finished");
  }

  convertingOBJtoModel() {
    try {
      //String titleText = titleText;
      //String descriptionText = descriptionController.text;
      if (initialValue == dropDownlist[0] ||
          initialValue == dropDownlist[1] ||
          initialValue == dropDownlist[7]) {
        geofenceRequestPayload = Geofencepayload(
            GeofenceUID: fetchedGeofenceUid == null ? null : fetchedGeofenceUid,
            ActionUTC: DateTime.now().toIso8601String(),
            Description: descriptionController.text == null
                ? null
                : descriptionController.text,
            GeofenceName: titleController.text,
            EndDate: endingDate == null ? null : endingDate!,
            GeometryWKT: finalPolygonWKTstring,
            GeofenceType: initialValue,
            IsTransparent: false,
            FillColor: colorValue == null ? 658170 : colorValue);
      } else {
        geofenceRequestPayload = Geofencepayload(
            IsFavorite: false,
            GeofenceUID: fetchedGeofenceUid == null ? null : fetchedGeofenceUid,
            ActionUTC: DateTime.now().toIso8601String(),
            Description: descriptionController.text == null
                ? null
                : descriptionController.text,
            GeofenceName: titleController.text,
            EndDate: endingDate == null ? null : endingDate!,
            GeometryWKT: finalPolygonWKTstring,
            GeofenceType: initialValue,
            IsTransparent: false,
            FillColor: colorValue == null ? 658170 : colorValue);

        Backfill backfill = Backfill(
            BackfillDate:
                backFillDate == null ? null : backFillDate!.toIso8601String());

        TargetData target = TargetData(
            TargetVolumeInCuMeter: targetController.text.isEmpty
                ? null
                : double.parse(targetController.text));

        Materials material =
            Materials(MaterialUID: materialUID == null ? null : materialUID);
        Geofenceinputs geofenceinputs = Geofenceinputs(
            BackfillInput: backfill,
            GeofenceInput: geofenceRequestPayload,
            Material: material,
            TargetInput: target);
        addGeofencePayLoad = Addgeofencemodel(
            Inputs: [geofenceinputs], ValidationConstraint: null);

        geofenceWithMaterialData = GeofenceModelWithMaterialData(
            Input: geofenceinputs, GeofenceUID: fetchedGeofenceUid);
      }
    } catch (e) {
      Logger().e(e.toString());
    }
  }

  getGeofenceTitleData(String? value) async {
    GeofenceTitleName? result = await _geofenceService!.getGeofenceName(value);
    Logger().i(result!.getGeofenceName!.toJson());
    if (result.getGeofenceName!.geofenceNameExist != null) {
      isTitleExist = result.getGeofenceName!.geofenceNameExist!;
    }
    notifyListeners();
  }

  onSavingData() async {
    try {
      if (isPolygonsCreated) {
        snackbarService!.showSnackbar(message: "Geofence not drawn in map");
        return;
      }
      if (fetchedGeofenceUid == null) {
        if (_polygon!.length < 3) {
          snackbarService!
              .showSnackbar(message: "Please Draw a valid polygons");
          return;
        }
      }
      if (isTitleExist) {
        snackbarService!.showSnackbar(message: "Geofence name must be unique");
        return;
      }

      // if (titleController.text.isEmpty && descriptionController.text.isEmpty) {
      //   snackbarService.showSnackbar(
      //       message: "Please enter title and description to proceed");
      //   return;
      // }
      if (titleController.text.isEmpty) {
        snackbarService!.showSnackbar(message: "Please enter title to proceed");
        return;
      }
      // if (descriptionController.text.isEmpty) {
      //   snackbarService.showSnackbar(
      //       message: "Please enter description to proceed");
      //   return;
      // }
      if (endingDate == null && !isNoendDate) {
        snackbarService!.showSnackbar(
            message: "Please select an end date or select the check box");
        return;
      }
      showLoadingDialog();
      if (fetchedGeofenceUid == null) {
        await convertingPolyOBJtoWKT();
      }
      await convertingOBJtoModel();
      if (fetchedGeofenceUid == null) {
        if (initialValue == dropDownlist[0] ||
            initialValue == dropDownlist[1] ||
            initialValue == dropDownlist[7]) {
          var data = await _geofenceService!.postGeofenceData(
              geofenceRequestPayload,
              graphqlSchemaService!.addGeofencePayload(
                  actionUTC: DateTime.now().toIso8601String(),
                  description: descriptionController.text,
                  endDate: endingDate == null ? null : endingDate!,
                  geofenceName: titleController.text,
                  geometryWKT: finalPolygonWKTstring,
                  geofenceType: initialValue,
                  fillColor: 658170));
          _navigationService!.navigateToView(ManageGeofenceView());
          hideLoadingDialog();
        } else {
          var data = await _geofenceService!.postAddGeofenceData(
              addGeofencePayLoad,
              graphqlSchemaService!.addGeofencePayload(
                  actionUTC: DateTime.now().toIso8601String(),
                  description: descriptionController.text,
                  endDate: endingDate == null ? null : endingDate!,
                  geofenceName: titleController.text,
                  geometryWKT: finalPolygonWKTstring,
                  geofenceType: initialValue,
                  fillColor: 658170));
          _navigationService!.clearTillFirstAndShowView(ManageGeofenceView());
          hideLoadingDialog();
        }
      } else {
        Logger().i("put method");
        if (initialValue == dropDownlist[0] ||
            initialValue == dropDownlist[1] ||
            initialValue == dropDownlist[7]) {
          await _geofenceService!.putGeofenceData(
              geofenceRequestPayload!,
              graphqlSchemaService!.updateGeofencePayload(
                  actionUTC: DateTime.now().toIso8601String(),
                  description: descriptionController.text,
                  endDate: endingDate == null ? null : endingDate!,
                  geofenceName: titleController.text,
                  geometryWKT: finalPolygonWKTstring,
                  geofenceType: initialValue,
                  fillColor: 658170));
          _navigationService!.clearTillFirstAndShowView(ManageGeofenceView());
          hideLoadingDialog();
        } else {
          await _geofenceService!.putGeofenceDataWithMaterial(
              geofenceWithMaterialData,
              graphqlSchemaService!.updateGeofencePayload(
                  actionUTC: DateTime.now().toIso8601String(),
                  description: descriptionController.text,
                  endDate: endingDate == null ? null : endingDate!,
                  geofenceName: titleController.text,
                  geometryWKT: finalPolygonWKTstring,
                  geofenceType: initialValue,
                  fillColor: 658170));
          _navigationService!.clearTillFirstAndShowView(ManageGeofenceView());
          hideLoadingDialog();
        }
      }
      listOfLatLong.clear();
      correctedListofLatlang.clear();
      listOfNumber.clear();
      _polygon?.clear();
      _polyline?.clear();
      _circle?.clear();
    } catch (e) {
      hideLoadingDialog();
      if (e is DioException) {
        final val = DioException.fromDioError(e as DioError);
        snackbarService!.showSnackbar(message: val.message!);
        Logger().e(e.message);
      } else {
        Logger().e(e.toString());
        throw e;
      }
    }
  }

  onCancelButtonClicked() {
    polygon!.clear();
    polyline!.clear();
    circle!.clear();
    titleController.clear();
    targetController.clear();
    endingDate = null;
    backFillDate = null;
    initialValue = dropDownlist[0];
    notifyListeners();
  }

  onPolygonCleared() {
    onZoomLatitude = null;
    onZoomLongitude = null;
    isPolygonsCreated = true;
    finalPolygonWKTstring = null;
    listOfLatLong.clear();
    listOfNumber.clear();
    lastLatLong = null;
    listOfLatLong.clear();
    listOfNumber.clear();
    correctedListofLatlang = [];
    polygon!.clear();
    polyline!.clear();
    circle!.clear();
    listOfLatLong.clear();
    correctedListofLatlangGeodesy.clear();
    notifyListeners();
  }

  getGeofenceData(String? uid) async {
    fetchedGeofenceUid = uid;
    Geofencemodeldata data;
    GetAddgeofenceModel geofenceInputsData;
    try {
      if (fetchedGeofenceUid != null) {
        data = await _geofenceService!.getSingleGeofenceData(uid);
        fetchedGeofenceType = data.GeofenceType;
        if (data.GeofenceType == dropDownlist[2] ||
            data.GeofenceType == dropDownlist[3] ||
            data.GeofenceType == dropDownlist[4] ||
            data.GeofenceType == dropDownlist[5] ||
            data.GeofenceType == dropDownlist[6]) {
          geofenceInputsData = await _geofenceService!.getGeofenceInput(uid);
          targetController.text =
              geofenceInputsData.Result!.Target!.TargetVolumeInCuMeter == null
                  ? 0.0.toString()
                  : geofenceInputsData.Result!.Target!.TargetVolumeInCuMeter
                      .toString();
        }

        titleController.text = data.GeofenceName.toString();
        descriptionController.text = data.Description.toString();
        if (data.EndDate != null) {
          endingDate = data.EndDate;
          isNoendDate = false;
        }

        initialValue = data.GeofenceType == "Unknown"
            ? dropDownlist[4]
            : data.GeofenceType;
        finalPolygonWKTstring = data.GeometryWKT;
        await convertWKTtoPolygon();
        isLoading = false;
        notifyListeners();
        Logger().wtf(data.toJson());
        return data;
      }
      isLoading = false;
    } on DioError catch (e) {
      isLoading = false;
      Logger().e(e.toString());
      var error = DioException.fromDioError(e);
      snackbarService!.showSnackbar(message: error.message!);
    }
  }

  List<Geo.Polygon> fetchedPolygons = [];

  convertWKTtoPolygon() {
    try {
      double fetchedLatitude;
      double fetchedLongitude;
      List<LatLng> fetchedLatlng = [];
      Polygon fetchedSinglePolygon;
      Polyline fetchedSinglePolyline;
      // Logger().e(polygonString);
      final geometryPolygon =
          Geo.wktProjected.parse(finalPolygonWKTstring!) as Geo.Polygon;
      fetchedPolygons.add(geometryPolygon);
      final pointSeriesList = fetchedPolygons.first.exterior.chain;
      Logger().w(pointSeriesList);
      for (var item in pointSeriesList) {
        fetchedLatitude = item.y as double;
        fetchedLongitude = item.x as double;
        final LatLng latitudeLongitude =
            LatLng(fetchedLatitude, fetchedLongitude);
        fetchedLatlng.add(latitudeLongitude);
      }
      _listOfLatLong = fetchedLatlng;
      onZoomLatitude = _listOfLatLong.first.latitude;
      onZoomLongitude = _listOfLatLong.first.longitude;
      centerPosition = CameraPosition(
          target: LatLng(onZoomLatitude!, onZoomLongitude!), zoom: 5);

      fetchedSinglePolygon = Polygon(
          strokeColor: color,
          strokeWidth: 3,
          polygonId: PolygonId(DateTime.now().toString()),
          fillColor: color,
          visible: true,
          points: fetchedLatlng);
      fetchedSinglePolyline = Polyline(
          jointType: JointType.round,
          endCap: Cap.roundCap,
          startCap: Cap.buttCap,
          width: 3,
          polylineId: PolylineId(DateTime.now().toString()),
          consumeTapEvents: true,
          color: color,
          visible: true,
          points: fetchedLatlng);
      _polygon!.add(fetchedSinglePolygon);
      _polyline!.add(fetchedSinglePolyline);
      Logger().d(_polygon);
      Logger().d(fetchedSinglePolygon);
      isPolygonsCreated = false;
      notifyListeners();
//_polygon = fetchedPolygons.toSet() as Set<Polygon>;
    } catch (e) {
      Logger().e(e.toString());
    }
  }

  Future<BitmapDescriptor> _getMarkerBitmap(int size, {String? text}) async {
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
    final data = await img.toByteData(format: ImageByteFormat.png);

    return BitmapDescriptor.fromBytes(data!.buffer.asUint8List());
  }
}
