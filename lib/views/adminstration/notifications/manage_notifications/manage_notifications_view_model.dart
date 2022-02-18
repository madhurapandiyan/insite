import 'package:flutter/cupertino.dart';
import 'package:insite/core/base/insite_view_model.dart';
import 'package:insite/core/locator.dart';
import 'package:insite/core/logger.dart';
import 'package:insite/core/models/manage_notifications.dart';
import 'package:insite/core/services/notification_service.dart';
import 'package:logger/logger.dart';
import 'package:stacked_services/stacked_services.dart';

class ManageNotificationsViewModel extends InsiteViewModel {
  late Logger log;

  NotificationService? _notificationService = locator<NotificationService>();
  final SnackbarService? _snackBarservice = locator<SnackbarService>();

  ManageNotificationsViewModel() {
    this.log = getLogger(this.runtimeType.toString());
    _notificationService!.setUp();
    setUp();
    getManageNotificationsData();
  }

  TextEditingController searchController = TextEditingController();

  List<ConfiguredAlerts> _notifications = [];
  List<ConfiguredAlerts> get notifications => _notifications;

  bool _isSearching = false;
  bool get isSearching => _isSearching;

  bool _loading = true;
  bool get loading => _loading;

  bool _loadingMore = false;
  bool get loadingMore => _loadingMore;

  bool _shouldLoadmore = true;
  bool get shouldLoadmore => _shouldLoadmore;

  String _searchKeyword = '';
  set searchKeyword(String keyword) {
    this._searchKeyword = keyword;
  }

  searchGroups(String searchValue) {
    _isSearching = true;
    _searchKeyword = searchValue;
    notifyListeners();
    _searchKeyword = searchValue;
    getSearchListData(_searchKeyword);
  }

  getSearchListData(String? searchValue) async {
    ManageNotificationsData? response =
        await _notificationService!.getsearchNotificationsData(searchValue);
    Logger().wtf(response!.toJson());
    _notifications.clear();

    if (response != null) {
      if (response.configuredAlerts != null &&
          response.configuredAlerts!.isNotEmpty) {
        _notifications.addAll(response.configuredAlerts!);

        _loading = false;
        _loadingMore = false;
        _isSearching = false;
        notifyListeners();
      } else {
        _loading = false;
        _loadingMore = false;
        _shouldLoadmore = false;
        _isSearching = false;
        notifyListeners();
      }
    } else {
      _loading = false;
      _loadingMore = false;
      _isSearching = false;
      notifyListeners();
    }
  }

  onRemovedSelectedNotification(int? index) {
    try {
      _notifications.removeAt(index!);
      _snackBarservice!.showSnackbar(message: "Notification deleted.");

      notifyListeners();
    } catch (e) {
      Logger().e(e.toString());
    }
  }

  getManageNotificationsData() async {
    ManageNotificationsData? response =
        await _notificationService!.getManageNotificationsData();

    if (response != null) {
      if (response.configuredAlerts != null &&
          response.configuredAlerts!.isNotEmpty) {
        _notifications.addAll(response.configuredAlerts!);
        _loading = false;
        _loadingMore = false;
        notifyListeners();
      } else {
        _notifications.addAll(response.configuredAlerts!);
        _loading = false;
        _loadingMore = false;
        _shouldLoadmore = false;
        notifyListeners();
      }
    } else {
      _loading = false;
      _loadingMore = false;
      notifyListeners();
    }

    Logger().wtf(response);
  }
}
