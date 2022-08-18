import 'package:flutter/material.dart';
import 'package:google_maps_controller/google_maps_controller.dart';
import 'package:insite/core/base/insite_view_model.dart';
import 'package:insite/core/locator.dart';
import 'package:insite/core/models/asset_location_search.dart';
import 'package:insite/core/models/filter_data.dart';
import 'package:insite/core/models/location_search.dart';
import 'package:insite/core/models/search_location_geofence.dart';
import 'package:insite/core/services/asset_location_service.dart';
import 'package:logger/logger.dart';

class LocationSearchBoxViewModel extends InsiteViewModel {
  CameraPosition centerPosition =
      CameraPosition(target: LatLng(30.666, 76.8127), zoom: 1);
  var _assetLocationService = locator<AssetLocationService>();
  bool _loading = false;
  bool get loading => _loading;

  bool isSearching = false;

  String? searchDropDownValue = "S/N";

  TextEditingController searchController = TextEditingController();

  List<LocationSearchData>? _locations = [];
  List<LocationSearchData>? get locations => _locations;

  List<FilterData> _filterLocations = [];
  List<FilterData> get filterLocations => _filterLocations;

  double? onZoomLatitude;
  double? onZoomLongitude;
  onLocationSelected(String locationLatitude, String locationLongitude) {
    double parsedLatitude = double.parse(locationLatitude);
    double parsedLongitude = double.parse(locationLongitude);
    onZoomLatitude = parsedLatitude;
    onZoomLongitude = parsedLongitude;
    LatLng pickedLatLong = LatLng(parsedLatitude, parsedLongitude);
    centerPosition = CameraPosition(target: pickedLatLong, zoom: 10);
    Logger().wtf(centerPosition);
    notifyListeners();
  }

  searchLocation(query) async {
    // List<LocationSearchData>? result =
    //     await _assetLocationService.searchLocation(10, query);
    // _locations = result;
    // if (_locations != null && _locations!.isNotEmpty) {
    //   _filterLocations.clear();
    //   for (LocationSearchData data in _locations!) {
    //     Logger().w(data.Address!.toJson());
    //     FilterData filterData = FilterData(
    //         count: data.Address!.Zip,
    //         isSelected: isAlreadSelected(
    //             data.Address!.City! + data.Address!.Country!,
    //             FilterType.LOCATION_SEARCH),
    //         title: data.Address!.City,
    //         type: FilterType.LOCATION_SEARCH,
    //         extras: [data.Coords!.Lat, data.Coords!.Lon, 10.toString()]);
    //     _filterLocations.add(filterData);
    //   }
    // }
    SearchLocationGeofence? result =
        await _assetLocationService.getGeofenceSerachLocationData(
            graphqlSchemaService!.searchLocationData(10, query));
    Logger()
        .w(result!.geofenceSearchLoaction!.locations!.first.coords!.toJson());

    _loading = false;
    notifyListeners();
  }

  onChangedDropDownValue(String? value) {
    searchDropDownValue = value;
    notifyListeners();
  }

  onSearchTextChanged(String? value) {
    if (value!.isNotEmpty && value.length > 2) {
      if (searchDropDownValue == "S/N") {
        searchLocationSeralNumber(value);
      } else {
        searchLocation(value);
      }

      notifyListeners();
    }
  }

  searchLocationSeralNumber(String value) async {
    AssetLocationSearch? result =
        await _assetLocationService.getAssetLocationsearch(
            graphqlSchemaService!.searchLocationSerialNumberData(query: value));
    Logger().w(result!.assetLocation!.mapRecords!.first!.toJson());
  }
}
