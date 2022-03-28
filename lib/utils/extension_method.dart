import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:geocore/base.dart' as geo;

extension on String {
  String wktToGeometry({List<LatLng?>? correctedListofLatlang}) {
    String? wktString;
    List<List<num>> listOfNumber = [];
    LatLng? lastLatLong;
    List<geo.Point2> listOfPoints = [];
    geo.PointSeries pointSeries;
    geo.LineString<geo.Point<num>> lineStringSeries;
    lastLatLong = correctedListofLatlang!.first;
    correctedListofLatlang.add(lastLatLong);
    List<geo.LineString<geo.Point<num>>> listOfLineSeries = [];
    for (var i = 0; i < correctedListofLatlang.length; i++) {
      double latitude = correctedListofLatlang[i]!.latitude;
      double longitude = correctedListofLatlang[i]!.longitude;
      List<num> json = [longitude, latitude];
      listOfNumber.add(json);
    }
    for (var i = 0; i < listOfNumber.length; i++) {
      geo.Point2 point = geo.Point2.geometry.newFrom(listOfNumber[i]);
      listOfPoints.add(point);
    }
    pointSeries = geo.PointSeries.make(listOfNumber, geo.Point2.geometry);
    lineStringSeries = geo.LineString(pointSeries);
    listOfLineSeries.add(lineStringSeries);
    String finalPolygonOBJ = "POLYGON((${lineStringSeries.toString()}))";
    if (finalPolygonOBJ.contains("((LineString<Point<num>>([Point2(")) {
      String polygonWKT1 =
          finalPolygonOBJ.replaceAll("((LineString<Point<num>>([Point2(", "((");
      if (polygonWKT1.contains("), Point2(")) {
        String polygonWKT2 = polygonWKT1.replaceAll("), Point2(", ",");
        if (polygonWKT2.contains(", ")) {
          String polygonWKT3 = polygonWKT2.replaceAll(", ", " ");
          if (polygonWKT3.contains(")])")) {
            wktString = polygonWKT3.replaceAll(")])", "");
          }
        }
      }
    }
    return wktString!;
  }
}
