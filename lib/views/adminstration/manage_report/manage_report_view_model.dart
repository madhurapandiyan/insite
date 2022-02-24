// ignore_for_file: unrelated_type_equality_checks

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:insite/core/base/insite_view_model.dart';
import 'package:insite/core/locator.dart';
import 'package:insite/core/models/manage_report_response.dart';
import 'package:insite/core/models/template_response.dart';
import 'package:insite/core/services/asset_admin_manage_user_service.dart';
import 'package:insite/views/adminstration/add_report/add_report_view.dart';
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

  bool _shouldLoadmore = true;
  bool get shouldLoadmore => _shouldLoadmore;

  ScrollController? scrollController;

  String _searchKeyword = '';
  set searchKeyword(String keyword) {
    this._searchKeyword = keyword;
  }

  TextEditingController searchcontroller = TextEditingController();

  List<ScheduledReportsRow> _assets = [];
  List<ScheduledReportsRow> get assets => _assets;

  List<String> _templateAssets = [];
  List<String> get templateAssets => _templateAssets;

  bool _isSearching = false;
  bool get isSearching => _isSearching;

  ManageReportViewModel(bool isTemplateView) {
    this.log = getLogger(this.runtimeType.toString());
    _manageUserService!.setUp();
    scrollController = new ScrollController();
    scrollController!.addListener(() {
      if (scrollController!.position.pixels ==
          scrollController!.position.maxScrollExtent) {
        _loadMore();
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

  searchReports(String searchValue) {
    if (searchValue.length >= 4) {
      pageNumber = 1;
      _isSearching = true;
      _searchKeyword = searchValue;
      notifyListeners();
      _searchKeyword = searchValue;
      getManageReportListData();
    } else {
    //  getManageReportListData();
    }
  }

  getManageReportListData() async {
    ManageReportResponse? result = await _manageUserService!
        .getManageReportListData(pageNumber, limit, _searchKeyword);
    if (result != null) {
      if (result.total != null) {
        _totalCount = result.total;
      }
      if (result.scheduledReports!.isNotEmpty) {
        Logger()
            .i("list of assets " + result.scheduledReports!.length.toString());

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
        for (var scheduledReport in result.scheduledReports!) {
          _assets.add(ScheduledReportsRow(
              scheduledReports: scheduledReport, isSelected: false));
        }
        _loading = false;
        _loadingMore = false;
        _shouldLoadmore = false;
        _isSearching = false;
        notifyListeners();
      }
    } else {
      if (_isSearching) {
        _assets = [];
      }
      _loading = false;
      _loadingMore = false;
      _isSearching = false;
      notifyListeners();
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
      ),
    );
  }

  onClickAddReportSelected() {
    _navigationService.navigateToView(
      AddReportView(
        scheduledReports: null,
        isEdit: false,
        templateDropDownValue: templateDropDownValue,
      ),
    );
  }

  onClickTemplateTypeAddReportSelected(String? templateDropDownValue) {
    _navigationService.navigateToView(
      AddReportView(
        scheduledReports: null,
        isEdit: false,
        templateDropDownValue: templateDropDownValue,
      ),
    );
  }

  List<String> templateDescription = [
    "The Asset event count report provides a summary of all the events over a 31 day period for a single asset.",
    "The Asset Fuel report provides a detailed overview of how effectively a specific asset is using fuel by calculating the amount of fuel burned idling, working and running for the specified reporting period. Additional fuel burn rate calculations provide a relative indication of how efficiently the asset is being operated.",
    "The Asset History report provides a list of events reported by the device for a single asset. Event types displayed in the report depend on the capabilities of the device as well as its active service plan.",
    "The Asset Security report summarizes the asset security activities performed by these users.",
    "The Speeding Event report provides a summary of all speed events including duration and maximum speed event.",
    "The Asset Usage report provides an overview of how effectively a single asset is being used, including the runtime for the specified reporting period as well a breakdown of the time spent idling and working. Additional calculations illustrate the performance of the asset relative to the expected hours of use.",
    "The Asset Usage Summary report provides a consolidated running hours snapshot for the selected assets along with its last known location during the selected date range.",
    "The Backhoe Loader Operation report provides the split in hours of machine’s operation in the Backhoe Mode and Loader Mode for the selected time frame. This report is exclusive of Backhoe Loader/ Excavator Loader Product Families. The information displayed in this report is based on the capabilities of the device as well as active subscription plan. Applicable only for assets of other OEM like Tata Hitachi etc.,",
    "The Cost Analysis - Fleet report provides a detailed overview of the cost of excessive idling for each selected asset by calculating the money spent for runtime hours and idle hours over a specific period of time.",
    "The Cost Analysis - Single Asset report provides a detailed overview of the cost of excessive idling for a selected asset by calculating the money spent for runtime hours and idle hours over a specific period of time.",
    "The Cycles report provides an overview of the load & dump information for each & every cycle which can be used to evaluate the machine & operator productivity.",
    "The Engine Idle report provides a breakdown of idle time for each asset. The report includes Idle events for assets using movement or switch based work definitions and daily idle time for assets using movement-based, switch-based or engine-sourced work definitions over the specified thresholds.",
    "The Excavator Usage report is a single asset report that provides the split in hours of Excavator’s operation in Power Mode, Economy Mode, Auto-Idle Mode, Front & Swing and Travel. This report is exclusive of Excavator Product Families. The information displayed in this report is based on the capabilities of the device as well as active subscription plan. Applicable only for assets of other OEM like Tata Hitachi etc.,",
    "The Fault Code summary report provides a list of Events and Diagnostics reported by the device for the selected assets over a given time frame. Fault code information displayed in the report depends on the capabilities of the device as well as having an active service plan.",
    "The Fuel Utilization report provides an overview of how effectively assets are using fuel by calculating the amount of fuel burned idling, working and running for the specified reporting period. Additional fuel burn rate calculations provide a relative indication of how efficiently assets are being operated.",
    "The Fleet Status report provides a current overview of the basic description of each asset. This includes identifying information such as Make and Model as well as the last known Location information and meter readings.",
    "The Fleet Usage report provides an overview of how effectively assets are being used, including the runtime for the specified reporting period as well as a breakdown of the time spent idling and working. Additional calculations illustrate the performance of assets relative to expected hours of use.",
    "The Fleet Utilization report provides a consolidated view of the idle time and fuel consumed for the selected assets.",
    "The Fluid Analysis report provides a sorted list of fluid sampling results for the assets included in the report. This report is helpful in identifying sample results and whether any action needs to be taken for a particular assets based on these results.",
    "The Payload report provides an overview of the machine based payload and cycle information which can be used to evaluate machine and operator productivity. The report also graphically represents the top and bottom performing assets based on payload.",
    "The Shared Asset View Report provides information on the list of Shared Views created for different organizations, the assets shared, the start date and end date of the view. This Report is helpful in tracking and managing the views created for multiple organizations.",
    "The Site Runtime Report provides a detailed list of Site Visits an asset has completed or is in-progress with. A complete Site visit is defined from corresponding Site Entry and Site Exit events, an in-progress Site visit is defined from a Site Entry Event with a Site Exit Event yet to be generated.",
    "The State Mileage report gives an overview of the distance travelled by each asset in the United States and Canada."
  ];
}
