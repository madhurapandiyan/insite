import 'dart:async';

import 'package:custom_info_window/custom_info_window.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import 'package:geocore/base.dart' as geo;
import 'package:insite/core/base/insite_view_model.dart';
import 'package:insite/core/locator.dart';
import 'package:insite/core/router_constants.dart';

import 'package:insite/core/services/geofence_service.dart';
import 'package:insite/theme/colors.dart';
import 'package:insite/views/adminstration/addgeofense/model/addgeofencemodel.dart';
import 'package:insite/views/adminstration/addgeofense/model/geofencepayload.dart';
import 'package:insite/views/adminstration/addgeofense/model/materialmodel.dart';
import 'package:insite/views/adminstration/addgeofense/model/materialmodel.dart'
    as m;
import 'package:insite/views/adminstration/manage_geofence/manage_geofence_view.dart';
import 'package:logger/logger.dart';
import 'package:insite/core/logger.dart';
import 'package:stacked_services/stacked_services.dart';

class AddgeofenseViewModel extends InsiteViewModel {
  final _geofenceservice = locator<Geofenceservice>();
  var _navigationService = locator<NavigationService>();
  Logger log;

  AddgeofenseViewModel() {
    this.log = getLogger(this.runtimeType.toString());

    getMaterialData();
  }
  double zoomval = 5;

  Geofencepayload geofenceRequestPayload;

  Addgeofencemodel addGeofencePayLoad;

  String finalPolygonWKTstring;
  Set<Circle> _circle = {};
  Set<Circle> get circle => _circle;

  Set<Polygon> _polygon = {};
  Set<Polygon> get polygon => _polygon;

  Set<Polyline> _polyline = {};
  Set<Polyline> get polyline => _polyline;

  List<LatLng> _listoflatlang = [];
  List<LatLng> get listoflatlang => _listoflatlang;

  List<LatLng> correctedListofLatlang = [];

  bool isDrawingPolygon = false;

  bool isLoading = false;

  bool isNoendDate = false;
  bool _allowAccessToSecurity = false;
  bool get allowAccessToSecurity => _allowAccessToSecurity;

  Color color = tango;

  int colorValue;

  Materialmodel _materialData;
  Materialmodel get materialData => _materialData;

  List<List<num>> listOfNumber = [];

  List<m.Material> materialModelList = [];

  String title;
  String descriptiontxt;
  String materialName;
  String targetValue;
  DateTime backFillDate;
  DateTime enddate;

  DateTime actionUTC = DateTime.now();
  String geofenceType;
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
  // Future<void> _plus(
  //   double zoomVal,
  // ) async {
  //   finalpolygonOBJl GoogleMapController controller = await contro.future;
  //   controller.animateCamera(CameraUpdate.newCameraPosition(
  //       CameraPosition(target: listoflatlang.last, zoom: zoomVal)));
  // }

  // onZoomOut() {
  //   zoomval--;
  // }

  LatLng lastlatlng;

  onGettingLatLang(
    LatLng userLatlang,
  ) {
    Polyline userpolyline;
    Polygon userpolygon;
    Circle usercircle;
    double latitude = userLatlang.longitude;
    double longitude = userLatlang.latitude;
    LatLng correctedlatlng = LatLng(latitude, longitude);
    lastlatlng = correctedlatlng;
    correctedListofLatlang.add(correctedlatlng);

    _listoflatlang.add(userLatlang);

    userpolyline = Polyline(
      jointType: JointType.round,
      endCap: Cap.roundCap,
      startCap: Cap.buttCap,
      width: 5,
      points: _listoflatlang,
      polylineId: PolylineId(DateTime.now().toString()),
      consumeTapEvents: true,
      color: color,
      visible: true,
    );
    userpolygon = Polygon(
        strokeColor: color,
        strokeWidth: 5,
        polygonId: PolygonId(DateTime.now().toString()),
        fillColor: color,
        visible: true,
        points: listoflatlang);
    usercircle = Circle(
        radius: 200,
        strokeWidth: 5,
        strokeColor: black,
        visible: true,
        circleId: CircleId(DateTime.now().toString()),
        center: userLatlang,
        fillColor: Colors.white);
    _polygon.add(userpolygon);
    _polyline.add(userpolyline);
    _circle.add(usercircle);
    //colorValue = int.parse(color.toString());
    Logger().e(_circle);

    notifyListeners();
  }

  getMaterialData() async {
    try {
      _materialData = await _geofenceservice.getmaterialmodeldata();
      for (var i = 0; i < _materialData.materials.length; i++) {
        m.Material extractedmaterial = _materialData.materials[i];
        materialModelList.add(extractedmaterial);
      }

      Logger().e(materialModelList.length);
    } catch (e) {
      Logger().e(e);
    }
    notifyListeners();
  }

  checkBoxState() {
    isNoendDate = !isNoendDate;
    //Logger().e(setDefaultPreferenceToUser);
    notifyListeners();
  }

  materialSelection(String value) {
    Logger().i("query typeed " + value);
    for (var i = 0; i < _materialData.materials.length; i++) {
      m.Material extractedmaterial = _materialData.materials[i];
      materialModelList.add(extractedmaterial);
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
        //Logger().i("total list size " + list.length.toString());
        //Logger().i("searched list size " + displayList.length.toString());
        notifyListeners();
      } else {
        return materialModelList;
      }
    }
    notifyListeners();
  }

  // selectedPolyLine(LatLng latlongdata) async {
  //   try {
  //     List<LatLng> newlistoflatlang = [];
  //     newlistoflatlang.add(latlongdata);
  //     Polyline newpolyline = Polyline(
  //         polylineId: PolylineId(DateTime.now().toString()),
  //         color: Colors.amber,
  //         visible: true,
  //         geodesic: true,
  //         consumeTapEvents: false,
  //         width: 12,
  //         points: newlistoflatlang);

  //     Polygon newpolygon = Polygon(
  //         fillColor: Colors.blue,
  //         strokeColor: Colors.black,
  //         strokeWidth: 12,
  //         polygonId: PolygonId(DateTime.now().toString()),
  //         points: newlistoflatlang);

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
      lastlatlng = correctedListofLatlang.first;
      correctedListofLatlang.add(lastlatlng);
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

      List<geo.Point2> listofpoint2 = [];
      geo.PointSeries mappiy;
      geo.LineString<geo.Point<num>> anotherdummy;
      List<geo.LineString<geo.Point<num>>> value = [];
      for (var i = 0; i < listOfNumber.length; i++) {
        geo.Point2 point = geo.Point2.geometry.newFrom(listOfNumber[i]);
        listofpoint2.add(point);
      }
      mappiy = geo.PointSeries.make(listOfNumber, geo.Point2.geometry);
      anotherdummy = geo.LineString(mappiy);
      value.add(anotherdummy);
      String finalpolygonOBJ = "POLYGON((${anotherdummy.toString()}))";

      if (finalpolygonOBJ.contains("((LineString<Point<num>>([Point2(")) {
        String polygonWKT1 = finalpolygonOBJ.replaceAll(
            "((LineString<Point<num>>([Point2(", "((");
        //Logger().d(polygonWKT1);
        if (polygonWKT1.contains("), Point2(")) {
          String polygonWKT2 = polygonWKT1.replaceAll("), Point2(", ",");
          //Logger().e(polygonWKT2);
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
      listoflatlang.clear();
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
    String titleText = titleController.text;
    String descriptionText = descriptionController.text;
    Logger().e(enddate);
    Logger().e(finalPolygonWKTstring);
    if (initialValue == dropDownlist[0] ||
        initialValue == dropDownlist[1] ||
        initialValue == dropDownlist[7]) {
      geofenceRequestPayload = Geofencepayload(
          ActionUTC: DateTime.now().toString(),
          Description: descriptionText == null ? null : descriptionText,
          GeofenceName: titleText,
          EndDate: enddate == null ? null : enddate.toString(),
          GeometryWKT: finalPolygonWKTstring,
          GeofenceType: initialValue,
          IsTransparent: true,
          FillColor: 658170);
    } else {
      Logger().e(targetValue);
      geofenceRequestPayload = Geofencepayload(
          ActionUTC: DateTime.now().toString(),
          Description: descriptionText == null ? null : descriptionText,
          GeofenceName: titleText,
          EndDate: enddate == null ? null : enddate.toString(),
          GeometryWKT: finalPolygonWKTstring,
          GeofenceType: initialValue,
          IsTransparent: true,
          FillColor: 658170);
      Backfill backfill = Backfill(
          BackfillDate: backFillDate == null ? null : backFillDate.toString());
      Target target = Target(
          TargetVolumeInCuMeter: targetController.text == null
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
  }

  onSavingData() async {
    try {
      await convertingPolyOBJtoWKT();
      await convertingOBJtoModel();
      //Logger().e(geofenceRequestPayload.toJson());

      //Logger().d(finalPolygonWKTstring);
      //Logger().e(addGeofencePayLoad.toJson());
      //print(addGeofencePayLoad.toJson());
      if (initialValue == dropDownlist[0] ||
          initialValue == dropDownlist[1] ||
          initialValue == dropDownlist[7]) {
        Map<String, dynamic> data = await _geofenceservice
            .postGeofenceData(geofenceRequestPayload)
            .then((value) {
          if (value == null) {
            navigationService.clearTillFirstAndShowView(ManageGeofenceView());
          } else {
            return;
          }
          return;
        });
        Logger().e(data);
      } else {
        isLoading = true;
        var data = await _geofenceservice
            .postAddGeofenceData(addGeofencePayLoad)
            .then((value) {
          if (value == null) {
            navigationService.clearTillFirstAndShowView(ManageGeofenceView());
          } else {
            return;
          }
        });
      }

      // listoflatlang.clear();
      // correctedListofLatlang.clear();
      // listOfNumber.clear();
      // _polygon.clear();
      // _polyline.clear();
      // _circle.clear();

    } catch (e) {
      Logger().e(e.toString());
      throw e;
    }
    notifyListeners();
  }
}
