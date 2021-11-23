import 'package:logger/logger.dart';

const String apikey = "AIzaSyBTJcIhg6xPwh44ti48Quh_xFEAgrxhY-8";

class StaticMap {
  String generatedimg(String polylineencode) {
    Logger().e(polylineencode);
    return "https://maps.googleapis.com/maps/api/staticmap?size=200x200&path=weight:3%7Ccolor:purple10%7Cenc:$polylineencode&key=$apikey";
  }
}
