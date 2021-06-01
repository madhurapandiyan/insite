import 'package:insite/core/base/insite_view_model.dart';
import 'package:insite/core/locator.dart';
import 'package:insite/core/services/filter_service.dart';

class FilterViewModel extends InsiteViewModel {
  var _searchService = locator<FilterService>();

  FilterViewModel() {
    _searchService.setUp();
  }
}
