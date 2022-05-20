import 'package:flutter/material.dart';
import 'package:insite/core/base/insite_view_model.dart';
import 'package:insite/core/locator.dart';
import 'package:insite/core/models/admin_manage_user.dart';
import 'package:insite/core/models/fleet.dart';
import 'package:insite/core/models/main_notification.dart' as notification;
import 'package:insite/core/router_constants.dart';
import 'package:insite/core/services/asset_admin_manage_user_service.dart';
import 'package:insite/core/services/fleet_service.dart';
import 'package:insite/core/services/graphql_schemas_service.dart';
import 'package:insite/core/services/local_service.dart';
import 'package:insite/core/services/notification_service.dart';
import 'package:insite/utils/helper_methods.dart';
import 'package:insite/views/detail/asset_detail_view.dart';
import 'package:insite/widgets/dumb_widgets/insite_dialog.dart';
import 'package:load/load.dart';
import 'package:logger/logger.dart';
import 'package:stacked/stacked.dart';
import 'package:insite/core/logger.dart';
import 'package:stacked_services/stacked_services.dart';

class NotificationViewModel extends InsiteViewModel {
  Logger? log;

  NotificationService? _mainNotificationService =
      locator<NotificationService>();
  NavigationService? _navigationService = locator<NavigationService>();
  GraphqlSchemaService? _graphqlSchemaService = locator<GraphqlSchemaService>();
  FleetService? _fleetService = locator<FleetService>();
  LocalService? _localService = locator<LocalService>();

  int? _totalCount = 0;
  int get totalCount => _totalCount!;

  int? _totalFleetCount = 0;
  int get totalFleetCount => _totalFleetCount!;

  List<notification.Notification> _assets = [];
  List<notification.Notification> get assets => _assets;

  Users? _user;
  Users? get userData => _user;

  bool _loadingMore = false;
  bool get loadingMore => _loadingMore;

  bool _isSearching = false;
  bool get isSearching => _isSearching;

  String _serialNo = "";
  String get serialNo => _serialNo;

  bool _showMenu = false;
  bool get showMenu => _showMenu;

  bool _showEdit = false;
  bool get showEdit => _showEdit;

  bool _showDelete = false;
  bool get showDelete => _showDelete;

  bool _showDeSelect = false;
  bool get showDeSelect => _showDeSelect;

  int pageNumber = 1;
  int pageCount = 50;

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
        if (assets.length != totalCount) {
          _loadMore();
        }
      }
    });
    Future.delayed(Duration(seconds: 1), () async {
      await getNotificationData();
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

  refresh() async {
    try {
      await getSelectedFilterData();
      await getDateRangeFilterData();
      pageNumber = 1;
      pageCount = 50;
      _refreshing = true;
      _shouldLoadmore = true;
      notifyListeners();
      Logger().wtf("start date " + startDate!);
      Logger().wtf("end date " + endDate!);

      await getNotificationData();

      notification.NotificationsData? response = await _mainNotificationService!
          .getNotificationsData(
              "0",
              "0",
              startDate!,
              endDate!,
              _graphqlSchemaService!.seeAllNotification(
                  endDate: Utils.getDateInFormatyyyyMMddTHHmmssZEnd(endDate),
                  startDate:
                      Utils.getDateInFormatyyyyMMddTHHmmssZStart(startDate),
                  pageNo: pageNumber));
      if (response != null) {
        _assets.clear();
        if (response.total!.items != null) {
          _totalCount = response.total!.items;
        }
        if (response.notifications != null &&
            response.notifications!.isNotEmpty) {
          _assets.addAll(response.notifications!);
        }
        _refreshing = false;
        notifyListeners();
      } else {
        _refreshing = false;
        notifyListeners();
      }
    } catch (e) {
      Logger().e(e.toString());
    }
  }

  onRemovedSelectedNotification(int index) {
    try {
      _assets.removeAt(index);
      notifyListeners();
    } catch (e) {
      Logger().e(e.toString());
    }
  }

  onDeleteClicked(BuildContext context, int? index) async {
    bool? value = await showDialog(
      context: context,
      builder: (BuildContext context) {
        return Dialog(
            backgroundColor: Theme.of(context).backgroundColor,
            child: InsiteDialog(
              title: "Delete User",
              message:
                  "Are you sure you want to permanently remove this notification?",
              onPositiveActionClicked: () {
                Navigator.pop(context, true);
              },
              onNegativeActionClicked: () {
                Navigator.pop(context, false);
              },
            ));
      },
    );
    if (value != null && value) {
      deleteSelectedNotification();
    }
  }

  deleteSelectedNotification() async {
    try {
      List<String>? ids = [];
      String doubleQuote = "\"";
      for (int i = 0; i < assets.length; i++) {
        var data = assets[i];
        if (data.isSelected!) {
          ids.add(data.notificationUID!);
          Logger().e(ids.length.toString());
        }
      }
      if (ids != null) {
        showLoadingDialog();
        var result =
            await _mainNotificationService!.deleteMainNotification(ids);
        if (result != null) {
          await deleteNotificationFromList(ids);
          snackbarService!.showSnackbar(message: "Deleted successfully");
        } else {
          snackbarService!.showSnackbar(message: "Deleting failed");
        }

        hideLoadingDialog();
      }
    } catch (e) {
      Logger().e(e.toString());
    }
  }

  deleteNotificationFromList(List<String> ids) {
    Logger().i("deleteReportFromList");
    ids.forEach((id) {
      _assets.removeWhere((element) => element.notificationUID == id);
    });

    _totalCount = _totalCount! - ids.length;
    notifyListeners();
    checkEditAndDeleteVisibility();
  }

  getNotificationData() async {
    notification.NotificationsData? response = await _mainNotificationService!
        .getNotificationsData(
            "0",
            "0",
            startDate,
            endDate,
            _graphqlSchemaService!.seeAllNotification(
                endDate: Utils.getDateInFormatyyyyMMddTHHmmssZEnd(endDate),
                startDate:
                    Utils.getDateInFormatyyyyMMddTHHmmssZStart(startDate),
                pageNo: pageNumber));
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

  onItemSelected(index) {
    try {
      _assets[index].isSelected = !_assets[index].isSelected!;
    } catch (e) {
      Logger().e(e);
    }
    notifyListeners();
    checkEditAndDeleteVisibility();
  }

  onDetailPageSelected(notification.Notification? notification) {
    _navigationService!.navigateTo(assetDetailViewRoute,
        arguments: DetailArguments(
          fleet: Fleet(
              assetSerialNumber: notification!.serialNumber,
              assetId: null,
              assetIdentifier: notification.assetUID),
          index: 0,
        ));
  }

  checkEditAndDeleteVisibility() {
    try {
      var count = 0;

      for (int i = 0; i < _assets.length; i++) {
        var data = _assets[i];
        if (data.isSelected!) {
          count++;
        }
      }

      if (count > 0) {
        if (count > 1) {
          _showMenu = true;
          _showDeSelect = true;
          _showEdit = true;
        } else {
          _showMenu = true;
          _showDeSelect = true;
          _showEdit = true;
        }
      } else {
        _showEdit = false;
        _showEdit = false;
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

  onSelectedItemClicK(String value, BuildContext context, int? index) {
    if (value == "deselect") {
      onItemDeselect();
    } else if (value == "resolve") {
      onItemDeselect();
    } else if (value == "Delete") {
      onDeleteClicked(context, index);
    }
  }
}
