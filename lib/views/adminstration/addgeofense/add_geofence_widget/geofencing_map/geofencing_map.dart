import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_maps/maps.dart';

class GeofencingMap extends StatefulWidget {
  GeofencingMap({Key key}) : super(key: key);

  @override
  _GeofencingMapState createState() => _GeofencingMapState();
}

class _GeofencingMapState extends State<GeofencingMap> {
  @override
  Widget build(BuildContext context) {
    return SfMaps(
      layers: [
        MapTileLayer(
          urlTemplate: "",
          sublayers: [],
        )
      ],
    );
  }
}
