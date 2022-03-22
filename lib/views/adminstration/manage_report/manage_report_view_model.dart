import 'dart:async';

import 'package:flutter/material.dart';
import 'package:insite/core/base/insite_view_model.dart';
import 'package:insite/core/locator.dart';
import 'package:insite/core/models/manage_report_response.dart';
import 'package:insite/core/models/template_response.dart';
import 'package:insite/core/services/asset_admin_manage_user_service.dart';
import 'package:insite/views/adminstration/add_report/add_report_view.dart';
import 'package:insite/views/adminstration/notifications/add_new_notifications/reusable_widget/multi_custom_dropDown_widget.dart';
import 'package:insite/views/adminstration/template/template_view.dart';
import 'package:insite/widgets/dumb_widgets/insite_dialog.dart';
import 'package:load/load.dart';
import 'package:logger/logger.dart';
import 'package:stacked/stacked.dart';
import 'package:insite/core/logger.dart';
import 'package:stacked_services/stacked_services.dart';

class ManageReportViewModel extends InsiteViewModel {
  Logger? log;
  final AssetAdminManagerUserService? _manageUserService =
      locator<AssetAdminManagerUserService>();

  var _navigationService = locator<NavigationService>();

  bool _loadingMore = false;
  bool get loadingMore => _loadingMore;

  int pageNumber = 1;
  int limit = 20;

  bool _showEdit = false;
  bool get showEdit => _showEdit;

  bool _showMenu = false;
  bool get showMenu => _showMenu;

  bool _showDeselect = false;
  bool get showDeselect => _showDeselect;

  bool _loading = true;
  bool get loading => _loading;

  int? _totalCount = 0;
  int get totalCount => _totalCount!;

  bool _isShowDelete = true;
  bool get showDelete => _isShowDelete;

  String templateDropDownValue = '';
  String templateTitleValue = '';

  bool _shouldLoadmore = true;
  bool get shouldLoadmore => _shouldLoadmore;

  ScrollController? scrollController;

  String _searchKeyword = '';
  set searchKeyword(String keyword) {
    this._searchKeyword = keyword;
  }

  TextEditingController searchcontroller = new TextEditingController();

  List<ScheduledReportsRow> _assets = [];
  List<ScheduledReportsRow> get assets => _assets;

  List<String> _templateAssets = [];
  List<String> get templateAssets => _templateAssets;

  bool _isSearching = false;
  bool get isSearching => _isSearching;

  ManageReportViewModel(bool isTemplateView) {
    if (isVisionLink) {
      templateDetaillist = templateDetailVL;
    } else {
      templateDetaillist = templateDetail;
    }
    this.log = getLogger(this.runtimeType.toString());
    _manageUserService!.setUp();
    scrollController = new ScrollController();
    scrollController!.addListener(() {
      if (scrollController!.position.pixels ==
          scrollController!.position.maxScrollExtent) {
        if (totalCount != assets.length) {
          _loadMore();
        }
      }
    });
    if (isTemplateView) {
      Future.delayed(Duration(seconds: 1), () {
        getTemplateReportAssetData();
      });
    } else {
      Future.delayed(Duration(seconds: 1), () {
        getManageReportListData();
      });
    }
  }
  List<TemplateDetails>? templateDetaillist;
  List<TemplateDetails> templateDetailVL = [
    TemplateDetails(
        title: "Asset Event Count",
        description:
            "The Asset event count report provides a summary of all the events over a 31 day period for a single asset."),
    TemplateDetails(
        title: "Asset Fuel - Single Asset",
        description:
            "The Asset Fuel report provides a detailed overview of how effectively a specific asset is using fuel by calculating the amount of fuel burned idling, working and running for the specified reporting period. Additional fuel burn rate calculations provide a relative indication of how efficiently the asset is being operated."),
    TemplateDetails(
        title: "Asset History",
        description:
            "The Asset History report provides a list of events reported by the device for a single asset. Event types displayed in the report depend on the capabilities of the device as well as its active service plan."),
    TemplateDetails(
      title: "Asset Security - User Activity",
      description:
          "The Asset Security report summarizes the asset security activities performed by these users.",
    ),
    TemplateDetails(
        title: "Asset Speeding",
        description:
            "The Speeding Event report provides a summary of all speed events including duration and maximum speed event."),
    TemplateDetails(
        title: "Asset Usage - Single Asset",
        description:
            "The Asset Usage report provides an overview of how effectively a single asset is being used, including the runtime for the specified reporting period as well a breakdown of the time spent idling and working. Additional calculations illustrate the performance of the asset relative to the expected hours of use."),
    TemplateDetails(
        title: "Asset Usage Summary",
        description:
            "The Asset Usage Summary report provides a consolidated running hours snapshot for the selected assets along with its last known location during the selected date range."),
    TemplateDetails(
        title: "Backhoe Loader Operation",
        description:
            "The Backhoe Loader Operation report provides the split in hours of machine’s operation in the Backhoe Mode and Loader Mode for the selected time frame. This report is exclusive of Backhoe Loader/ Excavator Loader Product Families. The information displayed in this report is based on the capabilities of the device as well as active subscription plan. Applicable only for assets of other OEM like Tata Hitachi etc.,"),
    TemplateDetails(
        title: "Cost Analysis - Fleet",
        description:
            "The Cost Analysis - Fleet report provides a detailed overview of the cost of excessive idling for each selected asset by calculating the money spent for runtime hours and idle hours over a specific period of time."),
    TemplateDetails(
        title: "Cost Analysis - Single Asset",
        description:
            "The Cost Analysis - Single Asset report provides a detailed overview of the cost of excessive idling for a selected asset by calculating the money spent for runtime hours and idle hours over a specific period of time."),
    TemplateDetails(
        title: "Cycles",
        description:
            "The Cycles report provides an overview of the load & dump information for each & every cycle which can be used to evaluate the machine & operator productivity."),
    TemplateDetails(
        title: "Engine Idle",
        description:
            "The Engine Idle report provides a breakdown of idle time for each asset. The report includes Idle events for assets using movement or switch based work definitions and daily idle time for assets using movement-based, switch-based or engine-sourced work definitions over the specified thresholds."),
    TemplateDetails(
        title: "Excavator Usage",
        description:
            "The Excavator Usage report is a single asset report that provides the split in hours of Excavator’s operation in Power Mode, Economy Mode, Auto-Idle Mode, Front & Swing and Travel. This report is exclusive of Excavator Product Families. The information displayed in this report is based on the capabilities of the device as well as active subscription plan. Applicable only for assets of other OEM like Tata Hitachi etc.,"),
    TemplateDetails(
        title: "Fault Code",
        description:
            "The Fault Code summary report provides a list of Events and Diagnostics reported by the device for the selected assets over a given time frame. Fault code information displayed in the report depends on the capabilities of the device as well as having an active service plan."),
    TemplateDetails(
        title: "Fleet Fuel",
        description:
            "The Fuel Utilization report provides an overview of how effectively assets are using fuel by calculating the amount of fuel burned idling, working and running for the specified reporting period. Additional fuel burn rate calculations provide a relative indication of how efficiently assets are being operated."),
    TemplateDetails(
        title: "Fleet Status",
        description:
            "The Fleet Status report provides a current overview of the basic description of each asset. This includes identifying information such as Make and Model as well as the last known Location information and meter readings."),
    TemplateDetails(
        title: "Fleet Usage",
        description:
            "The Fleet Usage report provides an overview of how effectively assets are being used, including the runtime for the specified reporting period as well as a breakdown of the time spent idling and working. Additional calculations illustrate the performance of assets relative to expected hours of use."),
    TemplateDetails(
        title: "Fleet Utilization",
        description:
            "The Fleet Utilization report provides a consolidated view of the idle time and fuel consumed for the selected assets."),
    TemplateDetails(
        title: "Fluid Analysis",
        description:
            "The Fluid Analysis report provides a sorted list of fluid sampling results for the assets included in the report. This report is helpful in identifying sample results and whether any action needs to be taken for a particular assets based on these results."),
    TemplateDetails(
        title: "Payload",
        description:
            "The Payload report provides an overview of the machine based payload and cycle information which can be used to evaluate machine and operator productivity. The report also graphically represents the top and bottom performing assets based on payload."),
    TemplateDetails(
        title: "Shared Asset View",
        description:
            "The Shared Asset View Report provides information on the list of Shared Views created for different organizations, the assets shared, the start date and end date of the view. This Report is helpful in tracking and managing the views created for multiple organizations."),
    TemplateDetails(
        title: "Site Runtime",
        description:
            "The Site Runtime Report provides a detailed list of Site Visits an asset has completed or is in-progress with. A complete Site visit is defined from corresponding Site Entry and Site Exit events, an in-progress Site visit is defined from a Site Entry Event with a Site Exit Event yet to be generated."),
    TemplateDetails(
        title: "State Mileage",
        description:
            "The State Mileage report gives an overview of the distance travelled by each asset in the United States and Canada.")
  ];

  List<TemplateDetails> templateDetail = [

    // TemplateDetails(
    //     title: "Asset Event Count",
    //     description:
    //         "The Asset event count report provides a summary of all the events over a 31 day period for a single asset."),

    TemplateDetails(
        title: "Asset Operation",
        description:
            "The Asset Operation report provides the Asset operated hours detail for the selected Assets corresponding to the selected date range."),
    TemplateDetails(

        title: "Asset Location History",
        description:
            "The Asset History report provides a list of events reported by the device for a single asset. Event types displayed in the report depend on the capabilities of the device as well as its active service plan."),
    // TemplateDetails(
    //     title: "Engine Idle",
    //     description:
    //         "The Engine Idle report provides a breakdown of idle time for each asset. The report includes Idle events for assets using movement or switch based work definitions and daily idle time for assets using movement-based, switch-based or engine-sourced work definitions over the specified thresholds."),
    // TemplateDetails(
    //     title: "Fault Code",
    //     description:
    //         "The Fault Code summary report provides a list of Events and Diagnostics reported by the device for the selected assets over a given time frame. Fault code information displayed in the report depends on the capabilities of the device as well as having an active service plan."),

    TemplateDetails(
        title: "Fault Code Asset Details",
        description:
            "The Fault Code Asset Details report provides a summary of all the faults over a 31 day period for a single asset."),
    TemplateDetails(
        title: "Fault Summary Fault Lists",
        description:
            "The Fault Summary Fault Lists report provides a consolidated fault reported by the device for the selected assets along with its last known location."),
    TemplateDetails(
        title: "Fleet Summary",
        description:
            "The Fleet Summary report provides all basic data reported by the device for the selected Assets over a given time frame."),
    TemplateDetails(
        title: "Multi-Asset Utilization",
        description:
            "The Multi-Asset Utilization report provides a consolidated view of the Idle time,Working and Run time for the selected assets."),
    TemplateDetails(
        title: "Utilization Details",
        description:
            "he Utilization Details report provides all the Idle time,Working and Run time data for the Single Asset corresponding to the selected date range.")
  ];

  searchReports(String searchValue) async {
    if (searchValue.length >= 3) {
      Logger().d("search Reports $searchValue");
      pageNumber = 1;
      _isSearching = true;
      _searchKeyword = searchValue;
      await getManageReportListData();
    } else {
      return;
    }

  }

  updateSearchDataToEmpty() {
    Logger().d("updateSearchDataToEmpty");
    _assets = [];
    _isSearching = true;

    _searchKeyword = "";

    getManageReportListData();
  }

  getManageReportListData() async {
    try {
      Logger().i("getManagerUserAssetList");
      ManageReportResponse? result = await _manageUserService!
          .getManageReportListData(pageNumber, limit, _searchKeyword);
      if (result != null) {
        if (result.total != null) {
          _totalCount = result.total;
        }
        if (result.scheduledReports!.isNotEmpty) {
          Logger().i(
              "list of assets " + result.scheduledReports!.length.toString());
          if (!loadingMore) {
            Logger().i("assets");
            _assets.clear();
          }
          for (var scheduledReport in result.scheduledReports!) {
            _assets.add(ScheduledReportsRow(
                scheduledReports: scheduledReport, isSelected: false));
          }
          _loading = false;
          _loadingMore = false;
          _isSearching = false;
          notifyListeners();
        } else {
          _assets.clear();
          _isSearching = false;
          // for (var scheduledReport in result.scheduledReports!) {
          //   _assets.add(ScheduledReportsRow(
          //       scheduledReports: scheduledReport, isSelected: false));
          // }
          // _loading = false;
          // _loadingMore = false;
          // _shouldLoadmore = false;
          // _isSearching = false;
          notifyListeners();
        }
      } else {
        _assets = [];

        _loading = false;
        _loadingMore = false;
        // _refreshing = false;
        _isSearching = false;
        notifyListeners();
      }
    } catch (e) {
      Logger().e(e.toString());
    }
  }

  onItemSelected(index) {
    try {
      _assets[index].isSelected = !_assets[index].isSelected!;
    } catch (e) {
      Logger().e(e);
    }

    notifyListeners();
    checkEditAndDeleteVisibility();
  }

  _loadMore() {
    log!.i("shouldLoadmore and is already loadingMore " +
        _shouldLoadmore.toString() +
        "  " +
        _loadingMore.toString());
    if (_shouldLoadmore && !_loadingMore) {
      log!.i("load more called");
      pageNumber++;
      _loadingMore = true;
      notifyListeners();
      getManageReportListData();
    }
  }

  checkEditAndDeleteVisibility() {
    try {
      var count = 0;

      for (int i = 0; i < _assets.length; i++) {
        var data = _assets[i];
        if (data.isSelected!) {
          count++;
        }
      }

      if (count > 0) {
        if (count > 1) {
          _showMenu = true;
          _isShowDelete = true;
          _showEdit = false;
          _showDeselect = true;
        } else {
          _showMenu = true;
          _isShowDelete = true;
          _showEdit = true;
          _showDeselect = true;
        }
      } else {
        _showMenu = false;
        _isShowDelete = false;
        _showEdit = true;
        _showDeselect = false;
      }
    } catch (e) {}
    notifyListeners();
  }

  onItemDeselect() {
    try {
      for (int i = 0; i < _assets.length; i++) {
        _assets[i].isSelected = false;
      }
    } catch (e) {
      Logger().e(e);
    }
    notifyListeners();
    checkEditAndDeleteVisibility();
  }

  onSelectedItemClicK(String value, BuildContext context) {
    if (value == "Deselect All") {
      onItemDeselect();
    } else if (value == "Delete") {
      onDeleteClicked(context);
    } else if (value == "Edit Report") {
      ScheduledReportsRow scheduledReportsRow =
          _assets.firstWhere((element) => element.isSelected!);
      onClickEditReportSelected(scheduledReportsRow.scheduledReports!);
    } else if (value == "Add New Report") {
      onClickAddReportSelected();
    }
  }

  onDeleteClicked(BuildContext context) async {
    bool? value = await showDialog(
      context: context,
      builder: (BuildContext context) {
        return Dialog(
            backgroundColor: Theme.of(context).backgroundColor,
            child: InsiteDialog(
              title: "Delete Reports",
              message:
                  "Are you sure you want to delete this scheduled report(s)?",
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
      deleteSelectedscheduledreport();
    }
  }

  deleteSelectedscheduledreport() async {
    try {
      Logger().i("deleteSelectedReports");
      if (showDelete) {
        Logger().i(showDelete);
        List<String>? ids = [];
        for (int i = 0; i < assets.length; i++) {
          var data = assets[i];
          if (data.isSelected!) {
            ids.add(data.scheduledReports!.reportUid!);
            Logger().e(ids.length.toString());
          }
        }
        if (ids != null) {
          showLoadingDialog();
          var result =
              await _manageUserService!.getDeleteManageReportAsset(ids);
          if (result != null) {
            await deleteReportFromList(ids);
            snackbarService!.showSnackbar(message: "Deleted successfully");
          } else {
            snackbarService!.showSnackbar(message: "Deleting failed");
          }

          hideLoadingDialog();
        }
      }
    } catch (e) {
      Logger().e(e.toString());
    }
  }

  deleteReportFromList(List<String> ids) {
    Logger().i("deleteReportFromList");
    ids.forEach((id) {
      _assets
          .removeWhere((element) => element.scheduledReports!.reportUid == id);
    });

    _totalCount = _totalCount! - ids.length;
    notifyListeners();
    checkEditAndDeleteVisibility();
  }

  onClickedTemplatePage() {
    _navigationService.navigateWithTransition(TemplateView(),
        transition: "fade");
  }

  getTemplateReportAssetData() async {
    try {
      TemplateResponse? result =
          await _manageUserService!.getTemplateReportAssetData();
      if (result != null) {
        for (var templateAssets in result.reports!) {
          if (templateAssets.sourceAppName == "BIRST" &&
              templateAssets.dateRange != null) {
            _templateAssets.add(templateAssets.reportTypeName!);
          }
        }
      }
      Logger().w(templateAssets.length.toString());
      _loading = false;
      notifyListeners();
    } catch (e) {
      Logger().e(e.toString());
    }
  }

  onClickEditReportSelected(ScheduledReports scheduledReports) {
    _navigationService.navigateToView(
      AddReportView(
        scheduledReports: scheduledReports,
        isEdit: true,
        templateDropDownValue: null,
      ),
    );
  }

  onClickAddReportSelected() {
    _navigationService.navigateToView(
      AddReportView(
        scheduledReports: null,
        isEdit: false,
      ),
    );
  }

  onClickTemplateTypeAddReportSelected(
      String? templateDropDownValue, String? templateTitleValue) {
    _navigationService.navigateToView(
      AddReportView(
        scheduledReports: null,
        templateDropDownValue: templateDropDownValue,
        templateTitleValue: templateTitleValue,
      ),
    );
  }
}

class TemplateDetails {
  String? title;
  String? description;
  TemplateDetails({this.title, this.description});
}
