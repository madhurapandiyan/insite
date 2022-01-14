import 'package:flutter/material.dart';
import 'package:insite/core/base/insite_view_model.dart';
import 'package:insite/core/locator.dart';
import 'package:insite/core/models/admin_manage_user.dart';
import 'package:insite/core/models/fleet.dart';
import 'package:insite/core/models/main_notification.dart';
import 'package:insite/core/router_constants.dart';
import 'package:insite/core/services/asset_admin_manage_user_service.dart';
import 'package:insite/core/services/fleet_service.dart';
import 'package:insite/core/services/local_service.dart';
import 'package:insite/core/services/main_notification_service.dart';
import 'package:insite/views/detail/asset_detail_view.dart';
import 'package:insite/widgets/dumb_widgets/insite_dialog.dart';
import 'package:load/load.dart';
import 'package:logger/logger.dart';
import 'package:stacked/stacked.dart';
import 'package:insite/core/logger.dart';
import 'package:stacked_services/stacked_services.dart';

class NotificationViewModel extends InsiteViewModel {
  Logger? log;

  MainNotificationService? _mainNotificationService =
      locator<MainNotificationService>();
  NavigationService? _navigationService = locator<NavigationService>();
  FleetService? _fleetService = locator<FleetService>();
  LocalService? _localService = locator<LocalService>();

  int? _totalCount = 0;
  int get totalCount => _totalCount!;

  int? _totalFleetCount = 0;
  int get totalFleetCount => _totalFleetCount!;

  List<Notifications> _assets = [];
  List<Notifications> get assets => _assets;

  Users? _user;
  Users? get userData => _user;

  bool _loadingMore = false;
  bool get loadingMore => _loadingMore;

  bool _isSearching = false;
  bool get isSearching => _isSearching;

  String _serialNo = "";
  String get serialNo => _serialNo;

  bool _showEdit = false;
  bool get showEdit => _showEdit;

  bool _showDelete = false;
  bool get showDelete => _showDelete;

  bool _showDeSelect = false;
  bool get showDeSelect => _showDeSelect;

  int pageNumber = 1;
  int pageSize = 50;

  bool _refreshing = false;
  bool get refreshing => _refreshing;

  bool _shouldLoadmore = true;
  bool get shouldLoadmore => _shouldLoadmore;

  ScrollController? scrollController;

  bool _loading = true;
  bool get loading => _loading;

  NotificationViewModel() {
    this.log = getLogger(this.runtimeType.toString());
    _mainNotificationService!.setUp();
    setUp();

    scrollController = new ScrollController();
    scrollController!.addListener(() {
      if (scrollController!.position.pixels ==
          scrollController!.position.maxScrollExtent) {
        _loadMore();
      }
    });
    Future.delayed(Duration(seconds: 1), () {
      getNotificationData();
    });
  }
  onItemDeselect() {
    try {
      for (int i = 0; i < _assets.length; i++) {
        _assets[i].isSelected = false;
      }
    } catch (e) {
      Logger().e(e);
    }
    notifyListeners();
    checkEditAndDeleteVisibility();
  }

  getNotificationData() async {
    NotificationsData? response = await _mainNotificationService!
        .getNotificationsData("0", "0", startDate, endDate);
    if (response != null) {
      if (response.total!.items != null) {
        _totalCount = response.total!.items;
      }
      if (response.notifications != null &&
          response.notifications!.isNotEmpty) {
        _assets.addAll(response.notifications!);
        _loading = false;
        _loadingMore = false;
        notifyListeners();
      } else {
        _assets.addAll(response.notifications!);
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
  }

  getNotificationsDetails(assetUid) async {
    Fleet? response =
        await _mainNotificationService!.getNotificationDetails(assetUid);

    _localService!.saveNotificationId(assetUid);

    onDetailPageSelected(response);
  }

  onItemSelected(index) {
    try {
      _assets[index].isSelected = !_assets[index].isSelected!;
    } catch (e) {
      Logger().e(e);
    }
    notifyListeners();
    checkEditAndDeleteVisibility();
  }

  onDetailPageSelected(Fleet? fleet) {
    _navigationService!.navigateTo(assetDetailViewRoute,
        arguments: DetailArguments(
          fleet: fleet,
          index: 0,
        ));
  }

  checkEditAndDeleteVisibility() {
    Logger().i("checkEditAndDeleteVisibility");
    try {
      var count = 0;
      for (int i = 0; i < _assets.length; i++) {
        var data = _assets[i];
        if (data.isSelected!) {
          count++;
        }
      }
      if (count > 0) {
        if (count >= 1) {
          _showEdit = false;
          _showDelete = true;
          _showDeSelect = true;
        } else {
          _showEdit = true;
          _showDelete = true;
          _showDeSelect = true;
        }
      } else {
        _showEdit = false;
        _showDelete = false;
        _showDeSelect = false;
      }
    } catch (e) {}
    notifyListeners();
  }

  _loadMore() {
    if (_shouldLoadmore && !_loadingMore) {
      pageNumber++;
      _loadingMore = true;
      notifyListeners();
      getNotificationData();
    }
  }
}
