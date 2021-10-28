import 'dart:async';

import 'package:custom_info_window/custom_info_window.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:geocore/geo.dart' as geo;

import 'package:geocore/base.dart' as geo;
import 'package:insite/core/base/insite_view_model.dart';
import 'package:insite/core/locator.dart';

import 'package:insite/core/services/geofence_service.dart';
import 'package:insite/core/services/local_service.dart';
import 'package:insite/theme/colors.dart';
import 'package:insite/views/adminstration/addgeofense/model/materialmodel.dart';
import 'package:logger/logger.dart';
import 'package:insite/core/logger.dart';

class AddgeofenseViewModel extends InsiteViewModel {
  Logger log;
  final _localService = locator<LocalService>();
  final _geofenceservice = locator<Geofenceservice>();

  AddgeofenseViewModel() {
    this.log = getLogger(this.runtimeType.toString());
  }
  double zoomval = 5;
  Set<Circle> _circle = {};
  Set<Circle> get circle => _circle;
  Set<Polygon> _polygon = {};
  Set<Polygon> get polygon => _polygon;
  Set<Polyline> _polyline = {};
  Set<Polyline> get polyline => _polyline;
  List<LatLng> _listoflatlang = [];
  List<LatLng> get listoflatlang => _listoflatlang;
  bool isdrawingpolygon = false;
  bool setDefaultPreferenceToUser = false;
  bool _allowAccessToSecurity = false;
  bool get allowAccessToSecurity => _allowAccessToSecurity;
  String value = "Administrator";
  Color color = tango;
  Materialmodel _materialdata;
  Materialmodel get materialdata => _materialdata;
  List<List<num>> listofnumber = [];
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
  List<String> maptype = ['MAP', 'TERRAIN', 'SATELLITE', 'HYBRID'];
  CustomInfoWindowController customInfoWindowController =
      CustomInfoWindowController();
  Completer<GoogleMapController> contro = Completer();
  Future<void> _plus(
    double zoomVal,
  ) async {
    final GoogleMapController controller = await contro.future;
    controller.animateCamera(CameraUpdate.newCameraPosition(
        CameraPosition(target: listoflatlang.last, zoom: zoomVal)));
  }

  onzoomout() {
    zoomval--;
  }

  ongettinglatlong(
    LatLng userLatlang,
  ) {
    int a = 5;
    double c = a / 10;
    Logger().e(c);
    Logger().d(userLatlang);
    Polyline userpolyline;
    Polygon userpolygon;
    Circle usercircle;

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
        radius: 500,
        strokeWidth: 5,
        strokeColor: Colors.black,
        circleId: CircleId(DateTime.now().toString()),
        center: userLatlang,
        fillColor: Colors.white);
    _polygon.add(userpolygon);
    _polyLines.add(userpolyline);
    _circle.add(usercircle);

    notifyListeners();
  }

  getmaterialdata() async {
    Logger().e("jdhgbvdxkjchn;oxdihg;zdh;gsozihgxchig;sxid");
    try {
      _materialdata = await _geofenceservice.getmaterialmodeldata();
      Logger().d(materialdata);
      Logger().d(_materialdata);
    } catch (e) {
      Logger().e(e);
    }
  }

  changecheckboxstate() {
    setDefaultPreferenceToUser = !setDefaultPreferenceToUser;
    Logger().e(setDefaultPreferenceToUser);
    notifyListeners();
  }

  filteronchange(String value) {
    materialdata.materials.forEach((element) {
      element.name.contains(value);
      materialdata.materials.clear();
      materialdata.materials.add(element);
    });
  }

  selectedpolyline(LatLng latlongdata) async {
    try {
      List<LatLng> newlistoflatlang = [];
      newlistoflatlang.add(latlongdata);
      Polyline newpolyline = Polyline(
          polylineId: PolylineId(DateTime.now().toString()),
          color: Colors.amber,
          visible: true,
          geodesic: true,
          consumeTapEvents: false,
          width: 12,
          points: newlistoflatlang);

      Polygon newpolygon = Polygon(
          fillColor: Colors.blue,
          strokeColor: Colors.black,
          strokeWidth: 12,
          polygonId: PolygonId(DateTime.now().toString()),
          points: newlistoflatlang);

      _polyLines.add(newpolyline);

      _polygon.add(newpolygon);

      Logger().e(polygon);
    } catch (e) {
      Logger().e(e);
    }
    //Logger().e(latlongdata);
  }

  Set<Polyline> _polyLines = {};
  Set<Polyline> get polylines => _polyLines;

  makinglistofnumber() {
    Logger().e(listoflatlang.length);
    for (var i = 0; i < listoflatlang.length; i++) {
      var json = listoflatlang[i].toJson();
      listofnumber.add(json);
      //Logger().d(listofnumber);
    }
  }

  dummytestfunction() {
    List<List<num>> testing = [
      [-15.201858478545118, 11.378635521993544],
      [28.027870505185483, 2.3525199526321785],
      [-11.379817550000007, -19.561794708191258],
      [-21.223567549999974, -1.320369840698433],
      [-15.201858478545118, 11.378635521993544]
    ];
    makinglistofnumber();

    //Logger().d(listofnumber);
    var dummy;
    List<geo.Point2> listofpoint2 = [];
    geo.PointSeries mappiy;
    geo.LineString<geo.Point<num>> anotherdummy;
    List<geo.LineString<geo.Point<num>>> value = [];
    for (var i = 0; i < listofnumber.length; i++) {
      geo.Point2 point = geo.Point2.geometry.newFrom(listofnumber[i]);
      listofpoint2.add(point);
    }
    mappiy = geo.PointSeries.make(listofnumber, geo.Point2.geometry);
    anotherdummy = geo.LineString(mappiy);
    value.add(anotherdummy);
    String fina = "POLYGON((${anotherdummy.toString()}))";

    if (fina.contains("((LineString<Point<num>>([Point2(")) {
      String test1 = fina.replaceAll("((LineString<Point<num>>([Point2(", "((");
      //Logger().d(test1);
      if (test1.contains("), Point2(")) {
        String test2 = test1.replaceAll("), Point2(", ",");
        //Logger().e(test2);
        if (test2.contains(", ")) {
          String test3 = test2.replaceAll(", ", " ");
          if (test3.contains(")])")) {
            String test4 = test3.replaceAll(")])", "");
            print(test4);
          }
        }
      }
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
  }

  notifyListeners();
}
