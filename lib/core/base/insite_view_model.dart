import 'dart:async';

import 'package:insite/core/flavor/flavor.dart';
import 'package:insite/core/locator.dart';
import 'package:insite/core/models/filter_data.dart';
import 'package:insite/core/router_constants.dart';
import 'package:insite/core/services/date_range_service.dart';
import 'package:insite/core/services/filter_service.dart';
import 'package:insite/utils/enums.dart';
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

  bool isVisionLink = false;

  InsiteViewModel() {
    try {
      if (AppConfig.instance!.apiFlavor == "visionlink") {
        isVisionLink = true;
      }
      // PackageInfo.fromPlatform().then((PackageInfo packageInfo) => {
      //       if ("com.trimble.insite.visionlink" == packageInfo.packageName ||
      //           "com.trimble.insite.trimble" == packageInfo.packageName)
      //         {isVisionLink = true}
      //     });
    } catch (e) {
      Logger().e(e);
    }
  }

  NavigationService? navigationService = locator<NavigationService>();
  FilterService? _filterService = locator<FilterService>();
  DateRangeService? _dateRangeService = locator<DateRangeService>();
  SnackbarService? snackbarService = locator<SnackbarService>();

  bool _youDontHavePermission = false;
  bool get youDontHavePermission => _youDontHavePermission;
  set youDontHavePermission(value) {
    _youDontHavePermission = value;
  }

  bool _loadingMore = false;
  bool get loadingMore => _loadingMore;

  bool _shouldLoadmore = true;
  bool get shouldLoadmore => _shouldLoadmore;

  String? _startDate = DateFormat('yyyy-MM-dd').format(
      DateTime.now().subtract(Duration(days: DateTime.now().weekday - 1)));
  set startDate(String? startDate) {
    this._startDate = startDate;
  }

  String? get startDate => _startDate;

  String? _endDate = DateFormat('yyyy-MM-dd').format(DateTime.now());
  set endDate(String? endDate) {
    this._endDate = endDate;
  }

  String? get endDate => _endDate;

  DateRangeType _dateType = DateRangeType.currentWeek;
  set dateType(DateRangeType dateType) {
    this._dateType = dateType;
  }

  DateRangeType get dateType => _dateType;

  setUp() {
    _filterService!.setUp();
    _dateRangeService!.setUp();
  }

  login() {
    Future.delayed(Duration(seconds: 2), () {
      navigationService!.replaceWith(logoutViewRoute);
    });
  }

  updateFilterInDb(List<FilterData?> selectedFilterData) {
    _filterService!.updateFilterInDb(selectedFilterData);
  }

  clearFilterOfTypeInDb(type) {
    _filterService!.clearFilterOfTypeInDb(type);
  }

  getSelectedFilterData() async {
    try {
      appliedFilters = await _filterService!.getSelectedFilters();
      Logger().d("getSelectedFilterData ${appliedFilters!.length.toString()}");
      notifyListeners();
    } catch (e) {
      Logger().e(e.toString());
    }
  }

  removeFilter(value) async {
    Logger().d("removeFilter title " + value.title.toString());
    await _filterService!.removeFilter(value);
    getSelectedFilterData();
  }

  addFilter(FilterData data) async {
    print("addFilter title " + data.title.toString());
    await _filterService!.addFilter(data);
  }

  Future clearFilterDb() async {
    return await _filterService!.clearFilterDatabase();
  }

  Future clearDashboardFiltersDb() async {
    await _filterService!.clearFilterOfTypeInDb(FilterType.PRODUCT_FAMILY);
    await _filterService!.clearFilterOfTypeInDb(FilterType.SEVERITY);
    await _filterService!.clearFilterOfTypeInDb(FilterType.IDLING_LEVEL);
    await _filterService!.clearFilterOfTypeInDb(FilterType.FUEL_LEVEL);
    await _filterService!.clearFilterOfTypeInDb(FilterType.ASSET_STATUS);
    notifyListeners();
  }

  getDateRangeFilterData() async {
    Logger().d("getDateRangeFilterData");
    List<String?>? appliedFilters =
        await (_dateRangeService!.getDateRangeFilters());
    Logger().d(appliedFilters!.length.toString());
    if (appliedFilters.isNotEmpty) {
      startDate = appliedFilters[0];
      endDate = appliedFilters[1];
      Logger().d("start date ", startDate);
      Logger().d("end date ", endDate);
      notifyListeners();
    } else {
      _startDate = DateFormat('yyyy-MM-dd').format(
          DateTime.now().subtract(Duration(days: DateTime.now().weekday - 1)));
      _endDate = DateFormat('yyyy-MM-dd').format(DateTime.now());
    }
  }

  bool isAlreadSelected(String? name, FilterType type) {
    try {
      var item = appliedFilters!.isNotEmpty
          ? appliedFilters!.firstWhere(
              (element) => element!.title == name && element.type == type,
              orElse: () {
                return null;
              },
            )
          : null;
      if (item != null) {
        return true;
      }
      return false;
    } catch (e) {
      return false;
    }
  }

  List<FilterData?>? appliedFilters = [];
}
