const String apikey = "AIzaSyBTJcIhg6xPwh44ti48Quh_xFEAgrxhY-8";

class StaticMap {
  String generatedimg(String? polylineencode, colorCode) {
    return "https://maps.googleapis.com/maps/api/staticmap?size=200x200&path=weight:3%7Cenc:$polylineencode&key=$apikey&fillcolor:$colorCode";
  }
}
