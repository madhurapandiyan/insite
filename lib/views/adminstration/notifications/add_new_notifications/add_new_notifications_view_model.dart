import 'dart:async';
import 'package:insite/core/models/manage_notifications.dart';
import 'package:insite/core/services/graphql_schemas_service.dart';
import 'package:insite/views/adminstration/notifications/add_new_notifications/model/alert_config_edit.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:insite/core/base/insite_view_model.dart';
import 'package:insite/core/locator.dart';
import 'package:insite/core/models/add_notification_payload.dart';

import 'package:insite/core/models/asset_group_summary_response.dart';
import 'package:insite/core/models/customer.dart';
import 'package:insite/core/models/notification_type.dart';
import 'package:insite/core/models/search_contact_report_list_response.dart';
import 'package:insite/core/services/asset_admin_manage_user_service.dart';
import 'package:insite/core/services/geofence_service.dart';
import 'package:insite/core/services/local_service.dart';
import 'package:insite/core/services/notification_service.dart';
import 'package:insite/theme/colors.dart';
import 'package:insite/views/adminstration/addgeofense/exception_handle.dart';
import 'package:insite/views/adminstration/notifications/add_new_notifications/reusable_widget/multi_custom_dropDown_widget.dart';
import 'package:insite/views/adminstration/notifications/manage_notifications/manage_notifications_view.dart';
import 'package:intl/intl.dart';
import 'package:load/load.dart';
import 'package:logger/logger.dart';
import 'package:insite/core/logger.dart';
import 'package:stacked_services/stacked_services.dart';
import '../../add_group/model/add_group_model.dart';
import './model/zone.dart';

import 'model/fault_code_type_search.dart';

class AddNewNotificationsViewModel extends InsiteViewModel {
  Logger? log;

  NotificationService? _notificationService = locator<NotificationService>();
  LocalService? _localService = locator<LocalService>();

  final AssetAdminManagerUserService? _manageUserService =
      locator<AssetAdminManagerUserService>();
  final SnackbarService? _snackBarservice = locator<SnackbarService>();
  NavigationService? _navigationService = locator<NavigationService>();
  final Geofenceservice? _geofenceservice = locator<Geofenceservice>();
  GraphqlSchemaService? graphqlSchemaService = locator<GraphqlSchemaService>();
  TabController? controller;
  Customer? accountSelected;
  @override
  void dispose() {
    super.dispose();
    controller!.dispose();
  }

  AddNewNotificationsViewModel(AlertConfigEdit? data) {
    this.log = getLogger(this.runtimeType.toString());
    _notificationService!.setUp();
    setUp();

    Future.delayed(Duration(seconds: 1), () async {
      await getNotificationTypesData();
      // onGettingFaultCodeData();
      if (data != null) {
        Future.delayed(Duration.zero, () async {
          editingNotification(data);
        });
      } else {
        Future.delayed(Duration.zero, () async {
          getGroupListData();
        });
      }
      faultCodeScrollController.addListener(() {
        if (faultCodeScrollController.position.pixels ==
            faultCodeScrollController.position.maxScrollExtent) {
          page++;
          _loadingMore = true;
          //onGettingFaultCodeData();
        }
      });
    });
  }

  ScrollController faultCodeScrollController = ScrollController();
  setUp() async {
    try {
      accountSelected = await _localService!.getAccountInfo();
    } catch (e) {
      Logger().e(e);
    }
  }

  bool isEditing = false;

  List<String?> _noticationTypes = ["select"];
  List<String?> get notificationTypes => _noticationTypes;

  List<CheckBoxDropDown> _zoneNamesInclusion = [];
  List<CheckBoxDropDown> get zoneNamesInclusion => _zoneNamesInclusion;

  List<CheckBoxDropDown> _zoneNamesExclusion = [];
  List<CheckBoxDropDown> get zoneNamesExclusion => _zoneNamesExclusion;

  List<String?> _notificationSubTypes = ["Options"];
  List<String?> get notificationSubTypes => _notificationSubTypes;

  List<String> _choiseData = [
    "Assets",
  ];
  List<String> get choiseData => _choiseData;

  bool _loading = true;
  bool get loading => _loading;

  bool _loadingMore = false;
  bool get loadingMore => _loadingMore;

  String _dropDownInitialValue = "select";
  String get dropDownInitialValue => _dropDownInitialValue;

  String _dropDownSubInitialValue = "Options";
  String get dropDownSubInitialValue => _dropDownSubInitialValue;

  String _inclusionInitialValue = "Select Inclusion Zone";
  String get inclusionInitialValue => _inclusionInitialValue;

  String _exclusionInitialValue = "Select Exclusion Zone";
  String get exclusionInitialValue => _exclusionInitialValue;

  bool isDrawing = false;
  bool isAddingInclusionZone = false;
  bool isAddingExclusionZone = false;
  bool isFaultCodePressed = false;
  bool isShowingSelectedContact = false;

  bool _showZone = false;
  bool get showZone => _showZone;

  bool isSelecetedForAllDays = false;

  List<User>? searchContactListName = [];
  bool isHideSearchList = false;

  String? alertConfigUid;

  String _searchKeyword = '';
  set searchKeyword(String keyword) {
    this._searchKeyword = keyword;
  }

  AssetGroupSummaryResponse? assetIdresult;

  List<String> dropDownList = ["All", "ID", "S/N"];

  String initialValue = "All";

  List<Asset>? selectedAsset = [];
  List<Asset>? searchAsset = [];

  bool isLoading = true;
  bool isSearching = false;

  List<String>? selectedContactItems = [];

  List<String>? phoneNumbers = [];
  List<String>? emailIds = [];

  List<String>? notificationFleetType = [];
  List<String>? notificationServiceType = [];
  List<String>? geofenceAssets = [];
  List<String>? administratortAssets = [];

  AlertTypes? alterTypes;
  AlertConfigEdit? alertConfigData;

  // text editing controller
  TextEditingController inclusionZoneName = TextEditingController();
  TextEditingController exclusionZoneName = TextEditingController();
  TextEditingController nameController = TextEditingController();
  TextEditingController notificationController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();
  TextEditingController occurenceController = TextEditingController(text: "1");
  TextEditingController assetStatusOccurenceController =
      TextEditingController(text: "1");

  // text editing controller ----------------------------

  List<ScheduleData> schedule = [
    ScheduleData(
        day: 0,
        title: "S",
        startTime: "00:00",
        endTime: "24:00",
        initialVale: "Not To Be Schedule",
        color: white),
    ScheduleData(
        day: 1,
        title: "M",
        startTime: "00:00",
        endTime: "24:00",
        initialVale: "Not To Be Schedule",
        color: white),
    ScheduleData(
        day: 2,
        title: "T",
        startTime: "00:00",
        endTime: "24:00",
        initialVale: "Not To Be Schedule",
        color: white),
    ScheduleData(
        day: 3,
        title: "W",
        startTime: "00:00",
        endTime: "24:00",
        initialVale: "Not To Be Schedule",
        color: white),
    ScheduleData(
        day: 4,
        title: "Th",
        startTime: "00:00",
        endTime: "24:00",
        initialVale: "Not To Be Schedule",
        color: white),
    ScheduleData(
        day: 5,
        title: "F",
        startTime: "00:00",
        endTime: "24:00",
        initialVale: "Not To Be Schedule",
        color: white),
    ScheduleData(
        day: 6,
        title: "SA",
        startTime: "00:00",
        endTime: "24:00",
        initialVale: "Not To Be Schedule",
        color: white),
  ];

  changingTabColor(int i) {
    schedule.forEach((element) {
      element.color = black;
    });
    schedule[i].color = white;

    notifyListeners();
  }

  AssetGroupSummaryResponse? groupSummaryResponseData;

  List<String> associatedAssetId = [];
  List<String> dissociatedAssetId = [];

  List<String>? svcBody = [];
  List<AddGroupModel>? selectedItemAssets = [];

  List<String> assetUidData = [];

  List<SwitchState> switchState = [
    SwitchState(state: true, text: "Open"),
    SwitchState(state: true, text: "Close")
  ];
  List<SwitchState> powerModeState = [
    SwitchState(state: true, text: "Economy"),
    SwitchState(state: true, text: "Standard"),
    SwitchState(state: true, text: "Run")
  ];

  List<SwitchState> severityState = [
    SwitchState(state: false, text: "High"),
    SwitchState(state: false, text: "Medium"),
    SwitchState(state: false, text: "Low")
  ];

  List<SwitchState> faultCodeType = [
    SwitchState(state: false, text: "Event"),
    SwitchState(state: false, text: "Diagnostic")
  ];

  List<SwitchState> customizableState = [
    SwitchState(state: false, text: "Include"),
    SwitchState(state: false, text: "Exclude")
  ];
  List<SwitchState> customizable = [
    SwitchState(state: false, text: "Customize"),
  ];

  List<SwitchState> fluidAnalysisState = [
    SwitchState(state: true, text: "Action Required"),
    SwitchState(state: true, text: "Monitor"),
    SwitchState(state: true, text: "No Action"),
  ];

  List<SwitchState> inspectionState = [
    SwitchState(state: true, text: "Red"),
    SwitchState(state: true, text: "Yellow"),
    SwitchState(state: true, text: "Green"),
    SwitchState(state: true, text: "Grey"),
  ];

  List<SwitchState> assetSecurityState = [
    SwitchState(state: true, text: "Normal Operation"),
    SwitchState(state: true, text: "Disabled"),
    SwitchState(state: true, text: "Derated"),
  ];

  List<SwitchState> overDueState = [
    SwitchState(
        state: true,
        text: "Hours After Overdue",
        controller: TextEditingController()),
    SwitchState(
        state: true,
        text: "Distance Travelled After Overdue",
        controller: TextEditingController()),
  ];
  List<SwitchState> upcomingState = [
    SwitchState(
        state: true,
        text: "Due in",
        controller: TextEditingController(),
        suffixTitle: "Miles"),
    SwitchState(
        state: true,
        text: "Due in",
        controller: TextEditingController(),
        suffixTitle: "Hours"),
    SwitchState(
        state: true,
        text: "Due in",
        controller: TextEditingController(),
        suffixTitle: "Days"),
  ];

  PageController pageController = PageController();
  Completer<GoogleMapController> googleMapController = Completer();
  CameraPosition centerPosition = CameraPosition(
    target: LatLng(30.666, 76.8127),
  );

  double radius = 50000;
  int page = 1;
  Set<Circle> circle = {};
  List<CheckBoxDropDown> geoenceData = [];
  List<String> selectedList = [];
  String expansionTitle = "Description";
  int notificationTypeGroupID = 0;
  int notificationTypeId = 0;
  List<Operand> operandData = [];
  NotificationTypes? notificationType;

  List<User> selectedUser = [];

  TextEditingController faultCodeSearchController = TextEditingController();

  List<FaultCodeDetails>? faultCodeTypeSearch = [];
  List<FaultCodeDetails>? SelectedfaultCodeTypeSearch = [];

  bool isTitleExist = false;
  bool isNotificationNameChange = false;

  String initialEndValue = "24:00";
  String initialStartValue = "00:00";
  String initialDayOption = "All Days";
  bool checkingAllDay = true;

  List<CheckBoxDropDown> selectedDays = [];
  List<Schedule> scheduleDay = [];

  List<String> days = ["All Days", "Days"];

  onConformingDropDown(List<String> value) {
    selectedList = value;
    Logger().e(value);
    notifyListeners();
  }

  onSelectingDays() {
    String? title;
    var data = schedule.where((element) => element.isSelected == true).toList();
    for (var i = 0; i < data.length; i++) {
      if (data[i].day == 0) {
        scheduleDay.add(Schedule(
            day: data[i].day,
            title: "Sunday",
            endTime: initialEndValue,
            startTime: initialStartValue));
      } else if (data[i].day == 1) {
        scheduleDay.add(Schedule(
            day: data[i].day,
            title: "Monday",
            endTime: initialEndValue,
            startTime: initialStartValue));
      } else if (data[i].day == 2) {
        scheduleDay.add(Schedule(
            day: data[i].day,
            title: "Tuesday",
            endTime: initialEndValue,
            startTime: initialStartValue));
      } else if (data[i].day == 3) {
        scheduleDay.add(Schedule(
            day: data[i].day,
            title: "Wednesday",
            endTime: initialEndValue,
            startTime: initialStartValue));
      } else if (data[i].day == 4) {
        scheduleDay.add(Schedule(
            day: data[i].day,
            title: "Thursday",
            endTime: initialEndValue,
            startTime: initialStartValue));
      } else if (data[i].day == 5) {
        scheduleDay.add(Schedule(
            day: data[i].day,
            title: "Friday",
            endTime: initialEndValue,
            startTime: initialStartValue));
      } else if (data[i].day == 6) {
        scheduleDay.add(Schedule(
            day: data[i].day,
            title: "Saturday",
            endTime: initialEndValue,
            startTime: initialStartValue));
      }
    }
    // showSelectedDays!.replaceRange(0, 5,"");
    notifyListeners();
  }

  getGroupListData() async {
    try {
      assetIdresult = await _manageUserService!.getGroupListData(false);
      if (isEditing) {
        var allAsset = await _manageUserService!.getGroupListData(true);
        allAsset?.assetDetailsRecords?.forEach((element) {
          if (alertConfigData!.alertConfig!.assets!.any(
              (editData) => editData.assetUID == element.assetIdentifier)) {
            Logger().wtf(alertConfigData!.alertConfig!.assets!.any(
                (editData) => editData.assetUID == element.assetIdentifier));
            selectedAsset!.add(Asset(
                assetIcon: element.assetIcon,
                assetId: element.assetId,
                assetIdentifier: element.assetIdentifier,
                assetSerialNumber: element.assetSerialNumber,
                makeCode: element.makeCode,
                model: element.model));
          }
        });
      }
      isLoading = false;
      notifyListeners();
    } catch (e) {
      isLoading = false;
      hideLoadingDialog();
      snackbarService?.showSnackbar(
          message:
              "Assets Are Not Loaded.Something Went Wrong.Try Again Later ");
      notifyListeners();
      Logger().e(e.toString());
    }
  }

  onDeletingSelectedDays(int i) {
    //var data = selectedDays.elementAt(i);
    scheduleDay.removeAt(i);

    notifyListeners();
  }

  onChangingSubType(value) {
    _dropDownSubInitialValue = value;
    notifyListeners();
  }

  onSwitchAllscheduleDate(bool value, int i) {
    var data = schedule.elementAt(i);
    schedule.forEach((element) {
      element.endTime = data.endTime;
      element.startTime = data.startTime;
      element.initialVale = data.initialVale;
      element.isSelected = false;
    });
    schedule[i].isSelected = value;

    notifyListeners();
  }

  onDaysSelected(int i) {
    schedule[i].isSelected = !schedule[i].isSelected!;
    notifyListeners();
  }

  onAddingAsset(int i, Asset? selectedData) {
    if (selectedData != null) {
      if (selectedAsset!.any((element) =>
          element.assetIdentifier == selectedData.assetIdentifier)) {
        snackbarService!.showSnackbar(message: "Asset Alerady Selected");
      } else {
        Logger().i(assetIdresult?.assetDetailsRecords?.length);
        assetIdresult?.assetDetailsRecords?.removeWhere((element) =>
            element.assetIdentifier == selectedData.assetIdentifier);
        selectedAsset?.add(selectedData);
        Logger().d(assetIdresult?.assetDetailsRecords?.length);
      }
    }
    notifyListeners();
  }

  onDeletingAsset(int i) {
    try {
      if (selectedAsset != null) {
        Logger().e(selectedAsset?.length);
        var data = selectedAsset?.elementAt(i);
        assetIdresult?.assetDetailsRecords?.add(data!);
        selectedAsset?.removeAt(i);
        Logger().e(selectedAsset?.length);
        notifyListeners();
      }
    } catch (e) {
      Logger().e(e.toString());
    }
  }

  onChangingInitialValue(value) {
    initialValue = value;
    notifyListeners();
  }

  onChangingSelectedAsset(String value) {
    if (value.length == 0) {
      isSearching = false;
    } else {
      isSearching = true;
      var data = selectedAsset!
          .where((element) =>
              element.assetSerialNumber!.contains(value.toUpperCase()) ||
              element.makeCode!.contains(value.toUpperCase()) ||
              element.model!.contains(value.toUpperCase()))
          .toList();
      searchAsset = data;
    }
    notifyListeners();
  }

  editingNotification(AlertConfigEdit data) async {
    List<String> assetList = ["Asset On", "Asset Off", "Not Reporting"];
    List<String> engineHourList = [
      "Equal to",
      "Greater than",
      "Less than",
      "Greater than or equal to",
      "Less than or equal to"
    ];
    isEditing = true;
    notificationController.text = data.alertConfig!.notificationTitle!;
    notificationTypeGroupID = data.alertConfig!.notificationTypeGroupID!;
    notificationTypeId = data.alertConfig!.notificationTypeID!;

    if (assetList
        .any((element) => element == data.alertConfig!.notificationType)) {
      _noticationTypes.clear();
      _dropDownInitialValue = "Asset Status";
      _noticationTypes.add("Asset Status");
      _notificationSubTypes.clear();
      _dropDownSubInitialValue = data.alertConfig!.notificationType!;
      _notificationSubTypes = assetList;
    } else if (data.alertConfig!.notificationType == "Fuel Level") {
      if (data.alertConfig!.notificationType == "Fuel Level") {
        _noticationTypes.clear();
        _dropDownInitialValue = "Fuel";
        _noticationTypes.add("Fuel");
        _notificationSubTypes.clear();
        if (data.alertConfig!.operands!.isNotEmpty) {
          data.alertConfig!.operands!.forEach((element) {
            _dropDownSubInitialValue = element.condition!;
            _notificationSubTypes = engineHourList;
          });
        }
      }
    } else {
      _noticationTypes.clear();
      _dropDownInitialValue = data.alertConfig!.notificationType!;
      _noticationTypes.add(data.alertConfig!.notificationType!);
      _notificationSubTypes.clear();
      if (data.alertConfig!.operands!.isNotEmpty) {
        data.alertConfig!.operands!.forEach((element) {
          _dropDownSubInitialValue = element.condition!;
          _notificationSubTypes = engineHourList;
        });
      }
    }

    // _notificationSubTypes.clear();
    // if (data.alertConfig!.operands!.isNotEmpty) {
    //   data.alertConfig!.operands!.forEach((element) {
    //     _dropDownSubInitialValue = element.condition!;
    //     _notificationSubTypes.add(element.condition);
    //   });
    // }
    alertConfigUid = data.alertConfig!.alertConfigUID;
    data.alertConfig?.deliveryConfig?.forEach((element) {
      if (element != null) {
        selectedUser.add(User(
          email: element.recipientStr,
          isVLUser: element.isVLUser,
        ));
        emailIds!.add(element.recipientStr!);
        isShowingSelectedContact = true;
      }
    });
    _showZone = true;
    alertConfigData = data;
    await getEditOperandData(alertConfigData?.alertConfig?.operands);

    if (alertConfigData!.alertConfig!.scheduleDetails!.isNotEmpty) {
      scheduleDay.clear();
      for (var i = 0;
          i < alertConfigData!.alertConfig!.scheduleDetails!.length;
          i++) {
        var data = alertConfigData!.alertConfig!.scheduleDetails;
        var endTimeHour =
            TimeOfDay.fromDateTime(DateTime.parse(data![i].scheduleEndTime!))
                .hour
                .toString()
                .padLeft(2, '0');
        var endTimeMinute =
            TimeOfDay.fromDateTime(DateTime.parse(data[i].scheduleEndTime!))
                .minute
                .toString()
                .padLeft(2, '0');
        var startTimeHour =
            TimeOfDay.fromDateTime(DateTime.parse(data[i].scheduleStartTime!))
                .hour
                .toString()
                .padLeft(2, '0');
        var startTimeMinute =
            TimeOfDay.fromDateTime(DateTime.parse(data[i].scheduleStartTime!))
                .minute
                .toString()
                .padLeft(2, '0');
        if (data[i].scheduleDayNum == 0) {
          scheduleDay.add(Schedule(
              day: data[i].scheduleDayNum,
              title: "Sunday",
              endTime: "$endTimeHour:$endTimeMinute",
              startTime: "$startTimeHour:$startTimeMinute"));
        } else if (data[i].scheduleDayNum == 1) {
          scheduleDay.add(Schedule(
              day: data[i].scheduleDayNum,
              title: "Monday",
              endTime: "$endTimeHour:$endTimeMinute",
              startTime: "$startTimeHour:$startTimeMinute"));
        } else if (data[i].scheduleDayNum == 2) {
          scheduleDay.add(Schedule(
              day: data[i].scheduleDayNum,
              title: "Tuesday",
              endTime: "$endTimeHour:$endTimeMinute",
              startTime: "$startTimeHour:$startTimeMinute"));
        } else if (data[i].scheduleDayNum == 3) {
          scheduleDay.add(Schedule(
              day: data[i].scheduleDayNum,
              title: "Wednesday",
              endTime: "$endTimeHour:$endTimeMinute",
              startTime: "$startTimeHour:$startTimeMinute"));
        } else if (data[i].scheduleDayNum == 4) {
          scheduleDay.add(Schedule(
              day: data[i].scheduleDayNum,
              title: "Thursday",
              endTime: "$endTimeHour:$endTimeMinute",
              startTime: "$startTimeHour:$startTimeMinute"));
        } else if (data[i].scheduleDayNum == 5) {
          scheduleDay.add(Schedule(
              day: data[i].scheduleDayNum,
              title: "Friday",
              endTime: "$endTimeHour:$endTimeMinute",
              startTime: "$startTimeHour:$startTimeMinute"));
        } else if (data[i].scheduleDayNum == 6) {
          scheduleDay.add(Schedule(
              day: data[i].scheduleDayNum,
              title: "Saturday",
              endTime: "$endTimeHour:$endTimeMinute",
              startTime: "$startTimeHour:$startTimeMinute"));
        }
      }
      // alertConfigData?.alertConfig?.scheduleDetails?.forEach((element) {
      //   scheduleDay.add(Schedule(
      //     day: element.scheduleDayNum,
      //     endTime: '$endTimeHour:$endTimeMinute',
      //     startTime: '$startTimeHour:$startTimeMinute',
      //   ));
      //   schedule.add(ScheduleData(
      //       day: element.scheduleDayNum,
      //       endTime: '$endTimeHour:$endTimeMinute',
      //       startTime: '$startTimeHour:$startTimeMinute',
      //       initialVale: "Range",
      //       title: "sun"));
      // });
    }

    data.alertConfig!.assets!.forEach((element) {
      assetUidData.add(element.assetUID!);
    });
    notifyListeners();
    await getGroupListData();
  }

  getEditOperandData(List<OperandData>? data) {
    if (dropDownInitialValue == "Fault Code") {
      var severityData =
          data!.where((element) => element.operandName == "Severity");
      var faultCodeData =
          data.where((element) => element.operandName == "FaultCode Type");
      if (severityData.any((element) => element.value == "1")) {
        severityState[0].state = true;
      }
      if (severityData.any((element) => element.value == "2")) {
        severityState[1].state = true;
      }
      if (severityData.any((element) => element.value == "3")) {
        severityState[2].state = true;
      }
    }
    data!.forEach((element) {
      assetStatusOccurenceController.text = element.value!;
      operandData.add(Operand(
          operandID: element.operandID,
          operatorId: element.operatorID,
          value: element.value));
    });
    notifyListeners();
  }

  onAddingFaultCode(int i) {
    var data = faultCodeTypeSearch!.elementAt(i);
    faultCodeTypeSearch!.remove(data);
    SelectedfaultCodeTypeSearch!.add(data);
    notifyListeners();
  }

  onDeletingSelectedFaultCode(int i) {
    var data = SelectedfaultCodeTypeSearch!.elementAt(i);
    SelectedfaultCodeTypeSearch!.remove(data);
    faultCodeTypeSearch!.add(data);
    notifyListeners();
  }

  onSelectingDropDown(int i) {
    geoenceData[i].isSelected = !geoenceData[i].isSelected!;
    notifyListeners();
  }

// occurence textbox change

  // onChagingOccurenceBox(String value) {

  // }

  // onChagingAssetOccurenceBox(String value) {}

  // onChagingeEngineHourOccurenceBox(String value) {}

  // onChagingeExcessiveOccurenceBox(String value) {}

  // onChagingeFuelOccurenceBox(String value) {}

  // onChagingeFuelLossOccurenceBox(String value) {}

  // onChagingeOdometerOccurenceBox(String value) {}

  // onChagingeGeofenceOccurenceBox(String value) {}

  // switching state of the switch_button

  onCustomiozablestateChange(int i) {
    customizable[i].state = !customizable[i].state!;
    // customizableState.forEach((element) {
    //   element.state = !element.state!;
    // });
    notifyListeners();
  }

  checkingSwitchState(int i) {
    switchState[i].state = !switchState[i].state!;
    notifyListeners();
  }

  checkingPowerModeState(int i) {
    powerModeState[i].state = !powerModeState[i].state!;
    notifyListeners();
  }

  checkingSeverityState(int i) {
    severityState[i].state = !severityState[i].state!;
    notifyListeners();
  }

  checkingFaultCodeTypeState(int i) {
    faultCodeType[i].state = !faultCodeType[i].state!;
    notifyListeners();
  }

  checkingCustomizeableState(int i) {
    customizableState[i].state = !customizableState[i].state!;
    notifyListeners();
  }

  checkingFluidAnalysisState(int i) {
    fluidAnalysisState[i].state = !fluidAnalysisState[i].state!;
    notifyListeners();
  }

  checkingInspectionState(int i) {
    inspectionState[i].state = !inspectionState[i].state!;
    notifyListeners();
  }

  checkingAssetSecurityState(int i) {
    assetSecurityState[i].state = !assetSecurityState[i].state!;
    notifyListeners();
  }

  checkingOverduestate(int i) {
    overDueState[i].state = !overDueState[i].state!;
    notifyListeners();
  }

  checkingUpcomingState(int i) {
    upcomingState[i].state = !upcomingState[i].state!;
    notifyListeners();
  }

  // switching state of the switch_button ------------------------------

  onChangingFaultCode(String value) async {
    try {
      if (value.length >= 3) {
        var faultCodeType =
            await _notificationService!.getFaultCodeTypeSearch(value, page, "");

        faultCodeTypeSearch = faultCodeType!.descriptions;
        notifyListeners();
      }
    } catch (e) {
      Logger().e(e.toString());
    }
  }

  onChangingOccurence(String value) {
    operandData.forEach((element) {
      element.value = value;
    });
  }

  onExpansion(bool value, int index) {
    faultCodeTypeSearch![index].isExpanded = value;
    notifyListeners();
  }

  onAddingInclusion() {
    isAddingInclusionZone = true;
    notifyListeners();
  }

  onAddingExclusion() {
    isAddingExclusionZone = true;
    notifyListeners();
  }

  onSliderChange(double value) {
    radius = value;
    var sliderCircle;
    circle.forEach((element) {
      sliderCircle = Circle(
          radius: radius,
          strokeWidth: element.strokeWidth,
          strokeColor: element.strokeColor,
          visible: true,
          circleId: element.circleId,
          center: element.center,
          fillColor: element.fillColor);
    });
    circle.clear();
    circle.add(sliderCircle);

    notifyListeners();
  }

  onEditing() {
    isDrawing = !isDrawing;
    Logger().i("editing $isDrawing");
    notifyListeners();
  }

  onDeleting() {
    circle.clear();
    notifyListeners();
  }

  onCreateInclusionZone() {
    isAddingInclusionZone = false;
    isAddingExclusionZone = false;
    notifyListeners();
  }

  onCreateExclusionZone() {
    isAddingInclusionZone = false;
    isAddingExclusionZone = false;
    notifyListeners();
  }

  onInclusionZoneCreating(LatLng value) {
    Logger().e(value);
    if (isDrawing) {
      var createdCircle = Circle(
          strokeColor: Colors.lightBlue[300]!,
          strokeWidth: 2,
          radius: radius,
          visible: true,
          circleId: CircleId(DateTime.now().toString()),
          center: value,
          fillColor: Colors.white70);
      circle.add(createdCircle);
      isDrawing = false;
    }
    notifyListeners();
  }

  onSelectingEmailList(String value) {
    emailController.text = value;
    isHideSearchList = false;
    notifyListeners();
  }

  addContact() {
    if (emailController.text.contains("@")) {
      isShowingSelectedContact = true;
      isShowingSelectedContact = true;
      selectedUser.add(User(
        email: emailController.text,
      ));
      emailIds!.add(emailController.text);
    } else {
      snackbarService!
          .showSnackbar(message: "Please Enter the valid device id");
    }

    notifyListeners();
  }

  onGettingFaultCodeData() async {
    try {
      showLoadingDialog();
      var faultCodeType =
          await _notificationService!.getFaultCodeTypeSearch("", page, "");
      if (_loadingMore) {
        faultCodeType!.descriptions!.forEach((element) {
          faultCodeTypeSearch!.add(FaultCodeDetails(
              faultCodeIdentifier: element.faultCodeIdentifier,
              faultCodeType: element.faultCodeType,
              faultDescription: element.faultDescription,
              isExpanded: element.isExpanded));
        });
      } else {
        faultCodeTypeSearch = faultCodeType?.descriptions;
      }

      hideLoadingDialog();

      notifyListeners();
    } catch (e) {
      hideLoadingDialog();
    }
  }

  onDescriptionFrontPressed() async {
    pageController.animateToPage(2,
        duration: Duration(microseconds: 3000), curve: Curves.easeInOut);
  }

  onDescriptionBackPressed() {
    Logger().e(isFaultCodePressed);
    if (isFaultCodePressed) {
      pageController.animateToPage(1,
          duration: Duration(microseconds: 3000), curve: Curves.easeInOut);
    } else {
      pageController.animateToPage(0,
          duration: Duration(microseconds: 3000), curve: Curves.easeInOut);
    }
  }

  onFaultCodeFrontPressed() {
    pageController.animateToPage(1,
        duration: Duration(microseconds: 3000), curve: Curves.easeInOut);
    isFaultCodePressed = true;
    notifyListeners();
  }

  onDiagnosticFrontPressed() async {
    showLoadingDialog();
    expansionTitle = "Fault Code Type";
    var faultCodeType = await _notificationService!
        .getFaultCodeTypeSearch("", page, "DIAGNOSTIC");
    faultCodeTypeSearch = faultCodeType!.descriptions;
    Future.delayed(Duration(seconds: 1), () {
      pageController.animateToPage(2,
          duration: Duration(microseconds: 3000), curve: Curves.easeInOut);
      hideLoadingDialog();
    });
    notifyListeners();
  }

  onEventFrontPressed() async {
    showLoadingDialog();
    expansionTitle = "Fault Code Type";
    var faultCodeType =
        await _notificationService!.getFaultCodeTypeSearch("", page, "EVENT");
    faultCodeTypeSearch = faultCodeType!.descriptions;
    Future.delayed(Duration(seconds: 1), () {
      pageController.animateToPage(2,
          duration: Duration(microseconds: 3000), curve: Curves.easeInOut);
      hideLoadingDialog();
    });
    notifyListeners();
  }

  onChangingInclusion(List<String> value) {
    Logger().w(value);
    notifyListeners();
  }

  onSelectingInclusion(int i) {
    zoneNamesInclusion[i].isSelected = !zoneNamesInclusion[i].isSelected!;
    notifyListeners();
  }

  onSelectingExclusion(int i) {
    zoneNamesExclusion[i].isSelected = !zoneNamesExclusion[i].isSelected!;
    notifyListeners();
  }

  onChangingExclusion(List<String> value) {
    Logger().e(value);
    notifyListeners();
  }

  updateModelValue(String value) {
    _dropDownInitialValue = value;
    _showZone = true;

    getNotificationSubTypes();
  }

  updateSubModelValue(String value) {
    _dropDownSubInitialValue = value;
    notifyListeners();
  }

  updateType(String value, int i) {
    initialDayOption = value;
    if (value == days[0]) {
      schedule.forEach((element) {
        element.isSelected = true;
      });
      checkingAllDay = true;
    } else {
      schedule.forEach((element) {
        element.isSelected = false;
      });
      checkingAllDay = false;
    }
    notifyListeners();
  }

  updateStartTime(String value, int i) {
    Logger().e(value);
    initialStartValue = value;
    notifyListeners();
  }

  updateEndTime(String value, int i) {
    initialEndValue = value;
    notifyListeners();
  }

  onCreatingInclusionZone() async {
    var data = await _notificationService!.creatingZone(ZoneCreating(
      latitude: circle.first.center.latitude,
      longitude: circle.first.center.longitude,
      radius: circle.first.radius,
      zoneName: inclusionZoneName.text,
    ));
    _zoneNamesInclusion.add(CheckBoxDropDown(items: inclusionZoneName.text));
    onCreateInclusionZone();
  }

  onCreatingExclusionZone() async {
    var data = await _notificationService!.creatingZone(ZoneCreating(
      latitude: circle.first.center.latitude,
      longitude: circle.first.center.longitude,
      radius: circle.first.radius,
      zoneName: exclusionZoneName.text,
    ));
    _zoneNamesExclusion.add(CheckBoxDropDown(items: exclusionZoneName.text));
    onCreateExclusionZone();
  }

  getInclusionExclusionZones() async {
    showLoadingDialog();
    ZoneValues? response =
        await _notificationService!.getInclusionExclusionZones();
    if (response != null) {
      response.zones!.forEach((zones) {
        if (_zoneNamesInclusion
            .any((element) => element.items!.contains(zones.zoneName!))) {
        } else {
          zoneNamesInclusion.add(CheckBoxDropDown(items: zones.zoneName));
        }
        if (_zoneNamesExclusion
            .any((element) => element.items!.contains(zones.zoneName!))) {
        } else {
          zoneNamesExclusion.add(CheckBoxDropDown(items: zones.zoneName));
        }
      });
    }
    Logger().e(zoneNamesInclusion);
    notifyListeners();
    hideLoadingDialog();
  }

  getNotificationSubTypes() async {
    _notificationSubTypes.clear();
    _notificationSubTypes = ["Options"];
    _dropDownSubInitialValue = "Options";
    alterTypes!.notificationTypeGroups?.forEach((notificationTypeGroup) {
      if (notificationTypeGroup.notificationTypeGroupName ==
              _dropDownInitialValue ||
          notificationTypeGroup.notificationTypes!.any((notificationType) =>
              notificationType.appName!.contains(_dropDownInitialValue))) {
        Logger().e(notificationTypeGroup.toJson());
        if (notificationTypeGroup.notificationTypeGroupName!
            .contains("Geofence")) {
          notificationTypeGroup.notificationTypes!.forEach((notification) {
            notification.siteOperands!.forEach((element) {
              _notificationSubTypes.add(element.operandName);
            });
          });
          _notificationSubTypes
              .add("${_notificationSubTypes[1]} & ${_notificationSubTypes[2]}");
          Logger().e(notificationTypeGroup.toJson());
          getGeofenceData();
        }
        if (notificationTypeGroup.notificationTypeGroupName!
            .contains("Zone Inclusion/Exclusion")) {
          _dropDownSubInitialValue = "Select Inclusion Zone";
          getInclusionExclusionZones();
        }
        notificationTypeGroup.notificationTypes?.forEach((notificationType) {
          notificationType.operands?.forEach((operand) async {
            if (operand.operandName!.contains("Fuel Level")) {
              _notificationSubTypes.clear();
              _notificationSubTypes = ["Conditions"];
              _dropDownSubInitialValue = "Conditions";
              operand.operators!.forEach((operator) {
                _notificationSubTypes.add(operator.name);
              });
            } else if (operand.operandName!.contains("Engine Hours")) {
              _notificationSubTypes.clear();
              _notificationSubTypes = ["Conditions"];
              _dropDownSubInitialValue = "Conditions";
              operand.operators!.forEach((operator) {
                _notificationSubTypes.add(operator.name);
              });
            } else if (operand.operandName!.contains("Odometer")) {
              _notificationSubTypes.clear();
              _notificationSubTypes = ["Conditions"];
              _dropDownSubInitialValue = "Conditions";
              operand.operators!.forEach((operator) {
                _notificationSubTypes.add(operator.name);
              });
            } else if (operand.operandName!.contains("Excessive Daily Idle")) {
              _notificationSubTypes.clear();
              _notificationSubTypes = ["Conditions"];
              _dropDownSubInitialValue = "Conditions";
              operand.operators!.forEach((operator) {
                _notificationSubTypes.add(operator.name);
              });
            } else if (notificationTypeGroup.notificationTypeGroupName ==
                "Asset Status") {
              _notificationSubTypes.add(operand.operandName);
            } else if (notificationTypeGroup.notificationTypeGroupName ==
                "Maintenance") {
              _notificationSubTypes.clear();
              _dropDownSubInitialValue = "Status";
              _notificationSubTypes.addAll(["Status", "Overdue", "Upcoming"]);
            } else {
              _notificationSubTypes.clear();
              Logger().e(dropDownInitialValue);
              Logger().e(dropDownSubInitialValue);
            }
          });
        });
      }
    });
    if (_dropDownInitialValue == "Asset Status") {
      _notificationSubTypes.removeWhere((element) =>
          element!.contains("Alternate Power") ||
          element.contains("Not Expected To Report") ||
          element.contains("Not Ready To Run") ||
          element.contains("Movement With Asset On") ||
          element.contains("Movement With Asset Off"));
    }
    Logger().w(_notificationSubTypes);
    Logger().wtf(_dropDownSubInitialValue);
    notifyListeners();
  }

  getGeofenceData() async {
    try {
      showLoadingDialog();
      geoenceData.clear();
      var data = await _geofenceservice!.getGeofenceData();
      if (data != null) {
        data.Geofences!.forEach((element) {
          geoenceData.add(CheckBoxDropDown(items: element.GeofenceName));
        });
      }
      hideLoadingDialog();
      notifyListeners();
    } catch (e) {
      Logger().e(e.toString());
    }
  }

  Future getNotificationTypesData() async {
    try {
      alterTypes = await _notificationService!
          .getNotificationTypes(graphqlSchemaService!.getNotificationTypes());
      if (alterTypes != null) {
        alterTypes!.notificationTypeGroups!.forEach((notificationTypeGroup) {
          if (notificationTypeGroup.notificationTypeGroupName!
              .contains("Fault")) {
            notificationTypeGroup.notificationTypes?.forEach((element) {
              notificationTypes.add(element.notificationTypeName);
            });
          } else {
            notificationTypes
                .add(notificationTypeGroup.notificationTypeGroupName);
          }
          // notificationTypeGroup.notificationTypes!.forEach((notificationType) {

          // if (notificationType.appName == "VL Unified Fleet" ||
          //     notificationType.appName == "Frame-Fleet-IND") {
          //   //Logger().w(notificationType.toJson());
          //   if (notificationTypeGroup.notificationTypeGroupName!.isNotEmpty) {
          //     if (notificationFleetType!.any((element) => element.contains(
          //         notificationTypeGroup.notificationTypeGroupName!))) {
          //     } else {
          //       if (notificationTypeGroup.notificationTypeGroupName ==
          //           "Geofence") {
          //         if (geofenceAssets!.any((element) => element.contains(
          //             notificationTypeGroup.notificationTypeGroupName!))) {
          //         } else {
          //           notificationTypes.add(notificationTypeGroup.notificationTypeGroupName!);
          //           geofenceAssets!
          //               .add(notificationTypeGroup.notificationTypeGroupName!);
          //         }
          //       } else {
          //         if (notificationTypeGroup.notificationTypeGroupName ==
          //             "Asset Security") {
          //           if (administratortAssets!.any((element) => element.contains(
          //               notificationTypeGroup.notificationTypeGroupName!))) {
          //           } else {
          //             notificationTypes.add(notificationTypeGroup.notificationTypeGroupName!);
          //             administratortAssets!.add(
          //                 notificationTypeGroup.notificationTypeGroupName!);
          //           }
          //         } else {
          //           notificationTypes.add(notificationTypeGroup.notificationTypeGroupName!);
          //           notificationFleetType!
          //               .add(notificationTypeGroup.notificationTypeGroupName!);
          //         }
          //       }
          //     }
          //   } else {
          //     notificationTypes.add(notificationTypeGroup.notificationTypeGroupName!);
          //     notificationFleetType!
          //         .add(notificationType.notificationTypeName!);
          //   }
          // } else if (notificationType.appName == "VL Unified Service" ||
          //     notificationType.appName == "Frame-Service-IND") {
          //       notificationTypes.add(notificationTypeGroup.notificationTypeGroupName!);
          //   notificationServiceType!
          //       .add(notificationType.notificationTypeName!);
          // } else if (notificationType.appName == "VisionLink Administrator" ||
          //     notificationType.appName == "Frame-Administrator-IND") {
          //       notificationTypes.add(notificationTypeGroup.notificationTypeGroupName!);
          //   administratortAssets!.add(notificationType.notificationTypeName!);
          // } else {
          //   notificationTypes.add(notificationTypeGroup.notificationTypeGroupName!);
          //   geofenceAssets!.add(notificationType.notificationTypeName!);
          // }
          //  });
        });
      }
      notificationTypes.removeWhere((element) =>
          element!.contains("Odometer") ||
          element.contains("Switches") ||
          element.contains("Fluid Analysis") ||
          element.contains("Maintenance") ||
          element.contains("Inspection") ||
          element.contains("Asset Security") ||
          element.contains("Fluid Analysis") ||
          element.contains("Geofence") ||
          element.contains("Zone Inclusion/Exclusion") ||
          element.contains("Fluid Analysis") ||
          element.contains("Power Mode") ||
          element.contains("Back To Start") ||
          element.contains("Usage") ||
          element.contains("Proximity"));

      notifyListeners();
    } catch (e) {
      hideLoadingDialog();
    }
  }

  checkIfNotificationNameExist(String? value) async {
    try {
      if (value!.length >= 4) {
        NotificationExist? notificationExists = await _notificationService!
            .checkNotificationTitle(
                value, graphqlSchemaService!.checkNotificationTitle(value));
        // isTitleExist = notificationExists!.alertTitleExists!;

        if (notificationExists?.alertTitleExists == true) {
          _snackBarservice!.showSnackbar(message: "Notification title exists");
          notificationController.clear();
        }
        notifyListeners();
      } else {
        //isNotificationNameChange=true;
        // notifyListeners();
      }
    } on DioError catch (e) {
      final error = DioException.fromDioError(e);
      Fluttertoast.showToast(msg: error.message!);
    }
  }

  gotoManageNotificationsPage() {
    _navigationService!.clearTillFirstAndShowView(ManageNotificationsView());
  }

  onRemovedSelectedContact(int index) {
    try {
      selectedUser.removeAt(index);
      notifyListeners();
    } catch (e) {
      Logger().e(e.toString());
    }
  }

  searchContacts(String searchValue) {
    if (searchValue.length >= 4) {
      _searchKeyword = searchValue;
      isHideSearchList = true;
      notifyListeners();
      getContactSearchReportData();
    }
  }

  getContactSearchReportData() async {
    try {
      SearchContactReportListResponse? result = await _manageUserService!
          .getSearchContactResposeData(_searchKeyword,
              graphqlSchemaService!.getContactSearchData(_searchKeyword));
      if (result != null) {
        searchContactListName!.clear();
        // Logger().i("result:${result.pageInfo!.totalPages}");

        for (var name in result.Users!) {
          searchContactListName!.add(name);
        }
      }
      notifyListeners();
    } catch (e) {
      Logger().e(e.toString());
    }
  }

  // cancel() {
  //   _showConditionTypes = false;
  //   _showNotificationType = false;
  //   _showFuelLoss = false;
  //   _setOdometer = false;
  //   _selectPowerMode = false;
  //   _showFaultCodes = false;
  //   _showSwitches = false;
  //   _showFluidAnalysis = false;
  //   _showInspections = false;
  //   _showMaintainance = false;
  //   _showAssetSecurity = false;
  //   _showZone = false;
  //   nameController.clear();
  //   notificationController.clear();
  //   emailController.clear();
  //   descriptionController.clear();
  //   occurenceController.clear();

  //   notifyListeners();
  // }

  getFaultCodeOperandsAndNotificationId() {
    operandData.clear();
    var notificationTypeGroups = alterTypes!.notificationTypeGroups!
        .singleWhere((element) => element.notificationTypeGroupName == "Fault");
    Logger().wtf(notificationTypeGroups.toJson());
    notificationTypeGroupID = notificationTypeGroups.notificationTypeGroupID!;
    notificationType = notificationTypeGroups.notificationTypes!.singleWhere(
        (element) => element.notificationTypeName == _dropDownInitialValue);
    var OperandData = notificationType?.operands;
    notificationTypeId = notificationType!.notificationTypeID!;
    if (severityState.any((element) => element.state == true)) {
      var data = OperandData?.singleWhere(
          (element) => element.operandName == "Severity");
      severityState.forEach((SeveritySwitcState) {
        if (SeveritySwitcState.text == "High") {
          if (SeveritySwitcState.state == true) {
            operandData.add(Operand(
                operandID: data!.operandID,
                operatorId: data.operators?.first.operatorID,
                value: "1"));
          }
        } else if (SeveritySwitcState.text == "Medium") {
          if (SeveritySwitcState.state == true) {
            operandData.add(Operand(
                operandID: data!.operandID,
                operatorId: data.operators?.first.operatorID,
                value: "2"));
          }
        } else {
          if (SeveritySwitcState.state == true) {
            operandData.add(Operand(
                operandID: data!.operandID,
                operatorId: data.operators?.first.operatorID,
                value: "3"));
          }
        }
      });
    }

    if (faultCodeType.any((element) => element.state == true)) {
      var data = OperandData?.singleWhere(
          (element) => element.operandName == "FaultCode Type");
      faultCodeType.forEach((faultCodeTypeSwitcState) {
        if (faultCodeTypeSwitcState.text == "Event") {
          if (faultCodeTypeSwitcState.state == true) {
            operandData.add(Operand(
                operandID: data!.operandID,
                operatorId: data.operators?.first.operatorID,
                value: "1"));
          }
        } else if (faultCodeTypeSwitcState.text == "Diagnostic") {
          if (faultCodeTypeSwitcState.state == true) {
            operandData.add(Operand(
                operandID: data!.operandID,
                operatorId: data.operators?.first.operatorID,
                value: "2"));
          }
        }
      });
    }
    Logger().wtf(notificationType!.toJson());
    notificationTypeId = notificationType!.notificationTypeID!;
  }

  getAssetStatusOperandAndNotificationId() {
    operandData.clear();
    operandData.clear();
    var notificationTypeGroups = alterTypes!.notificationTypeGroups!
        .singleWhere(
            (element) => element.notificationTypeGroupName == "Asset Status");
    notificationTypeGroupID = notificationTypeGroups.notificationTypeGroupID!;
    notificationType = notificationTypeGroups.notificationTypes!.singleWhere(
        (element) => element.notificationTypeName == _dropDownSubInitialValue);
    Logger().e(notificationType!.operands!.first.toJson());
    Logger().e(notificationType!.operands!.first.operators!.first.toJson());
    var OperandData = notificationType?.operands;
    notificationTypeId = notificationType!.notificationTypeID!;
    notificationTypeId = notificationType!.notificationTypeID!;
    operandData.add(Operand(
        operandID: OperandData!.first.operandID,
        operatorId: OperandData.first.operators!.first.operatorID,
        value: assetStatusOccurenceController.text));
  }

  getFuelOperandAndNotificationId() {
    operandData.clear();
    var notificationTypeGroups = alterTypes!.notificationTypeGroups!
        .singleWhere((element) => element.notificationTypeGroupName == "Fuel");
    notificationTypeGroupID = notificationTypeGroups.notificationTypeGroupID!;
    notificationType = notificationTypeGroups.notificationTypes!
        .singleWhere((element) => element.notificationTypeName == "Fuel Level");
    var OperandData = notificationType?.operands;
    notificationTypeId = notificationType!.notificationTypeID!;
    var fuelOperandData = OperandData?.singleWhere(
        (element) => element.operandName == "Fuel Level");
    if (fuelOperandData!.operators!
        .any((element) => element.name == _dropDownSubInitialValue)) {
      operandData.add(Operand(
          operandID: OperandData!.first.operandID,
          operatorId: OperandData.first.operators!.first.operatorID,
          value: assetStatusOccurenceController.text));
    }
  }

  getEngineHoursOperandAndNotificationId() {
    operandData.clear();
    var notificationTypeGroups = alterTypes!.notificationTypeGroups!
        .singleWhere(
            (element) => element.notificationTypeGroupName == "Engine Hours");
    notificationTypeGroupID = notificationTypeGroups.notificationTypeGroupID!;
    notificationType = notificationTypeGroups.notificationTypes!.singleWhere(
        (element) => element.notificationTypeName == "Engine Hours");
    var OperandData = notificationType?.operands;
    notificationTypeId = notificationType!.notificationTypeID!;
    var engineHoursOperandData = OperandData?.singleWhere(
        (element) => element.operandName == "Engine Hours");
    if (engineHoursOperandData!.operators!
        .any((element) => element.name == _dropDownSubInitialValue)) {
      operandData.add(Operand(
          operandID: OperandData!.first.operandID,
          operatorId: OperandData.first.operators!.first.operatorID,
          value: assetStatusOccurenceController.text));
    }
  }

  getExcessiveDailyIdleOperandAndNotificationId() {
    operandData.clear();
    var notificationTypeGroups = alterTypes!.notificationTypeGroups!
        .singleWhere((element) =>
            element.notificationTypeGroupName == "Excessive Daily Idle");
    notificationTypeGroupID = notificationTypeGroups.notificationTypeGroupID!;
    notificationType = notificationTypeGroups.notificationTypes!.singleWhere(
        (element) => element.notificationTypeName == "Excessive Daily Idle");
    var OperandData = notificationType?.operands;
    notificationTypeId = notificationType!.notificationTypeID!;
    var excessiveDailyIdleOperandData = OperandData?.singleWhere(
        (element) => element.operandName == "Excessive Daily Idle");
    if (excessiveDailyIdleOperandData!.operators!
        .any((element) => element.name == _dropDownSubInitialValue)) {
      operandData.add(Operand(
          operandID: OperandData!.first.operandID,
          operatorId: OperandData.first.operators!.first.operatorID,
          value: assetStatusOccurenceController.text));
    }
  }

  getFuelLossOperandAndNotificationId() {
    operandData.clear();
    var notificationTypeGroups = alterTypes!.notificationTypeGroups!
        .singleWhere(
            (element) => element.notificationTypeGroupName == "Fuel Loss");
    notificationTypeGroupID = notificationTypeGroups.notificationTypeGroupID!;
    notificationType = notificationTypeGroups.notificationTypes!
        .singleWhere((element) => element.notificationTypeName == "Fuel Loss");
    var OperandData = notificationType?.operands;
    notificationTypeId = notificationType!.notificationTypeID!;
    var fuelLossOperandData = OperandData?.singleWhere(
        (element) => element.operandName == "Fuel Loss");
    // if (fuelLossOperandData!.operators!
    //     .any((element) => element.name == _dropDownSubInitialValue)) {
    operandData.add(Operand(
        operandID: OperandData!.first.operandID,
        operatorId: OperandData.first.operators!.first.operatorID,
        value: assetStatusOccurenceController.text));
    // }
  }

  gettingNotificationIdandOperands() async {
    if (_dropDownInitialValue == "Fault Code") {
      await getFaultCodeOperandsAndNotificationId();
      Logger().w("notificationGroupid ${notificationTypeGroupID}");
      Logger().i("notificationTypeId ${notificationTypeId}");
      operandData.forEach((element) {
        Logger().wtf("OperandData ${element.toJson()}");
      });
    } else if (_dropDownInitialValue == "Asset Status") {
      await getAssetStatusOperandAndNotificationId();
      Logger().w("notificationGroupid ${notificationTypeGroupID}");
      Logger().i("notificationTypeId ${notificationTypeId}");
      operandData.forEach((element) {
        Logger().wtf("OperandData ${element.toJson()}");
      });
    } else if (_dropDownInitialValue == "Fuel") {
      await getFuelOperandAndNotificationId();
      Logger().w("notificationGroupid ${notificationTypeGroupID}");
      Logger().i("notificationTypeId ${notificationTypeId}");
      operandData.forEach((element) {
        Logger().wtf("OperandData ${element.toJson()}");
      });
    } else if (_dropDownInitialValue == "Engine Hours") {
      await getEngineHoursOperandAndNotificationId();
      Logger().w("notificationGroupid ${notificationTypeGroupID}");
      Logger().i("notificationTypeId ${notificationTypeId}");
      operandData.forEach((element) {
        Logger().wtf("OperandData ${element.toJson()}");
      });
    } else if (_dropDownInitialValue == "Excessive Daily Idle") {
      await getExcessiveDailyIdleOperandAndNotificationId();
      Logger().w("notificationGroupid ${notificationTypeGroupID}");
      Logger().i("notificationTypeId ${notificationTypeId}");
      operandData.forEach((element) {
        Logger().wtf("OperandData ${element.toJson()}");
      });
    } else if (_dropDownInitialValue == "Fuel Loss") {
      await getFuelLossOperandAndNotificationId();
      Logger().w("notificationGroupid ${notificationTypeGroupID}");
      Logger().i("notificationTypeId ${notificationTypeId}");
      operandData.forEach((element) {
        Logger().wtf("OperandData ${element.toJson()}");
      });
    }
    // var notificationTypeGroups = alterTypes!.notificationTypeGroups!
    //     .singleWhere((element) =>
    //         element.notificationTypeGroupName == _dropDownInitialValue);
    // Logger().wtf(notificationTypeGroups.toJson());
    // notificationTypeGroupID = notificationTypeGroups.notificationTypeGroupID!;
    // if (notificationTypeGroups.notificationTypes!
    //     .any((element) => element.notificationTypeName == "Fuel Level")) {
    //   notificationType = notificationTypeGroups.notificationTypes!.singleWhere(
    //       (element) => element.notificationTypeName == "Fuel Level");
    //   notificationTypeId = notificationType!.notificationTypeID!;
    //   Logger().w(notificationType!.toJson());
    // }
    // if (notificationTypeGroups.notificationTypes!.any(
    //     (element) => element.notificationTypeName == _dropDownInitialValue)) {
    //   notificationType = notificationTypeGroups.notificationTypes!.singleWhere(
    //       (element) => element.notificationTypeName == _dropDownInitialValue);
    //   Logger().w(notificationType!.toJson());
    //   notificationTypeId = notificationType!.notificationTypeID!;
    // }
    // if (notificationTypeGroups.notificationTypes!.any((element) =>
    //     element.notificationTypeName == _dropDownSubInitialValue)) {
    //   notificationType = notificationTypeGroups.notificationTypes!.singleWhere(
    //       (element) =>
    //           element.notificationTypeName == _dropDownSubInitialValue);
    //   Logger().w(notificationType!.toJson());
    //   notificationTypeId = notificationType!.notificationTypeID!;
    // }

    // Logger().i("notificationGroupId : $notificationTypeGroupID");
    // Logger().i("notificationTypeId : $notificationTypeId");

    // notificationType?.operands?.forEach((operand) {
    //   if (operand.operandName == "Fuel Loss") {
    //     var operator = operand.operators!.forEach((element) {
    //       Logger().e("operands ${element.toJson()}");
    //       operandData.clear();
    //       operandData.add(Operand(
    //           operandID: operand.operandID,
    //           operatorId: element.operatorID,
    //           value: assetStatusOccurenceController.text));
    //     });
    //   }
    //   if (operand.operandName == "Power Mode") {
    //     var operator = operand.operators!.forEach((element) {
    //       Logger().e("operands ${element.toJson()}");
    //       if (SelectedfaultCodeTypeSearch!.isEmpty) {
    //         operandData.clear();
    //         operandData.add(Operand(
    //             operandID: operand.operandID,
    //             operatorId: element.operatorID,
    //             value: assetStatusOccurenceController.text));
    //       } else {
    //         Logger().e("operands ${element.toJson()}");
    //         operandData.clear();
    //         operandData.add(Operand(
    //             operandID: operand.operandID,
    //             operatorId: element.operatorID,
    //             value: assetStatusOccurenceController.text));
    //       }
    //     });
    //   }
    //   if (operand.operandName == "Fuel Level") {
    //     var operator = operand.operators!
    //         .singleWhere((element) => element.name == _dropDownSubInitialValue);
    //     Logger().e("operands ${operand.toJson()}");
    //     operandData.clear();
    //     operandData.add(Operand(
    //         operandID: operand.operandID,
    //         operatorId: operator.operatorID,
    //         value: assetStatusOccurenceController.text));
    //   }
    //   if (operand.operators!
    //       .any((element) => element.name == _dropDownSubInitialValue)) {
    //     var operator = operand.operators!
    //         .singleWhere((element) => element.name == _dropDownSubInitialValue);
    //     Logger().e("operator ${operator.toJson()}");
    //     operandData.clear();
    //     operandData.add(Operand(
    //         operandID: operand.operandID,
    //         operatorId: operator.operatorID,
    //         value: assetStatusOccurenceController.text));
    //   } else {
    //     operand.operators!.forEach((operator) {
    //       Logger().e("operands ${operand.toJson()}");
    //       operandData.clear();
    //       operandData.add(Operand(
    //           operandID: operand.operandID,
    //           operatorId: operator.operatorID,
    //           value: assetStatusOccurenceController.text));
    //     });
    //     operandData.forEach((element) {
    //       Logger().e(element.toJson());
    //     });
    //   }
    // });
  }

  editNotification() async {
    showLoadingDialog();
    assetUidData.clear();
    selectedAsset?.forEach((element) {
      assetUidData.add(element.assetIdentifier!);
    });

    AddNotificationPayLoad payLoadData = AddNotificationPayLoad(
        alertCategoryID: alertConfigData!.alertConfig!.alertCategoryID,
        alertGroupId: alertConfigData!.alertConfig!.alertGroupID,
        alertTitle: notificationController.text,
        allAssets: false,
        assetUIDs: assetUidData,
        currentDate: alertConfigData!.alertConfig!.createdDate,
        notificationDeliveryChannel: "email",
        notificationTypeGroupID:
            alertConfigData!.alertConfig!.notificationTypeGroupID,
        notificationSubscribers: NotificationSubscribers(emailIds: emailIds),
        notificationTypeId: alertConfigData!.alertConfig!.notificationTypeID,
        schedule: scheduleDay,
        operands: operandData,
        numberOfOccurences: 1);

    Logger().e(payLoadData.toJson());
    var data = await _notificationService!.editNotification(
        payLoadData,
        alertConfigUid!,
        graphqlSchemaService!.updateNotification(
            alertCategoryID: alertConfigData!.alertConfig!.alertCategoryID,
            alertGroupId: alertConfigData!.alertConfig!.alertGroupID,
            alertTitle: notificationController.text,
            assetId: assetUidData,
            currentDate: alertConfigData!.alertConfig!.createdDate,
            notificationDeliveryChannel: "email",
            notificationTypeGroupID:
                alertConfigData!.alertConfig!.notificationTypeGroupID,
            notificationSubscribers:
                NotificationSubscribers(emailIds: emailIds),
            notificationTypeId:
                alertConfigData!.alertConfig!.notificationTypeID,
            schedule: scheduleDay,
            operand: operandData,
            alertId: alertConfigUid!,
            numberOfOccurences: 1));
    if (data != null) {
      _snackBarservice!.showSnackbar(message: "Edit Notification Success");
      gotoManageNotificationsPage();

      hideLoadingDialog();
      // gotoManageNotificationsPage();
    }
  }

  saveAddNotificationData() async {
    assetUidData.clear();
    selectedAsset!.forEach((element) {
      assetUidData.add(element.assetIdentifier!);
    });
    if (notificationController.text.isEmpty) {
      _snackBarservice!.showSnackbar(message: "Notification Name is required");
      return;
    }
    if (_dropDownInitialValue == "Select") {
      _snackBarservice!
          .showSnackbar(message: "Please Select Notification Type");
      return;
    }
    if (_dropDownInitialValue == "Asset Status" ||
        _dropDownInitialValue == "Fuel" ||
        _dropDownInitialValue == "Engine Hours" ||
        _dropDownInitialValue == "Excessive Daily Idle") {
      if (_dropDownSubInitialValue == "Options" ||
          _dropDownSubInitialValue == "Conditions") {
        _snackBarservice!
            .showSnackbar(message: "Please Configure Notification sub Type");
        return;
      }
    }
    if (assetUidData.isEmpty) {
      _snackBarservice!.showSnackbar(message: "Please Select Asset");
      return;
    }
    if (scheduleDay.isEmpty) {
      _snackBarservice!.showSnackbar(message: "Please Schedule Notification");
      return;
    }
    if (isEditing) {
      editNotification();
    } else {
      showLoadingDialog();
      var currentDate = DateTime.now();
      var newFormat = DateFormat("dd-MM-yy");
      String date = newFormat.format(currentDate);

      await gettingNotificationIdandOperands();
      AddNotificationPayLoad? notificationPayLoad = AddNotificationPayLoad(
          alertCategoryID: 1,
          alertGroupId: 1,
          alertTitle: notificationController.text,
          allAssets: false,
          assetUIDs: assetUidData,
          currentDate: DateFormat("MM/dd/yyyy").format(DateTime.now()),
          notificationDeliveryChannel: "email",
          notificationSubscribers:
              NotificationSubscribers(emailIds: emailIds, phoneNumbers: []),
          notificationTypeGroupID: notificationTypeGroupID,
          notificationTypeId: notificationTypeId,
          operands: operandData,
          schedule: scheduleDay,
          numberOfOccurences: 1);
// AddNotificationPayLoad? notificationPayLoad = AddNotificationPayLoad(
//         alertCategoryID: 1,
//         alertGroupId: 1,
//         alertTitle: notificationController.text,
//         allAssets: false,
//         assetUIDs: assetUidData,
//         currentDate:DateFormat("MM/dd/yyyy").format(DateTime.now()),
//         notificationDeliveryChannel: "email",
//         notificationSubscribers:NotificationSubscribers(emailIds: emailIds,phoneNumbers:[])
//         notificationTypeGroupID: notificationTypeGroupID,
//         notificationTypeId: notificationTypeId,
//         operands:operandData,
//         // numberOfOccurences: occurenceController.text.isEmpty? 1 :int.parse(occurenceController.text),
//         numberOfOccurences: 1
//         schedule:schedule.map((e) => Schedule(day: e.day,endTime:e.items![2]==e.initialVale && e.items![0]==e.initialVale? "00:00":e.endTime,startTime:e.items![2]==e.initialVale && e.items![0]==e.initialVale? "00:00":e.startTime,)).toList()
//         );

      Logger().w(notificationPayLoad.toJson());

      try {
        NotificationAdded? response =
            await _notificationService!.addNewNotification(
                notificationPayLoad,
                graphqlSchemaService!.createNotification(
                  alertCategoryID: 1,
                  alertGroupId: 1,
                  alertTitle: notificationController.text,
                  assetId: assetUidData,
                  currentDate: DateFormat("MM/dd/yyyy").format(DateTime.now()),
                  notificationDeliveryChannel: "email",
                  notificationSubscribers: NotificationSubscribers(
                      emailIds: emailIds, phoneNumbers: []),
                  notificationTypeGroupID: notificationTypeGroupID,
                  notificationTypeId: notificationTypeId,
                  operand: operandData,
                  numberOfOccurences: 1,
                  schedule: scheduleDay,
                ));

        if (response != null) {
          _snackBarservice!.showSnackbar(message: "Add Notification Success");

          hideLoadingDialog();
          gotoManageNotificationsPage();
        } else {
          _snackBarservice!
              .showSnackbar(message: "Kindly recheck credentials added");
        }
        hideLoadingDialog();
        Logger().i(response!.toJson());
        notifyListeners();
      } catch (e) {
        Logger().e(e.toString());
      }
    }
  }

  onItemContactSelected(int index) {
    selectedContactItems!.add(searchContactListName![index].email!);
    Logger().wtf(selectedContactItems!.length.toString());
    emailIds!.add(searchContactListName![index].email!);
    phoneNumbers!.add(searchContactListName![index].name!);
    isHideSearchList = false;

    notifyListeners();
  }

  onDeletingSelectedAsset(int i) {
    selectedItemAssets!.remove(i);
    notifyListeners();
  }
}

class SwitchState {
  bool? state;
  String? text;
  TextEditingController? controller;
  String? suffixTitle;
  SwitchState({this.state, this.text, this.controller, this.suffixTitle});
}

class ScheduleData {
  int? day;
  String? startTime;
  String? endTime;
  String? title;
  List<String>? items;
  String? initialVale;
  Color? color;
  bool? isSelected;

  ScheduleData(
      {this.day,
      this.startTime,
      this.endTime,
      this.title,
      this.initialVale,
      this.color,
      this.isSelected = true,
      this.items = const [
        "Not To Be Schedule",
        "Range",
        "All day",
      ]});
}
