import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:form_field_validator/form_field_validator.dart';
import 'package:insite/core/base/insite_view_model.dart';
import 'package:insite/core/locator.dart';
import 'package:insite/core/models/add_report_payload.dart';
import 'package:insite/core/models/asset_group_summary_response.dart';
import 'package:insite/core/models/edit_report_response.dart';
import 'package:insite/core/models/manage_group_summary_response.dart';
import 'package:insite/core/models/manage_report_response.dart';
import 'package:insite/core/models/search_contact_report_list_response.dart';
import 'package:insite/core/models/template_response.dart';
import 'package:insite/core/services/asset_admin_manage_user_service.dart';
import 'package:insite/core/services/geofence_service.dart';
import 'package:insite/utils/helper_methods.dart';
import 'package:insite/views/adminstration/add_group/model/add_group_model.dart';
import 'package:insite/views/adminstration/add_report/fault_code_model.dart';
import 'package:insite/views/adminstration/addgeofense/model/geofencemodel.dart';
import 'package:insite/views/adminstration/manage_report/manage_report_view.dart';
import 'package:load/load.dart';
import 'package:logger/logger.dart';
import 'package:insite/core/logger.dart';
import 'package:stacked_services/stacked_services.dart';

import '../add_group/asset_selection_widget/asset_selection_widget_view.dart';

class AddReportViewModel extends InsiteViewModel {
  Logger? log;
  AssetAdminManagerUserService? _manageUserService =
      locator<AssetAdminManagerUserService>();
  AddReportPayLoad? addReportPayLoad;
  List<String>? reportFleetAssets = ["Select"];
  List<String>? reportServiceAssets = [];
  List<String>? reportProductivityAssets = [];
  List<String>? reportStandartAssets = [];
  String? assetSelectionValue = "Assets";
  final Geofenceservice? _geofenceservice = locator<Geofenceservice>();

  List<String> _choiseData = ["Assets", "Geofences", "Groups"];
  List<String> get choiseData => _choiseData;

  List<User>? searchContactListName = [];
  List<String>? associatedIdentifier = [];

  List<String>? svcBody = [];
  List<AddGroupModel>? selectedItemAssets = [];

  final SnackbarService? _snackBarservice = locator<SnackbarService>();

  TextEditingController nameController = new TextEditingController();
  TextEditingController searchContactController = new TextEditingController();
  TextEditingController serviceDueController = new TextEditingController();
  TextEditingController emailContentController = new TextEditingController();

  String _searchKeyword = '';
  set searchKeyword(String keyword) {
    this._searchKeyword = keyword;
  }

  NavigationService? _navigationService = locator<NavigationService>();

  bool isHideSearchList = false;

  bool isListViewState = false;

  Geofence? geofenceData;

  ManageGroupSummaryResponse? groupResult;

  bool isLoading = true;
  bool isAssetLoading = true;
  int? reportFormat;

  String? dropDownValue = "Select";

  List<String>? selectedContactItems = [];
  List<User> selectedUser = [];

  String? assetsDropDownValue = "Select";

  String reportFormatDropDownValue = ".CSV";
  String frequencyDropDownValue = "Daily";
  String chooseByDropDownValue = "Assets";
  bool isShowingSelectedContact = false;
  String? editQueryUrl;
  List<String>? editReportColumn = [];
  bool isSearching = false;
  List<Asset>? searchAsset = [];
  List<Asset>? selectedAsset = [];
  AssetGroupSummaryResponse? assetIdresult;

  List<String> dropDownList = ["All", "ID", "S/N"];

  String initialValue = "All";

  ScheduledReports? scheduledReportsId;

  bool isEditing = false;

  TextEditingController dateTimeController = new TextEditingController();
  TextEditingController emailController = TextEditingController();
  List<String> dropvaluelist = [
    ".CSV",
    ".XLSX",
    //".PDF"
  ];
  final GlobalKey<AssetSelectionWidgetViewState> assetSelectionState =
      new GlobalKey();

  AddReportViewModel(ScheduledReports? scheduledReports, bool? isEdit,
      String? dropdownValue, String? templateTitleValue) {
    _geofenceservice!.setUp();
    (_manageUserService!.setUp() as Future).then((_) {
      this.scheduledReportsId = scheduledReports;
      this.log = getLogger(this.runtimeType.toString());
      if (isEdit == true) {
        isEditing = isEdit!;
        getEditReportData();
      } else if (isEdit == false) {
        Future.delayed(Duration.zero, () async {
          await getTemplateReportAssetData();
          await getGroupListData();
        });
      }
      if (isEdit == null) {
        Future.delayed(Duration.zero, () async {
          getGroupListData();
          getTemplateReportAssetData().then((_) {
            getTemplateTitleValue(templateTitleValue!);
            getDropDownValue(dropdownValue!);
          });
        });
      }
    });
  }

  getListViewState() {
    isListViewState = true;
    notifyListeners();
  }

  updateModelValueChooseBy(String value) async {
    if (value == assetSelectionValue) {
      return;
    }
    showLoadingDialog();
    assetSelectionValue = value;
    if (value == choiseData[1]) {
      geofenceData = await _geofenceservice!.getGeofenceData();
      assetIdresult = AssetGroupSummaryResponse(
          assetDetailsRecords: geofenceData!.geofences!
              .map((e) => Asset(
                    assetIdentifier: e.GeofenceUID,
                    assetSerialNumber: e.GeofenceName,
                  ))
              .toList());
      Logger().w(assetIdresult!.assetDetailsRecords!.first.toJson());
    } else if (value == choiseData[2]) {
      groupResult =
          await _manageUserService!.getManageGroupSummaryResponseListData(
              1,
              {
                "pageNumber": 1,
                "searchKey": "GroupName",
                "searchValue": _searchKeyword,
                "sort": ""
              },
              _searchKeyword);
      assetIdresult = AssetGroupSummaryResponse(
          assetDetailsRecords: groupResult!.groups!
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

  getDropDownValue(String dropdownValue) {
    Logger().w(dropdownValue);
    if (dropdownValue == ".CSV") {
      reportFormatDropDownValue = dropdownValue;
      dropvaluelist.clear();
      dropvaluelist.addAll([".CSV", ".XLS", ".PDF"]);
    } else if (dropDownValue == ".XLS") {
      reportFormatDropDownValue = dropdownValue;
      dropvaluelist.clear();
      dropvaluelist.addAll([".XLS", ".CSV", ".PDF"]);
    } else {
      reportFormatDropDownValue = dropdownValue;
      dropvaluelist.clear();
      dropvaluelist.addAll([".PDF", ".CSV", ".XLS"]);
    }
    notifyListeners();
  }

  List<String>? svsBodyFormated = [];

  getTemplateTitleValue(String templateTitleValue) {
    Logger().w(templateTitleValue);
    if (isVisionLink) {
    } else {
      if (templateTitleValue == "Asset Event Count") {
        assetsDropDownValue = templateTitleValue;
      } else if (templateTitleValue == "Fleet Summary") {
        assetsDropDownValue = templateTitleValue;
      } else if (templateTitleValue == "Asset Operation") {
        assetsDropDownValue = templateTitleValue;
      } else if (templateTitleValue == "Engine Idle") {
        assetsDropDownValue = templateTitleValue;
      } else if (templateTitleValue == "Fault Code") {
        assetsDropDownValue = templateTitleValue;
      } else if (templateTitleValue == "Fault Code Asset Details") {
        assetsDropDownValue = templateTitleValue;
      } else if (templateTitleValue == "Fault Summary Fault Lists") {
        assetsDropDownValue = templateTitleValue;
      } else if (templateTitleValue == "Multi-Asset Utilization") {
        assetsDropDownValue = templateTitleValue;
      } else if (templateTitleValue == "Utilization Details") {
        assetsDropDownValue = templateTitleValue;
      } else if (templateTitleValue == "Backhoe Loader Operation") {
        assetsDropDownValue = templateTitleValue;
      } else if (templateTitleValue == "Excavator Usage") {
        assetsDropDownValue = templateTitleValue;
      } else if (templateTitleValue == "Multi-Asset Backhoe Loader Operation") {
        assetsDropDownValue = templateTitleValue;
      } else if (templateTitleValue == "Multi-Asset Excavator Usage") {
        assetsDropDownValue = templateTitleValue;
      }

      reportFleetAssets!
          .removeWhere((element) => element == assetsDropDownValue);
      reportFleetAssets?.replaceRange(0, 1, [assetsDropDownValue!]);
    }
    notifyListeners();
  }

  getDatPickerData(String formattedDate) {
    dateTimeController.text = formattedDate;
    notifyListeners();
  }

  TemplateResponse? result;

  Future getTemplateReportAssetData() async {
    try {
      result = await _manageUserService!.getTemplateReportAssetData();

      for (var assetItems in result!.reports!) {
        if (assetItems.sourceAppName == "UNIFIEDFLEET" &&
            assetItems.defaultColumn != "") {
          if (isVisionLink) {
            reportFleetAssets!.add(assetItems.reportName!);
          } else {
            if (assetItems.reportName == "MultiAssetUtilization" ||
                assetItems.reportName == "UtilizationDetails" ||
                assetItems.reportName == "FaultSummaryFaultsList" ||
                assetItems.reportName == "FaultCodeAssetDetails" ||
                assetItems.reportName == "FleetSummary" ||
                assetItems.reportName == "AssetOperation" ||
                assetItems.reportName == "BackhoeLoaderOperation" ||
                assetItems.reportName == "ExcavatorUsageReport" ||
                assetItems.reportName == "MultiAssetBackhoeLoaderOperation" ||
                assetItems.reportName == "MultiAssetExcavatorUsageReport") {
              reportFleetAssets!.add(assetItems.reportTypeName!);
            }
          }
        }
      }

      for (var assetItems in result!.reports!) {
        if (assetItems.sourceAppName == "UNIFIEDSERVICES" &&
            assetItems.defaultColumn != null) {
          if (isVisionLink) {
            reportServiceAssets!.add(assetItems.reportName!);
          } else {
            if (assetItems.reportName == "MultiAssetUtilization" ||
                    assetItems.reportName == "UtilizationDetails" ||
                    assetItems.reportName == "FaultSummaryFaultsList" ||
                    assetItems.reportName == "FaultCodeAssetDetails" ||
                    assetItems.reportName == "FleetSummary" ||
                    assetItems.reportName == "Asset Location History"
                //assetItems.reportName == "Engine Idle" ||
                //assetItems.reportName == "Engine Idle" ||
                //assetItems.reportName == "Asset Event Count" ||
                // assetItems.reportName == "Fault Code"
                ) {
              reportFleetAssets!.add(assetItems.reportTypeName!);
            }
          }
        }
      }

      for (var assetItems in result!.reports!) {
        if (assetItems.sourceAppName == "UNIFIEDPRODUCTIVITY" &&
            assetItems.sourceApplicationID != "") {
          if (isVisionLink) {
            reportFleetAssets!.add(assetItems.reportName!);
          }
        }
      }

      for (var templateAssets in result!.reports!) {
        if (templateAssets.sourceAppName == "BIRST" &&
            templateAssets.dateRange != null) {
          if (isVisionLink) {
            reportFleetAssets!.add(templateAssets.reportName!);
          } else {
            if (templateAssets.reportName == "Asset Event Count" ||
                templateAssets.reportName == "AssetHealth" ||
                // templateAssets.reportName == "ExcavatorUsageReport" ||
                templateAssets.reportName == "EngineIdle" ||
                // templateAssets.reportName == "BackhoeLoaderOperation" ||
                templateAssets.reportName == "AssetEventCountReport") {
              reportFleetAssets!.add(templateAssets.reportTypeName!);
            }
          }
        }
      }
      reportFleetAssets?.removeWhere((element) =>
          element == "Engine Idle" ||
          element == "Asset Event Count" ||
          element == "Fault Code");
      // reportFleetAssets!.add("Asset Location History");
      assetsDropDownValue = reportFleetAssets![0];
      isLoading = false;
      notifyListeners();
    } catch (e) {
      isLoading = false;
      Logger().e(e.toString());
      notifyListeners();
    }
  }

  searchContacts(String searchValue) {
    Logger().wtf(searchValue);
    if (emailController.text.length >= 4) {
      _searchKeyword = searchValue;
      isHideSearchList = true;
      notifyListeners();
      getContactSearchReportData();
    } else {
      isHideSearchList = false;
      searchContactListName!.clear();
      notifyListeners();
    }
  }

  getContactSearchReportData() async {
    try {
      SearchContactReportListResponse? result = await _manageUserService!
          .getSearchContactResposeData(_searchKeyword,
              graphqlSchemaService!.getContactSearchData(_searchKeyword));

      if (result != null) {
        searchContactListName?.clear();
        // Logger().i("result:${result.pageInfo!.totalPages}");
        for (var name in result.users!) {
          searchContactListName!.add(name);
        }
      }
      notifyListeners();
    } catch (e) {
      Logger().e(e.toString());
    }
  }

  onItemContactSelected(int index) {
    selectedContactItems!.add(searchContactListName![index].email!);
    Logger().wtf(selectedContactItems!.length.toString());
    isHideSearchList = false;
    notifyListeners();
  }

  onRemovedSelectedContact(int index) {
    try {
      selectedUser.removeAt(index);
      notifyListeners();
    } catch (e) {
      Logger().e(e.toString());
    }
  }

  List<FaultCodeModel>? severityListData = [
    FaultCodeModel(isSelected: false, speed: "High"),
    FaultCodeModel(isSelected: false, speed: "Medium"),
    FaultCodeModel(isSelected: false, speed: "Low"),
  ];
  onItemSelect(int index) {
    severityListData![index].isSelected = !severityListData![index].isSelected!;
    notifyListeners();
  }

  List<FaultCodeModel>? faultCodeTypeListData = [
    FaultCodeModel(isSelected: false, speed: "Event"),
    FaultCodeModel(isSelected: false, speed: "Diagnostic"),
  ];
  getEditReportData() async {
    try {
      //showLoadingDialog();
      await getTemplateReportAssetData();
      reportFleetAssets!.clear();
      Logger().w(scheduledReportsId!.reportUid!);
      EditReportResponse? resultData = await _manageUserService!
          .getEditReportData(
              scheduledReportsId!.reportUid!,
              graphqlSchemaService!
                  .getEditReportData(scheduledReportsId!.reportUid!));
      if (result != null) {
        Logger().w(resultData!.scheduledReport!.toJson());
        editQueryUrl = resultData.scheduledReport!.queryUrl;
        result?.reports?.forEach((element) {
          if (element.reportName == resultData.scheduledReport!.reportType) {
            Logger().wtf(element.reportTypeName);
            Logger().wtf(element.reportName);
            assetsDropDownValue = element.reportTypeName;
          }
        });
        if (resultData.scheduledReport!.reportPeriod == 1) {
          frequencyDropDownValue = "Daily";
        }
        if (resultData.scheduledReport!.reportPeriod == 2) {
          frequencyDropDownValue = "Weekly";
        }
        if (resultData.scheduledReport!.reportPeriod == 3) {
          frequencyDropDownValue = "Monthly";
        }
        reportFleetAssets?.add(assetsDropDownValue!);
        nameController.text = resultData.scheduledReport!.reportTitle!;
        reportFormat = resultData.scheduledReport?.reportFormat;

        // dateTimeController.text = DateFormat("yyyy-MM-dd").format(
        //     DateFormat("yyyy-MM-dd")
        //         .parse(result.scheduledReport!.scheduleEndDate ?? ""));
        emailIds!.clear();
        selectedUser.clear();
        resultData.scheduledReport!.emailRecipients!.forEach((element) {
          isShowingSelectedContact = true;
          emailIds!.add(element.email!);
          selectedUser
              .add(User(email: element.email, isVLUser: element.isVLUser));
        });

        serviceDueController.text =
            resultData.scheduledReport!.emailSubject ?? "-";
        emailContentController.text =
            resultData.scheduledReport!.emailContent ?? "-";

        isLoading = false;
        notifyListeners();
        if (assetsDropDownValue == "Utilization Details" ||
            assetsDropDownValue == "Fault Code Asset Details") {
          var data = Utils.getAssetIdentifierFromUrl(editQueryUrl);
          svsBodyFormated?.add(data!);
          await getGroupListData();
        } else if (assetsDropDownValue == "Fault Summary Faults List") {
          svcBody = resultData.scheduledReport!.svcBody;
          if (svcBody!.first.contains("assetuids")) {
            svsBodyFormated =
                Utils.getAssetIdentifierForFaultSummaryType(svcBody?.first);
            svcBody?.clear();
            await getGroupListData();
          } else {
            svsBodyFormated = Utils.getAssetIdentifier(svcBody?.first ?? "");
            Logger().wtf(svsBodyFormated);
            await getGroupListData();
          }
        } else {
          svcBody = resultData.scheduledReport!.svcBody;

          svsBodyFormated = Utils.getAssetIdentifier(svcBody?.first ?? "");
          await getGroupListData();
        }

        editReportColumn = resultData.scheduledReport!.reportColumns;
        hideLoadingDialog();
        notifyListeners();
      }
    } catch (e) {
      Logger().e(e.toString());
    }
  }

  onAddingAsset(int i, Asset? selectedData) {
    if (selectedAsset!.isEmpty) {
      selectedAsset?.add(selectedData!);
    } else {
      if (selectedAsset?.length == 1) {
        if (assetsDropDownValue == "Utilization Details" ||
            assetsDropDownValue == "Asset Location History" ||
            assetsDropDownValue == "Fault Code Asset Details") {
          snackbarService!.showSnackbar(
              message:
                  "For $assetsDropDownValue Report Type You Must Be Able To Select Only One Asset");
        } else {
          if (selectedAsset!.any((element) =>
              element.assetIdentifier == selectedData?.assetIdentifier)) {
            if (assetSelectionValue == "Assets") {
              snackbarService!.showSnackbar(message: "Asset Alerady Selected");
            }
            else if(assetSelectionValue=="Geofences"){
              snackbarService!.showSnackbar(message: "Geofence Alerady Selected");
            }
            else{
               snackbarService!.showSnackbar(message: "Group Alerady Selected");
            }
          } else {
            assetIdresult?.assetDetailsRecords?.removeWhere((element) =>
                element.assetIdentifier == selectedData?.assetIdentifier);
            selectedAsset?.add(selectedData!);
          }
        }
      } else {
        if (selectedAsset!.any((element) =>
            element.assetIdentifier == selectedData?.assetIdentifier)) {
          snackbarService!.showSnackbar(message: "Asset Alerady Selected");
        } else {
          assetIdresult?.assetDetailsRecords?.removeWhere((element) =>
              element.assetIdentifier == selectedData?.assetIdentifier);
          selectedAsset?.add(selectedData!);
        }
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

  Future getGroupListData() async {
    try {
      assetIdresult = await _manageUserService!.getGroupListData(false);
      if (isEditing) {
        if (svsBodyFormated == null) {
          return;
        } else {
          var allAsset = await _manageUserService!.getGroupListData(true);
          for (var item in allAsset!.assetDetailsRecords!) {
            if (svsBodyFormated!
                .any((editData) => editData == item.assetIdentifier)) {
              selectedAsset!.add(Asset(
                  assetIcon: item.assetIcon,
                  assetId: item.assetId,
                  assetIdentifier: item.assetIdentifier,
                  assetSerialNumber: item.assetSerialNumber,
                  makeCode: item.makeCode,
                  model: item.model));
            }
          }
        }
      }
      isAssetLoading = false;
      notifyListeners();
    } catch (e) {
      isAssetLoading = false;
      hideLoadingDialog();
      notifyListeners();
      Logger().e(e.toString());
    }
  }

  // editGroupListData() async {
  //   try {
  //     assetIdresult = await _manageUserService!.getGroupListData();

  //     Future.delayed(Duration(seconds: 1), () {
  //       isLoading = false;
  //       notifyListeners();
  //     });
  //     notifyListeners();
  //   } catch (e) {
  //     isLoading = false;
  //     hideLoadingDialog();
  //     notifyListeners();
  //     Logger().e(e.toString());
  //   }
  // }

  onSelectingEmailList(String value) {
    emailController.text = value;
    isHideSearchList = false;
    notifyListeners();
  }

  // List<User> selectedUser = [];
  List<String>? emailIds = [];

  addContact() {
    Logger().w(emailController.text);
    if (emailController.text.contains("@")) {
      isShowingSelectedContact = true;
      selectedUser.add(User(
        email: emailController.text,
      ));
      emailIds!.add(emailController.text);
    } else {
      snackbarService!.showSnackbar(message: "Please Enter the valid Email-Id");
    }

    notifyListeners();
  }

  addPayload() {
    List<String> reportColum = [];
    String? reportType;
    associatedIdentifier!.clear();
    selectedAsset!.forEach((element) {
      associatedIdentifier?.add(element.assetIdentifier!);
    });
    result?.reports?.forEach((element) {
      if (element.reportTypeName == assetsDropDownValue) {
        reportType = element.reportName!;
      }
    });
    addReportPayLoad = AddReportPayLoad(
      assetFilterCategoryID: chooseByDropDownValue == "Assets"
          ? 1
          : chooseByDropDownValue == "Groups"
              ? 2
              : chooseByDropDownValue == "Geofences"
                  ? 3
                  : 0,
      reportCategoryID: 0,
      reportFormat: reportFormatDropDownValue == ".CSV"
          ? 1
          : reportFormatDropDownValue == ".XLSX"
              ? 2
              : reportFormatDropDownValue == ".PDF"
                  ? 3
                  : 0,
      reportPeriod: frequencyDropDownValue == 'Daily'
          ? 1
          : frequencyDropDownValue == "Weekly"
              ? 2
              : frequencyDropDownValue == "Monthly"
                  ? 3
                  : 0,
      reportTitle: nameController.text,
      reportScheduledDate: Utils.getLastReportedDateFilterData(DateTime.now()),
      reportStartDate: "",
      reportEndDate: dateTimeController.text,
      emailSubject: serviceDueController.text,
      emailRecipients: emailIds,
      svcMethod: assetsDropDownValue == "Utilization Details"
          ? ""
          : assetsDropDownValue == "Fault Code Asset Details"
              ? "GET"
              : "POST",
      allAssets: false,
      queryUrl: Utils.getQueryUrl(assetsDropDownValue!, associatedIdentifier),
      reportType: reportType,
      reportColumns: Utils.getReportColumn(assetsDropDownValue!),
      svcbody: assetsDropDownValue == "Fault Summary Faults List" ||
              assetsDropDownValue == "FaultSummaryFaultsList"
          ? null
          : Utils.reportSvcBody(assetsDropDownValue, associatedIdentifier),
      svcbodyJson: assetsDropDownValue == "Fault Summary Faults List" ||
              assetsDropDownValue == "FaultSummaryFaultsList"
          ? SvcbodyResponse.fromJson({
              "colFilters": [
                "basic",
                "details",
                "dynamic",
                "asset.basic",
                "asset.details",
                "asset.dynamic"
              ],
              "assetuids": associatedIdentifier
            })
          : null,
      emailContent: emailContentController.text,
    );

    if (isVisionLink) {
      addReportPayLoad = AddReportPayLoad(
          assetFilterCategoryID: chooseByDropDownValue == "Assets"
              ? 1
              : chooseByDropDownValue == "Groups"
                  ? 2
                  : chooseByDropDownValue == "Geofences"
                      ? 3
                      : 0,
          allAssets: false,
          reportColumns: reportColum,
          svcbody: associatedIdentifier,
          reportTitle: nameController.text,
          reportCategoryID: 0,
          reportPeriod: frequencyDropDownValue == 'Daily'
              ? 1
              : frequencyDropDownValue == "Weekly"
                  ? 2
                  : frequencyDropDownValue == "Monthly"
                      ? 3
                      : 0,
          emailContent: emailContentController.text,
          emailRecipients: emailIds,
          reportFormat: reportFormatDropDownValue == ".CSV"
              ? 1
              : reportFormatDropDownValue == ".XLSX"
                  ? 2
                  : reportFormatDropDownValue == ".PDF"
                      ? 3
                      : 0,
          svcMethod: "POST",
          emailSubject: serviceDueController.text,
          reportEndDate: dateTimeController.text,
          reportStartDate: "",
          reportType: "AssetLocationHistory",
          reportScheduledDate:
              Utils.getLastReportedDateFilterData(DateTime.now()),
          queryUrl:
              "https://cloud.api.trimble.com/osg-in/frame-fleet/1.0/UnifiedFleet/FleetSummary/v2?sort=assetid");
    }
  }

  addReportSaveData() async {
    try {
      await addPayload();
      if (nameController.text.isEmpty) {
        _snackBarservice!.showSnackbar(message: "Name should be specified");
        return;
      } else if (associatedIdentifier!.isEmpty) {
        _snackBarservice!.showSnackbar(message: "Assets can't be empty");
        return;
      } else if (serviceDueController.text.isEmpty) {
        _snackBarservice!
            .showSnackbar(message: "Email subject Line should be required");
        return;
      } else if (emailIds!.isEmpty) {
        _snackBarservice!.showSnackbar(
            message: "Email Report Recipients should be required");
        return;
      } else if (assetsDropDownValue == null) {
        _snackBarservice!.showSnackbar(message: "Please Select Report Type");
        return;
      }
      showLoadingDialog();
      Logger().i(addReportPayLoad?.toJson());
      ManageReportResponse? responce = await _manageUserService!
          .getAddReportSaveData(
              addReportPayLoad!, graphqlSchemaService!.addReportPayLoad());
      if (responce != null) {
        _snackBarservice!.showSnackbar(message: "Report is added sucessfully");
        gotoScheduleReportPage();
      }
      hideLoadingDialog();
      notifyListeners();
    } catch (e) {
      hideLoadingDialog();
      Logger().e(e.toString());
    }
  }

  editPayload() {
    emailIds!.clear();
    associatedIdentifier!.clear();

    selectedUser.forEach((element) {
      emailIds?.add(element.email!);
    });
    if (assetSelectionValue == "Geofences") {
      geofenceData!.geofences!.forEach((data) {
        if (selectedAsset!
            .any((element) => element.assetIdentifier == data.GeofenceUID)) {
          associatedIdentifier!.add(data.GeofenceUID!);
        }
      });
    } else if (assetSelectionValue == "Groups") {
      groupResult!.groups!.forEach((group) {
        if (selectedAsset!
            .any((element) => element.assetIdentifier == group.GroupUid)) {
          associatedIdentifier!.add(group.GroupUid!);
        }
      });
    } else {
      selectedAsset?.forEach((element) {
        associatedIdentifier?.add(element.assetIdentifier!);
      });
    }

    addReportPayLoad = AddReportPayLoad(
      reportUid: scheduledReportsId!.reportUid ?? "",
      assetFilterUIDs: associatedIdentifier,
      reportPeriod: frequencyDropDownValue == 'Daily'
          ? 1
          : frequencyDropDownValue == "Weekly"
              ? 2
              : frequencyDropDownValue == "Monthly"
                  ? 3
                  : 0,
      reportTitle: nameController.text,
      emailSubject: serviceDueController.text,
      emailContent: emailContentController.text,
      emailRecipients: emailIds,
      queryUrl: editQueryUrl,
      assetFilterCategoryID: chooseByDropDownValue == "Assets"
          ? 1
          : chooseByDropDownValue == "Groups"
              ? 2
              : chooseByDropDownValue == "Geofences"
                  ? 3
                  : 0,
      allAssets: false,
      svcbody: associatedIdentifier,
    );

    if (isVisionLink) {
      addReportPayLoad = AddReportPayLoad(
          assetFilterCategoryID: chooseByDropDownValue == "Assets"
              ? 1
              : chooseByDropDownValue == "Groups"
                  ? 2
                  : chooseByDropDownValue == "Geofences"
                      ? 3
                      : 0,
          allAssets: false,
          //reportColumns: reportColum,
          svcbody: associatedIdentifier,
          reportTitle: nameController.text,
          reportCategoryID: 0,
          reportPeriod: frequencyDropDownValue == 'Daily'
              ? 1
              : frequencyDropDownValue == "Weekly"
                  ? 2
                  : frequencyDropDownValue == "Monthly"
                      ? 3
                      : 0,
          emailContent: emailContentController.text,
          emailRecipients: selectedContactItems!..sort(),
          reportFormat: reportFormatDropDownValue == ".CSV"
              ? 1
              : reportFormatDropDownValue == ".XLSX"
                  ? 2
                  : reportFormatDropDownValue == ".PDF"
                      ? 3
                      : 0,
          svcMethod: "POST",
          emailSubject: serviceDueController.text,
          reportEndDate: dateTimeController.text,
          reportStartDate: "",
          reportType: "AssetLocationHistory",
          reportScheduledDate:
              Utils.getLastReportedDateFilterData(DateTime.now()),
          queryUrl:
              "https://cloud.api.trimble.com/osg-in/frame-fleet/1.0/UnifiedFleet/FleetSummary/v2?sort=assetid");
    }
  }

  getEditReportSaveData() async {
    try {
      showLoadingDialog();
      await editPayload();
      Logger().i(addReportPayLoad!.toJson());
      ManageReportResponse? result = await _manageUserService!
          .getEditReportSaveData(
              scheduledReportsId!.reportUid!,
              addReportPayLoad!,
              graphqlSchemaService!.getEditReportsaveData()!);

      if (result != null) {
        _snackBarservice!
            .showSnackbar(message: "Edit Report has been done successfully");
        gotoScheduleReportPage();
      }
      hideLoadingDialog();
      notifyListeners();
    } catch (e) {
      Logger().e(e.toString());
      hideLoadingDialog();
    }
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

  onRemoving() {
    selectedAsset!.clear();
    notifyListeners();
  }

  gotoScheduleReportPage() {
    _navigationService!.clearTillFirstAndShowView(ManageReportView());
  }
}
