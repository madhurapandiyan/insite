import 'package:flutter/material.dart';
import 'package:insite/core/base/insite_view_model.dart';
import 'package:insite/core/locator.dart';
import 'package:insite/core/models/notification_type.dart';
import 'package:insite/core/services/notification_service.dart';
import 'package:logger/logger.dart';
import 'package:stacked/stacked.dart';
import 'package:insite/core/logger.dart';

class AddNewNotificationsViewModel extends InsiteViewModel {
  late Logger log;

  NotificationService? _notificationService = locator<NotificationService>();
  TabController? controller;

  AddNewNotificationsViewModel() {
    this.log = getLogger(this.runtimeType.toString());
    _notificationService!.setUp();
    Future.delayed(Duration(seconds: 1), () {
      getNotificationTypesData();
    });
  }

  @override
  void dispose() {
    super.dispose();
    controller!.dispose();
  }

  List<String?> _noticationTypes = ["select"];
  List<String?> get notificationTypes => _noticationTypes;

  List<String?> _notificationSubTypes = ["Options"];
  List<String?> get notificationSubTypes => _notificationSubTypes;

  List<String> _type = [
    "select",
    "Range",
    "All day",
  ];
  List<String> get type => _type;

  List<String> _startTimes = ["select", "12:01", "3:00", "2:00", "1:00"];
  List<String> get startTimes => _startTimes;

  List<String> _endTimes = ["select", "12:01", "3:00", "2:00", "1:00"];
  List<String> get endTimes => _endTimes;

  bool _loading = true;
  bool get loading => _loading;

  bool _loadingMore = false;
  bool get loadingMore => _loadingMore;

  bool _shouldLoadmore = true;
  bool get shouldLoadmore => _shouldLoadmore;

  String _dropDownInitialValue = "select";
  String get dropDownInitialValue => _dropDownInitialValue;

  String _dropDownSubInitialValue = "Options";
  String get dropDownSubInitialValue => _dropDownSubInitialValue;

  bool _showNotificationType = false;
  bool get showNotificationType => _showNotificationType;

  bool _showConditionTypes = false;
  bool get showConditionTypes => _showConditionTypes;

  bool _showFaultValue = false;
  bool get showFaultValue => _showFaultValue;

  bool _showFuelLoss = false;
  bool get showFuelLoss => _showFuelLoss;

  bool _setOdometer = false;
  bool get setOdometer => _setOdometer;

  updateModelValue(String value) {
    _notificationSubTypes.clear();
    _notificationSubTypes.add("Options");
    _dropDownSubInitialValue = "Options";

    _showConditionTypes = false;
    _showNotificationType = false;
    _showFuelLoss = false;
    _setOdometer = false;

    _dropDownInitialValue = value;

    getNotificationSubTypes(_dropDownInitialValue);

    notifyListeners();
  }

  updateSubModelValue(String value) {
    _dropDownSubInitialValue = value;

    notifyListeners();
  }

  getNotificationSubTypes(String value) async {
    AlertTypes? response = await _notificationService!.getNotificationTypes();

    if (response != null) {
      if (response.notificationTypeGroups != null &&
          response.notificationTypeGroups!.isNotEmpty) {
        for (var notification in response.notificationTypeGroups!) {
          if (value == notification.notificationTypeGroupName &&
              notification.notificationTypes!.isNotEmpty &&
              notification.notificationTypeGroupName == "Asset Status") {
            for (var item in notification.notificationTypes!) {
              _showNotificationType = true;
              _notificationSubTypes.add(item.notificationTypeName);
            }
          } else if (value == notification.notificationTypeGroupName &&
              notification.notificationTypes!.isNotEmpty) {
            if (notification.notificationTypeGroupName == "Fuel") {
              for (var item in notification
                  .notificationTypes!.first.operands!.first.operators!) {
                _showConditionTypes = true;
                _notificationSubTypes.add(item.name);
              }
            }
            if (notification.notificationTypeGroupName == "Engine Hours") {
              for (var item in notification
                  .notificationTypes!.first.operands!.first.operators!) {
                _showConditionTypes = true;
                _notificationSubTypes.add(item.name);
              }
            }
            if (notification.notificationTypeGroupName == "Odometer") {
              for (var item in notification
                  .notificationTypes!.first.operands!.first.operators!) {
                _showConditionTypes = true;
                _setOdometer = true;
                _notificationSubTypes.add(item.name);
              }
            }
            if (notification.notificationTypeGroupName == "Fuel Loss") {
              _showFuelLoss = true;
            }
            if (notification.notificationTypeGroupName ==
                "Excessive Daily Idle") {
              for (var item in notification
                  .notificationTypes!.first.operands!.first.operators!) {
                _showConditionTypes = true;
                _notificationSubTypes.add(item.name);
              }
            } else if (value == notification.notificationTypeGroupName &&
                notification.notificationTypes!.isNotEmpty &&
                notification.notificationTypeGroupName == "Maintenance") {
              List<String> maintainanceList = ["Overdue", "Upcoming"];
              _notificationSubTypes.addAll(maintainanceList);
            }
          }

          _loading = false;
          _loadingMore = false;
        }
      } else {
        // for (var notification in response.notificationTypeGroups!) {
        //   if (value == notification.notificationTypeGroupName &&
        //       notification.notificationTypes!.isNotEmpty) {
        //     for (var item in notification.notificationTypes!) {
        //       notificationSubTypes.add(item.notificationTypeName);
        //     }
        //   }
        // }

        _loading = false;
        _loadingMore = false;
        _shouldLoadmore = false;
      }
    } else {
      _loading = false;
      _loadingMore = false;
    }

    notifyListeners();

    Logger().wtf(response);
  }

  getNotificationTypesData() async {
    AlertTypes? response = await _notificationService!.getNotificationTypes();

    if (response != null) {
      if (response.notificationTypeGroups != null &&
          response.notificationTypeGroups!.isNotEmpty) {
        for (var notification in response.notificationTypeGroups!) {
          _noticationTypes.add(notification.notificationTypeGroupName!);
        }

        _loading = false;
        _loadingMore = false;
      } else {
        for (var notification in response.notificationTypeGroups!) {
          _noticationTypes.add(notification.notificationTypeGroupName!);
        }

        _loading = false;
        _loadingMore = false;
        _shouldLoadmore = false;
      }
    } else {
      _loading = false;
      _loadingMore = false;
    }
    notifyListeners();

    Logger().wtf(response);
  }
}
