import 'dart:async';
import 'package:insite/core/models/manage_group_summary_response.dart';
import 'package:insite/core/models/manage_notifications.dart';
import 'package:insite/core/services/graphql_schemas_service.dart';
import 'package:insite/utils/helper_methods.dart';
import 'package:insite/views/adminstration/addgeofense/model/geofencemodel.dart';
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
import '../../add_group/asset_selection_widget/asset_selection_widget_view.dart';
import '../../add_group/model/add_group_model.dart';
import './model/zone.dart';
import 'package:insite/widgets/dumb_widgets/insite_dialog.dart';
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

  bool? isEditLoading = false;

  AlertConfigEdit? localData;

  NotificationExist? notificationExists;
  String? maintenanceDropDownValue;
  @override
  void dispose() {
    super.dispose();
    controller!.dispose();
  }

  final GlobalKey<AssetSelectionWidgetViewState> assetSelectionState =
      new GlobalKey();
BuildContext ctx;
  AddNewNotificationsViewModel(AlertConfigEdit? data,this.ctx) {
    localData = data;
    this.log = getLogger(this.runtimeType.toString());
    _notificationService!.setUp();
    _manageUserService!.setUp();
    _geofenceservice?.setUp();
    setUp();
    getEditingSeverityState(data);
    getInitialEndValue();
    Future.delayed(Duration(seconds: 1), () async {
      showLoadingDialog(tapDismiss: false);
      await getNotificationTypesData();
      await onGettingFaultCodeData();
      hideLoadingDialog();
      if (data != null) {
        getEditLoading();
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
          onGettingFaultCodeData();
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

  getEditLoading() {
    isEditLoading = true;
    notifyListeners();
  }

  bool isEditing = false;

  bool isEditLoader = true;

  List<String?> _noticationTypes = ["select"];
  List<String?> get notificationTypes => _noticationTypes;

  List<CheckBoxDropDown> _zoneNamesInclusion = [];
  List<CheckBoxDropDown> get zoneNamesInclusion => _zoneNamesInclusion;

  List<CheckBoxDropDown> _zoneNamesExclusion = [];
  List<CheckBoxDropDown> get zoneNamesExclusion => _zoneNamesExclusion;

  List<String?> _notificationSubTypesEdit = ["Site Entry", "Site Exit"];
  List<String?> get notificationSubTypesEdit => _notificationSubTypesEdit;

  List<String?> _notificationSubTypes = ["Options"];
  List<String?> get notificationSubTypes => _notificationSubTypes;

  List<String> _choiseData = [
    "Assets",
    "Groups",
    "Geofences",
  ];
  List<String> get choiseData => _choiseData;

  List<String> _choiseDatas = [
    "Assets",
    "Groups",
  ];
  List<String> get choiseDatas => _choiseDatas;

  bool _loading = true;
  bool get loading => _loading;

  bool _loadingMore = false;
  bool get loadingMore => _loadingMore;

  String _dropDownInitialValue = "select";
  String get dropDownInitialValue => _dropDownInitialValue;

  String _dropDownSubInitialValue = "Options";
  String get dropDownSubInitialValue => _dropDownSubInitialValue;

  String? _dropDownSubInitialValueEdit;
  String get dropDownSubInitialValueEdit => _dropDownSubInitialValueEdit!;

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
  String? assetSelectionValue = "Assets";

  String _searchKeyword = '';
  set searchKeyword(String keyword) {
    this._searchKeyword = keyword;
  }

  AssetGroupSummaryResponse? assetIdresult;

  ManageGroupSummaryResponse? groupResult;

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

  List<String>? geofenceUIDList = [];
  List<String>? geofenceNameList = [];

  String geofenceName = '';

  String geofenceNameBR = '';

  List<String> geofenceAddedList = [];

  String geofenceAddedName = '';

  String geofenceAddedNameBR = '';

  AlertTypes? alterTypes;
  AlertConfigEdit? alertConfigData;

  Geofence? geofenceData;

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
  List<String> geofenceId = [];

  List<SwitchState> switchState = [
    SwitchState(state: true, text: "Open"),
    SwitchState(state: true, text: "Close")
  ];
  List<SwitchState> powerModeState = [
    SwitchState(state: true, text: "Economy"),
    SwitchState(state: true, text: "Standard"),
    SwitchState(state: true, text: "Run")
  ];

  List<SwitchState> severityState = [];

  List<SwitchState> faultCodeType = [
    SwitchState(state: false, text: "Event"),
    SwitchState(state: false, text: "Diagnostic")
  ];

  List<SwitchState> customizableState = [
    SwitchState(state: true, text: "Include"),
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
  List<CheckBoxDropDown>? selectedList = [];
  String expansionTitle = "Description";
  int notificationTypeGroupID = 0;
  int notificationTypeId = 0;
  List<Operand> operandData = [];
  List<SitOperands> sitOperands = [];
  //List<Map<String, dynamic>>? siteOperand = [];
  NotificationTypes? notificationType;

  List<User> selectedUser = [];

  TextEditingController faultCodeSearchController = TextEditingController();

  List<FaultCodeDetails>? faultCodeTypeSearch = [];
  List<FaultCodeDetails> SelectedfaultCodeTypeSearch = [];

  bool isTitleExist = false;
  bool isNotificationNameChange = false;
//  TimeOfDay? startTime=TimeOfDay(hour: 12, minute: 00);
//  TimeOfDay? endTime=TimeOfDay(hour: 14, minute: 59);
  TimeOfDay? startTime = TimeOfDay(hour: 00, minute: 00);
  TimeOfDay? endTime = TimeOfDay(hour: 23, minute: 59);
  String initialEndValue = "23:59";
  String initialStartValue = "00:00";
  String initialDayOption = "All Days";
  bool checkingAllDay = true;

  List<CheckBoxDropDown> selectedDays = [];
  List<Schedule> scheduleDay = [];

  List<String> days = ["All Days", "Days"];

  onConformingDropDown(List<CheckBoxDropDown>? value) {
    selectedList = value;
    Logger().e(value);

    notifyListeners();
  }

  getEditingSeverityState(AlertConfigEdit? data) async {
    if (data?.alertConfig != null) {
      Logger().v(data?.alertConfig!.operands!.length);
      await getEditOperandData(data?.alertConfig?.operands);
      severityState = [
        SwitchState(state: false, text: "High"),
        SwitchState(state: false, text: "Medium"),
        SwitchState(state: false, text: "Low")
      ];
    } else {
      severityState = [
        SwitchState(state: true, text: "High"),
        SwitchState(state: true, text: "Medium"),
        SwitchState(state: true, text: "Low")
      ];
    }
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
        if (alertConfigData!.alertConfig!.alertCategoryID == 1) {
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
        } else if (alertConfigData!.alertConfig!.alertCategoryID == 2) {
          var groupResult =
              await _manageUserService!.getManageGroupSummaryResponseListData(
                  1,
                  {
                    "pageNumber": 1,
                    "searchKey": "GroupName",
                    "searchValue": _searchKeyword,
                    "sort": ""
                  },
                  _searchKeyword);
          Logger().wtf(groupResult?.toJson());
          assetIdresult = AssetGroupSummaryResponse(
              assetDetailsRecords: groupResult?.groups!
                  .map((e) => Asset(
                        assetIdentifier: e.GroupUid,
                        assetSerialNumber: e.GroupName,
                      ))
                  .toList());
          if (this.alertConfigData!.alertConfig!.assetGroups!.isNotEmpty &&
              groupResult != null) {
            for (var item in groupResult.groups!) {
              if (this
                  .alertConfigData!
                  .alertConfig!
                  .assetGroups!
                  .any((editData) => editData == item.GroupUid)) {
                selectedAsset?.add(Asset(
                  assetIdentifier: item.GroupUid,
                  assetSerialNumber: item.GroupName,
                ));
                assetIdresult!.assetDetailsRecords = assetIdresult!
                    .assetDetailsRecords!
                    .where((o) => o.assetIdentifier != item.GroupUid)
                    .toList();
              }
            }
            selectedAsset = selectedAsset?.toSet().toList();
          }
        } else if (alertConfigData!.alertConfig!.alertCategoryID == 3) {
          var geofenceData = await _geofenceservice!.getGeofenceData();
          Logger().wtf(geofenceData?.toJson());
          assetIdresult = AssetGroupSummaryResponse(
              assetDetailsRecords: geofenceData!.geofences!
                  .map((e) => Asset(
                        assetIdentifier: e.GeofenceUID,
                        assetSerialNumber: e.GeofenceName,
                      ))
                  .toList());
          Logger().wtf(geofenceData.toJson());
          if (this.alertConfigData!.alertConfig!.geofences!.isNotEmpty &&
              geofenceData != null) {
            for (var item in geofenceData.geofences!) {
              if (this
                  .alertConfigData!
                  .alertConfig!
                  .geofences!
                  .any((editData) => editData == item.GeofenceUID)) {
                selectedAsset!.add(Asset(
                  assetIdentifier: item.GeofenceUID,
                  assetSerialNumber: item.GeofenceName,
                ));
                assetIdresult!.assetDetailsRecords = assetIdresult!
                    .assetDetailsRecords!
                    .where((o) => o.assetIdentifier != item.GeofenceUID)
                    .toList();
              }
            }
            selectedAsset = selectedAsset?.toSet().toList();
          }
        }
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

  onRemoving() {
    selectedAsset!.clear();
    notifyListeners();
  }

  onAddingAllAsset(List<Asset>? allAsset) {
    // if (selectedAsset!.isEmpty) {
    //   selectedAsset!.addAll(allAsset!);
    // } else {
    Logger().w(allAsset!.length);
    for (var singleAsset in allAsset) {
      if (selectedAsset!.isEmpty) {
        selectedAsset!.add(singleAsset);
      } else if (selectedAsset!.any((element) =>
          element.assetSerialNumber == singleAsset.assetSerialNumber)) {
        snackbarService!.showSnackbar(message: "Asset Alerady Selected");
        return;
      } else {
        selectedAsset!.add(singleAsset);
      }
    }
    //}
    notifyListeners();
  }

  onAddingAsset(int i, Asset? selectedData) {
    if (selectedData != null) {
      if (selectedAsset!.any((element) =>
          element.assetIdentifier == selectedData.assetIdentifier)) {
        if (assetSelectionValue == "Assets") {
          snackbarService!.showSnackbar(message: "Asset Alerady Selected");
        } else if (assetSelectionValue == "Geofences") {
          snackbarService!.showSnackbar(message: "Geofence Alerady Selected");
        } else {
          snackbarService!.showSnackbar(message: "Group Alerady Selected");
        }
      } else {
        Logger().i(assetIdresult?.assetDetailsRecords?.length);
        // assetIdresult?.assetDetailsRecords?.removeWhere((element) =>
        //     element.assetIdentifier == selectedData.assetIdentifier);
        selectedAsset?.add(selectedData);
      }
    }
    notifyListeners();
  }

  onDeletingAsset(int i) {
    try {
      if (selectedAsset != null) {
        //   Logger().e(selectedAsset?.length);
        var data = selectedAsset?.elementAt(i);
        //  // assetIdresult?.assetDetailsRecords?.add(data!);
        selectedAsset?.removeAt(i);
        //assetSelectionState.currentState!.onAddingDeletedAsset(data!);
        assetSelectionState.currentState!
            .build(assetSelectionState.currentContext!);
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
      "Conditions",
      "Equal to",
      "Greater than",
      "Less than",
      "Greater than or equal to",
      "Less than or equal to"
    ];
    List<String> geofenceList = ["Site Entry", "Site Exit"];

    List<String> maintenance = ["Overdue", "Upcoming"];
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
    } else if (geofenceList
        .any((element) => element == data.alertConfig!.notificationType)) {
      _noticationTypes.clear();
      _dropDownSubInitialValueEdit = data.alertConfig!.notificationType;
      Logger().wtf(data.alertConfig!.siteOperands!.length);
      //geofenceCount = data.alertConfig!.siteOperands!.length;
      _dropDownInitialValue = "Geofence";
      _noticationTypes.add("Geofence");
      _notificationSubTypes.clear();
      await getGeofenceData();
      if (data.alertConfig!.siteOperands!.isNotEmpty) {
        data.alertConfig!.siteOperands!
          ..forEach((element) {
            //geoenceData.add(CheckBoxDropDown(items: element.GeofenceName));
            //Logger().wtf(element.GeofenceName);
            geofenceAddedList.add(element.name.toString());
            geofenceAddedName = "$geofenceAddedList";

            geofenceAddedNameBR =
                geofenceAddedName.substring(1, geofenceAddedName.length - 1);
            Logger().wtf(element.name.toString());
          });
      }
      for (int i = 0; i < geoenceData.length; i++) {
        for (int j = 0; j < geofenceAddedList.length; j++) {
          if (geoenceData[i].items == geofenceAddedList[j]) {
            Logger().wtf(i);
            Logger().wtf(geoenceData[i].items);
            geofenceUIDList!.add(geofenceData!.geofences![i].GeofenceUID!);
            geoenceData[i].isSelected = true;
          }
        }
      }
    } else {
      Logger().w(data.alertConfig!.notificationType);
      if (data.alertConfig!.notificationType == "Maintenance") {
        _noticationTypes.clear();
        _dropDownInitialValue = data.alertConfig!.notificationType!;
        _noticationTypes.add(data.alertConfig!.notificationType!);
        _notificationSubTypes.clear();
        if (data.alertConfig!.operands!.isNotEmpty) {
          data.alertConfig!.operands!.forEach((element) {
            if (element.value == '1') {
              _dropDownSubInitialValue = maintenance[0];
            } else {
              _dropDownSubInitialValue = maintenance[1];
            }

            _notificationSubTypes = maintenance;
          });
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
    switch (alertConfigData!.alertConfig!.alertCategoryID) {
      case 1:
        assetSelectionValue = 'Assets';
        break;
      case 2:
        assetSelectionValue = 'Groups';
        break;
      case 3:
        assetSelectionValue = 'Geofences';
        break;
      default:
    }
    isEditLoading = false;
    await getGroupListData();
    notifyListeners();

    if (dropDownInitialValue != "Geofence")
      await getEditOperandData(alertConfigData?.alertConfig?.operands);

    if (alertConfigData!.alertConfig!.scheduleDetails!.isNotEmpty) {
      scheduleDay.clear();
     if(userPref!.timeFormat=="hh:mm a"){
       for (var i = 0;
          i < alertConfigData!.alertConfig!.scheduleDetails!.length;
          i++) {
        var data = alertConfigData!.alertConfig!.scheduleDetails;
        var editedEndTime =
            TimeOfDay.fromDateTime(DateTime.parse(data![i].scheduleEndTime!)).format(ctx);
          Logger().wtf("editedEndTime:$editedEndTime") ;     
        
        var editedStartTime =
            TimeOfDay.fromDateTime(DateTime.parse(data[i].scheduleStartTime!)).format(ctx);
               Logger().wtf("editedStartTime:$editedStartTime") ;   
       
        if (data[i].scheduleDayNum == 0) {
          scheduleDay.add(Schedule(
              day: data[i].scheduleDayNum,
              title: "Sunday",
              endTime: editedEndTime,
              startTime: editedStartTime));
        } else if (data[i].scheduleDayNum == 1) {
          scheduleDay.add(Schedule(
              day: data[i].scheduleDayNum,
              title: "Monday",
              endTime: editedEndTime,
              startTime: editedStartTime));
        } else if (data[i].scheduleDayNum == 2) {
          scheduleDay.add(Schedule(
              day: data[i].scheduleDayNum,
              title: "Tuesday",
              endTime: editedEndTime,
              startTime: editedStartTime));
        } else if (data[i].scheduleDayNum == 3) {
          scheduleDay.add(Schedule(
              day: data[i].scheduleDayNum,
              title: "Wednesday",
              endTime: editedEndTime,
              startTime: editedStartTime));
        } else if (data[i].scheduleDayNum == 4) {
          scheduleDay.add(Schedule(
              day: data[i].scheduleDayNum,
              title: "Thursday",
              endTime: editedEndTime,
              startTime: editedStartTime));
        } else if (data[i].scheduleDayNum == 5) {
          scheduleDay.add(Schedule(
              day: data[i].scheduleDayNum,
              title: "Friday",
              endTime: editedEndTime,
              startTime: editedStartTime));
        } else if (data[i].scheduleDayNum == 6) {
          scheduleDay.add(Schedule(
              day: data[i].scheduleDayNum,
              title: "Saturday",
              endTime: editedEndTime,
              startTime: editedStartTime));
        }
      }
     }else{
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

    // data.alertConfig!.assets!.forEach((element) {
    //   assetUidData.add(element.assetUID!);
    // });

    notifyListeners();
  }

  getEditOperandData(List<OperandData>? data) async {
    if (dropDownInitialValue == "Fault Code") {
      var isInclude = false;
      var isExclude = false;
      var severityData =
          data!.where((element) => element.operandName == "Severity");
      var faultCodeData =
          data.where((element) => element.operandName == "FaultCode Type");
      var faultCodeDescription = data
          .where((element) => element.operandName == "FaultCode Identifier");
      if (faultCodeData
          .any((element) => element.value == "1" && element.operatorID == 26)) {
        faultCodeType[0].state = true;
      } else {
        faultCodeType[0].state = false;
      }
      if (faultCodeData
          .any((element) => element.value == "2" && element.operatorID == 26)) {
        faultCodeType[1].state = true;
      } else {
        faultCodeType[1].state = false;
      }
      if (faultCodeDescription.any(
          (element) => element.operatorID == 40 && element.operandID == 23)) {
        isInclude = true;
      } else if (faultCodeDescription.any(
          (element) => element.operatorID == 41 && element.operandID == 23)) {
        isExclude = true;
      }
      isInclude == true
          ? customizableState[0].state = true
          : customizableState[0].state = false;
      isExclude == true
          ? customizableState[1].state = true
          : customizableState[1].state = false;
      if (isInclude == true || isExclude == true) {
        faultCodeDescription.forEach((item) {
          faultCodeTypeSearch?.forEach((element) => {
                if (element.faultCodeIdentifier == item.value)
                  {SelectedfaultCodeTypeSearch.add(element)}
              });
        });
        customizable[0].state = true;
        var faultCodeDescriptionList = await _notificationService!
            .getSingleFaultCodeDescription(graphqlSchemaService
                ?.getSingleNotiFaultDescription(alertConfigUid));
        faultCodeDescriptionList!.faults!.length > 0
            ? faultCodeDescriptionList.faults?.forEach((element) {
                SelectedfaultCodeTypeSearch.add(element);
              })
            : null;
      }
      if (severityData
          .any((element) => element.value == "1" && element.operatorID == 25)) {
        severityState[0].state = true;
      } else {
        severityState[0].state = false;
      }
      if (severityData
          .any((element) => element.value == "2" && element.operatorID == 25)) {
        severityState[1].state = true;
      } else {
        severityState[1].state = false;
      }
      if (severityData
          .any((element) => element.value == "3" && element.operatorID == 25)) {
        severityState[2].state = true;
      } else {
        severityState[2].state = false;
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
    SelectedfaultCodeTypeSearch.add(data);
    notifyListeners();
  }

  onDeletingSelectedFaultCode(int i) {
    var data = SelectedfaultCodeTypeSearch.elementAt(i);
    SelectedfaultCodeTypeSearch.remove(data);
    faultCodeTypeSearch!.add(data);
    notifyListeners();
  }

  onSelectingDropDown(int i) {
    geoenceData[i].isSelected = !geoenceData[i].isSelected!;
    // Logger().wtf(geoenceData[i].isSelected!);

    //Logger().wtf(geofenceData!.geofences![i].GeofenceName);
    if (geofenceData != null) {
      if (geoenceData[i].isSelected! == true) {
        geofenceUIDList!.add(geofenceData!.geofences![i].GeofenceUID!);

        geofenceNameList!.add("${geofenceData!.geofences![i].GeofenceName!}");

        geofenceName = "$geofenceNameList";

        geofenceNameBR = geofenceName.substring(1, geofenceName.length - 1);

        Logger().wtf(geoenceData[i].isSelected!);
      } else if (geoenceData[i].isSelected! == false) {
        geofenceUIDList!.remove(geofenceData!.geofences![i].GeofenceUID!);

        geofenceNameList!.remove(geofenceData!.geofences![i].GeofenceName!);

        geofenceName = "$geofenceNameList";

        geofenceNameBR = geofenceName.substring(1, geofenceName.length - 1);

        Logger().wtf(geoenceData[i].isSelected!);
      }
    }
    //Logger().wtf(geofenceUIDList);
    notifyListeners();
  }

  onEditSelectingDropDown(int i) {
    geoenceData[i].isSelected = !geoenceData[i].isSelected!;

    // if (geofenceAddedList.isNotEmpty) {
    //   for (int i = 0; i < geofenceData!.geofences!.length; i++) {
    //     if (geofenceAddedNameBR == geofenceData!.geofences![i].GeofenceName!) {
    //       geofenceUIDList!.add(geofenceData!.geofences![i].GeofenceUID!);
    //       Logger().wtf(geofenceAddedNameBR);
    //       Logger().wtf(geofenceData!.geofences![i].GeofenceName!);
    //     }
    //   }
    // }

    if (geofenceData != null) {
      if (geoenceData[i].isSelected! == true) {
        geofenceUIDList!.add(geofenceData!.geofences![i].GeofenceUID!);

        geofenceAddedList.add("${geofenceData!.geofences![i].GeofenceName!}");

        geofenceAddedName = "$geofenceAddedList";

        geofenceAddedNameBR =
            geofenceAddedName.substring(1, geofenceAddedName.length - 1);

        Logger().wtf(geoenceData[i].isSelected!);
      } else if (geoenceData[i].isSelected! == false) {
        geofenceUIDList!.remove(geofenceData!.geofences![i].GeofenceUID!);

        geofenceAddedList.remove(geofenceData!.geofences![i].GeofenceName!);

        geofenceAddedName = "$geofenceAddedList";

        geofenceAddedNameBR =
            geofenceAddedName.substring(1, geofenceAddedName.length - 1);

        Logger().wtf(geoenceData[i].isSelected!);
      }
    }

    notifyListeners();
  }

  String geofenceDropDownValue() {
    String data = "";
    if (selectedList!.isNotEmpty) {
      selectedList!.forEach((element) {
        data = data + ", ${element.items!}";
      });

      return data.replaceFirst(",", "").padLeft(0);
    } else {
      return "Select";
    }
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
    severityState.forEach((element) {
      element.state = false;
    });
    faultCodeType.forEach((element) {
      element.state = true;
    });

    // customizableState.forEach((element) {
    //   element.state = true;
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
    customizableState.forEach((element) {
      if (element.state == true) {
        element.state = false;
      }
    });
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
      if (value.length >= 2) {
        var faultCodeType = await _notificationService!.getFaultCodeTypeSearch(
            value,
            page,
            "",
            graphqlSchemaService?.getFaultCodeTypesData(
                faultDescription: value,
                pageNo: page,
                lang: "en-US",
                codeType: ""));

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
    if (selectedUser.any((emailID) => emailID.email == emailController.text)) {
      snackbarService!.showSnackbar(message: "Recipient already added");
    } else {
      if (emailController.text.contains("@")) {
        isShowingSelectedContact = true;
        selectedUser.add(User(
          email: emailController.text,
        ));
        emailIds!.add(emailController.text);
        notifyListeners();
      } else {
        snackbarService!
            .showSnackbar(message: "Please Enter the valid Email-Id");
      }

      notifyListeners();
    }
  }

  onGettingFaultCodeData() async {
    try {
      var faultCodeType = await _notificationService!.getFaultCodeTypeSearch(
          "",
          page,
          "",
          graphqlSchemaService?.getFaultCodeTypesData(
              faultDescription: "", pageNo: page, lang: "en-US", codeType: ""));
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

  getInitialEndValue() async {
    await getUserPreference();

    if (userPref?.timeFormat != null && userPref!.timeFormat == "hh:mm a") {
      initialEndValue = "11:59 PM";
      initialStartValue = "12:00 AM";
      Logger().wtf("get initial time");
      notifyListeners();
    }
  }

  onDiagnosticFrontPressed() async {
    showLoadingDialog();
    expansionTitle = "Fault Code Type";
    page = 1;
    var faultCodeType = await _notificationService!.getFaultCodeTypeSearch(
        "",
        page,
        "DIAGNOSTIC",
        graphqlSchemaService?.getFaultCodeTypesData(
            faultDescription: "",
            pageNo: page,
            lang: "en-US",
            codeType: "DIAGNOSTIC"));
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
    page = 1;
    var faultCodeType = await _notificationService!.getFaultCodeTypeSearch(
        "",
        page,
        "EVENT",
        graphqlSchemaService?.getFaultCodeTypesData(
            faultDescription: "",
            pageNo: page,
            lang: "en-US",
            codeType: "EVENT"));
    faultCodeTypeSearch = faultCodeType!.descriptions;
    Future.delayed(Duration(seconds: 1), () {
      pageController.animateToPage(2,
          duration: Duration(microseconds: 3000), curve: Curves.easeInOut);
      hideLoadingDialog();
    });
    notifyListeners();
  }

  onChangingInclusion(List<CheckBoxDropDown>? value) {
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

  onChangingExclusion(List<CheckBoxDropDown>? value) {
    Logger().e(value);
    notifyListeners();
  }

  updateModelValue(String value) {
    _dropDownInitialValue = value;
    _showZone = true;
    getNotificationSubTypes();
  }

  updateModelValueChooseBy(String value) async {
    if (value == assetSelectionValue) {
      return;
    }
    showLoadingDialog();
    assetSelectionValue = value;
    if (value == choiseData[2]) {
      var geofenceData = await _geofenceservice!.getGeofenceData();
      assetIdresult = AssetGroupSummaryResponse(
          assetDetailsRecords: geofenceData!.geofences!
              .map((e) => Asset(
                    assetIdentifier: e.GeofenceUID,
                    assetSerialNumber: e.GeofenceName,
                  ))
              .toList());
    } else if (value == choiseData[1]) {
      var groupResult =
          await _manageUserService!.getManageGroupSummaryResponseListData(
              1,
              {
                "pageNumber": 1,
                "searchKey": "GroupName",
                "searchValue": _searchKeyword,
                "sort": ""
              },
              _searchKeyword);
      Logger().wtf(groupResult?.toJson());
      assetIdresult = AssetGroupSummaryResponse(
          assetDetailsRecords: groupResult?.groups!
              .map((e) => Asset(
                    assetIdentifier: e.GroupUid,
                    assetSerialNumber: e.GroupName,
                  ))
              .toList());
    } else {
      await getGroupListData();
    }
    hideLoadingDialog();
    notifyListeners();
  }

  getGeofenceListData() async {
    geofenceData = await _geofenceservice!.getGeofenceData();
  }

  // getGroupData() async {
  //   groupResult =
  //       await _manageUserService!.getManageGroupSummaryResponseListData(
  //           1,
  //           {
  //             "pageNumber": 1,
  //             "searchKey": "GroupName",
  //             "searchValue": _searchKeyword,
  //             "sort": ""
  //           },
  //           _searchKeyword);
  // }

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

  updateStartTime(String value, int i, TimeOfDay initialStartTime) {
    Logger().e(value);
    startTime = initialStartTime;
    initialStartValue = value;
    notifyListeners();
  }

  updateEndTime(String value, int i, TimeOfDay initialEndTime) {
    endTime = initialEndTime;
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
            // if (notification.siteOperands != null &&
            //     notification.siteOperands!.isNotEmpty) {

            // }
            _notificationSubTypes.add(notification.notificationTypeName);
            // notification.siteOperands?.forEach((element) {
            //   _notificationSubTypes.add(element.operandName);
            // });
          });
          Logger().w(_notificationSubTypes[0]);
          // if (_notificationSubTypes.isNotEmpty &&
          //     _noticationTypes.length != 1) {
          //   _notificationSubTypes.add(
          //       "${_notificationSubTypes[1]} & ${_notificationSubTypes[2]}");
          // }

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

                Logger().wtf(operator.operatorID);
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
      geofenceData = await _geofenceservice!.getGeofenceData();
      if (geofenceData != null) {
        geofenceData!.geofences!.forEach((element) {
          geoenceData.add(CheckBoxDropDown(items: element.GeofenceName));
          //Logger().wtf(element.GeofenceName);
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
          //element.contains("Maintenance") ||
          element.contains("Fuel") ||
          element.contains("Fuel Loss") ||
          element.contains("Inspection") ||
          element.contains("Asset Security") ||
          element.contains("Fluid Analysis") ||
          //element.contains("Geofence") ||
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
      if (value!.length >= 2) {
        notificationExists = await _notificationService!.checkNotificationTitle(
            value, graphqlSchemaService!.checkNotificationTitle(value));
        //isTitleExist = notificationExists!.alertTitleExists!;

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
      emailIds!.removeAt(index);

      notifyListeners();
    } catch (e) {
      Logger().e(e.toString());
    }
  }

  Timer? deBounce;

  searchContacts(String searchValue) async {
    if (emailController.text.length >= 4) {
      if (deBounce?.isActive ?? false) {
        deBounce!.cancel();
      }
      deBounce = Timer(Duration(seconds: 2), () async {
        showLoadingDialog();
        await getContactSearchReportData();
        isHideSearchList = true;
        notifyListeners();
        hideLoadingDialog();
      });
    } else {
      isHideSearchList = false;
      searchContactListName!.clear();
      notifyListeners();
    }
  }

  getContactSearchReportData() async {
    try {
      SearchContactReportListResponse? result = await _manageUserService!
          .getSearchContactResposeData(emailController.text,
              graphqlSchemaService!.getContactSearchData(emailController.text));
      if (result != null) {
        searchContactListName!.clear();
        // Logger().i("result:${result.pageInfo!.totalPages}");

        for (var name in result.users!) {
          searchContactListName!.add(name);
        }
      }
    } catch (e) {
      Logger().e(e.toString());
    }
  }

  cancel(BuildContext context) async {
    bool? value = await showDialog(
      context: context,
      builder: (BuildContext context) {
        return Dialog(
            backgroundColor: Theme.of(context).backgroundColor,
            child: InsiteDialog(
              title: "Confirm Cancellation",
              message:
                  "All the unsaved changes will be lost. Are you sure you want to cancel the operation?",
              onPositiveActionClicked: () {
                Navigator.pop(context, true);
                _showZone = false;
                nameController.clear();
                notificationController.clear();
                emailController.clear();
                descriptionController.clear();
                occurenceController.clear();
                inclusionZoneName.clear();
                exclusionZoneName.clear();
                nameController.clear();
                notificationController.clear();
                emailController.clear();
                descriptionController.clear();
                occurenceController.clear();
                assetStatusOccurenceController.clear();
                selectedUser.clear();
                selectedAsset?.clear();
                scheduleDay.clear();
                _dropDownInitialValue = "select";
                _dropDownSubInitialValue = "Options";
                if (userPref?.timeFormat != null &&
                    userPref!.timeFormat == "hh:mm a") {
                  initialStartValue = "00:00";
                  initialEndValue = "11:59";
                  startTime = TimeOfDay(hour: 00, minute: 00);
                  endTime = TimeOfDay(hour: 11, minute: 59);
                } else {
                  initialStartValue = "00:00";
                  initialEndValue = "23:59";
                  startTime = TimeOfDay(hour: 00, minute: 00);
                  endTime = TimeOfDay(hour: 23, minute: 59);
                }
                notifyListeners();
              },
              onNegativeActionClicked: () {
                Navigator.pop(context, false);
              },
            ));
      },
    );
  }

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
        Logger().wtf(faultCodeTypeSwitcState.text);
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
    var faultData = OperandData?.singleWhere(
        (element) => element.operandName == "FaultCode Identifier");
    Logger().wtf(notificationType!.toJson());
    notificationTypeId = notificationType!.notificationTypeID!;

    if (SelectedfaultCodeTypeSearch.isNotEmpty) {
      for (int i = 0; i < SelectedfaultCodeTypeSearch.length; i++) {
        operandData.add(Operand(
            operandID: faultData!.operandID,
            operatorId: faultData.operators!.first.operatorID,
            value: SelectedfaultCodeTypeSearch[i].faultCodeIdentifier));
      }
    }
  }

  getAssetStatusOperandAndNotificationId() {
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

    // for (int i = 0; i < _notificationSubTypes.length; i++) {
    //   if (_notificationSubTypes[i] == _dropDownSubInitialValue) {
    //     Logger().wtf(OperandData!.first.operators![i].name);
    //     Logger().wtf(OperandData.first.operators![i].operatorID);
    //     operandData.add(Operand(
    //         operandID: OperandData.first.operandID,
    //         operatorId: OperandData.first.operators![i].operatorID,
    //         value: assetStatusOccurenceController.text));
    //   }
    // }
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
      // for (int i = 0; i < _notificationSubTypes.length; i++) {
      //   if (_notificationSubTypes[i] == _dropDownSubInitialValue) {
      //     Logger().wtf(OperandData!.first.operators![i].name);
      //     Logger().wtf(OperandData.first.operators![i].operatorID);
      //     operandData.add(Operand(
      //         operandID: OperandData.first.operandID,
      //         operatorId: OperandData.first.operators![i].operatorID,
      //         value: assetStatusOccurenceController.text));
      //   }
      // }
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
      for (int i = 0; i < _notificationSubTypes.length; i++) {
        if (_notificationSubTypes[i] == dropDownSubInitialValue) {
          Logger().wtf(OperandData!.first.operators![i - 1].name);
          Logger().wtf(OperandData.first.operators![i - 1].operatorID);
          operandData.add(Operand(
              operandID: OperandData.first.operandID,
              operatorId: OperandData.first.operators![i - 1].operatorID,
              value: assetStatusOccurenceController.text));
        }
      }
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
      // for (int i = 0; i < _notificationSubTypes.length; i++) {
      //   if (_notificationSubTypes[i] == _dropDownSubInitialValue) {
      //     Logger().wtf(OperandData!.first.operators![i].name);
      //     Logger().wtf(OperandData.first.operators![i].operatorID);
      //     operandData.add(Operand(
      //         operandID: OperandData.first.operandID,
      //         operatorId: OperandData.first.operators![i].operatorID,
      //         value: assetStatusOccurenceController.text));
      //   }
      // }
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

  getGeofenceOperandAndNotificationId() {
    try {
      operandData.clear();
      var notificationTypeGroups = alterTypes!.notificationTypeGroups!
          .singleWhere(
              (element) => element.notificationTypeGroupName == "Geofence");
      notificationTypeGroupID = notificationTypeGroups.notificationTypeGroupID!;
      if (dropDownSubInitialValue == "Site Entry") {
        notificationType = notificationTypeGroups.notificationTypes!
            .singleWhere(
                (element) => element.notificationTypeName == dropDownSubInitialValue);
      } else if (dropDownSubInitialValue == "Site Exit") {
        notificationType = notificationTypeGroups.notificationTypes!
            .singleWhere(
                (element) => element.notificationTypeName == dropDownSubInitialValue);
      }

      notificationTypeId = notificationType!.notificationTypeID!;
      Logger().wtf(notificationType!.notificationTypeName);
      Logger().wtf(notificationType!.notificationTypeID);
      if (geofenceUIDList!.isNotEmpty) {
        for (int i = 0; i < geofenceUIDList!.length; i++) {
          sitOperands.add(SitOperands(
              operandID: notificationType!.notificationTypeID!,
              siteUID: geofenceUIDList![i]));

          Logger().wtf(notificationType!.notificationTypeID!);
          Logger().wtf(notificationType!.notificationTypeName);
          Logger().wtf(geofenceUIDList![i]);
        }
      }

      // var OperandData = notificationType?.siteOperands;
      // siteOperand = OperandData?.singleWhere(
      //     (element) => element.operandName == dropDownSubInitialValue);
//     if (geofenceOperandData!.operators!
//         .any((element) => element.name == _dropDownSubInitialValue)) {
//     siteOperand.add(SiteOperand(
// condition:
//         ));
//   }
    } catch (e) {
      Logger().w(e.toString());
    }
  }

  getMaintenanceAndNotificationId() {
    operandData.clear();
    var notificationTypeGroups = alterTypes!.notificationTypeGroups!
        .singleWhere(
            (element) => element.notificationTypeGroupName == "Maintenance");
    notificationTypeGroupID = notificationTypeGroups.notificationTypeGroupID!;
    notificationType = notificationTypeGroups.notificationTypes!.singleWhere(
        (element) => element.notificationTypeName == "Maintenance");
    var OperandData = notificationType?.operands;
    notificationTypeId = notificationType!.notificationTypeID!;
    var fuelLossOperandData =
        OperandData?.singleWhere((element) => element.operandName == "DueType");
    // if (fuelLossOperandData!.operators!
    //     .any((element) => element.name == _dropDownSubInitialValue)) {

    if (_dropDownSubInitialValue == "Overdue") {
      maintenanceDropDownValue = '1';
    } else if (_dropDownSubInitialValue == "Upcoming") {
      maintenanceDropDownValue = '2';
    }
    operandData.add(Operand(
        operandID: OperandData!.first.operandID,
        operatorId: OperandData.first.operators!.first.operatorID,
        value: maintenanceDropDownValue));
    // }assetStatusOccurenceController.text
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
    } else if (_dropDownInitialValue == "Maintenance") {
      await getMaintenanceAndNotificationId();
      Logger().w("notificationGroupid ${notificationTypeGroupID}");
      Logger().i("notificationTypeId ${notificationTypeId}");
      operandData.forEach((element) {
        Logger().wtf("OperandData ${element.toJson()}");
      });
    } else if (_dropDownInitialValue == "Geofence") {
      await getGeofenceOperandAndNotificationId();
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

    await gettingNotificationIdandOperands();
    // await getGeofenceOperandAndNotificationId();

    // if (geofenceAddedList.isNotEmpty) {
    //   for (int i = 0; i < geoenceData.length; i++) {
    //     if (geoenceData[i].isSelected! == true) {
    //       Logger().wtf(geofenceAddedNameBR);
    //       geofenceUIDList!.add(geofenceData!.geofences![i].GeofenceUID!);
    //       Logger().wtf(geofenceData!.geofences![i].GeofenceUID!);
    //       sitOperands.add(SitOperands(
    //           operandID: notificationType!.notificationTypeID!,
    //           siteUID: geofenceData!.geofences![i].GeofenceUID!));
    //     }
    //   }
    // }

    AddNotificationPayLoad payLoadData = AddNotificationPayLoad(
        alertCategoryID: alertConfigData!.alertConfig!.alertCategoryID,
        alertGroupId: alertConfigData!.alertConfig!.alertGroupID,
        alertTitle: notificationController.text,
        allAssets: false,
        assetUIDs: assetSelectionValue == 'Assets' ? assetUidData : [],
        //geofenceUIDs: assetSelectionValue == 'Geofences' ? assetUidData : null,
        geofenceUIDs: geofenceUIDList,
        currentDate: alertConfigData!.alertConfig!.createdDate,
        notificationDeliveryChannel: "email",
        notificationTypeGroupID:
            alertConfigData!.alertConfig!.notificationTypeGroupID,
        notificationSubscribers: NotificationSubscribers(emailIds: emailIds),
        notificationTypeId: alertConfigData!.alertConfig!.notificationTypeID,
        schedule: scheduleDay,
        operands: operandData,
        siteOperands: sitOperands,
        numberOfOccurences: 1);
    var data = await _notificationService!.editNotification(
        payLoadData,
        alertConfigUid!,
        graphqlSchemaService!.updateNotification(
            // geofenceUIDs:
            //     assetSelectionValue == 'Geofences' ? assetUidData : null,
            assetUIDs: assetSelectionValue == 'Assets' ? assetUidData : null,
            assetGroupUIDs:
                assetSelectionValue == 'Groups' ? assetUidData : null,
            alertCategoryID: alertConfigData!.alertConfig!.alertCategoryID,
            alertGroupId: alertConfigData!.alertConfig!.alertGroupID,
            alertTitle: notificationController.text,
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
            siteOperand: sitOperands,
            geofenceUIDs: geofenceUIDList,
            alertId: alertConfigUid!,
            numberOfOccurences: 1));
    //Logger().wtf(operandData[0].operatorId);
    if (data != null) {
      _snackBarservice!.showSnackbar(message: "Edit Notification Success");
      gotoManageNotificationsPage();

      hideLoadingDialog();
      // gotoManageNotificationsPage();
    }
  }

  saveAddNotificationData() async {
    try {
      assetUidData.clear();
    selectedAsset!.forEach((element) {
      assetUidData.add(element.assetIdentifier!);
    });

//To know if initialStartValue greater than initialEndValue

    var currentDate = DateTime.now();
    var startDateTime =
        DateTime(currentDate.year, currentDate.month, currentDate.day)
            .add(Duration(hours: startTime!.hour, minutes: startTime!.minute));
    Logger().v("startDateTime: $startDateTime");
    var endDateTime =
        DateTime(currentDate.year, currentDate.month, currentDate.day)
            .add(Duration(hours: endTime!.hour, minutes: endTime!.minute));
    Logger().v("endDateTime:$endDateTime");
    if (endDateTime.isBefore(startDateTime)) {
      _snackBarservice!
          .showSnackbar(message: "To time must greater than from time");
      return null;
    }

    if (notificationExists?.alertTitleExists == true) {
      Logger().v("show title");
      _snackBarservice!.showSnackbar(message: "Notification title exists");
      // notificationController.clear();
    }

    if (notificationController.text.isEmpty) {
      _snackBarservice!.showSnackbar(message: "Notification Name is required");
      return;
    }

    if (emailIds!.isEmpty) {
      _snackBarservice!.showSnackbar(message: "Notification email is required");
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
    if (userPref!.timeFormat == "hh:mm a") {
      scheduleDay.forEach((element) {
        final format = DateFormat.jm();
        element.endTime = Utils.get24hrFormat(
            time: TimeOfDay.fromDateTime(format.parse(element.endTime!)));
        element.startTime = Utils.get24hrFormat(
            time: TimeOfDay.fromDateTime(format.parse(element.startTime!)));
      });
    }

    if (isEditing) {
      editNotification();
    } else {
      showLoadingDialog();
      var currentDate = DateTime.now();
      var newFormat = DateFormat("dd-MM-yy");
      String date = newFormat.format(currentDate);
      Logger().wtf(assetSelectionValue);
      await gettingNotificationIdandOperands();
      AddNotificationPayLoad? notificationPayLoad;
      if (dropDownInitialValue == "Geofence") {
        notificationPayLoad = AddNotificationPayLoad(
            alertCategoryID: assetSelectionValue == 'Assets'
                ? 1
                : assetSelectionValue == 'Groups'
                    ? 2
                    : assetSelectionValue == 'Geofences'
                        ? 3
                        : 1,
            alertGroupId: dropDownInitialValue == "Geofence" ? 2 : 1,
            alertTitle: notificationController.text,
            allAssets: false,
            assetUIDs: assetSelectionValue == 'Assets' ? assetUidData : null,
            assetGroupUIDs:
                assetSelectionValue == 'Groups' ? assetUidData : null,
            geofenceUIDs: geofenceUIDList,
            currentDate: DateFormat("MM/dd/yyyy").format(DateTime.now()),
            notificationDeliveryChannel: "email",
            notificationSubscribers:
                NotificationSubscribers(emailIds: emailIds, phoneNumbers: []),
            notificationTypeGroupID: notificationTypeGroupID,
            notificationTypeId: notificationTypeId,
            siteOperands: sitOperands,
            schedule: scheduleDay,
            numberOfOccurences: 1);
        Logger().w(notificationPayLoad.toJson());
      } else {
        notificationPayLoad = AddNotificationPayLoad(
            alertCategoryID: assetSelectionValue == 'Assets'
                ? 1
                : assetSelectionValue == 'Groups'
                    ? 2
                    : assetSelectionValue == 'Geofences'
                        ? 3
                        : 1,
            alertGroupId: dropDownInitialValue == "Geofence" ? 2 : 1,
            alertTitle: notificationController.text,
            allAssets: false,
            assetUIDs: assetSelectionValue == 'Assets' ? assetUidData : null,
            assetGroupUIDs:
                assetSelectionValue == 'Groups' ? assetUidData : null,
            geofenceUIDs:
                assetSelectionValue == 'Geofences' ? assetUidData : null,
            currentDate: DateFormat("MM/dd/yyyy").format(DateTime.now()),
            notificationDeliveryChannel: "email",
            notificationSubscribers:
                NotificationSubscribers(emailIds: emailIds, phoneNumbers: []),
            notificationTypeGroupID: notificationTypeGroupID,
            notificationTypeId: notificationTypeId,
            operands: operandData,
            schedule: scheduleDay,
            numberOfOccurences: 1);
        Logger().w(notificationPayLoad.toJson());
      }

      
        NotificationAdded? response = await _notificationService!
            .addNewNotification(notificationPayLoad,
                graphqlSchemaService!.createNotification());

        if (response != null) {
          _snackBarservice!.showSnackbar(message: "Add Notification Success");
          hideLoadingDialog();
          gotoManageNotificationsPage();
        }
        // else {
        //   _snackBarservice!
        //       .showSnackbar(message: "Kindly recheck credentials added");
        // }
        hideLoadingDialog();
        Logger().i(response!.toJson());
        notifyListeners();
      
    }
      
    } catch (e) {
      Logger().e(e.toString());
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

  AddNotificationPayLoad? getNotificationPayLoad(String? value) {
    if (value == "Geofences") {
      AddNotificationPayLoad? notificationPayLoadGeofence =
          AddNotificationPayLoad(
              alertCategoryID: 3,
              alertGroupId: dropDownInitialValue == "Geofence" ? 2 : 1,
              alertTitle: notificationController.text,
              allAssets: false,
              geofenceUIDs: assetUidData,
              currentDate: DateFormat("MM/dd/yyyy").format(DateTime.now()),
              notificationDeliveryChannel: "email",
              notificationSubscribers:
                  NotificationSubscribers(emailIds: emailIds, phoneNumbers: []),
              notificationTypeGroupID: notificationTypeGroupID,
              notificationTypeId: notificationTypeId,
              operands: operandData,
              schedule: scheduleDay,
              numberOfOccurences: 1);
      Logger().i(notificationPayLoadGeofence.toJson());
      return notificationPayLoadGeofence;
    } else if (value == "Groups") {
      AddNotificationPayLoad? notificationPayLoadGroup = AddNotificationPayLoad(
          alertCategoryID: 2,
          alertGroupId: dropDownInitialValue == "Geofence" ? 2 : 1,
          alertTitle: notificationController.text,
          allAssets: false,
          assetGroupUIDs: assetUidData,
          currentDate: DateFormat("MM/dd/yyyy").format(DateTime.now()),
          notificationDeliveryChannel: "email",
          notificationSubscribers:
              NotificationSubscribers(emailIds: emailIds, phoneNumbers: []),
          notificationTypeGroupID: notificationTypeGroupID,
          notificationTypeId: notificationTypeId,
          operands: operandData,
          schedule: scheduleDay,
          numberOfOccurences: 1);
      Logger().i(notificationPayLoadGroup.toJson());
      return notificationPayLoadGroup;
    } else {
      AddNotificationPayLoad addNotificationPayLoad = AddNotificationPayLoad(
          alertCategoryID: 1,
          alertGroupId: dropDownInitialValue == "Geofence" ? 2 : 1,
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
      Logger().wtf(addNotificationPayLoad.toJson());
      return addNotificationPayLoad;
    }
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
