import 'dart:async';

import 'package:flutter/material.dart';
import 'package:insite/core/base/insite_view_model.dart';
import 'package:insite/core/locator.dart';
import 'package:insite/core/models/asset_group_summary_response.dart';
import 'package:insite/core/models/manage_group_summary_response.dart';
import 'package:insite/core/models/update_user_data.dart';
import 'package:insite/core/services/asset_admin_manage_user_service.dart';
import 'package:insite/views/adminstration/add_group/add_group_view.dart';
import 'package:insite/views/login/india_stack_login_view.dart';
import 'package:insite/widgets/dumb_widgets/insite_dialog.dart';
import 'package:load/load.dart';
import 'package:logger/logger.dart';
import 'package:stacked/stacked.dart';
import 'package:insite/core/logger.dart';
import 'package:stacked_services/stacked_services.dart';

class ManageGroupViewModel extends InsiteViewModel {
  Logger? log;

  final AssetAdminManagerUserService? _manageUserService =
      locator<AssetAdminManagerUserService>();
  final NavigationService? _navigationService = locator<NavigationService>();

  bool _shouldLoadmore = true;
  bool get shouldLoadmore => _shouldLoadmore;

  int? _totalCount = 0;
  int get totalCount => _totalCount!;

  ScrollController? scrollController;

  int pageNumber = 1;

  bool _isShowDelete = true;

  bool get showDelete => _isShowDelete;

  bool _isFavorite = false;
  bool get isFavorite => _isFavorite;

  bool _loading = true;
  bool get loading => _loading;

  List<GroupRow> _assets = [];
  List<GroupRow> get assets => _assets;

  bool _showEdit = false;
  bool get showEdit => _showEdit;

  bool _showMenu = false;
  bool get showMenu => _showMenu;

  bool _showDeSelect = false;
  bool get showDeSelect => _showDeSelect;

  bool _loadingMore = false;
  bool get loadingMore => _loadingMore;

  bool _isSearching = false;
  bool get isSearching => _isSearching;

  int? selectedIndex;

  String _searchKeyword = '';
  set searchKeyword(String keyword) {
    this._searchKeyword = keyword;
  }

  List<String>? popList = ["New Group"];

  TextEditingController searchcontroller = TextEditingController();

  ManageGroupViewModel() {
    this.log = getLogger(this.runtimeType.toString());
    _manageUserService!.setUp();
    scrollController = new ScrollController();
    scrollController!.addListener(() {
      if (scrollController!.position.pixels ==
          scrollController!.position.maxScrollExtent) {
        _loadMore();
      }
    });
    Future.delayed(Duration(seconds: 1), () {
      getGroupListData();
    });
  }

  searchGroups(String searchValue) {
    pageNumber = 1;
    _isSearching = true;
    _searchKeyword = searchValue;
    notifyListeners();
    _searchKeyword = searchValue;
    getGroupListData();
  }

  getGroupListData() async {
    Logger().i("getManagerUserAssetList");
    ManageGroupSummaryResponse? result =
        await _manageUserService!.getManageGroupSummaryResponseListData(
            pageNumber,
            {
              "pageNumber": pageNumber,
              "searchKey": "GroupName",
              "searchValue": _searchKeyword,
              "sort": ""
            },
            _searchKeyword);
    if (result != null) {
      if (result.total != null) {
        _totalCount = result.total!.items!;

        Logger().e(result.total!.items!);
        Logger().w(_totalCount);
      }
      if (result.groups!.isNotEmpty) {
        Logger().i("list of assets " + result.groups!.length.toString());
        Logger().e(loadingMore);
        if (!loadingMore) {
          Logger().i("assets");
          _assets.clear();
        }
        for (var group in result.groups!) {
          _assets.add(GroupRow(groups: group, isSelected: false));
        }
        _loading = false;
        _loadingMore = false;
        _isSearching = false;
        notifyListeners();
      } else {
        for (var group in result.groups!) {
          _assets.add(GroupRow(groups: group, isSelected: false));
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
      getGroupListData();
    }
  }

  onItemSelected(index) {
    try {
      _assets[index].isSelected = !_assets[index].isSelected!;
      popList!.clear();
      var selecetedAsset =
          _assets.where((element) => element.isSelected!).toList();
      if (selecetedAsset.length == 1) {
        popList!.addAll(["New Group", "Edit Group", "Delete"]);
      } else if (selecetedAsset.length > 1) {
        popList!.add("New Group");
      } else {
        popList!.add("New Group");
      }
      _isFavorite = _assets[index].groups!.IsFavourite!;
      Logger().i(_isFavorite);
      notifyListeners();
      checkEditAndDeleteVisibility();
    } catch (e) {
      Logger().e(e);
    }
  }

  onFavoriteItemSelected(index) {
    List<String> groupId = [];
    var visibilityData;

    try {
      visibilityData = _assets[index].groups!.IsFavourite =
          !_assets[index].groups!.IsFavourite!;
      groupId.add(_assets[index].groups!.GroupUid!);
    } catch (e) {
      Logger().e(e.toString());
    }
    notifyListeners();

    getGroupFavoriteData(groupId, visibilityData);
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
          _showDeSelect = true;
          _showEdit = true;
          _isShowDelete = false;
        } else {
          _showMenu = true;
          _showDeSelect = true;
          _showEdit = true;
          _isShowDelete = true;
        }
      } else {
        _showEdit = false;
        _showDeSelect = false;
        _isShowDelete = false;
      }
    } catch (e) {}
    notifyListeners();
  }

  onSelectedItemClicK(String value, BuildContext context) {
    if (value == "Deselect All") {
      onItemDeselect();
    } else if (value == "Favorite") {
      checkFavoriteVisibility();
    } else if (value == "UnFavorite") {
      checkUnFavoriteVisibility();
    } else if (value == "Delete") {
      onDeleteClicked(context);
    } else if (value == "Edit Group") {
      GroupRow groupRow = _assets.firstWhere((element) => element.isSelected!);
      onClickEditGroupSelected(
        groupRow.groups!,
      );
    } else if (value == "New Group") {
      onClickAddGroupSelected();
    }
  }

  onDeleteClicked(BuildContext context) async {
    bool? value = await showDialog(
      context: context,
      builder: (BuildContext context) {
        return Dialog(
            backgroundColor: Theme.of(context).backgroundColor,
            child: InsiteDialog(
              title: "Delete Group",
              message: "Are you sure you want to delete this group?",
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
      deleteSelectedGroup();
    }
  }

  checkFavoriteVisibility() {
    List<String> groupId = [];
    var visibiliyData;
    try {
      List<GroupRow> selecteddata =
          _assets.where((element) => element.isSelected == true).toList();
      selecteddata.forEach((element) {
        visibiliyData = element.groups!.IsFavourite = true;
      });
      notifyListeners();
    } catch (e) {
      Logger().e(e.toString());
    }
    for (int i = 0; i < _assets.length; i++) {
      var data = _assets[i];
      if (data.isSelected!) {
        groupId.add(data.groups!.GroupUid!);
      }
    }
    getGroupFavoriteData(groupId, visibiliyData);
    onItemDeselect();
  }

  checkUnFavoriteVisibility() {
    List<String> groupId = [];
    var visibiliyData;
    try {
      List<GroupRow> selecteddata = _assets
          .where((element) => element.groups!.IsFavourite! == true)
          .toList();
      selecteddata.forEach((element) {
        visibiliyData = element.groups!.IsFavourite = false;
      });

      notifyListeners();
    } catch (e) {
      Logger().e(e.toString());
    }
    for (int i = 0; i < _assets.length; i++) {
      var data = _assets[i];
      if (data.isSelected!) {
        groupId.add(data.groups!.GroupUid!);
      }
    }
    getGroupFavoriteData(groupId, visibiliyData);
    onItemDeselect();
  }

  getGroupFavoriteData(groupId, isFavoriteCheck) async {
    try {
      showLoadingDialog();
      UpdateResponse? result = await _manageUserService!
          .getFavoriteGroupData(groupId, isFavoriteCheck);
      Logger().i(result);
      if (isFavoriteCheck) {
        snackbarService!.showSnackbar(message: "Favorite is done sucessfully");
      } else {
        snackbarService!
            .showSnackbar(message: "UnFavorite is done sucessfully");
      }
      hideLoadingDialog();
    } catch (e) {
      Logger().e(e.toString());
    }
  }

  void deleteSelectedGroup() async {
    Logger().i("deleteSelectedUsers");
    if (showDelete) {
      String? groupId;
      for (int i = 0; i < assets.length; i++) {
        var data = assets[i];
        if (data.isSelected!) {
          groupId = data.groups!.GroupUid;
        }
      }
      if (groupId != null) {
        showLoadingDialog();
        var result = await _manageUserService!.getDeleteFavoriteData(groupId);
        if (result != null) {
          await deleteGroupsFromList(groupId);
          snackbarService!.showSnackbar(message: "Delete Group successfully");
        } else {
          snackbarService!.showSnackbar(message: "Deleting failed");
        }

        hideLoadingDialog();
        // getManagerUserAssetList();
      }
    }
  }

  deleteGroupsFromList(String? ids) async {
    Logger().i("deleteGroupsFromList");
    for (int i = 0; i < assets.length; i++) {
      var data = assets[i];

      if (data.groups!.GroupUid == ids) {
        assets.removeAt(i);
      }
    }
    _totalCount = _totalCount! - 1;
    Logger().w(_totalCount);
    notifyListeners();
    checkEditAndDeleteVisibility();
  }

  onClickEditGroupSelected(Groups group) {
    _navigationService!.navigateToView(
        AddGroupView(
          isEdit: false,
        ),
        arguments: group);
  }

  onClickAddGroupSelected() {
    _navigationService!.navigateWithTransition(
        AddGroupView(
          groups: null,
          isEdit: false,
        ),
        transition: "fade");
  }
}
