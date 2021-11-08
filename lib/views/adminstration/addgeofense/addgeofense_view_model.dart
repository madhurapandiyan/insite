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
  String polygonString;
  String fetchedGeofenceType;
  String initialValue = "Generic";
  var titleController = TextEditingController();
  var descriptionController = TextEditingController();
  var targetController = TextEditingController();

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

  onRespectivePageNavigation() {
    _navigationService.navigateToView(ManageGeofenceView());
  }

  Future<void> plus(
    double zoomVal,
    LatLng targetPosition,
  ) async {
    final controller = await googleMapController.future;
    controller.animateCamera(CameraUpdate.newCameraPosition(CameraPosition(
        target: LatLng(onZoomLatitude, onZoomLongitude), zoom: zoomVal)));
  }

  Future<void> minus(
    double zoomVal,
    LatLng targetPosition,
  ) async {
    Logger().e(targetPosition);
    final GoogleMapController controller = await googleMapController.future;
    controller.animateCamera(CameraUpdate.newCameraPosition(CameraPosition(
        target: LatLng(onZoomLatitude, onZoomLongitude), zoom: zoomVal)));
  }

  onChoosingColor(String value) {
    Logger().d(value);
    Logger().i(value.contains("Color(0xff"));
    Logger().i(value.contains(")"));
    String colorValueString;
    if (value.contains("Color(0xff") && value.contains(")")) {
      colorValueString = value.replaceAll("Color(0xff", "");
      colorValueString = colorValueString.replaceAll(")", "");
      //colorValue = int.parse(colorValueString);
      Logger().e(colorValueString);
    }
    colorValue = int.parse(colorValueString, radix: 16);
    Logger().i(colorValue);
  }

  onLocationSelected(String locationLatitude, String locationLongitude) {
    double parsedLatitude = double.parse(locationLatitude);
    double parsedLongitude = double.parse(locationLongitude);
    LatLng pickedLatLong = LatLng(parsedLatitude, parsedLongitude);
    centerPosition = CameraPosition(target: pickedLatLong, zoom: 10);
    notifyListeners();
  }

  onGettingLatLang(
    LatLng userLatlong,
  ) {
    Logger().wtf(userLatlong);
    Polyline userPolyline;
    Polygon userPolygon;
    Circle userCircle;
    double latitude1 = userLatlong.longitude;
    double longitude1 = userLatlong.latitude;
    Logger().wtf(longitude1);
    Logger().wtf(latitude1);
    LatLng correctedLatLong = LatLng(latitude1,longitude1);
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
      width: 5,
      points: _listOfLatLong,
      polylineId: PolylineId(DateTime.now().toString()),
      consumeTapEvents: true,
      color: color,
      visible: true,
    );
    userPolygon = Polygon(
        strokeColor: color,
        strokeWidth: 5,
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
    try {
      lastLatLong = correctedListofLatlang.first;
      correctedListofLatlang.add(lastLatLong);
      Logger().d(correctedListofLatlang);

      for (var i = 0; i < correctedListofLatlang.length; i++) {
        var json = correctedListofLatlang[i].toJson();
        listOfNumber.add(json);
      }
      //List<num> firstlatlang = listOfNumber.first;
      //Logger().d(firstlatlang);
      //listOfNumber.insert(listOfNumber.length - 1, firstlatlang);
      //Logger().d(listOfNumber);

      //Logger().d(listOfNumber);

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

    // for (var i = 0; i < testing.length; i++) {
    //     List innerlist1 = testing[i];
    //     for (var i1 = 0; i1 < innerlist1.length; i1++) {
    //       List innerlist2 = innerlist1[i1];

    //       example = geo.Point2.geometry.newFrom(innerlist2 as Iterable<num>);
    //       listofpointfactory.add(example);
    //     }
    //     Logger().e(listofpointfactory);
    //     polygonsparsing = geo.Polygon.make(testing, geo.Point2.geometry);
    //   }
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
      }
    } catch (e) {
      Logger().e(e.toString());
    }
  }

  onSavingData() async {
    showLoadingDialog();
    try {
      await convertingPolyOBJtoWKT();
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
    Geofencemodeldata data;
    GetAddgeofenceModel geofenceInputsData;
    try {
      data = await _geofenceService.getSingleGeofenceData(uid);
      fetchedGeofenceType = data.GeofenceType;
      if (data.GeofenceType == dropDownlist[2] ||
          data.GeofenceType == dropDownlist[3] ||
          data.GeofenceType == dropDownlist[4] ||
          data.GeofenceType == dropDownlist[5] ||
          data.GeofenceType == dropDownlist[6]) {
        geofenceInputsData = await _geofenceService.getGeofenceInput(uid);
        Logger().wtf(geofenceInputsData.Result.toJson());
        targetController.text =
            geofenceInputsData.Result.Target.TargetVolumeInCuMeter.toString();
      }
      titleController.text = data.GeofenceName;
      descriptionController.text = data.Description;
      initialValue = data.GeofenceType;
      polygonString = data.GeometryWKT;
      await convertWKTtoPolygon();
      isLoading = false;
      notifyListeners();
      Logger().wtf(data.toJson());
      return data;
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
      double correctedFetchedLatitude;
      double correctedFetchedLongitude;
      List<LatLng> correctedFetchedLatLng = [];
      List<LatLng> fetchedLatlng = [];
      Set<Polygon> fetchedSetPolygon = {};
      Polygon fetchedSinglePolygon;
      Set<Polyline> fetchedSetPolyline = {};
      Polyline fetchedSinglePolyline;
      // Logger().e(polygonString);
      final geometryPolygon = Geo.wktProjected.parse(polygonString);

      fetchedPolygons.add(geometryPolygon);
      final pointSeriesList = fetchedPolygons.first.exterior.chain;
      for (var item in pointSeriesList) {
        fetchedLatitude = item.y;
        fetchedLongitude = item.x;
        correctedFetchedLatitude = item.x;
        correctedFetchedLongitude = item.y;
        final LatLng correctedFetchedLatLng =
            LatLng(correctedFetchedLatitude, correctedFetchedLongitude);
        final LatLng latitudeLongitude =
            LatLng(fetchedLatitude, fetchedLongitude);
        fetchedLatlng.add(latitudeLongitude);
        correctedListofLatlang.add(correctedFetchedLatLng);
      }
      _listOfLatLong = fetchedLatlng;
      onZoomLatitude = _listOfLatLong.first.latitude;
      onZoomLongitude = _listOfLatLong.first.longitude;
      fetchedSinglePolygon = Polygon(
          strokeColor: color,
          strokeWidth: 5,
          polygonId: PolygonId(DateTime.now().toString()),
          fillColor: color,
          visible: true,
          points: fetchedLatlng);
      fetchedSinglePolyline = Polyline(
          jointType: JointType.round,
          endCap: Cap.roundCap,
          startCap: Cap.buttCap,
          width: 5,
          polylineId: PolylineId(DateTime.now().toString()),
          consumeTapEvents: true,
          color: color,
          visible: true,
          points: fetchedLatlng);
      fetchedSetPolygon.add(fetchedSinglePolygon);
      fetchedSetPolyline.add(fetchedSinglePolyline);
      _polygon = fetchedSetPolygon;
      _polyline = fetchedSetPolyline;
      Logger().d(_polygon);
      Logger().d(fetchedSinglePolygon);
      convertingPolyOBJtoWKT();
      isPolygonsCreated = true;
      notifyListeners();
//_polygon = fetchedPolygons.toSet() as Set<Polygon>;
    } catch (e) {
      Logger().e(e.toString());
    }
  }
}
