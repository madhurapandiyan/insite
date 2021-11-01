import 'package:geocore/geocore.dart' as geo;
import 'package:google_maps_flutter/google_maps_flutter.dart';

import 'package:insite/core/base/insite_view_model.dart';
import 'package:insite/core/locator.dart';

import 'package:insite/core/services/geofence_service.dart';
import 'package:insite/views/adminstration/addgeofense/model/geofencemodel.dart';
import 'package:logger/logger.dart';
import 'package:google_polyline_algorithm/google_polyline_algorithm.dart';
import 'package:insite/core/logger.dart';

class ManageGeofenceViewModel extends InsiteViewModel {
  final _geofenceservice = locator<Geofenceservice>();
  Logger log;

  ManageGeofenceViewModel() {
    this.log = getLogger(this.runtimeType.toString());
    Future.delayed(Duration(seconds: 3), () {
      getGeofencedata();
    });
  }

  bool isLoading = true;

  List<Set<Polyline>> _fetchedPolygons = [];
  List<Set<Polyline>> get fetchedPolygons => _fetchedPolygons;

  List<geo.Polygon> _polygondata = [];
  List<String> listOfEncoded = [];
  List<Set<Polygon>> type = [];

  Geofence _geofence;
  Geofence get geofence => _geofence;
  var value;
  List<num> list;

  getGeofencedata() async {
    List<String> dat = [];

    //MapLatLng latlo = MapLatLng(latitude, longitude);
    List<geo.PointSeries<geo.Point<num>>> pointseries = [];
    _geofence = await _geofenceservice.getgeoencedata();

    try {
      for (var i = 0; i < _geofence.Geofences.length; i++) {
        String wkttext = _geofence.Geofences[i].GeometryWKT;
        //Logger().e(_geofence.Geofences.last.GeometryWKT);
        dat.add(wkttext);
        final geofencedata = geo.wktProjected.parse(dat[i]);
        Logger().d(geofencedata);
        Logger().d(_polygondata);
        _polygondata.add(geofencedata);
        Logger().e(_polygondata);
        final points = _polygondata[i].exterior.chain;
        Logger().d(points);
        pointseries.add(points);
      }
      //Logger().d(pointseries);

      getEncodedPolylines(pointseries);
      //makemaplatlan(pointseries);
      //getEncodedPolylines(pointseries);
      return 1;
    } catch (e) {
      Logger().e(e.toString());
    }

    notifyListeners();
  }

  deleteGeofence(uid, actionUTC) async {
    try {
      Logger().e(uid);
      Logger().e(actionUTC);
      //var data = _geofenceservice.deleteGeofence(uid, actionUTC);
    } catch (e) {
      Logger().e(e.toString());
    }
  }

  // makemaplatlan(List<geo.PointSeries<geo.Point<num>>> pointslist) {
  //   _fetchedPolygons = [];
  //   double latitude;
  //   double longitude;
  //   Set<Polyline> mypolygons = {};
  //   Set<Polygon> mypoly = {};
  //   List<LatLng> setlatlang_element = [];
  //   LatLng latitudelongidude;

  //   for (var p = 0; p < pointslist.length; p++) {
  //     var innerList = pointslist[p];

  //     for (var i = 0; i < innerList.length; i++) {
  //       latitude = innerList[i].x;
  //       longitude = innerList[i].y;
  //       list = innerList[i].values;
  //       latitudelongidude = LatLng(latitude, longitude);
  //       setlatlang_element.add(latitudelongidude);
  //     }
  //     mypoly.add(Polygon(
  //         polygonId: PolygonId(DateTime.now().toString()),
  //         points: setlatlang_element));

  //     mypolygons.add(Polyline(
  //         polylineId: PolylineId(DateTime.now().toString()),
  //         points: setlatlang_element));
  //     Logger().d(mypolygons);
  //     _fetchedPolygons.add(mypolygons);
  //     type.add(mypoly);
  //     setlatlang_element = [];
  //     mypoly = {};
  //     mypolygons = {};
  //   }

  //   Logger().d(_fetchedPolygons);
  // }

  getEncodedPolylines(List<geo.PointSeries<geo.Point<num>>> pointslist) {
    Logger().e(pointslist);
    listOfEncoded = [];

    List<num> listOfNumber = [];
    List<List<num>> list = [];
    String encoding;

    for (var p = 0; p < pointslist.length; p++) {
      var innerList = pointslist[p];
      for (var i = 0; i < innerList.length; i++) {
        listOfNumber = innerList[i].values;
        list.add(listOfNumber);
        //Logger().d(list);
        listOfNumber = [];
      }
      Logger().d(list);

      encoding = encodePolyline(list, accuracyExponent: 5);
      listOfEncoded.add(encoding);
      list = [];
      isLoading = false;
      notifyListeners();

      //Logger().d(list);
      // var getEncodedPolylines = poly.Polyline.Encode(
      //     precision: 5, decodedCoords: list as List<List<double>>);
      //Logger().e(getEncodedPolylines.encodedString);
    }
    Logger().d(listOfEncoded.length);
  }
}
