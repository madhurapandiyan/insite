import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:insite/core/models/asset_location.dart';

class InsiteMarker {
  InsiteMarker({
    this.markerId,
    this.position,
    this.mapData,
    this.onTapInfoWindow,
  });

  MarkerId markerId;
  MapRecord mapData;
  LatLng position;
  Function onTapInfoWindow;
}
