import 'package:insite/core/base/insite_view_model.dart';
import 'package:insite/core/locator.dart';
import 'package:insite/core/models/fleet.dart';
import 'package:insite/core/models/search_data.dart';
import 'package:insite/core/router_constants.dart';
import 'package:insite/core/services/search_service.dart';
import 'package:insite/views/detail/asset_detail_view.dart';
import 'package:logger/logger.dart';
import 'package:insite/core/logger.dart';
import 'package:stacked_services/stacked_services.dart';

class GlobalSearchViewModel extends InsiteViewModel {
  Logger? log;
  SearchService? _searchService = locator<SearchService>();
  NavigationService? _navigationService = locator<NavigationService>();

  SearchData? _searchData;
  SearchData? get searchData => _searchData;

  bool _loading = false;
  bool get loading => _loading;

  String _searchKeyword = '';
  set searchKeyword(String keyword) {
    this._searchKeyword = keyword;
  }

  GlobalSearchViewModel() {
    this.log = getLogger(this.runtimeType.toString());
    _searchService!.setUp();
  }

  getSearchResult(type) async {
    SearchData? result =
        await _searchService!.getSearchResult(_searchKeyword, type);
    if (result != null) {
      if (result.topMatches != null) {
        _searchData = result;
      } else {
        _searchData = null;
      }
    } else {
      _searchData = null;
    }
    _loading = false;
    notifyListeners();
  }

  updateSearchDataToEmpty() {
    _searchData = null;
    notifyListeners();
  }

  onDetailPageSelected(TopMatch fleet) {
    Logger().d("message $fleet");
    _navigationService!.navigateTo(assetDetailViewRoute,
        arguments: DetailArguments(
            index: 0,
            fleet: Fleet(
                assetSerialNumber: fleet.serialNumber,
                assetId: fleet.assetUid,
                assetIdentifier: fleet.assetID)));
  }
}
