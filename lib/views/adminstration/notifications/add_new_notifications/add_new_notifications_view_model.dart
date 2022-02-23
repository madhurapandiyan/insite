import 'dart:async';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:insite/core/base/insite_view_model.dart';
import 'package:insite/core/locator.dart';
import 'package:insite/core/models/add_notification_payload.dart';

import 'package:insite/core/models/asset_group_summary_response.dart';
import 'package:insite/core/models/customer.dart';
import 'package:insite/core/models/edit_group_response.dart';
import 'package:insite/core/models/manage_group_summary_response.dart';
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
  TabController? controller;
  Customer? accountSelected;
  @override
  void dispose() {
    super.dispose();
    controller!.dispose();
  }

  AddNewNotificationsViewModel() {
    this.log = getLogger(this.runtimeType.toString());
    _notificationService!.setUp();
    setUp();

    Future.delayed(Duration(seconds: 1), () {
      getNotificationTypesData();
      getData();
      onGettingFaultCodeData();
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

  List<User>? searchContactListName = [];
  bool isHideSearchList = false;

  String _searchKeyword = '';
  set searchKeyword(String keyword) {
    this._searchKeyword = keyword;
  }

  List<String>? selectedContactItems = [];

  List<String>? phoneNumbers = [];
  List<String>? emailIds = [];

  List<String>? notificationFleetType = [];
  List<String>? notificationServiceType = [];
  List<String>? geofenceAssets = [];
  List<String>? administratortAssets = [];

  AlertTypes? alterTypes;

  // text editing controller
  TextEditingController inclusionZoneName = TextEditingController();
  TextEditingController exclusionZoneName = TextEditingController();
  TextEditingController nameController = TextEditingController();
  TextEditingController notificationController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();
  TextEditingController occurenceController = TextEditingController();
  TextEditingController assetStatusOccurenceController =
      TextEditingController();
  TextEditingController engineHoursOccurenceController =
      TextEditingController();
  TextEditingController excessiveDailyOccurenceController =
      TextEditingController();
  TextEditingController fuelOccurenceController = TextEditingController();
  TextEditingController fuelLosssOccurenceController = TextEditingController();
  TextEditingController odometerOccurenceController = TextEditingController();
  TextEditingController geofenceOccurenceController = TextEditingController();

  // text editing controller ----------------------------

  onTap() {
    for (var i = 0; i < schedule.length; i++) {
      if (i == 0) {
        Logger().w(
            "endTime :-${schedule[i].endTime},startTime :-${schedule[i].startTime},title:-${schedule[i].title},initialValue :-${schedule[i].initialVale}");
      }
      if (i == 1) {
        Logger().w(
            "endTime :-${schedule[i].endTime},startTime :-${schedule[i].startTime},title:-${schedule[i].title},initialValue :-${schedule[i].initialVale}");
      }
      if (i == 2) {
        Logger().w(
            "endTime :-${schedule[i].endTime},startTime :-${schedule[i].startTime},title:-${schedule[i].title},initialValue :-${schedule[i].initialVale}");
      }
      if (i == 3) {
        Logger().w(
            "endTime :-${schedule[i].endTime},startTime :-${schedule[i].startTime},title:-${schedule[i].title},initialValue :-${schedule[i].initialVale}");
      }
      if (i == 4) {
        Logger().w(
            "endTime :-${schedule[i].endTime},startTime :-${schedule[i].startTime},title:-${schedule[i].title},initialValue :-${schedule[i].initialVale}");
      }
      if (i == 5) {
        Logger().w(
            "endTime :-${schedule[i].endTime},startTime :-${schedule[i].startTime},title:-${schedule[i].title},initialValue :-${schedule[i].initialVale}");
      }
      if (i == 6) {
        Logger().w(
            "endTime :-${schedule[i].endTime},startTime :-${schedule[i].startTime},title:-${schedule[i].title},initialValue :-${schedule[i].initialVale}");
      }
    }

    // Logger().w(hoursAfetrOverDueController.text);
    // Logger().w(distanceTravelAfetrOverDueController.text);
    // Logger().w(upcomingMilesController.text);
    // Logger().w(upcomingHoursController.text);
    // Logger().w(upcomingDaysController.text);
  }

  onChangingSubType(value) {
    _dropDownSubInitialValue = value;
    notifyListeners();
  }

  List<ScheduleData> schedule = [
    ScheduleData(
        day: 0,
        title: "SUN",
        startTime: "00:00",
        endTime: "24:00",
        initialVale: "select"),
    ScheduleData(
        day: 0,
        title: "MON",
        startTime: "00:00",
        endTime: "24:00",
        initialVale: "select"),
    ScheduleData(
        day: 0,
        title: "TUE",
        startTime: "00:00",
        endTime: "24:00",
        initialVale: "select"),
    ScheduleData(
        day: 0,
        title: "WED",
        startTime: "00:00",
        endTime: "24:00",
        initialVale: "select"),
    ScheduleData(
        day: 0,
        title: "THU",
        startTime: "00:00",
        endTime: "24:00",
        initialVale: "select"),
    ScheduleData(
        day: 0,
        title: "FRI",
        startTime: "00:00",
        endTime: "24:00",
        initialVale: "select"),
    ScheduleData(
        day: 0,
        title: "SAT",
        startTime: "00:00",
        endTime: "24:00",
        initialVale: "select"),
  ];

  Groups? groups;

  AssetGroupSummaryResponse? groupSummaryResponseData;

  List<String> associatedAssetId = [];
  List<String> dissociatedAssetId = [];

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
    SwitchState(state: true, text: "High"),
    SwitchState(state: true, text: "Medium"),
    SwitchState(state: true, text: "Low")
  ];

  List<SwitchState> faultCodeType = [
    SwitchState(state: true, text: "Event"),
    SwitchState(state: true, text: "Diagnostic")
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

  onConformingDropDown(List<String> value) {
    selectedList = value;
    Logger().e(value);
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

  onChagingOccurenceBox(String value) {}

  onChagingAssetOccurenceBox(String value) {}

  onChagingeEngineHourOccurenceBox(String value) {}

  onChagingeExcessiveOccurenceBox(String value) {}

  onChagingeFuelOccurenceBox(String value) {}

  onChagingeFuelLossOccurenceBox(String value) {}

  onChagingeOdometerOccurenceBox(String value) {}

  onChagingeGeofenceOccurenceBox(String value) {}

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
    isShowingSelectedContact = true;
    var data = searchContactListName!
        .where((element) => element.email!.contains(emailController.text));
    if (selectedUser
        .any((element) => element.email!.contains(data.first.email!))) {
    } else {
      selectedUser.add(data.first);
      emailIds!.add(data.first.name!);
    }
    notifyListeners();
  }

  onGettingFaultCodeData() async {
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
    schedule[i].initialVale = value;
    notifyListeners();
  }

  updateStartTime(String value, int i) {
    Logger().e(value);
    schedule[i].startTime = value;
    notifyListeners();
  }

  updateEndTime(String value, int i) {
    schedule[i].endTime = value;
    notifyListeners();
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

  getNotificationTypesData() async {
    alterTypes = await _notificationService!.getNotificationTypes();

    if (alterTypes != null) {
      alterTypes!.notificationTypeGroups!.forEach((notificationTypeGroup) {
        notificationTypeGroup.notificationTypes!.forEach((notificationType) {
           Logger().w(notificationType.toJson());
          if (notificationType.appName == "VL Unified Fleet" ||
              notificationType.appName ==
                  "Frame-Fleet-IND") {
                    //Logger().w(notificationType.toJson());
            if (notificationTypeGroup.notificationTypeGroupName!.isNotEmpty) {
              if (notificationFleetType!.any((element) => element.contains(
                  notificationTypeGroup.notificationTypeGroupName!))) {
              } else {
                if (notificationTypeGroup.notificationTypeGroupName ==
                    "Geofence") {
                  if (geofenceAssets!.any((element) => element.contains(
                      notificationTypeGroup.notificationTypeGroupName!))) {
                  } else {
                    geofenceAssets!
                        .add(notificationTypeGroup.notificationTypeGroupName!);
                  }
                } else {
                  if (notificationTypeGroup.notificationTypeGroupName ==
                      "Asset Security") {
                    if (administratortAssets!.any((element) => element.contains(
                        notificationTypeGroup.notificationTypeGroupName!))) {
                    } else {
                      administratortAssets!.add(
                          notificationTypeGroup.notificationTypeGroupName!);
                    }
                  } else {
                    notificationFleetType!
                        .add(notificationTypeGroup.notificationTypeGroupName!);
                  }
                }
              }
            } else {
              notificationFleetType!
                  .add(notificationType.notificationTypeName!);
           }
            

          } else if (notificationType.appName == "VL Unified Service" ||
              notificationType.appName == "Frame-Service-IND") {
            notificationServiceType!
                .add(notificationType.notificationTypeName!);
          } else if (notificationType.appName == "VisionLink Administrator" ||
              notificationType.appName == "Frame-Administrator-IND") {
            administratortAssets!.add(notificationType.notificationTypeName!);
          } else {
            geofenceAssets!.add(notificationType.notificationTypeName!);
          }
        });
      });
    }

    notifyListeners();
  }

  checkIfNotificationNameExist(String? value) async {
    try {
      if (value!.length >= 4) {
        NotificationExist? notificationExists =
            await _notificationService!.checkNotificationTitle(value);

        if (notificationExists!.alertTitleExists == true) {
          _snackBarservice!.showSnackbar(message: "Notification title exists");
        }
        notifyListeners();
      }
    } on DioError catch (e) {
      final error = DioException.fromDioError(e);
      Fluttertoast.showToast(msg: error.message!);
    }
  }

  getEditGroupData() async {
    try {
      showLoadingDialog();
      EditGroupResponse? result =
          await _manageUserService!.getEditGroupData(groups!.GroupUid!);
      if (result != null) {
        nameController.text = result.GroupName!;
        descriptionController.text = result.Description ?? "";
        if (result.AssetUID != null) {
          for (var i = 0; i < result.AssetUID!.length; i++) {
            assetUidData.add(result.AssetUID![i]);
          }
          Logger().i("assetUId:${assetUidData.length}");
        }
      }

      hideLoadingDialog();
      notifyListeners();
    } catch (e) {
      Logger().e(e.toString());
    }
  }

  void getData() {
    if (groups != null) {
      getEditGroupData();
    } else {}
    hideLoadingDialog();
    notifyListeners();
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
      SearchContactReportListResponse? result =
          await _manageUserService!.getSearchContactResposeData(_searchKeyword);
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

  gettingNotificationIdandOperands() {
    if (_dropDownInitialValue == "Fault Code") {
      var notificationTypeGroups = alterTypes!.notificationTypeGroups!
          .singleWhere(
              (element) => element.notificationTypeGroupName == "Fault");
      Logger().wtf(notificationTypeGroups.toJson());
      notificationTypeGroupID = notificationTypeGroups.notificationTypeGroupID!;
      notificationType = notificationTypeGroups.notificationTypes!.singleWhere(
          (element) => element.notificationTypeName == _dropDownInitialValue);
      Logger().wtf(notificationType!.toJson());
      notificationTypeId = notificationType!.notificationTypeID!;
    } else {
      var notificationTypeGroups = alterTypes!.notificationTypeGroups!
          .singleWhere((element) =>
              element.notificationTypeGroupName == _dropDownInitialValue);
      Logger().wtf(notificationTypeGroups.toJson());
      notificationTypeGroupID = notificationTypeGroups.notificationTypeGroupID!;
      if (notificationTypeGroups.notificationTypes!
          .any((element) => element.notificationTypeName == "Fuel Level")) {
        notificationType = notificationTypeGroups.notificationTypes!
            .singleWhere(
                (element) => element.notificationTypeName == "Fuel Level");
        notificationTypeId = notificationType!.notificationTypeID!;
        Logger().w(notificationType!.toJson());
      }
      if (notificationTypeGroups.notificationTypes!.any(
          (element) => element.notificationTypeName == _dropDownInitialValue)) {
        notificationType = notificationTypeGroups.notificationTypes!
            .singleWhere((element) =>
                element.notificationTypeName == _dropDownInitialValue);
        Logger().w(notificationType!.toJson());
        notificationTypeId = notificationType!.notificationTypeID!;
      }
      if (notificationTypeGroups.notificationTypes!.any((element) =>
          element.notificationTypeName == _dropDownSubInitialValue)) {
        notificationType = notificationTypeGroups.notificationTypes!
            .singleWhere((element) =>
                element.notificationTypeName == _dropDownSubInitialValue);
        Logger().w(notificationType!.toJson());
        notificationTypeId = notificationType!.notificationTypeID!;
      }
    }
    Logger().i("notificationGroupId : $notificationTypeGroupID");
    Logger().i("notificationTypeId : $notificationTypeId");

    notificationType?.operands?.forEach((operand) {
      if (operand.operandName == "Fuel Loss") {
        var operator = operand.operators!.forEach((element) {
          Logger().e(element.toJson());
          operandData.clear();
          operandData.add(Operand(
              operandID: operand.operandID,
              operatorId: element.operatorID,
              value: "1"));
        });
      }
      if (operand.operandName == "Power Mode") {
        var operator = operand.operators!.forEach((element) {
          Logger().e(element.toJson());
          if (SelectedfaultCodeTypeSearch!.isEmpty) {
            operandData.clear();
            operandData.add(Operand(
                operandID: operand.operandID,
                operatorId: element.operatorID,
                value: "1"));
          } else {
            operandData.clear();
            operandData.add(Operand(
                operandID: operand.operandID,
                operatorId: element.operatorID,
                value: "1"));
          }
        });
      }
      if (operand.operandName == "Fuel Level") {
        var operator = operand.operators!
            .singleWhere((element) => element.name == _dropDownSubInitialValue);
        Logger().e(operator.toJson());
        operandData.clear();
        operandData.add(Operand(
            operandID: operand.operandID,
            operatorId: operator.operatorID,
            value: "1"));
      }
      if (operand.operators!
          .any((element) => element.name == _dropDownSubInitialValue)) {
        var operator = operand.operators!
            .singleWhere((element) => element.name == _dropDownSubInitialValue);
        Logger().e(operator.toJson());
        operandData.clear();
        operandData.add(Operand(
            operandID: operand.operandID,
            operatorId: operator.operatorID,
            value: "1"));
      } else {
        operand.operators!.forEach((operator) {
          // Logger().e(operator.toJson());
          operandData.clear();
          operandData.add(Operand(
              operandID: operand.operandID,
              operatorId: operator.operatorID,
              value: "1"));
        });
        operandData.forEach((element) {
          Logger().e(element.toJson());
        });
      }
    });
  }

  saveAddNotificationData() async {
    var currentDate = DateTime.now();
    var newFormat = DateFormat("dd-MM-yy");
    String date = newFormat.format(currentDate);

    await gettingNotificationIdandOperands();
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

//         Logger().w(notificationPayLoad.toJson());

//     try {
//       if (notificationController.text.isEmpty) {
//         _snackBarservice!
//             .showSnackbar(message: "Notification Name is be required");
//         return;
//       }

//       NotificationAdded? response =
//           await _notificationService!.addNewNotification(notificationPayLoad);

//       showLoadingDialog();

//       if (response != null) {
//         _snackBarservice!
//             .showSnackbar(message: "You have added a new notification");

//         hideLoadingDialog();
//         gotoManageNotificationsPage();
//       } else {
//         _snackBarservice!
//             .showSnackbar(message: "Kindly recheck credentials added");
//       }
//       hideLoadingDialog();
//       Logger().i(response!.toJson());
//       notifyListeners();
//     } catch (e) {
//       Logger().e(e.toString());
//     }
  }

  onItemContactSelected(int index) {
    selectedContactItems!.add(searchContactListName![index].email!);
    Logger().wtf(selectedContactItems!.length.toString());
    emailIds!.add(searchContactListName![index].email!);
    phoneNumbers!.add(searchContactListName![index].name!);
    isHideSearchList = false;

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

  ScheduleData(
      {this.day,
      this.startTime,
      this.endTime,
      this.title,
      this.initialVale,
      this.items = const [
        "select",
        "Range",
        "All day",
      ]});
}
