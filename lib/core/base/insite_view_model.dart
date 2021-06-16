import 'package:insite/core/locator.dart';
import 'package:insite/core/models/filter_data.dart';
import 'package:insite/core/router_constants.dart';
import 'package:insite/core/services/filter_service.dart';
import 'package:logger/logger.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';

abstract class InsiteViewModel extends BaseViewModel {
  bool _is401 = false;
  bool get is401 => _is401;
  set is401(value) {
    _is401 = value;
  }

  var _navigationService = locator<NavigationService>();
  var _filterService = locator<FilterService>();

  bool _youDontHavePermission = false;
  bool get youDontHavePermission => _youDontHavePermission;
  set youDontHavePermission(value) {
    _youDontHavePermission = value;
  }

  bool _loadingMore = false;
  bool get loadingMore => _loadingMore;

  bool _shouldLoadmore = true;
  bool get shouldLoadmore => _shouldLoadmore;

  setUp() {
    _filterService.setUp();
  }

  login() {
    Future.delayed(Duration(seconds: 2), () {
      _navigationService.replaceWith(logoutViewRoute);
    });
  }

  getSelectedFilterData() async {
    appliedFilters = await _filterService.getSelectedFilters();
    Logger().d(appliedFilters.toString());
  }

  removeFilter(value) async {
    Logger().d("removeFilter title " + value.title.toString());
    await _filterService.removeFilter(value);
  }

  addFilter(FilterData data) {
    print("addFilter title " + data.title.toString());
    _filterService.addFilter(data);
  }

  clearDb() {
    _filterService.clearDatabase();
  }

  List<FilterData> appliedFilters = [];
}
