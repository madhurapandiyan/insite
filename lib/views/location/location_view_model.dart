import 'dart:async';
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
import 'package:insite/core/models/filter_data.dart';
import 'package:insite/core/models/fleet.dart';
import 'package:insite/core/models/marker.dart';
import 'package:insite/core/router_constants.dart';
import 'package:insite/core/services/asset_location_service.dart';
import 'package:insite/theme/colors.dart';
import 'package:insite/views/detail/asset_detail_view.dart';
import 'package:insite/widgets/dumb_widgets/location_info_window_widget.dart';
import 'package:logger/logger.dart';
import 'package:insite/core/logger.dart';
import 'package:stacked_services/stacked_services.dart';
import 'dart:math' as Math;

class LocationViewModel extends InsiteViewModel {
  Logger log;
  var _assetLocationService = locator<AssetLocationService>();
  var _navigationService = locator<NavigationService>();
  Set<Marker> markers = Set();
  List<LatLng> latlngs = [];
  List<ClusterItem<InsiteMarker>> clusterMarkers = [];
  bool _loading = true;
  bool get loading => _loading;
  CustomInfoWindowController customInfoWindowController =
      CustomInfoWindowController();
  Completer<GoogleMapController> controller = Completer();
  ClusterManager manager;
  bool _refreshing = false;
  bool get refreshing => _refreshing;

  TYPE _pageType = TYPE.LOCATION;
  TYPE get pageType => _pageType;

  AssetLocationData _assetLocation;
  AssetLocationData get assetLocation => _assetLocation;
  int pageNumber = 1;
  int pageSize = 2500;

  clusterMarker() {
    int index = 1;
    List<MapRecord> assetLocationList = assetLocation.mapRecords;
    clusterMarkers.clear();
    latlngs.clear();
    for (var assetLocation in assetLocationList) {
      latlngs.add(LatLng(assetLocation.lastReportedLocationLatitude,
          assetLocation.lastReportedLocationLongitude));
      clusterMarkers.add(
        ClusterItem(
            LatLng(assetLocation.lastReportedLocationLatitude,
                assetLocation.lastReportedLocationLongitude),
            item: InsiteMarker(
              markerId: MarkerId('${index++}'),
              mapData: assetLocation,
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
                  assetCount: cluster.count,
                  type: pageType,
                  infoText: cluster.items.toList()[0].mapData.assetSerialNumber,
                  onCustomWindowClose: () {
                    customInfoWindowController.hideInfoWindow();
                  },
                  onFleetPageSelectedTap: () {
                    customInfoWindowController.hideInfoWindow();
                    if (cluster.count > 1) {
                      onFleetPageSelected(cluster.markers.toList());
                    } else {
                      onDetailPageSelected(
                          cluster.items.toList()[0].mapData, 0);
                    }
                  },
                  onTapWithZoom: () {
                    customInfoWindowController.hideInfoWindow();
                    if (cluster.count > 1) {
                      if (pageType == TYPE.DASHBOARD) {
                      } else {
                        refreshCluster(cluster.markers.toList());
                      }
                    } else {
                      onDetailPageSelected(
                          cluster.items.toList()[0].mapData, 3);
                    }
                  },
                ),
                LatLng(cluster.location.latitude, cluster.location.longitude));
          },
          icon: cluster.isMultiple
              ? await _getMarkerBitmap(125, text: cluster.count.toString())
              : await _getNormalMarkerBitmap(),
        );
      };

  Future<BitmapDescriptor> _getNormalMarkerBitmap() async {
    return BitmapDescriptor.fromAssetImage(
        ImageConfiguration.empty, "assets/images/marker.png");
  }

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

  onFleetPageSelected(List<ClusterItem<InsiteMarker>> list) async {
    List<LatLng> selectedClustorLatLnglist = [];
    for (ClusterItem<InsiteMarker> item in list) {
      selectedClustorLatLnglist.add(item.location);
    }
    LatLngBounds bounds = getBound(selectedClustorLatLnglist);
    LatLng smallLatLng = bounds.southwest;
    LatLng largeLatLng = bounds.northeast;
    double radiusKm = await getDistanceFromLatLonInKm(smallLatLng.latitude,
        smallLatLng.longitude, largeLatLng.latitude, largeLatLng.longitude);
    Logger().d("lat lng northeast ${bounds.northeast}");
    Logger().d("lat lng southwest ${bounds.southwest}");
    Logger().d("radius between southwest northeast $radiusKm");
    FilterData filterData = FilterData(
        count: "",
        isSelected: true,
        title: "Clustor",
        type: FilterType.CLUSTOR,
        extras: [
          smallLatLng.latitude.toString(),
          largeLatLng.longitude.toString(),
          radiusKm.toString()
        ]);
    await addFilter(filterData);
    _navigationService.navigateTo(
      fleetViewRoute,
    );
  }

  onDetailPageSelected(MapRecord mapData, index) {
    Logger().d("onDetailPageSelected $mapData.serialNumber");
    _navigationService.navigateTo(assetDetailViewRoute,
        arguments: DetailArguments(
            index: index,
            fleet: Fleet(
                assetSerialNumber: mapData.assetSerialNumber,
                assetId: null,
                assetIdentifier: mapData.assetIdentifier)));
  }

  goToLocationPageSelected(MapRecord mapData, index) {
    Logger().d("goToLocationPageSelected $mapData.serialNumber");
    _navigationService.navigateTo(
      locationViewRoute,
    );
  }

  LocationViewModel(TYPE type) {
    this._pageType = type;
    this.log = getLogger(this.runtimeType.toString());
    _assetLocationService.setUp();
    setUp();
    manager = initClusterManager();
    if (pageType == TYPE.LOCATION) {
      Future.delayed(Duration(seconds: 1), () {
        getAssetLocation();
      });
    } else if (pageType == TYPE.DASHBOARD) {
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
    latlngs.clear();
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

  refreshCluster(List<ClusterItem<InsiteMarker>> list) async {
    Logger().d("refreshCluster with size of  ${list.length}");
    _refreshing = true;
    clusterMarkers.clear();
    markers.clear();
    latlngs.clear();
    notifyListeners();
    List<LatLng> selectedClustorLatLnglist = [];
    for (ClusterItem<InsiteMarker> item in list) {
      selectedClustorLatLnglist.add(item.location);
    }
    LatLngBounds bounds = getBound(selectedClustorLatLnglist);
    LatLng smallLatLng = bounds.southwest;
    LatLng largeLatLng = bounds.northeast;
    double radiusKm = await getDistanceFromLatLonInKm(smallLatLng.latitude,
        smallLatLng.longitude, largeLatLng.latitude, largeLatLng.longitude);
    Logger().d("lat lng northeast ${bounds.northeast}");
    Logger().d("lat lng southwest ${bounds.southwest}");
    Logger().d("radius between southwest northeast $radiusKm");
    AssetLocationData result =
        await _assetLocationService.getAssetLocationWithCluster(
            pageNumber,
            pageSize,
            '-lastlocationupdateutc',
            smallLatLng.latitude,
            largeLatLng.longitude,
            radiusKm);
    _assetLocation = result;
    clusterMarker();
    manager.updateMap();
    _loading = false;
    _refreshing = false;
    notifyListeners();
    zoomToMarkers();
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

  zoomToMarkers() async {
    final GoogleMapController mapController = await controller.future;
    Future.delayed(Duration(seconds: 1), () {
      mapController
          .animateCamera(CameraUpdate.newLatLngBounds(getBound(latlngs), 0));
    });
  }

  zoomPlus() {}

  zoomMinus() {}

  LatLngBounds getBound(list) {
    assert(list.isNotEmpty);
    double x0, x1, y0, y1;
    for (LatLng latLng in list) {
      if (x0 == null) {
        x0 = x1 = latLng.latitude;
        y0 = y1 = latLng.longitude;
      } else {
        if (latLng.latitude > x1) x1 = latLng.latitude;
        if (latLng.latitude < x0) x0 = latLng.latitude;
        if (latLng.longitude > y1) y1 = latLng.longitude;
        if (latLng.longitude < y0) y0 = latLng.longitude;
      }
    }
    return LatLngBounds(northeast: LatLng(x1, y1), southwest: LatLng(x0, y0));
  }

  //finds the distance between two latlng values
  Future<double> getDistanceFromLatLonInKm(lat1, lon1, lat2, lon2) async {
    var R = 6371; // Radius of the earth in km
    var dLat = deg2rad(lat2 - lat1); // deg2rad below
    var dLon = deg2rad(lon2 - lon1);
    var a = Math.sin(dLat / 2) * Math.sin(dLat / 2) +
        Math.cos(deg2rad(lat1)) *
            Math.cos(deg2rad(lat2)) *
            Math.sin(dLon / 2) *
            Math.sin(dLon / 2);
    var c = 2 * Math.atan2(Math.sqrt(a), Math.sqrt(1 - a));
    var d = R * c; // Distance in km
    print(d);
    return d.roundToDouble();
  }

  //utils
  double deg2rad(deg) {
    return deg * (Math.pi / 180);
  }
}

enum TYPE { LOCATION, SEARCH, DASHBOARD }
