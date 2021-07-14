import 'dart:ui';
import 'package:custom_info_window/custom_info_window.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_cluster_manager/google_maps_cluster_manager.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:insite/core/base/insite_view_model.dart';
import 'package:insite/core/locator.dart';
import 'package:insite/core/models/asset_location.dart';
import 'package:insite/core/models/marker.dart';
import 'package:insite/core/router_constants.dart';
import 'package:insite/core/services/asset_location_service.dart';
import 'package:insite/theme/colors.dart';
import 'package:insite/widgets/dumb_widgets/location_info_window_widget.dart';
import 'package:logger/logger.dart';
import 'package:insite/core/logger.dart';
import 'package:stacked_services/stacked_services.dart';

class LocationViewModel extends InsiteViewModel {
  Logger log;
  var _assetLocationService = locator<AssetLocationService>();
  var _navigationService = locator<NavigationService>();
  Set<Marker> markers = Set();
  List<ClusterItem<InsiteMarker>> clusterMarkers = [];
  bool _loading = true;
  bool get loading => _loading;
  CustomInfoWindowController customInfoWindowController =
      CustomInfoWindowController();
  ClusterManager manager;
  bool _refreshing = false;
  bool get refreshing => _refreshing;
  AssetLocationData _assetLocation;
  AssetLocationData get assetLocation => _assetLocation;
  int pageNumber = 1;
  int pageSize = 2500;
  double radiusKm = 402.8692581547376;

  clusterMarker() {
    int index = 1;
    List<MapRecord> assetLocationList = assetLocation.mapRecords;
    clusterMarkers.clear();
    for (var assetLocation in assetLocationList) {
      clusterMarkers.add(
        ClusterItem(
            LatLng(assetLocation.lastReportedLocationLatitude,
                assetLocation.lastReportedLocationLongitude),
            item: InsiteMarker(
              markerId: MarkerId('${index++}'),
              position: LatLng(assetLocation.lastReportedLocationLatitude,
                  assetLocation.lastReportedLocationLongitude),
            )),
      );
    }
  }

  ClusterManager initClusterManager() {
    return ClusterManager<InsiteMarker>(clusterMarkers, _updateMarkers,
        markerBuilder: _markerBuilder,
        initialZoom: 5,
        stopClusteringZoom: 10.0);
  }

  void _updateMarkers(Set<Marker> markers) {
    this.markers = markers;
    print('Updated ${markers.length} markers');
    notifyListeners();
  }

  Future<Marker> Function(Cluster<InsiteMarker>) get _markerBuilder => (
        cluster,
      ) async {
        return Marker(
          markerId: MarkerId(cluster.getId()),
          position: cluster.location,
          onTap: () {
            customInfoWindowController.addInfoWindow(
                LocationInfoWindowWidget(
                  text: cluster.count.toString(),
                  onCustomWindowClose: () {
                    customInfoWindowController.hideInfoWindow();
                  },
                  onFleetPageSelectedTap: () {
                    customInfoWindowController.hideInfoWindow();
                    onFleetPageSelected();
                  },
                  onTapWithZoom: () {
                    customInfoWindowController.hideInfoWindow();
                    refreshWithCluster(
                        cluster.location.latitude, cluster.location.longitude);
                  },
                ),
                LatLng(cluster.location.latitude, cluster.location.longitude));
          },
          icon: await _getMarkerBitmap(cluster.isMultiple ? 125 : 75,
              text: cluster.count.toString()),
        );
      };
  Future<BitmapDescriptor> _getMarkerBitmap(int size, {String text}) async {
    if (kIsWeb) size = (size / 2).floor();

    final PictureRecorder pictureRecorder = PictureRecorder();
    final Canvas canvas = Canvas(pictureRecorder);
    final Paint paint1 = Paint()..color = Colors.white;
    final Paint paint2 = Paint()..color = Colors.blue;

    canvas.drawCircle(Offset(size / 2, size / 2), size / 2.0, paint1);
    canvas.drawCircle(Offset(size / 2, size / 2), size / 2.2, paint2);
    canvas.drawCircle(Offset(size / 2, size / 2), size / 2.8, paint1);

    if (text != null) {
      TextPainter painter = TextPainter(textDirection: TextDirection.ltr);
      painter.text = TextSpan(
        text: text,
        style: TextStyle(
            fontSize: size / 3,
            color: darkGrey,
            fontStyle: FontStyle.normal,
            fontWeight: FontWeight.w400),
      );
      painter.layout();
      painter.paint(
        canvas,
        Offset(size / 2 - painter.width / 2, size / 2 - painter.height / 2),
      );
    }

    final img = await pictureRecorder.endRecording().toImage(size, size);
    final data = await img.toByteData(format: ImageByteFormat.png);

    return BitmapDescriptor.fromBytes(data.buffer.asUint8List());
  }

  onFleetPageSelected() {
    _navigationService.navigateTo(
      fleetViewRoute,
    );
  }

  LocationViewModel(TYPE type) {
    this.log = getLogger(this.runtimeType.toString());
    _assetLocationService.setUp();
    setUp();
    manager = initClusterManager();
    if (type == TYPE.LOCATION) {
      Future.delayed(Duration(seconds: 1), () {
        getAssetLocation();
      });
    } else if (type == TYPE.DASHBOARD) {
      Future.delayed(Duration(seconds: 1), () {
        getAssetLocationHome();
      });
    }
  }

  refresh() async {
    await getDateRangeFilterData();
    Logger().d("refresh getAssetLocation");
    _refreshing = true;
    clusterMarkers.clear();
    markers.clear();
    notifyListeners();
    AssetLocationData result = await _assetLocationService.getAssetLocation(
        pageNumber, pageSize, '-lastlocationupdateutc', appliedFilters);
    _assetLocation = result;
    clusterMarker();
    manager.updateMap();
    _loading = false;
    _refreshing = false;
    notifyListeners();
  }

  refreshWithCluster(double latitude, double longitude) async {
    Logger().d("refreshWithCluster");
    _refreshing = true;
    clusterMarkers.clear();
    markers.clear();
    notifyListeners();
    AssetLocationData result =
        await _assetLocationService.getAssetLocationWithCluster(pageNumber,
            pageSize, '-lastlocationupdateutc', latitude, longitude, radiusKm);
    _assetLocation = result;
    clusterMarker();
    manager.updateMap();
    _loading = false;
    _refreshing = false;
    notifyListeners();
  }

  getAssetLocationHome() async {
    print('getAssetLocationHome');
    AssetLocationData result =
        await _assetLocationService.getAssetLocationWithoutFilter(
            pageNumber, pageSize, '-lastlocationupdateutc');
    _assetLocation = result;
    clusterMarker();
    _loading = false;
    notifyListeners();
  }

  getAssetLocation() async {
    Logger().d("getAssetLocation");
    AssetLocationData result = await _assetLocationService.getAssetLocation(
      pageNumber,
      pageSize,
      '-lastlocationupdateutc',
      appliedFilters,
    );
    _assetLocation = result;
    clusterMarker();
    _loading = false;
    _refreshing = false;
    notifyListeners();
  }
}

enum TYPE { LOCATION, SEARCH, DASHBOARD }
