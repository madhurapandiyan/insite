import 'package:google_maps_cluster_manager/google_maps_cluster_manager.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:insite/core/models/asset_location.dart';

class InsiteMarker with ClusterItem {
  InsiteMarker({
    this.markerId,
    this.latLng,
    this.mapData,
    this.onTapInfoWindow,
  });

  MarkerId? markerId;
  MapRecord? mapData;
  LatLng? latLng;
  Function? onTapInfoWindow;
  @override
  LatLng get location => latLng!;
}
