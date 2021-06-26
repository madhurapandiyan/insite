import 'package:insite/core/locator.dart';
import 'package:insite/core/models/filter_data.dart';
import 'package:insite/core/router_constants.dart';
import 'package:insite/core/services/date_range_service.dart';
import 'package:insite/core/services/filter_service.dart';
import 'package:insite/views/date_range/date_range_view.dart';
import 'package:intl/intl.dart';
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
  var _dateRangeService = locator<DateRangeService>();

  bool _youDontHavePermission = false;
  bool get youDontHavePermission => _youDontHavePermission;
  set youDontHavePermission(value) {
    _youDontHavePermission = value;
  }

  bool _loadingMore = false;
  bool get loadingMore => _loadingMore;

  bool _shouldLoadmore = true;
  bool get shouldLoadmore => _shouldLoadmore;

  String _startDate = DateFormat('yyyy-MM-dd')
      .format(DateTime.now().subtract(Duration(days: DateTime.now().weekday)));
  set startDate(String startDate) {
    this._startDate = startDate;
  }

  String get startDate => _startDate;

  String _endDate = DateFormat('yyyy-MM-dd').format(DateTime.now());
  set endDate(String endDate) {
    this._endDate = endDate;
  }

  String get endDate => _endDate;

  DateRangeType _dateType = DateRangeType.currentWeek;
  set dateType(DateRangeType dateType) {
    this._dateType = dateType;
  }

  DateRangeType get dateType => _dateType;

  setUp() {
    _filterService.setUp();
    _dateRangeService.setUp();
  }

  login() {
    Future.delayed(Duration(seconds: 2), () {
      _navigationService.replaceWith(logoutViewRoute);
    });
  }

  getSelectedFilterData() async {
    appliedFilters = await _filterService.getSelectedFilters();
    Logger().d(appliedFilters.length.toString());
    notifyListeners();
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

  getDateRangeFilterData() async {
    Logger().d("getDateRangeFilterData");
    List<String> appliedFilters = await _dateRangeService.getDateRangeFilters();
    Logger().d(appliedFilters.length.toString());
    if (appliedFilters.isNotEmpty) {
      startDate = appliedFilters[0];
      endDate = appliedFilters[1];
      Logger().d("start date ", startDate);
      Logger().d("end date ", endDate);
      notifyListeners();
    }
  }

  List<FilterData> appliedFilters = [];
}
