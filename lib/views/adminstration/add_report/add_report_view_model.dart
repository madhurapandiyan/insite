import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:insite/core/base/insite_view_model.dart';
import 'package:insite/core/locator.dart';
import 'package:insite/core/models/add_report_payload.dart';
import 'package:insite/core/models/asset_group_summary_response.dart';
import 'package:insite/core/models/edit_report_response.dart';
import 'package:insite/core/models/manage_report_response.dart';
import 'package:insite/core/models/search_contact_report_list_response.dart';
import 'package:insite/core/models/template_response.dart';
import 'package:insite/core/services/asset_admin_manage_user_service.dart';
import 'package:insite/utils/helper_methods.dart';
import 'package:insite/views/adminstration/add_group/model/add_group_model.dart';
import 'package:insite/views/adminstration/add_report/fault_code_model.dart';
import 'package:insite/views/adminstration/manage_report/manage_report_view.dart';
import 'package:intl/intl.dart';
import 'package:load/load.dart';
import 'package:logger/logger.dart';
import 'package:insite/core/logger.dart';
import 'package:stacked_services/stacked_services.dart';

class AddReportViewModel extends InsiteViewModel {
  Logger? log;
  final AssetAdminManagerUserService? _manageUserService =
      locator<AssetAdminManagerUserService>();

  List<String>? reportFleetAssets = [];
  List<String>? reportServiceAssets = [];
  List<String>? reportProductivityAssets = [];
  List<String>? reportStandartAssets = [];

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

  bool isLoading = true;
  bool isAssetLoading = true;
  int? reportFormat;

  String? dropDownValue = "Select";

  List<String>? selectedContactItems = [];
  List<User> selectedUser = [];

  String? assetsDropDownValue;

  String reportFormatDropDownValue = ".CSV";
  String frequencyDropDownValue = "Daily";
  String chooseByDropDownValue = "Assets";
  bool isShowingSelectedContact = false;
  String? editQueryUrl;
  List<String>? editReportColumn = [];

  List<Asset>? selectedAsset = [];
  AssetGroupSummaryResponse? assetIdresult;

  List<String> dropDownList = ["All", "ID", "S/N"];

  String initialValue = "All";

  ScheduledReports? scheduledReportsId;

  TextEditingController dateTimeController = new TextEditingController();
  TextEditingController emailController = TextEditingController();
  List<String> dropvaluelist = [".CSV", ".XLS", ".PDF"];

  AddReportViewModel(ScheduledReports? scheduledReports, bool? isEdit,
      String? dropdownValue, String? templateTitleValue) {
    this.scheduledReportsId = scheduledReports;
    this.log = getLogger(this.runtimeType.toString());
    _manageUserService!.setUp();

    if (isEdit == null) {
      getDropDownValue(dropdownValue!);
      getTemplateTitleValue(templateTitleValue!);
    }
    if (isEdit == true) {
      getEditReportData();
    } else {
      getTemplateReportAssetData();

      getGroupListData();
    }
  }

  getListViewState() {
    isListViewState = true;
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
      }
    }
    notifyListeners();
  }

  getDatPickerData(String formattedDate) {
    dateTimeController.text = formattedDate;
    notifyListeners();
  }

  TemplateResponse? result;

  getTemplateReportAssetData() async {
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
                assetItems.reportName == "AssetOperation") {
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
                assetItems.reportName == "FleetSummary") {
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
      assetsDropDownValue = reportFleetAssets![0];
      isLoading = false;
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
      EditReportResponse? resultData = await _manageUserService!
          .getEditReportData(scheduledReportsId!.reportUid!);
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
        await getGroupListData();
        svcBody = resultData.scheduledReport!.svcBody;
        editReportColumn = resultData.scheduledReport!.reportColumns;
        assetIdresult?.assetDetailsRecords?.forEach((element) {
          if (svcBody!.any((editData) => editData == element.assetIdentifier)) {
            selectedAsset!.add(Asset(
                assetIcon: element.assetIcon,
                assetId: element.assetId,
                assetIdentifier: element.assetIdentifier,
                assetSerialNumber: element.assetSerialNumber,
                makeCode: element.makeCode,
                model: element.model));
          }
        });
        Logger().e(svcBody!.length);

        hideLoadingDialog();
        notifyListeners();
      }
    } catch (e) {
      Logger().e(e.toString());
    }
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

  Future getGroupListData() async {
    try {
      assetIdresult = await _manageUserService!.getGroupListData();
      isAssetLoading = false;
      notifyListeners();
    } catch (e) {
      isAssetLoading = false;
      hideLoadingDialog();
      notifyListeners();
      Logger().e(e.toString());
    }
  }

  editGroupListData() async {
    try {
      assetIdresult = await _manageUserService!.getGroupListData();

      Future.delayed(Duration(seconds: 1), () {
        isLoading = false;
        notifyListeners();
      });
      notifyListeners();
    } catch (e) {
      isLoading = false;
      hideLoadingDialog();
      notifyListeners();
      Logger().e(e.toString());
    }
  }

  onSelectingEmailList(String value) {
    emailController.text = value;
    isHideSearchList = false;
    notifyListeners();
  }

  // List<User> selectedUser = [];
  List<String>? emailIds = [];

  addContact() {
    isShowingSelectedContact = true;
    var data = searchContactListName!
        .where((element) => element.email!.contains(emailController.text));
    if (selectedUser
        .any((element) => element.email!.contains(data.first.email!))) {
    } else {
      emailController.clear();
      selectedUser.add(data.first);
      emailIds!.add(data.first.email!);
    }
    notifyListeners();
  }

  addReportSaveData() async {
    List<Reports?> defaultColumn = [];
    selectedAsset!.forEach((element) {
      associatedIdentifier?.add(element.assetIdentifier!);
    });
    result!.reports!.forEach((reports) {
      defaultColumn.add(reports);
    });
    Logger().d(defaultColumn.length);
    var addReportPayLoad;
    Logger().e(defaultColumn.length);
    List<String> reportColum = [];

    for (var item in defaultColumn) {
      if (item!.reportTypeName == assetsDropDownValue) {
        Logger().wtf(item.defaultColumn);
        var data = Utils.reportColumn(item.defaultColumn);
        Logger().wtf(data.isEmpty);
        if (data.first == "") {
          reportColum = [
            "assetName",
            "serialNumber",
            "make-model",
            "locationEventLocalTime",
            "hourmeter",
            "location",
            "assetStatus",
            "fromDate",
            "toDate",
            "latitude",
            "longitude"
          ];
        } else {
          reportColum = data as List<String>;
        }
      }
    }
    Logger().e(reportColum.length);

    String? reportType;
    result?.reports?.forEach((element) {
      if (element.reportTypeName == assetsDropDownValue) {
        reportType = element.reportName!;
      }
    });
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
              : reportFormatDropDownValue == ".XLS"
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
    } else {
      Logger().i(dropDownValue);
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
              : reportFormatDropDownValue == ".XLS"
                  ? 2
                  : reportFormatDropDownValue == ".PDF"
                      ? 3
                      : 0,
          svcMethod: "POST",
          emailSubject: serviceDueController.text,
          reportEndDate: dateTimeController.text,
          reportStartDate: "",
          reportType: reportType,
          reportScheduledDate:
              Utils.getLastReportedDateFilterData(DateTime.now()),
          queryUrl: assetsDropDownValue == "Fleet Summary"
              ? "https://cloud.api.trimble.com/osg-in/frame-fleet/1.0/UnifiedFleet/FleetSummary/v2?sort=assetid"
              : assetsDropDownValue == "Multi-Asset Utilization"
                  ? "https://cloud.api.trimble.com/osg-in/frame-fleet/1.0/UnifiedFleet/Utilization?startDate=&endDate=&sort=-RuntimeHours&pageNumber=1&pageSize=50000"
                  : assetsDropDownValue == "Utilization Details"
                      ? "https://cloud.api.trimble.com/osg-in/frame-utilization/1.0/api/v1/Utilization/Details?assetUid=92A5ECE6-B301-11EB-82DE-0AE8BA8D3970&endDate=&includeNonReportedDays=true&includeOutsideLastReportedDay=true&sort=-LastReportedUtilizationTime&startDate="
                      : assetsDropDownValue == "Asset Operation"
                          ? "https://cloud.api.trimble.com/osg-in/frame-utilization/1.0/AssetOperation?assetUid=c6cef15d-58c6-11ec-82e4-0282799e2450&startDate=&endDate="
                          : assetsDropDownValue == "Fault Summary Faults List"
                              ? "https://cloud.api.trimble.com/osg-in/frame-fault/1.0/Health/Faults/Search?startDateTime=&endDateTime="
                              : assetsDropDownValue ==
                                      "Fault Code Asset Details"
                                  ? "https://cloud.api.trimble.com/osg-in/frame-fault/1.0/health/FaultDetails/v1?assetUid=9e7082cc-2b28-11ec-82e0-0ae8ba8d3970&startDateTime=&endDateTime=&langDesc=en-US"
                                  : "");
    }

    try {
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
      ManageReportResponse? result =
          await _manageUserService!.getAddReportSaveData(addReportPayLoad);
      Logger().wtf(result!.reqId);
      Logger().d(addReportPayLoad.toJson());
      if (result != null) {
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

  getEditReportSaveData() async {
    var addReportPayLoad;

    result?.reports?.forEach((element) {
      if (element.reportTypeName == assetsDropDownValue) {
        assetsDropDownValue = element.reportName;
      }
    });

    selectedUser.forEach((element) {
      emailIds?.add(element.email!);
    });

    selectedAsset?.forEach((element) {
      associatedIdentifier?.add(element.assetIdentifier!);
    });

    String? reportType;
    result?.reports?.forEach((element) {
      if (element.reportTypeName == assetsDropDownValue) {
        reportType = element.reportName!;
      }
    });

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
          emailRecipients: selectedContactItems,
          reportFormat: reportFormatDropDownValue == ".CSV"
              ? 1
              : reportFormatDropDownValue == ".XLS"
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
    } else {
      Logger().i(dropDownValue);
      addReportPayLoad = AddReportPayLoad(
          assetFilterCategoryID: chooseByDropDownValue == "Assets"
              ? 1
              : chooseByDropDownValue == "Groups"
                  ? 2
                  : chooseByDropDownValue == "Geofences"
                      ? 3
                      : 0,
          allAssets: false,
          reportColumns: editReportColumn,
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
              : reportFormatDropDownValue == ".XLS"
                  ? 2
                  : reportFormatDropDownValue == ".PDF"
                      ? 3
                      : 0,
          svcMethod: "POST",
          emailSubject: serviceDueController.text,
          reportEndDate: dateTimeController.text,
          reportStartDate: "",
          reportType: reportType,
          reportScheduledDate:
              Utils.getLastReportedDateFilterData(DateTime.now()),
          queryUrl: editQueryUrl);
    }
    try {
      ManageReportResponse? result = await _manageUserService!
          .getEditReportSaveData(
              scheduledReportsId!.reportUid!, addReportPayLoad);
      if (result != null) {
        Logger().d(result.metadata!.toJson());
        _snackBarservice!
            .showSnackbar(message: "Edit Report has been done successfully");
        gotoScheduleReportPage();
      }

      hideLoadingDialog();
      notifyListeners();
    } catch (e) {
      Logger().e(e.toString());
    }
  }

  gotoScheduleReportPage() {
    _navigationService!.navigateToView(ManageReportView());
  }
}
