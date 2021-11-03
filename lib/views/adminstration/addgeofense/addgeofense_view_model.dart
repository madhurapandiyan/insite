import 'dart:async';

import 'package:custom_info_window/custom_info_window.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import 'package:geocore/base.dart' as geo;
import 'package:insite/core/base/insite_view_model.dart';
import 'package:insite/core/locator.dart';
import 'package:insite/core/models/asset_location.dart';

import 'package:insite/core/services/geofence_service.dart';
import 'package:insite/theme/colors.dart';
import 'package:insite/views/adminstration/addgeofense/model/addgeofencemodel.dart';
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

  bool isLoading = false;

  bool isSearching = false;

  bool isNoendDate = false;
  bool _allowAccessToSecurity = false;
  bool get allowAccessToSecurity => _allowAccessToSecurity;

  Color color = tango;

  int colorValue;

  Materialmodel _materialData;
  Materialmodel get materialData => _materialData;

  List<List<num>> listOfNumber = [];

  List<m.Material> materialModelList = [];
  DateTime backFillDate;
  DateTime endingDate;
  DateTime actionUTC = DateTime.now();
  String geofenceType = "Generic";
  String materialUID;
  var titleController = TextEditingController();
  var descriptionController = TextEditingController();
  var targetController = TextEditingController();

  List<String> dropDownlist = [
    "Generic",
    "Avoidance Zone",
    "Cut",
    "Borrow Pit",
    "Stockpile",
    "Fill",
    "Waste",
    "Landfill"
  ];

  String initialValue = "Generic";
  String initialName = "select";
  String initialMapType = "MAP";
  List<String> mapType = ['MAP', 'TERRAIN', 'SATELLITE', 'HYBRID'];
  CustomInfoWindowController customInfoWindowController =
      CustomInfoWindowController();
  Completer<GoogleMapController> googleMapController = Completer();
  CameraPosition centerPosition =
      CameraPosition(target: LatLng(30.666, 76.8127), zoom: 1);
  // Future<void> _plus(
  //   double zoomVal,
  // ) async {
  //   finalPolygonOBJl GoogleMapController controller = await contro.future;
  //   controller.animateCamera(CameraUpdate.newCameraPosition(
  //       CameraPosition(target: listOfLatLong.last, zoom: zoomVal)));
  // }

  // onZoomOut() {
  //   zoomValue--;
  // }

  LatLng lastLatLong;

  onChangeDropDown(String value) {
    if (value == dropDownlist[0] ||
        value == dropDownlist[6] ||
        value == dropDownlist[7]) {
      geofenceType = value;
    } else if (value == dropDownlist[1]) {
      geofenceType = "AvoidanceZone";
    } else if (value == dropDownlist[2]) {
      geofenceType = "CutZone";
    } else if (value == dropDownlist[3]) {
      geofenceType = "Borrow";
    } else if (value == dropDownlist[4]) {
      geofenceType = "stockpile";
    } else {
      geofenceType = "FillZone";
    }
    Logger().d(initialValue);
    notifyListeners();
  }

  onRespectivePageNavigation() {
    _navigationService.navigateToView(ManageGeofenceView());
  }

  Future<void> plus(
    double zoomVal,
    LatLng targetPosition,
  ) async {
    final controller = await googleMapController.future;
    controller.animateCamera(CameraUpdate.newCameraPosition(
        CameraPosition(target: targetPosition, zoom: zoomVal)));
  }

  Future<void> minus(
    double zoomVal,
    LatLng targetPosition,
  ) async {
    final GoogleMapController controller =  await googleMapController.future;
    controller.animateCamera(CameraUpdate.newCameraPosition(
        CameraPosition(target: targetPosition, zoom: zoomVal)));
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
    colorValue = int.parse(colorValueString, radix: 17);
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
    Polyline userPolyline;
    Polygon userPolygon;
    Circle userCircle;
    double latitude = userLatlong.longitude;
    double longitude = userLatlong.latitude;
    LatLng correctedLatLong = LatLng(latitude, longitude);
    lastLatLong = correctedLatLong;
    correctedListofLatlang.add(correctedLatLong);

    _listOfLatLong.add(userLatlong);

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
        points: listOfLatLong);
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
      String titleText = titleController.text;
      String descriptionText = descriptionController.text;
      Logger().e(endingDate);
      Logger().e(finalPolygonWKTstring);
      if (initialValue == dropDownlist[0] ||
          initialValue == dropDownlist[1] ||
          initialValue == dropDownlist[7]) {
        geofenceRequestPayload = Geofencepayload(
            ActionUTC: DateTime.now().toIso8601String(),
            Description: descriptionText == null ? null : descriptionText,
            GeofenceName: titleText,
            EndDate: endingDate == null ? null : endingDate.toIso8601String(),
            GeometryWKT: finalPolygonWKTstring,
            GeofenceType: geofenceType,
            IsTransparent: false,
            FillColor: colorValue == null ? 658170 : colorValue);
      } else {
        geofenceRequestPayload = Geofencepayload(
            ActionUTC: DateTime.now().toIso8601String(),
            Description: descriptionText == null ? null : descriptionText,
            GeofenceName: titleText,
            EndDate: endingDate == null ? null : endingDate.toIso8601String(),
            GeometryWKT: finalPolygonWKTstring,
            GeofenceType: geofenceType,
            IsTransparent: false,
            FillColor: colorValue == null ? 658170 : colorValue);

        Backfill backfill = Backfill(
            BackfillDate:
                backFillDate == null ? null : backFillDate.toIso8601String());
        Logger().d("mappiy");
        Target target = Target(
            TargetVolumeInCuMeter: targetController.text.isEmpty
                ? null
                : double.parse(targetController.text));
        Logger().d("1234");
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

      // listOfLatLong.clear();
      // correctedListofLatlang.clear();
      // listOfNumber.clear();
      // _polygon.clear();
      // _polyline.clear();
      // _circle.clear();

    } on DioError catch (e) {
      hideLoadingDialog();
      snackbarService.showSnackbar(message: e.response.statusMessage);
      Logger().e(e.toString());
    }
    notifyListeners();
  }
}
