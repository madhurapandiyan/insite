import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:insite/core/base/insite_view_model.dart';
import 'package:insite/core/locator.dart';
import 'package:insite/core/models/add_report_payload.dart';
import 'package:insite/core/models/edit_report_response.dart';
import 'package:insite/core/models/manage_report_response.dart';
import 'package:insite/core/models/search_contact_report_list_response.dart';
import 'package:insite/core/models/template_response.dart';
import 'package:insite/core/services/asset_admin_manage_user_service.dart';
import 'package:insite/utils/helper_methods.dart';
import 'package:insite/views/adminstration/add_report/fault_code_model.dart';
import 'package:load/load.dart';
import 'package:logger/logger.dart';
import 'package:insite/core/logger.dart';
import 'package:stacked_services/stacked_services.dart';

class AddReportViewModel extends InsiteViewModel {
  Logger? log;
  final AssetAdminManagerUserService? _manageUserService =
      locator<AssetAdminManagerUserService>();

  List<String>? reportAssets = [];
  List<String>? reportColumn = [];
  List<User>? searchContactListName = [];
  List<String>? associatedIdentifier = [];

  final SnackbarService? _snackBarservice = locator<SnackbarService>();

  TextEditingController nameController = new TextEditingController();
  TextEditingController searchContactController = new TextEditingController();
  TextEditingController serviceDueController = new TextEditingController();
  TextEditingController emailContentController = new TextEditingController();

  String _searchKeyword = '';
  set searchKeyword(String keyword) {
    this._searchKeyword = keyword;
  }

  bool isHideSearchList = false;

  String? reportTypeValue = '';
  int? reportFormat;

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
    Future.delayed(Duration(seconds: 1), () {
      getTemplateReportAssetData();
      assetsDropDownValue = reportAssets![0];
    });
    Future.delayed(Duration(seconds: 1), () {
      getContactSearchReportData();
    });
    if (isEdit) {
      Future.delayed(Duration(seconds: 1), () {
        getEditReportData();
      });
    }
  }

  getDatPickerData(String formattedDate) {
    dateTimeController.text = formattedDate;
    notifyListeners();
  }

  getTemplateReportAssetData() async {
    try {
      TemplateResponse? result =
          await _manageUserService!.getTemplateReportAssetData();
      if (result!.reports!
          .any((element) => element.sourceAppName == "UNIFIEDFLEET")) {
        reportAssets!.add("Unified Fleet");
        for (var assetItems in result.reports!) {
          if (assetItems.sourceAppName == "UNIFIEDFLEET" &&
              assetItems.defaultColumn != "") {
            reportAssets!.add(assetItems.reportTypeName!);
          }
        }
        if (result.reports!
            .any((element) => element.sourceAppName == "UNIFIEDSERVICES")) {
          reportAssets!.add("Unified Services");
          for (var assetItems in result.reports!) {
            if (assetItems.sourceAppName == "UNIFIEDSERVICES" &&
                assetItems.defaultColumn != null) {
              reportAssets!.add(assetItems.reportTypeName!);
            }
          }
        }
      }
      if (result.reports!
          .any((element) => element.sourceAppName == "UNIFIEDPRODUCTIVITY")) {
        reportAssets!.add("Unified Productivity");
        for (var assetItems in result.reports!) {
          if (assetItems.sourceAppName == "UNIFIEDPRODUCTIVITY" &&
              assetItems.sourceApplicationID != "") {
            reportAssets!.add(assetItems.reportTypeName!);
          }
        }
      }
      if (result.reports!.any((element) => element.sourceAppName == "BIRST")) {
        reportAssets!.add("Standard");
        for (var templateAssets in result.reports!) {
          if (templateAssets.sourceAppName == "BIRST" &&
              templateAssets.dateRange != null) {
            reportAssets!.add(templateAssets.reportTypeName!);
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
        Logger().w(result.scheduledReport!.emailRecipients!.first.toJson());
        reportTypeValue = result.scheduledReport!.reportType!;
        reportFormat = result.scheduledReport!.reportFormat!;
        nameController.text = result.scheduledReport!.reportTitle!;
        dateTimeController.text = Utils.getDateInFormatddMMyyyy(
            result.scheduledReport!.scheduleEndDate!);
        result.scheduledReport!.emailRecipients!
            .forEach((element) => selectedContactItems!.add(element.email!));
        serviceDueController.text = result.scheduledReport!.emailSubject ?? "-";
        emailContentController.text =
            result.scheduledReport!.emailContent ?? "-";
        hideLoadingDialog();
        notifyListeners();
      }
    } catch (e) {
      Logger().e(e.toString());
    }
  }

  addReportSaveData() async {
    var addReportPayLoad = AddReportPayLoad(
      assetFilterCategoryID: chooseByDropDownValue == "Assets"
          ? 1
          : chooseByDropDownValue == "Groups"
              ? 2
              : chooseByDropDownValue == "Geofences"
                  ? 3
                  : 0,
      allAssets: false,
      reportColumns: [
        "assetName",
        "serialNumber",
        "make-model",
        "locationEventLocalTime",
        "hourmeter",
        "odometer",
        "location",
        "assetStatus",
        "fromDate",
        "toDate",
        "latitude",
        "longitude"
      ],
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
      svcMethod: "GET",
      emailSubject: serviceDueController.text,
      reportEndDate: dateTimeController.text,
      reportStartDate: "",
      reportType: "AssetLocationHistory",
      reportScheduledDate: DateTime.now().toString(),
      queryUrl:
          "https://administrator.myvisionlink.com/t/trimble.com/vss-assethistory/1.0/AssetLocationHistory/4ff34130-3d27-11ea-8104-060d7e00a6d1/v2?endTimeLocal=&lastReported=false&pageNumber=1&pageSize=100&startTimeLocal=",
    );
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
      Logger().wtf(result!.msg!);
      Logger().d(addReportPayLoad.toJson());
      hideLoadingDialog();
      notifyListeners();
    } catch (e) {
      Logger().e(e.toString());
    }
  }

  getEditReportSaveData() async {
    var addReportPayLoad = AddReportPayLoad(
      assetFilterCategoryID: chooseByDropDownValue == "Assets"
          ? 1
          : chooseByDropDownValue == "Groups"
              ? 2
              : chooseByDropDownValue == "Geofences"
                  ? 3
                  : 0,
      allAssets: false,
      reportTitle: nameController.text,
      reportCategoryID: 0,
      reportEndDate: dateTimeController.text,
      emailRecipients: selectedContactItems,
      emailSubject: serviceDueController.text,
      queryUrl:
          "https://administrator.myvisionlink.com/t/trimble.com/vss-assethistory/1.0/AssetLocationHistory/4ff34130-3d27-11ea-8104-060d7e00a6d1/v2?endTimeLocal=&lastReported=false&pageNumber=1&pageSize=100&startTimeLocal=",
    );
    try {
      showLoadingDialog();
      ManageReportResponse? result = await _manageUserService!
          .getEditReportSaveData(
              scheduledReportsId!.reportUid!, addReportPayLoad);
      Logger().d(result!.metadata!.toJson());
      hideLoadingDialog();
      notifyListeners();
    } catch (e) {
      Logger().e(e.toString());
    }
  }
}
