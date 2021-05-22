import 'package:google_maps_flutter/google_maps_flutter.dart';

class InsiteMarker {
  InsiteMarker({
    this.markerId,
    this.position,
    this.onTapInfoWindow,
  });

  MarkerId markerId;
  LatLng position;
  Function onTapInfoWindow;
}
