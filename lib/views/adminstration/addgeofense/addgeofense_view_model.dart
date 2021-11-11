import 'dart:async';

import 'package:custom_info_window/custom_info_window.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import 'package:geocore/base.dart' as geo;
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

class AddgeofenseViewModel extends InsiteViewModel {
  final _geofenceService = locator<Geofenceservice>();
  var _navigationService = locator<NavigationService>();
  Logger log;

  AddgeofenseViewModel() {
    this.log = getLogger(this.runtimeType.toString());

    getMaterialData();
  }
  double zoomValue = 1;

  Geofencepayload geofenceRequestPayload;

  Addgeofencemodel addGeofencePayLoad;

  GeofenceModelWithMaterialData geofenceWithMaterialData;

  AssetLocationData _assetLocation;
  AssetLocationData get assetLocation => _assetLocation;

  String finalPolygonWKTstring;
  Set<Circle> _circle = {};
  Set<Circle> get circle => _circle;

  Set<Polygon> _polygon = {};
  Set<Polygon> get polygon => _polygon;

  Set<Polyline> _polyline = {};
  Set<Polyline> get polyline => _polyline;

  List<LatLng> _listOfLatLong = [];
  List<LatLng> get listOfLatLong => _listOfLatLong;

  List<LatLng> correctedListofLatlang = [];

  bool isDrawingPolygon = false;

  bool isPolygonsCreated = true;

  bool isLoading = true;

  bool isSearching = false;

  bool isNoendDate = false;
  bool _allowAccessToSecurity = false;
  bool get allowAccessToSecurity => _allowAccessToSecurity;

  Color color = tango;

  int colorValue;

  Materialmodel _materialData;
  Materialmodel get materialData => _materialData;

  List<List<num>> listOfNumber = [];

  double onZoomLatitude;
  double onZoomLongitude;

  List<m.Material> materialModelList = [];
  DateTime backFillDate;
  DateTime endingDate;
  DateTime actionUTC = DateTime.now();
  //String geofenceType = "Generic";
  String materialUID;
  String fetchedGeofenceName = "null";
  String fetchedGeofenceUid;
  String titleText;
  String descriptionText;
  String targetText;
  String fetchedGeofenceType;
  String initialValue = "Generic";
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

  String initialName = "select";
  String initialMapType = "MAP";
  List<String> mapType = ['MAP', 'TERRAIN', 'SATELLITE', 'HYBRID'];
  CustomInfoWindowController customInfoWindowController =
      CustomInfoWindowController();
  Completer<GoogleMapController> googleMapController = Completer();
  CameraPosition centerPosition =
      CameraPosition(target: LatLng(30.666, 76.8127), zoom: 1);

  LatLng lastLatLong;

//navigation
  onRespectivePageNavigation() {
    _navigationService.navigateToView(ManageGeofenceView());
  }

//datepick
  onBackFillDatePicked(DateTime value) {
    backFillDate = value;
    notifyListeners();
  }

  onEndDatePicked(DateTime value) {
    endingDate = value;
    notifyListeners();
  }

//zoom functions
  Future<void> plus(double zoomVal) async {
    final controller = await googleMapController.future;
    controller.animateCamera(CameraUpdate.newCameraPosition(CameraPosition(
        target: LatLng(onZoomLatitude == null ? 30.666 : onZoomLatitude,
            onZoomLongitude == null ? 76.8127 : onZoomLongitude),
        zoom: zoomVal)));
    notifyListeners();
  }

  Future<void> minus(double zoomVal) async {
    final GoogleMapController controller = await googleMapController.future;
    controller.animateCamera(CameraUpdate.newCameraPosition(CameraPosition(
        target: LatLng(onZoomLatitude == null ? 30.666 : onZoomLatitude,
            onZoomLongitude == null ? 76.8127 : onZoomLongitude),
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
    _polygon.clear();
    _polyline.clear();
    _circle.clear();
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
          //strokeColor: color,
          strokeWidth: 3,
          polygonId: PolygonId(DateTime.now().toString()),
          fillColor: color,
          visible: true,
          points: _listOfLatLong);
    }
    _polygon.add(userPolygon);
    _polyline.add(userPolyline);
    notifyListeners();
  }

  onChoosingColor() {
    String colorString = color.toString();
    Logger().d(colorString);
    Logger().i(colorString.contains("Color(0xff"));
    Logger().i(colorString.contains(")"));
    String colorValueString;
    if (colorString.contains("Color(0xff") && colorString.contains(")")) {
      colorValueString = colorString.replaceAll("Color(0xff", "");
      colorValueString = colorValueString.replaceAll(")", "");
      //colorValue = int.parse(colorValueString);
      Logger().e(colorValueString);
    }
    colorValue = int.parse(colorValueString, radix: 16);
    Logger().i(colorValue);
    notifyListeners();
  }

  onLocationSelected(String locationLatitude, String locationLongitude) {
    double parsedLatitude = double.parse(locationLatitude);
    double parsedLongitude = double.parse(locationLongitude);
    onZoomLatitude = parsedLatitude;
    onZoomLongitude = parsedLongitude;
    LatLng pickedLatLong = LatLng(parsedLatitude, parsedLongitude);
    centerPosition = CameraPosition(target: pickedLatLong, zoom: 10);
    notifyListeners();
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
    _polygon.clear();
    _polyline.clear();
    _circle.clear();
    _listOfLatLong.clear();
    notifyListeners();
  }

  onSearching() {
    isSearching = !isSearching;
    notifyListeners();
  }

  onGettingLatLang(LatLng userLatlong) {
    Logger().wtf(userLatlong);
    Polyline userPolyline;
    Polygon userPolygon;
    Circle userCircle;
    double latitude1 = userLatlong.longitude;
    double longitude1 = userLatlong.latitude;
    Logger().wtf(longitude1);
    Logger().wtf(latitude1);
    LatLng correctedLatLong = LatLng(longitude1, latitude1);
    lastLatLong = correctedLatLong;
    correctedListofLatlang.add(correctedLatLong);
    Logger().d(correctedListofLatlang);

    _listOfLatLong.add(userLatlong);
    onZoomLatitude = _listOfLatLong.first.latitude;
    onZoomLongitude = _listOfLatLong.first.longitude;

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
        strokeColor: color,
        strokeWidth: 3,
        polygonId: PolygonId(DateTime.now().toString()),
        fillColor: color,
        visible: true,
        points: _listOfLatLong);
    userCircle = Circle(
        radius: 200,
        strokeWidth: 5,
        strokeColor: black,
        visible: true,
        circleId: CircleId(DateTime.now().toString()),
        center: userLatlong,
        fillColor: Colors.white);
    _polygon.add(userPolygon);
    _polyline.add(userPolyline);
    _circle.add(userCircle);
    //colorValue = int.parse(color.toString());
    Logger().e(_circle);
    isPolygonsCreated = false;

    notifyListeners();
  }

  getMaterialData() async {
    try {
      _materialData = await _geofenceService.getMaterialModelData();
      for (var i = 0; i < _materialData.materials.length; i++) {
        m.Material extractedMaterial = _materialData.materials[i];
        materialModelList.add(extractedMaterial);
      }

      Logger().e(materialModelList.length);
    } catch (e) {
      Logger().e(e);
      final val = DioException.fromDioError(e);
      Logger().e(val.message);
      snackbarService.showSnackbar(message: val.message);
    }
    notifyListeners();
  }

  // checkBoxState() {
  //   isNoendDate = !isNoendDate;
  //   //Logger().e(setDefaultPreferenceToUser);
  //   notifyListeners();
  // }

  materialSelection(String value) {
    Logger().i("query typeed " + value);
    for (var i = 0; i < _materialData.materials.length; i++) {
      m.Material extractedMaterial = _materialData.materials[i];
      materialModelList.add(extractedMaterial);
    }
    Logger().e(materialModelList.length);
    Logger().d(materialModelList);
    if (value != null) {
      if (value.trim().isNotEmpty) {
        List<m.Material> tempList = [];
        tempList.clear();
        materialModelList.forEach((item) {
          if (item.name.contains(value.toUpperCase())) tempList.add(item);
        });
        materialModelList = tempList;
        notifyListeners();
      } else {
        return materialModelList;
      }
    }
    notifyListeners();
  }

  // selectedPolyLine(LatLng latlongdata) async {
  //   try {
  //     List<LatLng> newlistOfLatLong = [];
  //     newlistOfLatLong.add(latlongdata);
  //     Polyline newpolyline = Polyline(
  //         polylineId: PolylineId(DateTime.now().toString()),
  //         color: Colors.amber,
  //         visible: true,
  //         geodesic: true,
  //         consumeTapEvents: false,
  //         width: 12,
  //         points: newlistOfLatLong);

  //     Polygon newpolygon = Polygon(
  //         fillColor: Colors.blue,
  //         strokeColor: Colors.black,
  //         strokeWidth: 12,
  //         polygonId: PolygonId(DateTime.now().toString()),
  //         points: newlistOfLatLong);

  //     _polyline.add(newpolyline);

  //     _polygon.add(newpolygon);

  //     Logger().e(polygon);
  //   } catch (e) {
  //     Logger().e(e);
  //   }
  //   //Logger().e(latlongdata);
  // }

  convertingPolyOBJtoWKT() {
    Logger().d("running too many times");
    try {
      listOfNumber.clear();
      lastLatLong = correctedListofLatlang.first;
      correctedListofLatlang.add(lastLatLong);
      for (var i = 0; i < correctedListofLatlang.length; i++) {
        double latitude = correctedListofLatlang[i].latitude;
        double longitude = correctedListofLatlang[i].longitude;
        List<num> json = [longitude, latitude];
        Logger().d(json);
        listOfNumber.add(json);
      }
      List<geo.Point2> listOfPoints = [];
      geo.PointSeries pointSeries;
      geo.LineString<geo.Point<num>> lineStringSeries;
      List<geo.LineString<geo.Point<num>>> listOfLineSeries = [];
      for (var i = 0; i < listOfNumber.length; i++) {
        geo.Point2 point = geo.Point2.geometry.newFrom(listOfNumber[i]);
        listOfPoints.add(point);
      }
      pointSeries = geo.PointSeries.make(listOfNumber, geo.Point2.geometry);
      lineStringSeries = geo.LineString(pointSeries);
      listOfLineSeries.add(lineStringSeries);
      String finalPolygonOBJ = "POLYGON((${lineStringSeries.toString()}))";

      if (finalPolygonOBJ.contains("((LineString<Point<num>>([Point2(")) {
        String polygonWKT1 = finalPolygonOBJ.replaceAll(
            "((LineString<Point<num>>([Point2(", "((");

        if (polygonWKT1.contains("), Point2(")) {
          String polygonWKT2 = polygonWKT1.replaceAll("), Point2(", ",");
          if (polygonWKT2.contains(", ")) {
            String polygonWKT3 = polygonWKT2.replaceAll(", ", " ");
            if (polygonWKT3.contains(")])")) {
              finalPolygonWKTstring = polygonWKT3.replaceAll(")])", "");
              print(finalPolygonWKTstring);
            }
          }
        }
      }
      correctedListofLatlang.clear();
      listOfNumber.clear();
      listOfLatLong.clear();
    } catch (e) {
      Logger().e(e.toString());
    }
    Logger().d("parsing finished");
  }

  convertingOBJtoModel() {
    try {
      //String titleText = titleText;
      //String descriptionText = descriptionController.text;
      Logger().wtf(initialValue);
      Logger().e(endingDate);
      Logger().e(finalPolygonWKTstring);
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
            EndDate: endingDate == null ? null : endingDate.toIso8601String(),
            GeometryWKT: finalPolygonWKTstring,
            GeofenceType: initialValue,
            IsTransparent: false,
            FillColor: colorValue == null ? 658170 : colorValue);
      } else {
        geofenceRequestPayload = Geofencepayload(
            GeofenceUID: fetchedGeofenceUid == null ? null : fetchedGeofenceUid,
            ActionUTC: DateTime.now().toIso8601String(),
            Description: descriptionController.text == null
                ? null
                : descriptionController.text,
            GeofenceName: titleController.text,
            EndDate: endingDate == null ? null : endingDate.toIso8601String(),
            GeometryWKT: finalPolygonWKTstring,
            GeofenceType: initialValue,
            IsTransparent: false,
            FillColor: colorValue == null ? 658170 : colorValue);

        Backfill backfill = Backfill(
            BackfillDate:
                backFillDate == null ? null : backFillDate.toIso8601String());

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

  onSavingData() async {
    showLoadingDialog();
    try {
      if (fetchedGeofenceUid == null) {
        await convertingPolyOBJtoWKT();
      }
      await convertingOBJtoModel();
      if (fetchedGeofenceUid == null) {
        if (initialValue == dropDownlist[0] ||
            initialValue == dropDownlist[1] ||
            initialValue == dropDownlist[7]) {
          var data =
              await _geofenceService.postGeofenceData(geofenceRequestPayload);
          _navigationService.clearTillFirstAndShowView(ManageGeofenceView());
          hideLoadingDialog();
        } else {
          var data =
              await _geofenceService.postAddGeofenceData(addGeofencePayLoad);
          _navigationService.clearTillFirstAndShowView(ManageGeofenceView());
          hideLoadingDialog();
        }
      } else {
        Logger().i("put method");
        if (initialValue == dropDownlist[0] ||
            initialValue == dropDownlist[1] ||
            initialValue == dropDownlist[7]) {
          await _geofenceService.putGeofenceData(geofenceRequestPayload);
          _navigationService.clearTillFirstAndShowView(ManageGeofenceView());
          hideLoadingDialog();
        } else {
          await _geofenceService
              .putGeofenceDataWithMaterial(geofenceWithMaterialData);
          _navigationService.clearTillFirstAndShowView(ManageGeofenceView());
          hideLoadingDialog();
        }
      }

      // listOfLatLong.clear();
      // correctedListofLatlang.clear();
      // listOfNumber.clear();
      // _polygon.clear();
      // _polyline.clear();
      // _circle.clear();

    } on DioError catch (e) {
      hideLoadingDialog();
      final val = DioException.fromDioError(e);

      snackbarService.showSnackbar(message: val.message);
      Logger().e(e.message);
    }
    notifyListeners();
  }

  onCancelButtonClicked() {
    polygon.clear();
    polyline.clear();
    circle.clear();
    titleText = null;
    descriptionText = null;
    targetText = null;
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
    polygon.clear();
    polyline.clear();
    circle.clear();
    listOfLatLong.clear();
    notifyListeners();
  }

  Future<Geofencemodeldata> getGeofenceData(String uid) async {
    Logger().e("FUNCTION");
    fetchedGeofenceUid = uid;
    Geofencemodeldata data;
    GetAddgeofenceModel geofenceInputsData;
    try {
      if (fetchedGeofenceUid != null) {
        data = await _geofenceService.getSingleGeofenceData(uid);
        fetchedGeofenceType = data.GeofenceType;
        if (data.GeofenceType == dropDownlist[2] ||
            data.GeofenceType == dropDownlist[3] ||
            data.GeofenceType == dropDownlist[4] ||
            data.GeofenceType == dropDownlist[5] ||
            data.GeofenceType == dropDownlist[6]) {
          geofenceInputsData = await _geofenceService.getGeofenceInput(uid);
          Logger().wtf(geofenceInputsData.Result.toJson());
          Logger().d("mappiy");
          targetController.text =
              geofenceInputsData.Result.Target.TargetVolumeInCuMeter == null
                  ? 0.0
                  : geofenceInputsData.Result.Target.TargetVolumeInCuMeter
                      .toString();
        }
        titleController.text = data.GeofenceName;
        descriptionController.text = data.Description;
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
    } catch (e) {
      isLoading = false;
      Logger().e(e.toString());
      var error = DioException.fromDioError(e);
      snackbarService.showSnackbar(message: error.message);
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
      final geometryPolygon = Geo.wktProjected.parse(finalPolygonWKTstring);
      fetchedPolygons.add(geometryPolygon);
      final pointSeriesList = fetchedPolygons.first.exterior.chain;
      Logger().w(pointSeriesList);
      for (var item in pointSeriesList) {
        fetchedLatitude = item.y;
        fetchedLongitude = item.x;
        final LatLng latitudeLongitude =
            LatLng(fetchedLatitude, fetchedLongitude);
        fetchedLatlng.add(latitudeLongitude);
      }
      _listOfLatLong = fetchedLatlng;
      onZoomLatitude = _listOfLatLong.first.latitude;
      onZoomLongitude = _listOfLatLong.first.longitude;
      centerPosition = CameraPosition(
          target: LatLng(onZoomLatitude, onZoomLongitude), zoom: 5);

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
      _polygon.add(fetchedSinglePolygon);
      _polyline.add(fetchedSinglePolyline);
      Logger().d(_polygon);
      Logger().d(fetchedSinglePolygon);
      isPolygonsCreated = false;
      notifyListeners();
//_polygon = fetchedPolygons.toSet() as Set<Polygon>;
    } catch (e) {
      Logger().e(e.toString());
    }
  }
}
