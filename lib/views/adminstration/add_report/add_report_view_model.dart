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

  int? reportFormat;

  String? dropDownValue = "Select";

  List<String>? selectedContactItems = [];

  String? assetsDropDownValue;
  String reportFormatDropDownValue = ".CSV";
  String frequencyDropDownValue = "Daily";
  String chooseByDropDownValue = "Assets";

  ScheduledReports? scheduledReportsId;

  TextEditingController dateTimeController = new TextEditingController();

  AddReportViewModel(ScheduledReports? scheduledReports, bool isEdit) {
    this.scheduledReportsId = scheduledReports;
    this.log = getLogger(this.runtimeType.toString());
    _manageUserService!.setUp();

    if (isEdit) {
      Future.delayed(Duration(seconds: 1), () {
        getEditReportData();
      });
    }

    Future.delayed(Duration(seconds: 1), () {
      getTemplateReportAssetData();
      assetsDropDownValue = reportFleetAssets![0];
    });

    Future.delayed(Duration(seconds: 1), () {
      getContactSearchReportData();
      getGroupListData();
    });
  }

  getListViewState() {
    isListViewState = true;
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
            reportFleetAssets!.add(assetItems.reportTypeName!);
          } else {
            if (assetItems.reportName == "MultiAssetUtilization" ||
                assetItems.reportName == "UtilizationDetails" ||
                assetItems.reportName == "FaultSummaryFaultsList" ||
                assetItems.reportName == "FaultCodeAssetDetails" ||
                assetItems.reportName == "FleetSummary" ||
                assetItems.reportName == "AssetOperation") {
              reportFleetAssets!.add(assetItems.reportName!);
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
              reportServiceAssets!.add(assetItems.reportName!);
            }
          }
        }
      }

      for (var assetItems in result!.reports!) {
        if (assetItems.sourceAppName == "UNIFIEDPRODUCTIVITY" &&
            assetItems.sourceApplicationID != "") {
          if (isVisionLink) {
            reportProductivityAssets!.add(assetItems.reportName!);
          }
        }
      }

      for (var templateAssets in result!.reports!) {
        if (templateAssets.sourceAppName == "BIRST" &&
            templateAssets.dateRange != null) {
          if (isVisionLink) {
            reportStandartAssets!.add(templateAssets.reportName!);
          }
        }
      }

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

  onItemContactSelected(int index) {
    selectedContactItems!.add(searchContactListName![index].email!);
    Logger().wtf(selectedContactItems!.length.toString());
    isHideSearchList = false;
    notifyListeners();
  }

  onRemovedSelectedContact(int index) {
    try {
      selectedContactItems!.removeAt(index);
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
      showLoadingDialog();
      EditReportResponse? result = await _manageUserService!
          .getEditReportData(scheduledReportsId!.reportUid!);
      if (result != null) {
        Logger().w(result.scheduledReport!.toJson());
        dropDownValue = result.scheduledReport!.reportType;
        nameController.text = result.scheduledReport!.reportTitle!;
        dateTimeController.text = DateFormat("yyyy-MM-dd").format(
            DateFormat("yyyy-MM-dd")
                .parse(result.scheduledReport!.scheduleEndDate ?? ""));
        result.scheduledReport!.emailRecipients!
            .forEach((element) => selectedContactItems!.add(element.email!));
        serviceDueController.text = result.scheduledReport!.emailSubject ?? "-";
        emailContentController.text =
            result.scheduledReport!.emailContent ?? "-";
        svcBody = result.scheduledReport!.svcBody;
        Logger().e(svcBody!.length);

        hideLoadingDialog();
        notifyListeners();
      }
    } catch (e) {
      Logger().e(e.toString());
    }
  }

  addReportSaveData() async {
    List<Reports?> defaultColumn = [];
    result!.reports!.forEach((reports) {
      defaultColumn.add(reports);
    });
    Logger().d(defaultColumn.length);
    var addReportPayLoad;

    List<String> reportColum = [];
    for (var item in defaultColumn) {
      if (item!.reportName == dropDownValue) {
        var data = Utils.reportColumn(item.defaultColumn);
        reportColum = data as List<String>;
      }
    }
    Logger().e(reportColum.length);

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
          reportType: dropDownValue,
          reportScheduledDate:
              Utils.getLastReportedDateFilterData(DateTime.now()),
          queryUrl: dropDownValue == "FleetSummary"
              ? "https://cloud.api.trimble.com/osg-in/frame-fleet/1.0/UnifiedFleet/FleetSummary/v2?sort=assetid"
              : dropDownValue == "MultiAssetUtilization"
                  ? "https://cloud.api.trimble.com/osg-in/frame-fleet/1.0/UnifiedFleet/Utilization?startDate=&endDate=&sort=-RuntimeHours&pageNumber=1&pageSize=50000"
                  : dropDownValue == "UtilizationDetails"
                      ? "https://cloud.api.trimble.com/osg-in/frame-utilization/1.0/api/v1/Utilization/Details?assetUid=92A5ECE6-B301-11EB-82DE-0AE8BA8D3970&endDate=&includeNonReportedDays=true&includeOutsideLastReportedDay=true&sort=-LastReportedUtilizationTime&startDate="
                      : dropDownValue == "AssetOperation"
                          ? "https://cloud.api.trimble.com/osg-in/frame-utilization/1.0/AssetOperation?assetUid=c6cef15d-58c6-11ec-82e4-0282799e2450&startDate=&endDate="
                          : dropDownValue == "FaultSummaryFaultsList"
                              ? "https://cloud.api.trimble.com/osg-in/frame-fault/1.0/Health/Faults/Search?startDateTime=&endDateTime="
                              : dropDownValue == "FaultCodeAssetDetails"
                                  ? "https://cloud.api.trimble.com/osg-in/frame-fault/1.0/health/FaultDetails/v1?assetUid=9e7082cc-2b28-11ec-82e0-0ae8ba8d3970&startDateTime=&endDateTime=&langDesc=en-US"
                                  : "");
    }

    try {
      if (nameController.text.isEmpty) {
        _snackBarservice!
            .showSnackbar(message: "Report Name should be required");
        return;
      } else if (associatedIdentifier!.isEmpty) {
        _snackBarservice!.showSnackbar(message: "Assets can't be empty");
        return;
      } else if (serviceDueController.text.isEmpty) {
        _snackBarservice!
            .showSnackbar(message: "Email subject Line should be required");
        return;
      } else if (selectedContactItems!.isEmpty) {
        _snackBarservice!.showSnackbar(
            message: "Email Report Recipients should be required");
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
    List<Reports?> defaultColumn = [];
    result!.reports!.forEach((reports) {
      defaultColumn.add(reports);
    });
    Logger().d(defaultColumn.length);

    List<String> reportColum = [];
    for (var item in defaultColumn) {
      if (item!.reportName == dropDownValue) {
        var data = Utils.reportColumn(item.defaultColumn);
        reportColum = data as List<String>;
      }
    }
    Logger().e(reportColum.length);

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
          reportType: dropDownValue,
          reportScheduledDate:
              Utils.getLastReportedDateFilterData(DateTime.now()),
          queryUrl: dropDownValue == "FleetSummary"
              ? "https://cloud.api.trimble.com/osg-in/frame-fleet/1.0/UnifiedFleet/FleetSummary/v2?sort=assetid"
              : dropDownValue == "MultiAssetUtilization"
                  ? "https://cloud.api.trimble.com/osg-in/frame-fleet/1.0/UnifiedFleet/Utilization?startDate=&endDate=&sort=-RuntimeHours&pageNumber=1&pageSize=50000"
                  : dropDownValue == "UtilizationDetails"
                      ? "https://cloud.api.trimble.com/osg-in/frame-utilization/1.0/api/v1/Utilization/Details?assetUid=92A5ECE6-B301-11EB-82DE-0AE8BA8D3970&endDate=&includeNonReportedDays=true&includeOutsideLastReportedDay=true&sort=-LastReportedUtilizationTime&startDate="
                      : dropDownValue == "AssetOperation"
                          ? "https://cloud.api.trimble.com/osg-in/frame-utilization/1.0/AssetOperation?assetUid=c6cef15d-58c6-11ec-82e4-0282799e2450&startDate=&endDate="
                          : dropDownValue == "FaultSummaryFaultsList"
                              ? "https://cloud.api.trimble.com/osg-in/frame-fault/1.0/Health/Faults/Search?startDateTime=&endDateTime="
                              : dropDownValue == "FaultCodeAssetDetails"
                                  ? "https://cloud.api.trimble.com/osg-in/frame-fault/1.0/health/FaultDetails/v1?assetUid=9e7082cc-2b28-11ec-82e0-0ae8ba8d3970&startDateTime=&endDateTime=&langDesc=en-US"
                                  : "");
    }
    try {
      showLoadingDialog();
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

  Future<AssetGroupSummaryResponse?> getGroupListData() async {
    var assetIdresult = await _manageUserService!.getGroupListData();
    if (assetIdresult != null) {
      //Logger().w("sdn");
      assetIdresult.assetDetailsRecords!.forEach((assedId) {
        if (svcBody!.any((element) => element == assedId.assetIdentifier)) {
          selectedItemAssets!.add(AddGroupModel(
              assetId: assedId.assetId,
              assetIdentifier: assedId.assetIdentifier,
              make: assedId.makeCode,
              model: assedId.model,
              serialNo: assedId.assetSerialNumber));
        }
      });
    }

    notifyListeners();
  }
}
