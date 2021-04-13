import 'package:insite/core/locator.dart';
import 'package:insite/core/models/search_data.dart';
import 'package:insite/core/services/search_service.dart';
import 'package:logger/logger.dart';
import 'package:stacked/stacked.dart';
import 'package:insite/core/logger.dart';

class GlobalSearchViewModel extends BaseViewModel {
  Logger log;
  var _searchService = locator<SearchService>();

  SearchData _searchData;
  SearchData get searchData => _searchData;

  bool _loading = true;
  bool get loading => _loading;

  String _searchKeyword = '';
  set searchKeyword(String keyword) {
    this._searchKeyword = keyword;
  }

  GlobalSearchViewModel() {
    this.log = getLogger(this.runtimeType.toString());
    _searchService.setUp();
    Future.delayed(Duration(seconds: 1), () {
      getSearchResult();
    });
  }

  getSearchResult() async {
    SearchData result = await _searchService.getSearchResult(_searchKeyword);
    _searchData = result;
    _loading = false;
    notifyListeners();
  }
}
