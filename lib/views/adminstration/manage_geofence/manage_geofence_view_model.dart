import 'dart:ffi';

import 'package:geocore/geocore.dart' as geo;
import 'package:geocore/geocore.dart' as g;
import 'package:geojson/geojson.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import 'package:insite/core/base/insite_view_model.dart';
import 'package:insite/core/locator.dart';
import 'package:insite/core/models/geofencemodel.dart';
import 'package:insite/core/services/geofence_service.dart';
import 'package:insite/core/services/local_service.dart';
import 'package:logger/logger.dart';
import 'package:google_polyline_algorithm/google_polyline_algorithm.dart';
import 'package:insite/core/logger.dart';

class ManageGeofenceViewModel extends InsiteViewModel {
  final _localService = locator<LocalService>();
  final _geofenceservice = locator<Geofenceservice>();
  Logger log;

  ManageGeofenceViewModel() {
    this.log = getLogger(this.runtimeType.toString());
  }

  List<Set<Polyline>> _fetchedpolygons = [];
  List<Set<Polyline>> get fetchedpolygons => _fetchedpolygons;

  List<geo.Polygon> _polygondata = [];
  List<String> listofendoded = [];
  List<Set<Polygon>> type = [];

  Geofence _geofence;
  Geofence get geofence => _geofence;
  var value;
  List<num> list;
  Future<int> getdata() async {
    List<String> dat = [];

    double latitude;
    double longitude;
    //MapLatLng latlo = MapLatLng(latitude, longitude);
    List<geo.PointSeries<geo.Point<num>>> serie = [];
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
        serie.add(points);
      }
      //Logger().d(serie);

      test(serie);
      //makemaplatlan(serie);
      //test(serie);
      return 1;
    } catch (e) {
      Logger().e(e.toString());
    }

    notifyListeners();
  }

  makemaplatlan(List<geo.PointSeries<geo.Point<num>>> pointslist) {
    _fetchedpolygons = [];
    double latitude;
    double longitude;
    Set<Polyline> mypolygons = {};
    Set<Polygon> mypoly = {};
    List<LatLng> setlatlang_element = [];
    LatLng latitudelongidude;

    for (var p = 0; p < pointslist.length; p++) {
      var innerList = pointslist[p];

      for (var i = 0; i < innerList.length; i++) {
        latitude = innerList[i].x;
        longitude = innerList[i].y;
        list = innerList[i].values;
        latitudelongidude = LatLng(latitude, longitude);
        setlatlang_element.add(latitudelongidude);
      }
      mypoly.add(Polygon(
          polygonId: PolygonId(DateTime.now().toString()),
          points: setlatlang_element));

      mypolygons.add(Polyline(
          polylineId: PolylineId(DateTime.now().toString()),
          points: setlatlang_element));
      Logger().d(mypolygons);
      _fetchedpolygons.add(mypolygons);
      type.add(mypoly);
      setlatlang_element = [];
      mypoly = {};
      mypolygons = {};
    }

    Logger().d(_fetchedpolygons);
  }

  test(List<geo.PointSeries<geo.Point<num>>> pointslist) {
    Logger().e(pointslist);
    listofendoded = [];
    double lat;
    double long;
    List<num> listofnum = [];
    List<List<num>> list = [];
    String encoding;

    for (var p = 0; p < pointslist.length; p++) {
      var innerList = pointslist[p];
      for (var i = 0; i < innerList.length; i++) {
        listofnum = innerList[i].values;
        list.add(listofnum);
        //Logger().d(list);
        listofnum = [];
      }
      Logger().d(list);

      encoding = encodePolyline(list, accuracyExponent: 5);
      listofendoded.add(encoding);
      list = [];

      //Logger().d(list);
      // var test = poly.Polyline.Encode(
      //     precision: 5, decodedCoords: list as List<List<double>>);
      //Logger().e(test.encodedString);
    }
    Logger().d(listofendoded.length);
  }
}
