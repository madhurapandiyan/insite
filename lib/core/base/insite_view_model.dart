import 'dart:async';

import 'package:insite/core/flavor/flavor.dart';
import 'package:insite/core/locator.dart';
import 'package:insite/core/models/filter_data.dart';
import 'package:insite/core/models/login_response.dart';
import 'package:insite/core/router_constants.dart';
import 'package:insite/core/services/asset_status_service.dart';
import 'package:insite/core/services/date_range_service.dart';
import 'package:insite/core/services/filter_service.dart';
import 'package:insite/core/services/graphql_schemas_service.dart';
import 'package:insite/core/services/local_service.dart';
import 'package:insite/core/services/login_service.dart';
import 'package:insite/core/services/notification_service.dart';
import 'package:insite/utils/enums.dart';
import 'package:insite/utils/helper_methods.dart';
import 'package:intl/intl.dart';
import 'package:jwt_decoder/jwt_decoder.dart';
import 'package:logger/logger.dart';
import 'package:random_string/random_string.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';

abstract class InsiteViewModel extends BaseViewModel {
  bool _is401 = false;
  bool get is401 => _is401;
  set is401(value) {
    _is401 = value;
  }

  bool isVisionLink = false;
  bool enableGraphQl = false;

  InsiteViewModel() {
    try {
      if (AppConfig.instance!.apiFlavor == "visionlink") {
        isVisionLink = true;
      }
      if (AppConfig.instance!.enableGraphql == true) {
        enableGraphQl = true;
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
  GraphqlSchemaService? graphqlSchemaService = locator<GraphqlSchemaService>();
  final LocalService? _localService = locator<LocalService>();
  final LoginService? _loginService = locator<LoginService>();
  NotificationService? _mainNotificationService =
      locator<NotificationService>();
  AssetStatusService? _assetStatusService = locator<AssetStatusService>();

  bool _youDontHavePermission = false;
  bool get youDontHavePermission => _youDontHavePermission;
  set youDontHavePermission(value) {
    _youDontHavePermission = value;
  }

  bool _loadingMore = false;
  bool get loadingMore => _loadingMore;

  bool _shouldLoadmore = true;
  bool get shouldLoadmore => _shouldLoadmore;
  DateRangeType? _dateRange = DateRangeType.currentWeek;
  DateRangeType? get dateRange => _dateRange;

  String? codeChallenge;
  static String _createCodeVerifier() {
    return randomAlphaNumeric(43);
  }

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

  String? _maintenanceHistoryStartDate = DateFormat("yyyy-MM-dd")
      .format(DateTime.now().subtract(Duration(days: 29)));
  String? get maintenanceHistoryStartDate => _maintenanceHistoryStartDate;
  set maintenanceHistoryStartDate(String? maintenanceHistoryStartDate) {
    this._maintenanceHistoryStartDate = maintenanceHistoryStartDate;
  }

  String? _maintenanceHistoryEndDate =
      DateFormat("yyyy-MM-dd").format(DateTime.now());
  String? get maintenanceHistoryEndDate => _maintenanceHistoryEndDate;
  set maintenanceHistoryEndDate(String? maintenanceHistoryEndDate) {
    this._maintenanceHistoryEndDate = maintenanceHistoryEndDate;
  }

  String? _maintenanceStartDate =
      DateFormat("yyyy-MM-dd").format(DateTime.now());
  String? get maintenanceStartDate => _maintenanceStartDate;
  set maintenanceStartDate(String? maintenanceStartDate) {
    this._maintenanceStartDate = maintenanceStartDate;
  }

  String? _maintenanceEndDate =
      DateFormat("yyyy-MM-dd").format(DateTime.now().add(Duration(days: 30)));
  String? get maintenanceEndDate => _maintenanceEndDate;
  set maintenanceEndDate(String? maintenanceEndDate) {
    this._maintenanceEndDate = maintenanceEndDate;
  }

  DateRangeType _dateType = DateRangeType.currentWeek;
  set dateType(DateRangeType dateType) {
    this._dateType = dateType;
  }

  DateRangeType get dateType => _dateType;

  setUp() {
    _filterService!.setUp();
    _dateRangeService!.setUp();
    _mainNotificationService!.setUp();
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
      //return appliedFilters;
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
        await _dateRangeService!.getDateRangeFilters();
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
      Logger().w("start date $startDate");
      Logger().w("end date $endDate");
    }
    getMaintenanceDateFilter();
  }

  onClearFilterValue() async {
    await _assetStatusService!.setUp();
    _assetStatusService!.onClearLocalFilter();
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

  Future<LoginResponse?> refreshToken() async {
    try {
      var currentCodeVerifier = await _localService!.getCodeVerifier();
      var refreshToken = await _localService!.getRefreshToken();
      codeChallenge = Utils.generateCodeChallenge(_createCodeVerifier(), true);
      Logger().e("code verifier $currentCodeVerifier");
      Logger().i("refresh token $refreshToken");
      Logger().w("code challenge $codeChallenge");
      LoginResponse? result = await _loginService!.getRefreshLoginDataV4(
          code_challenge: codeChallenge,
          code_verifier: currentCodeVerifier,
          token: refreshToken);
      if (result != null) {
        await _localService!.saveTokenInfo(result);
        await _localService!.saveToken(result.access_token);
        await _localService!.saveRefreshToken(result.refresh_token);
        var tokenTime = Utils.tokenExpiresTime(result.expires_in!);
        await _localService!.saveExpiryTime(tokenTime);
      }
      return result;
    } catch (e) {
      throw e;
    }
  }

  getMaintenanceDateFilter() {
    _maintenanceStartDate = _localService?.getMaintenanceFromDate() ??
        DateFormat("yyyy-MM-dd").format(DateTime.now());
    _maintenanceEndDate = _localService?.getMaintenanceEndDate() ??
        DateFormat("yyyy-MM-dd").format(DateTime.now().add(Duration(days: 29)));
  }

  clearSpecificFilterType({FilterType? type}) {
    _assetStatusService!.clearSpecificFilterType(type: type);
  }

  List<FilterData?>? appliedFilters = [];
}
