import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:insite/core/base/insite_view_model.dart';
import 'package:insite/core/locator.dart';
import 'package:insite/core/logger.dart';
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

  ScrollController? controller;
  bool? isLoadMore;
  int pageNumber = 1;
  int pageCount = 20;
  ManageNotificationsViewModel() {
    this.log = getLogger(this.runtimeType.toString());
    _notificationService!.setUp();
    setUp();
    Future.delayed(Duration.zero, () async {
      await getManageNotificationsData();
    });

    controller?.addListener(() {
      if (controller!.position.pixels == controller!.position.maxScrollExtent) {
        Logger().e(1);
        _loadingMore = true;
        pageNumber = pageNumber++;
        getManageNotificationsData();
        notifyListeners();
      }
    });
  }

  TextEditingController searchController = TextEditingController();

  List<ConfiguredAlerts> _notifications = [];
  List<ConfiguredAlerts> get notifications => _notifications;

  bool _isSearching = false;
  bool get isSearching => _isSearching;

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

  searchGroups(String searchValue) {
    _isSearching = true;
    _searchKeyword = searchValue;
    notifyListeners();
    _searchKeyword = searchValue;
    getSearchListData(_searchKeyword);
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
    List<String> uids = [];
    uids.add(alertId!);
    var result = await _notificationService!.deleteManageNotification(
        alertId, _graphqlSchemaService!.deleteNotification(uids));
    if (result != null) {
      await onRemovedSelectedNotification(index!);
      snackbarService!.showSnackbar(message: "Deleted successfully");
    } else {
      snackbarService!.showSnackbar(message: "Deleting failed");
    }

    hideLoadingDialog();
    // getManagerUserAssetList();
  }

  getSearchListData(String? searchValue) async {
    try {
      if (searchValue!.length >= 4) {
        showLoadingDialog();
        notifications.clear();
        ManageNotificationsData? response = await _notificationService!
            .getsearchNotificationsData(
                pageNumber: pageNumber,
                count: pageCount,
                searchText: searchValue);

        if (response != null) {
          if (response.configuredAlerts != null &&
              response.configuredAlerts!.isNotEmpty) {
            _notifications.clear();
            _notifications.addAll(response.configuredAlerts!);
            _isSearching = false;
            notifyListeners();
          } else {
            _notifications.clear();
            _isSearching = false;
            notifyListeners();
          }
        } else {
          _loading = false;
          _loadingMore = false;
          _isSearching = false;
          notifyListeners();
        }
        hideLoadingDialog();
      } else if (searchValue.isEmpty) {
        showLoadingDialog();
        await getManageNotificationsData();
        hideLoadingDialog();
      }
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
    Logger().w(data!.toJson());

    navigationService!.navigateToView(AddNewNotificationsView(
      alertData: data,
    ));
    hideLoadingDialog();
  }

  getManageNotificationsData() async {
    try {
      _notifications.clear();
      ManageNotificationsData? response = await _notificationService!
          .getManageNotificationsData(pageNumber, pageCount, "");
      Logger().wtf(response!.toJson());

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
    } catch (e) {
      hideLoadingDialog();
    }
  }
}
