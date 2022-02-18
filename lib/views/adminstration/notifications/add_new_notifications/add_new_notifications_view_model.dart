import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:insite/core/base/insite_view_model.dart';
import 'package:insite/core/locator.dart';
import 'package:insite/core/models/add_group_data_response.dart';
import 'package:insite/core/models/add_group_payload.dart';
import 'package:insite/core/models/add_notification_payload.dart';

import 'package:insite/core/models/asset_group_summary_response.dart';
import 'package:insite/core/models/customer.dart';
import 'package:insite/core/models/edit_group_payload.dart';
import 'package:insite/core/models/edit_group_response.dart';
import 'package:insite/core/models/manage_group_summary_response.dart';
import 'package:insite/core/models/notification_type.dart';
import 'package:insite/core/models/search_contact_report_list_response.dart';
import 'package:insite/core/models/update_user_data.dart';
import 'package:insite/core/services/asset_admin_manage_user_service.dart';
import 'package:insite/core/services/local_service.dart';
import 'package:insite/core/services/notification_service.dart';
import 'package:insite/views/adminstration/addgeofense/exception_handle.dart';
import 'package:insite/views/adminstration/manage_group/manage_group_view.dart';
import 'package:insite/views/adminstration/notifications/manage_notifications/manage_notifications_view.dart';
import 'package:intl/intl.dart';
import 'package:load/load.dart';
import 'package:logger/logger.dart';
import 'package:stacked/stacked.dart';
import 'package:insite/core/logger.dart';
import 'package:stacked_services/stacked_services.dart';

class AddNewNotificationsViewModel extends InsiteViewModel {
  Logger? log;

  NotificationService? _notificationService = locator<NotificationService>();
  LocalService? _localService = locator<LocalService>();

  final AssetAdminManagerUserService? _manageUserService =
      locator<AssetAdminManagerUserService>();
  final SnackbarService? _snackBarservice = locator<SnackbarService>();
  NavigationService? _navigationService = locator<NavigationService>();
  TabController? controller;
  Customer? accountSelected;

  AddNewNotificationsViewModel()  {
    this.log = getLogger(this.runtimeType.toString());
    _notificationService!.setUp();
    setUp();
   

    Future.delayed(Duration(seconds: 1), () {
      
      getNotificationTypesData();
      getInclusionExclusionZones();
      getData();
    });
  }

  setUp() async {
    try {
      accountSelected = await _localService!.getAccountInfo();
     
    } catch (e) {
      Logger().e(e);
    }
  }

  @override
  void dispose() {
    super.dispose();
    controller!.dispose();
  }

  List<String?> _noticationTypes = ["select"];
  List<String?> get notificationTypes => _noticationTypes;

  List<String?> _zoneNamesInclusion = ["Select Inclusion Zone"];
  List<String?> get zoneNamesInclusion => _zoneNamesInclusion;

  List<String?> _zoneNamesExclusion = ["Select Exclusion Zone"];
  List<String?> get zoneNamesExclusion => _zoneNamesExclusion;

  List<String?> _notificationSubTypes = ["Options"];
  List<String?> get notificationSubTypes => _notificationSubTypes;

  List<String?> _email = ["Select"];
  List<String?> get email => _email;

  List<String> _type = [
    "select",
    "Range",
    "All day",
  ];
  List<String> get type => _type;

  List<String> _choiseData = [
    
    "Assets",
    
  ];
  List<String> get choiseData => _choiseData;

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

  String _initialType = "select";
  String get initialType => _initialType;

  String _initialStartTime = "select";
  String get initialStartTime => _initialStartTime;

  String _initialEndTime = "select";
  String get initialEndTime => _initialEndTime;

  String _dropDownSubInitialValue = "Options";
  String get dropDownSubInitialValue => _dropDownSubInitialValue;

  String _inclusionInitialValue = "Select Inclusion Zone";
  String get inclusionInitialValue => _inclusionInitialValue;

  String _exclusionInitialValue = "Select Exclusion Zone";
  String get exclusionInitialValue => _exclusionInitialValue;

  int? _notificationTyeGroupId = 1;
  int? get notificationTyeGroupId => _notificationTyeGroupId;

  int? _notificationTypeId = 1;
  int? get notificationTypeId => _notificationTypeId;

  int? _operandId = 1;
  int? get operandId => _operandId;

  int? _operatorId = 1;
  int? get operatorId => _operatorId;

  int? _value = 1;
  int? get value => _value;

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

  bool _selectPowerMode = false;
  bool get selectPowerMode => _selectPowerMode;

  bool _showSwitches = false;
  bool get showSwitches => _showSwitches;

  bool _showFaultCodes = false;
  bool get showFaultCodes => _showFaultCodes;

  bool _showFluidAnalysis = false;
  bool get showFluidnalysis => _showFluidAnalysis;

  bool _showInspections = false;
  bool get showInspections => _showInspections;

  bool _showMaintainance = false;
  bool get showMaintainance => _showMaintainance;

  bool _showAssetSecurity = false;
  bool get showAssetSecurity => _showAssetSecurity;

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
  List<String>? emailIds =[];
  

  updateModelValue(String value) {
    _notificationSubTypes.clear();
    _notificationSubTypes.add("Options");
    _dropDownSubInitialValue = "Options";

    _showConditionTypes = false;
    _showNotificationType = false;
    _showFuelLoss = false;
    _setOdometer = false;
    _selectPowerMode = false;
    _showFaultCodes = false;
    _showSwitches = false;
    _showFluidAnalysis = false;
    _showInspections = false;
    _showMaintainance = false;
    _showAssetSecurity = false;
    _showZone = false;

    _dropDownInitialValue = value;

    getNotificationSubTypes(_dropDownInitialValue);

    notifyListeners();
  }

  updateSubModelValue(String value) {
    _dropDownSubInitialValue = value;

    notifyListeners();
  }

  updateType(String value) {
    _initialType = value;

    notifyListeners();
  }

  updateStartTime(String value) {
    _initialStartTime = value;

    notifyListeners();
  }

  updateEndTime(String value) {
    _initialEndTime = value;

    notifyListeners();
  }

  getInclusionExclusionZones() async {
    ZoneValues? response =
        await _notificationService!.getInclusionExclusionZones();

    if (response != null) {
      if (response.zones != null && response.zones!.isNotEmpty) {
        response.zones!.forEach((element) {
          if (element != null) {
            _zoneNamesInclusion.add(element.zoneName);
            _zoneNamesExclusion.add(element.zoneName);
          }
        });

        _loading = false;
        _loadingMore = false;
        _shouldLoadmore = false;
      } else {
        _loading = false;
        _loadingMore = false;
        _shouldLoadmore = false;
      }
    } else {
      _loading = false;
      _loadingMore = false;
      _shouldLoadmore = false;
    }
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
              _notificationTyeGroupId = notification.notificationTypeGroupID;
              _notificationTypeId = item.notificationTypeID;
              _operandId = item.operands!.first.operandID;
            }
          } else if (value == notification.notificationTypeGroupName &&
              notification.notificationTypes!.isNotEmpty) {
            if (notification.notificationTypeGroupName == "Fuel") {
              for (var item in notification
                  .notificationTypes!.first.operands!.first.operators!) {
                _showConditionTypes = true;
                _notificationSubTypes.add(item.name);
                _notificationTyeGroupId = notification.notificationTypeGroupID;
                _operandId = notification
                  .notificationTypes!.first.operands!.first.operandID;

                  if(item.name == "Equal to"){
                    _operatorId = item.operatorID;
                    _value = 1;

                  }else if(item.name == "Greater than"){
                     _operatorId = item.operatorID;
                    _value = 2;

                  }
                  else if(item.name == "Less than"){
                     _operatorId = item.operatorID;
                    _value = 3;

                  }else if(item.name == "Greater than or equal to"){
                     _operatorId = item.operatorID;
                    _value = 4;

                  }else if(item.name == "Less than or equal to"){
                     _operatorId = item.operatorID;
                    _value = 5;

                  }
                for (var item in notification.notificationTypes!) {
                _notificationTypeId = item.notificationTypeID;
                
              }}
            }
            if (notification.notificationTypeGroupName == "Engine Hours") {
              for (var item in notification
                  .notificationTypes!.first.operands!.first.operators!) {
                _showConditionTypes = true;
                _notificationSubTypes.add(item.name);
                _operandId = notification
                  .notificationTypes!.first.operands!.first.operandID;
                  if(item.name == "Equal to"){
                    _operatorId = item.operatorID;
                    _value = 1;

                  }else if(item.name == "Greater than"){
                     _operatorId = item.operatorID;
                    _value = 2;

                  }
                  else if(item.name == "Less than"){
                     _operatorId = item.operatorID;
                    _value = 3;

                  }else if(item.name == "Greater than or equal to"){
                     _operatorId = item.operatorID;
                    _value = 4;

                  }else if(item.name == "Less than or equal to"){
                     _operatorId = item.operatorID;
                    _value = 5;

                  }
                _notificationTyeGroupId = notification.notificationTypeGroupID;
                 for (var item in notification.notificationTypes!) {
                _notificationTypeId = item.notificationTypeID;
              }
              }
            }
            if (notification.notificationTypeGroupName == "Odometer") {
              for (var item in notification
                  .notificationTypes!.first.operands!.first.operators!) {
                _showConditionTypes = true;
                _setOdometer = true;
                _notificationSubTypes.add(item.name);
                _operandId = notification
                  .notificationTypes!.first.operands!.first.operandID;
                  if(item.name == "Equal to"){
                    _operatorId = item.operatorID;
                    _value = 1;

                  }else if(item.name == "Greater than"){
                     _operatorId = item.operatorID;
                    _value = 2;

                  }
                  else if(item.name == "Less than"){
                     _operatorId = item.operatorID;
                    _value = 3;

                  }else if(item.name == "Greater than or equal to"){
                     _operatorId = item.operatorID;
                    _value = 4;

                  }else if(item.name == "Less than or equal to"){
                     _operatorId = item.operatorID;
                    _value = 5;

                  }
                _notificationTyeGroupId = notification.notificationTypeGroupID;
                 for (var item in notification.notificationTypes!) {
                _notificationTypeId = item.notificationTypeID;
              }
              }
            }
            if (notification.notificationTypeGroupName == "Fuel Loss") {
              _showFuelLoss = true;
              _notificationTyeGroupId = notification.notificationTypeGroupID;
               for (var item in notification.notificationTypes!) {
                _notificationTypeId = item.notificationTypeID;
                _operandId = item.operands!.first.operandID;
              }
            }
            if (notification.notificationTypeGroupName == "Power Mode") {
              _selectPowerMode = true;
              _notificationTyeGroupId = notification.notificationTypeGroupID;
               for (var item in notification.notificationTypes!) {
                _notificationTypeId = item.notificationTypeID;
                _operandId = item.operands!.first.operandID;
              }
            }
            if (notification.notificationTypeGroupName == "Switches") {
              _showSwitches = true;
              _notificationTyeGroupId = notification.notificationTypeGroupID;
               for (var item in notification.notificationTypes!) {
                _notificationTypeId = item.notificationTypeID;
                _operandId = item.operands!.first.operandID;
              }
            }
            if (notification.notificationTypeGroupName == "Fault") {
              _showFaultCodes = true;
              _notificationTyeGroupId = notification.notificationTypeGroupID;
               for (var item in notification.notificationTypes!) {
                _notificationTypeId = item.notificationTypeID;
                _operandId = item.operands!.first.operandID;
              }
            }
            if (notification.notificationTypeGroupName == "Fluid Analysis") {
              _showFluidAnalysis = true;
              _notificationTyeGroupId = notification.notificationTypeGroupID;
               for (var item in notification.notificationTypes!) {
                _notificationTypeId = item.notificationTypeID;
                _operandId = item.operands!.first.operandID;
              }
            }
            if (notification.notificationTypeGroupName == "Inspection") {
              _showInspections = true;
              _notificationTyeGroupId = notification.notificationTypeGroupID;
               for (var item in notification.notificationTypes!) {
                _notificationTypeId = item.notificationTypeID;
                _operandId = item.operands!.first.operandID;
              }
            }
            if (notification.notificationTypeGroupName == "Asset Security") {
              _showAssetSecurity = true;
              _notificationTyeGroupId = notification.notificationTypeGroupID;
               for (var item in notification.notificationTypes!) {
                _notificationTypeId = item.notificationTypeID;
                _operandId = item.operands!.first.operandID;
              }
            }
            if (notification.notificationTypeGroupName ==
                "Zone Inclusion/Exclusion") {
              _showZone = true;
              _notificationTyeGroupId = notification.notificationTypeGroupID;
               for (var item in notification.notificationTypes!) {
                _notificationTypeId = item.notificationTypeID;
                _operandId = item.operands!.first.operandID;
              }
            }
            if (notification.notificationTypeGroupName ==
                "Excessive Daily Idle") {
              for (var item in notification
                  .notificationTypes!.first.operands!.first.operators!) {
                _showConditionTypes = true;
                _notificationSubTypes.add(item.name);
                if(item.name == "Equal to"){
                    _operatorId = item.operatorID;
                    _value = 1;

                  }else if(item.name == "Greater than"){
                     _operatorId = item.operatorID;
                    _value = 2;

                  }
                  else if(item.name == "Less than"){
                     _operatorId = item.operatorID;
                    _value = 3;

                  }else if(item.name == "Greater than or equal to"){
                     _operatorId = item.operatorID;
                    _value = 4;

                  }else if(item.name == "Less than or equal to"){
                     _operatorId = item.operatorID;
                    _value = 5;

                  }
                _notificationTyeGroupId = notification.notificationTypeGroupID;
                 for (var item in notification.notificationTypes!) {
                _notificationTypeId = item.notificationTypeID;
                _operandId =item.operands!.first.operandID;
              }
              }
            } else if (value == notification.notificationTypeGroupName &&
                notification.notificationTypes!.isNotEmpty &&
                notification.notificationTypeGroupName == "Maintenance") {
              _showMaintainance = true;
              List<String> maintainanceList = ["Overdue", "Upcoming"];
              _notificationSubTypes.addAll(maintainanceList);
              _notificationTyeGroupId = notification.notificationTypeGroupID;
               for (var item in notification.notificationTypes!) {
                _notificationTypeId = item.notificationTypeID;
                _operandId = item.operands!.first.operandID;
              }
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

  TextEditingController nameController = TextEditingController();
  TextEditingController notificationController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();
  TextEditingController occurenceController = TextEditingController();

  Groups? groups;

  

  AssetGroupSummaryResponse? groupSummaryResponseData;

  List<String> associatedAssetId = [];
  List<String> dissociatedAssetId = [];

  List<String> assetUidData = [];

  checkIfNotificationNameExist(String? value) async{
    try{
       NotificationExist? notificationExists = await _notificationService!.checkNotificationTitle(value);

       if(notificationExists!.alertTitleExists == true){
          _snackBarservice!.showSnackbar(message: "Notification title exists");

       }
       notifyListeners();

    }on DioError catch (e) {
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
      selectedContactItems!.removeAt(index);
      notifyListeners();
    } catch (e) {
      Logger().e(e.toString());
    }
  }

  searchContacts(String searchValue) {
    _searchKeyword = searchValue;
    isHideSearchList = true;
    notifyListeners();

    getContactSearchReportData();
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

  cancel(){

  }

  saveAddNotificationData() async {
    var currentDate = DateTime.now();
    var newFormat = DateFormat("dd-MM-yy");
    String date = newFormat.format(currentDate);

    AddNotificationPayLoad? notificationPayLoad = AddNotificationPayLoad(
      alertCategoryID: 1
      alertGroupId: 1,
      alertTitle: notificationController.text
      allAssets: false,
      assetUIDs: ["${accountSelected!.CustomerUID}"],
      currentDate:date,
      notificationDeliveryChannel: "email",
      notificationSubscribers:NotificationSubscribers(emailIds: emailIds,phoneNumbers:["+917619168091@airtel.com"]),
      notificationTypeGroupID: _notificationTyeGroupId,
      notificationTypeId: _notificationTypeId,
      operands:[ Operand(operandID: 36, operatorId: 51, value: "1")],
      // numberOfOccurences: occurenceController.text.isEmpty? 1 :int.parse(occurenceController.text),
      numberOfOccurences: 1,
      schedule:[ Schedule(day: 0, startTime: "00:00", endTime: " 00:24"),Schedule(day: 1, startTime: "00:00", endTime: " 00:24"),Schedule(day: 2, startTime: "00:00", endTime: " 00:24"),Schedule(day: 3, startTime: "00:00", endTime: " 00:24"),Schedule(day: 4, startTime: "00:00", endTime: " 00:24"),Schedule(day: 5, startTime: "00:00", endTime: " 00:24"),Schedule(day: 6, startTime: "00:00", endTime: " 00:24"),]
    );

    try{
      if (notificationController.text.isEmpty) {
        _snackBarservice!.showSnackbar(message: "Notification Name is be required");
        return;
      }

      NotificationAdded? response = await _notificationService!.addNewNotification(notificationPayLoad);


      showLoadingDialog();
      
      if (response != null) {
        
        _snackBarservice!.showSnackbar(message: "You have added a new notification");
        
        hideLoadingDialog();
        gotoManageNotificationsPage();
      }else{
         _snackBarservice!.showSnackbar(message: "Kindly recheck credentials added");
      }
      hideLoadingDialog();
      Logger().i(response!.toJson());
      notifyListeners();
    }catch(e){
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
}
