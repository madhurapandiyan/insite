import 'package:flutter/material.dart';
import 'package:google_maps_controller/google_maps_controller.dart';
import 'package:insite/core/base/insite_view_model.dart';
import 'package:insite/core/locator.dart';
import 'package:insite/core/models/asset_location.dart';
import 'package:insite/core/models/asset_location_search.dart';
import 'package:insite/core/models/filter_data.dart';
import 'package:insite/core/models/location_search.dart';
import 'package:insite/core/models/search_location_geofence.dart';
import 'package:insite/core/services/asset_location_service.dart';
import 'package:insite/utils/enums.dart';
import 'package:load/load.dart';
import 'package:logger/logger.dart';

class LocationSearchBoxViewModel extends InsiteViewModel {
  LocationSearchBoxViewModel() {
    _assetLocationService.setUp();
  }
  var _assetLocationService = locator<AssetLocationService>();

  List<String> dropDownList = ['S/N', 'Location'];
  List<String> assetDropDownList = ['Location'];

  String? searchDropDownValue = "S/N";

  bool? isSerching = false;

  String? searchLocationDropDownValue = "Location";

  TextEditingController searchController = TextEditingController();

  List<LocationKey>? list = [];

  AssetLocationSearch? result;

  searchLocation(query) async {
    if (query != null) {
      isSerching = true;
      SearchLocationGeofence? result =
          await _assetLocationService.getGeofenceSerachLocationData(
              graphqlSchemaService!.searchLocationData(10, query));
      if (result?.geofenceSearchLoaction?.locations != null &&
          result!.geofenceSearchLoaction!.locations!.isNotEmpty) {
        list!.clear();
        result.geofenceSearchLoaction!.locations!.forEach((element) {
          LocationKey data = LocationKey(
            value: element.shortString,
            latitude: double.parse(element.coords?.lat ?? "0.0"),
            longitude: double.parse(element.coords?.lon ?? "0.0"),
          );
          list!.add(data);
        });
      }
    }
    isSerching = false;
    notifyListeners();
  }

  onChangedDropDownValue(String? value) {
    searchDropDownValue = value;
    notifyListeners();
  }

  searchLocationSeralNumber(String value) async {
    if (value != null) {
      isSerching = true;
      result = await _assetLocationService.getAssetLocationsearch(
          graphqlSchemaService!.searchLocationSerialNumberData(
              query: value, pageNumber: 1, pageSize: 1000));

      if (result != null && result!.assetLocation!.mapRecords!.isNotEmpty) {
        list!.clear();
        result!.assetLocation!.mapRecords!.forEach((element) {
          LocationKey data = LocationKey(
              value: element!.assetSerialNumber ?? "",
              latitude: element.lastReportedLocationLatitude,
              longitude: element.lastReportedLocationLongitude);
          list!.add(data);
        });
      }
    }
    isSerching = false;
    notifyListeners();
  }

  onSearchTextChanged(String? value, ScreenType screenType) async {
    try {
      if (screenType == ScreenType.ASSET_DETAIL) {
        await searchLocation(value!);
      } else {
        if (value!.isNotEmpty && value.length > 2) {
          if (searchDropDownValue == "S/N") {
            await searchLocationSeralNumber(value);
          } else {
            await searchLocation(value);
          }
        } else {
          list!.clear();
        }
      }

      notifyListeners();
    } catch (e) {}
  }

  // Future<List<String>?> onSearchTextChanged(String? value) async {
  //   if (value!.isNotEmpty && value.length > 2) {
  //     //showLoadingDialog();
  //     List<LocationSearchData>? result =
  //         await _assetLocationService.searchLocation(10, value);
  //     _locations = result;
  //     if (_locations != null && _locations!.isNotEmpty) {
  //       list!.clear();
  //       for (LocationSearchData data in _locations!) {
  //         list!.add(data.Address!.City!);
  //       }
  //     }
  //     // hideLoadingDialog();
  //     notifyListeners();
  //   } else {
  //     list!.clear();

  //     notifyListeners();
  //   }
  // }

  onSelect(String value) {
    searchController.text = value;
    notifyListeners();
  }

  onChangeDropDownValueTwo(String value) {
    searchLocationDropDownValue = value;
    notifyListeners();
  }

  onChangeDropDown(String value) {
    searchDropDownValue = value;
    searchController.clear();
    notifyListeners();
  }
}

class LocationKey {
  final String? value;
  final double? latitude;
  final double? longitude;
  LocationKey({this.latitude, this.longitude, this.value});
}
