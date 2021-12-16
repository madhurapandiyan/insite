import 'package:geocore/geocore.dart' as geo;
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:insite/core/base/insite_view_model.dart';
import 'package:insite/core/locator.dart';
import 'package:insite/core/services/geofence_service.dart';
import 'package:insite/views/adminstration/addgeofense/addgeofense_view.dart';
import 'package:insite/views/adminstration/addgeofense/model/geofencemodel.dart';
import 'package:load/load.dart';
import 'package:logger/logger.dart';
import 'package:google_polyline_algorithm/google_polyline_algorithm.dart';
import 'package:insite/core/logger.dart';

class ManageGeofenceViewModel extends InsiteViewModel {
  final Geofenceservice? _geofenceservice = locator<Geofenceservice>();
  Logger? log;

  ManageGeofenceViewModel() {
    this.log = getLogger(this.runtimeType.toString());
    _geofenceservice!.setUp();
    Future.delayed(Duration(seconds: 1), () {
      getGeofencedata();
    });
  }

  bool isLoading = true;

  List<Set<Polyline>> _fetchedPolygons = [];
  List<Set<Polyline>> get fetchedPolygons => _fetchedPolygons;

  List<geo.Polygon> _polygonData = [];
  List<String> listOfEncoded = [];

  Geofence? _geofence;
  Geofence? get geofence => _geofence;

  bool _isFavourite = false;
  bool get isFavourite => _isFavourite;

  getGeofencedata() async {
    List<String?> listOfWKTstring = [];

    //MapLatLng latlo = MapLatLng(latitude, longitude);
    List<geo.PointSeries<geo.Point<num>>> listOfPointSeries = [];
    _geofence = await _geofenceservice!.getGeofenceData();
    Logger().i(_geofence!.toJson());
    try {
      for (var i = 0; i < _geofence!.Geofences!.length; i++) {
        String? wktText = _geofence!.Geofences![i].GeometryWKT;
        //Logger().e(_geofence.Geofences.last.GeometryWKT);
        listOfWKTstring.add(wktText);
        final geofenceData = geo.wktProjected.parse(listOfWKTstring[i]!)as geo.Polygon;
        //Logger().d(geofenceData);
        //Logger().d(_polygonData);
        _polygonData.add(geofenceData);
        // Logger().e(_polygonData);
        final points = _polygonData[i].exterior.chain;
        //Logger().d(points);
        listOfPointSeries.add(points);
      }
      getEncodedPolylines(listOfPointSeries);
    } catch (e) {
      Logger().e(e.toString());
    }

    notifyListeners();
  }

  markFavouriteStatus(String uid, int index) async {
    _geofence!.Geofences![index].IsFavorite =
        !_geofence!.Geofences![index].IsFavorite!;
    //showLoadingDialog();
    _isFavourite = !isFavourite;
    notifyListeners();
    if (_geofence!.Geofences![index].IsFavorite!) {
      await _geofenceservice!.markFavourite(uid, "MarkFavorite?");
    } else {
      await _geofenceservice!.markFavourite(uid, "MarkUnfavorite?");
    }
  }

  deleteGeofence(uid, actionUTC, int i) async {
    try {
      geofence!.Geofences!.removeAt(i);
      var data = await _geofenceservice!.deleteGeofence(uid, actionUTC);
      notifyListeners();
    } catch (e) {
      Logger().e(e.toString());
    }
    notifyListeners();
  }

  onNavigation(String? uid) {
    if (uid == null) {
      navigationService!.clearTillFirstAndShowView(AddgeofenseView());
    } else {
      navigationService!.clearTillFirstAndShowView(AddgeofenseView(),
          arguments: uid);
    }
  }

  getEncodedPolylines(List<geo.PointSeries<geo.Point<num>>> pointslist) {
    try {
      if (_geofence!.Geofences!.isEmpty) {
        isLoading = false;
        notifyListeners();
      } else {
        listOfEncoded = [];

        List<List<num>> list = [];
        String encoding;
        List<num> listOfNumber = [];
        for (var p = 0; p < pointslist.length; p++) {
          var innerList = pointslist[p];
          for (var i = 0; i < innerList.length; i++) {
            num latitude = innerList[i].x;
            num longitude = innerList[i].y;
            listOfNumber.addAll([longitude, latitude]);

            list.add(listOfNumber);
            listOfNumber = [];
          }
          Logger().d(list);

          encoding = encodePolyline(list, accuracyExponent: 5);
          listOfEncoded.add(encoding);
          Logger().w(listOfEncoded);
          list = [];

          notifyListeners();

          //Logger().d(list);
          // var getEncodedPolylines = poly.Polyline.Encode(
          //     precision: 5, decodedCoords: list as List<List<double>>);
          //Logger().e(getEncodedPolylines.encodedString);
        }
        Logger().d(listOfEncoded.length);
      }
      isLoading = false;
      hideLoadingDialog();
    } catch (e) {
      hideLoadingDialog();
      Logger().d(e.toString());
    }
  }
}
