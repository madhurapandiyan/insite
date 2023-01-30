import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:insite/core/base/insite_view_model.dart';
import 'package:insite/core/locator.dart';
import 'package:insite/core/logger.dart';
import 'package:insite/core/models/filter_data.dart';
import 'package:insite/core/models/manage_notifications.dart';
import 'package:insite/core/services/graphql_schemas_service.dart';
import 'package:insite/core/services/notification_service.dart';
import 'package:insite/views/adminstration/notifications/add_new_notifications/add_new_notifications_view.dart';
import 'package:insite/widgets/dumb_widgets/insite_dialog.dart';
import 'package:load/load.dart';
import 'package:logger/logger.dart';
import 'package:stacked_services/stacked_services.dart';

class ManageNotificationsViewModel extends InsiteViewModel {
  late Logger log;

  NotificationService? _notificationService = locator<NotificationService>();
  final SnackbarService? _snackBarservice = locator<SnackbarService>();
  final GraphqlSchemaService? _graphqlSchemaService =
      locator<GraphqlSchemaService>();

  ScrollController? scrollController = ScrollController();
  bool? isLoadMore;
  int pageNumber = 1;
  int pageCount = 20;

  ManageNotificationsViewModel() {
    this.log = getLogger(this.runtimeType.toString());
    _notificationService!.setUp();

    scrollController?.addListener(() async {
      if (scrollController!.position.pixels ==
          scrollController!.position.maxScrollExtent) {
        if (totalCount != notifications.length) {
          showLoadingDialog();
          _loadingMore = true;
          pageNumber++;
          Logger().w(pageNumber);
          await getManageNotificationsData();
          hideLoadingDialog();
          notifyListeners();
        }
      }
    });
    setUp();
    Future.delayed(Duration.zero, () async {
      await getManageNotificationsData();
    });
  }

  TextEditingController searchController = TextEditingController();

  List<ConfiguredAlerts> _notifications = [];
  List<ConfiguredAlerts> get notifications => _notifications;

  List<ConfiguredAlerts> _searchNotifications = [];

  int _totalCount = 0;

  int get totalCount => _totalCount;

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

  onDeleteClicked(BuildContext context, String? alertId, int? index) async {
    bool? value = await showDialog(
      context: context,
      builder: (BuildContext context) {
        return Dialog(
            backgroundColor: Theme.of(context).backgroundColor,
            child: InsiteDialog(
              title: "Delete Notification",
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
      deleteSelectedNotification(alertId, index!);
    }
  }

  deleteSelectedNotification(String? alertId, int? index) async {
    Logger().i("deleteSelectedUsers");

    showLoadingDialog();
    var result = await _notificationService!.deleteManageNotification(
        alertId, _graphqlSchemaService!.deleteNotification(alertId!));
    if (result != null) {
      await onRemovedSelectedNotification(index!);
      snackbarService!.showSnackbar(message: "Deleted successfully");
    } else {
      snackbarService!.showSnackbar(message: "Deleting failed");
    }

    hideLoadingDialog();
    // getManagerUserAssetList();
  }

  Timer? deBounce;
  onChange() {
    Logger().w(searchController.text);
    if (searchController.text.length >= 4 ||
        searchController.text.length == 1) {
      if (deBounce?.isActive ?? false) {
        deBounce!.cancel();
      }
      deBounce = Timer(Duration(seconds: 2), () {
        getSearchListData();
      });
    } else {
      Logger().w(_searchNotifications.length);
      _notifications = _searchNotifications;
      _totalCount = _searchNotifications.length;
      notifyListeners();
    }
  }

  getSearchListData() async {
    try {
      showLoadingDialog();
      await getSelectedFilterData();
      var notificationFilters = appliedFilters!
          .where((element) => element!.type == FilterType.NOTIFICATION_TYPE);
      var notificationType = notificationFilters.map((e) => e!.title).toList();
      Logger().wtf(notificationType.length);
      ManageNotificationsData? response = await _notificationService!
          .getsearchNotificationsData(
              searchText: searchController.text,
              payLoad: {
            "pageNumber": pageNumber,
            "count": pageCount,
            "searchKey": searchController.text,
            "notificationType":
                notificationType.isNotEmpty ? notificationType : null
          });
      Logger().wtf("response:$response");
      if (response!.total!.items != null) {
        _totalCount = response.total!.items!;
      }
      if (response != null) {
        if (response.configuredAlerts != null &&
            response.configuredAlerts!.isNotEmpty) {
          _notifications = response.configuredAlerts!;
          notifyListeners();
        } else {
          _notifications = response.configuredAlerts!;
          _loading = false;
          _loadingMore = false;
          _shouldLoadmore = false;
          notifyListeners();
        }
      }

      hideLoadingDialog();
    } catch (e) {
      hideLoadingDialog();
    }
  }

  onRemovedSelectedNotification(int? index) {
    try {
      _notifications.removeAt(index!);

      notifyListeners();
    } catch (e) {
      Logger().e(e.toString());
    }
  }

  editNotification(int i) async {
    showLoadingDialog();
    var data = await _notificationService!.alertConfigEdit(
        notifications[i].alertConfigUID!,
        graphqlSchemaService!.editSingleNotification(
            notifications[i].alertConfigUID!, pageNumber.toString()));

    navigationService!.navigateToView(AddNewNotificationsView(
      alertData: data,
    ));
    hideLoadingDialog();
  }

  getManageNotificationsData() async {
    try {
      await getSelectedFilterData();
      var notificationFilters = appliedFilters!
          .where((element) => element!.type == FilterType.NOTIFICATION_TYPE);
      var notificationType = notificationFilters.map((e) => e!.title).toList();
      Logger().wtf(notificationType.length);
      notificationType.forEach((element) {
        Logger().wtf(element);
      });

      ManageNotificationsData? response =
          await _notificationService!.getManageNotificationsData(pageNumber, {
        "pageNumber": pageNumber,
        "count": pageCount,
        "searchKey": "",
        "notificationType":
            notificationType.isNotEmpty ? notificationType : null
      });

      if (response != null) {
        if (response.total!.items != null) {
          _totalCount = response.total!.items!;
        }
        if (response.configuredAlerts != null &&
            response.configuredAlerts!.isNotEmpty) {
          _notifications.addAll(response.configuredAlerts!);

          for (var i = 0; i < _notifications.length; i++) {
            _notifications
                .sort((a, b) => b.createdDate!.compareTo(a.createdDate!));
          }
          _loading = false;
          _loadingMore = false;
          notifyListeners();
        } else {
          _notifications = response.configuredAlerts!;

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
      _searchNotifications = _notifications;
    } catch (e) {
      hideLoadingDialog();
    }
  }

  refresh() async {
    await getSelectedFilterData();
    appliedFilters?.forEach((element) {
      Logger().d(element?.toJson());
    });
    var notificationFilters = appliedFilters!
        .where((element) => element!.type == FilterType.NOTIFICATION_TYPE);
    Logger().wtf("notificationFilters:$notificationFilters");
    _loading = true;
    _loadingMore = true;
    _shouldLoadmore = true;
    notifyListeners();

    ManageNotificationsData? response =
        await _notificationService!.getManageNotificationsData(pageNumber, {
      "pageNumber": pageNumber,
      "count": pageCount,
      "searchKey": "",
      "notificationType": notificationFilters.map((e) => e!.title).toList()
    });

    if (response != null) {
      if (response.total?.items != null) {
        _totalCount = response.total!.items!;
      }
      if (response.configuredAlerts != null &&
          response.configuredAlerts!.isNotEmpty) {
        _notifications.clear();
        _notifications.addAll(response.configuredAlerts!);

        for (var i = 0; i < _notifications.length; i++) {
          _notifications
              .sort((a, b) => b.createdDate!.compareTo(a.createdDate!));
        }
        _loading = false;
        _loadingMore = false;
        notifyListeners();
      } else {
        _notifications = response.configuredAlerts!;

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
    _searchNotifications = _notifications;
  }
}
