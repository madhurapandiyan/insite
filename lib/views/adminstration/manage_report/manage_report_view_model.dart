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
    pageNumber = 1;
    _isSearching = true;
    _searchKeyword = searchValue;
    notifyListeners();
    _searchKeyword = searchValue;
    getManageReportListData();
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
      ),
    );
  }
}
