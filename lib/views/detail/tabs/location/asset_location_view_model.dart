import 'dart:io';

import 'package:insite/core/locator.dart';
import 'package:insite/core/logger.dart';
import 'package:insite/core/services/asset_location_history_service.dart';
import 'package:stacked/stacked.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:insite/core/models/asset_location_history.dart';
import 'package:logger/logger.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class AssetLocationViewModel extends BaseViewModel {
  Logger log;

  var _assetLocationHistoryService = locator<AssetLocationHistoryService>();

  AssetLocationHistory _assetLocationHistory;
  AssetLocationHistory get assetLocationHistory => _assetLocationHistory;

  bool _loading = true;
  bool get loading => _loading;

  AssetLocationViewModel() {
    this.log = getLogger(this.runtimeType.toString());
    _assetLocationHistoryService.setUp();
    Future.delayed(Duration(seconds: 1), () {
      getAssetLocationHistoryResult();
    });
  }

  getAssetLocationHistoryResult() async {
    AssetLocationHistory result =
        await _assetLocationHistoryService.getAssetLocationHistory();
    _assetLocationHistory = result;
    _loading = false;
    notifyListeners();
  }

  // INFO WINDOW

  bool _showInfoWindow;
  bool _tempHidden;
  AssetLocation _assetLocation;
  double _leftMargin;
  double _topMargin;

  void rebuildInfoWindow() {
    notifyListeners();
  }

  void updateLocation(AssetLocation location) {
    _assetLocation = location;
  }

  void updateVisibility(bool visibility) {
    _showInfoWindow = visibility;
  }

  void updateInfoWindow(BuildContext context, GoogleMapController mapController,
      LatLng location, double infoWindowWidth, double markerOffSet) async {
    ScreenCoordinate screenCoordinate =
        await mapController.getScreenCoordinate(location);
    double devicePixelRatio =
        Platform.isAndroid ? MediaQuery.of(context).devicePixelRatio : 1.0;
    double left = (screenCoordinate.x.toDouble() / devicePixelRatio) -
        (infoWindowWidth / 2);
    double top =
        (screenCoordinate.x.toDouble() / devicePixelRatio) - markerOffSet;

    if (left < 0 || top < 0)
      _tempHidden = true;
    else {
      _tempHidden = false;
      _leftMargin = left;
      _topMargin = top;
    }
  }

  bool get showInfoWindow =>
      (_showInfoWindow == true && _tempHidden == false) ? true : false;

  double get leftMargin => _leftMargin;
  double get topMargin => _topMargin;
  AssetLocation get assetLocation => _assetLocation;
}
