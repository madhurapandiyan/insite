import 'package:flutter/material.dart';
import 'package:insite/core/base/insite_view_model.dart';
import 'package:insite/core/locator.dart';
import 'package:insite/core/models/filter_data.dart';
import 'package:insite/core/models/location_search.dart';
import 'package:insite/core/services/asset_location_service.dart';
import 'package:insite/views/home/home_view.dart';
import 'package:logger/logger.dart';
import 'package:insite/core/logger.dart';
import 'location_view_model.dart';

class LocationSearchViewModel extends InsiteViewModel {
  Logger log;

  var _assetLocationService = locator<AssetLocationService>();

  bool _loading = false;
  bool get loading => _loading;

  List<LocationSearchData> _locations = [];
  List<LocationSearchData> get locations => _locations;

  List<FilterData> _filterLocations = [];
  List<FilterData> get filterLocations => _filterLocations;

  LocationSearchViewModel(ScreenType type) {
    this.log = getLogger(this.runtimeType.toString());
    _assetLocationService.setUp();
    if (type == ScreenType.SEARCH) {
      // searchLocation("");
    }
    textEditingController.addListener(() {
      onSearchTextChanged(textEditingController.text);
    });
  }

  searchLocation(query) async {
    List<LocationSearchData> result =
        await _assetLocationService.searchLocation(10, query);
    _locations = result;
    if (_locations != null && _locations.isNotEmpty) {
      _filterLocations.clear();
      for (LocationSearchData data in _locations) {
        FilterData filterData = FilterData(
            count: data.Address.Zip,
            isSelected: isAlreadSelected(
                data.Address.City + data.Address.Country,
                FilterType.LOCATION_SEARCH),
            title: data.Address.City + data.Address.Country,
            type: FilterType.LOCATION_SEARCH,
            extras: [data.Coords.Lat, data.Coords.Lon, 10.toString()]);
        _filterLocations.add(filterData);
      }
    }
    _loading = false;
    notifyListeners();
  }

  void onSearchTextChanged(String text) {
    if (text.isNotEmpty && text.length > 2) {
      searchLocation(text);
    }
  }

  clearFilter() {
    for (var i = 0; i < _filterLocations.length; i++) {
      _filterLocations[i].isSelected = false;
    }
    notifyListeners();
  }

  TextEditingController textEditingController = TextEditingController();
}
