import 'package:flutter/material.dart';
import 'package:insite/core/base/insite_view_model.dart';
import 'package:insite/core/locator.dart';
import 'package:insite/core/models/filter_data.dart';
import 'package:insite/core/models/location_search.dart';
import 'package:insite/core/services/asset_location_service.dart';
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

  LocationSearchViewModel(TYPE type) {
    this.log = getLogger(this.runtimeType.toString());
    _assetLocationService.setUp();
    if (type == TYPE.SEARCH) {
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
      for (LocationSearchData data in _locations) {
        FilterData filterData = FilterData(
            count: "",
            isSelected: false,
            title: data.Address.StateName,
            type: FilterType.LOCATION_SEARCH,
            extras: [data.Coords.Lat, data.Coords.Lon]);
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