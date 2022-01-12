import 'dart:async';

import 'package:flutter/material.dart';
import 'package:insite/core/base/insite_view_model.dart';
import 'package:insite/core/locator.dart';
import 'package:insite/core/models/group_summary_response.dart';
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

  final AssetAdminManagerUserService? _manageUserService = locator<AssetAdminManagerUserService>();
  final NavigationService? _navigationService = locator<NavigationService>();

  bool _shouldLoadmore = true;
  bool get shouldLoadmore => _shouldLoadmore;

  int ?_totalCount = 0;
  int get totalCount => _totalCount!;

  ScrollController ?scrollController;

  int pageNumber = 1;

  bool _isShowDelete = true;

  bool get showDelete => _isShowDelete;

  bool _isShowFavorite = false;
  bool get isShowFavorite => _isShowFavorite;

  bool _isShowUnFavorite = false;
  bool get isShowUnFavorite => _isShowUnFavorite;

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

  String _searchKeyword = '';
  set searchKeyword(String keyword) {
    this._searchKeyword = keyword;
  }

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
    Future.delayed(Duration(seconds: 2), () {
      getGroupListData();
    });
  }
  Timer ?debounce;
  searchUsers(String searchValue) {
    if (debounce != null) debounce!.cancel();
    debounce = Timer(Duration(seconds: 2), () {
      _searchKeyword = searchValue;
      getGroupListData();
    });
  }

  updateSearchDataToEmpty() {
    _assets = [];
  }

  getGroupListData() async {
    Logger().i("getManagerUserAssetList");
    ManageGroupSummaryResponse? result = await _manageUserService!
        .getManageGroupSummaryResponseListData(pageNumber, _searchKeyword);
    if (result != null) {
      if (result.total != null) {
        _totalCount = result.total!.items;
      }
      if (result.groups!.isNotEmpty) {
        Logger().i("list of assets " + result.groups!.length.toString());
        if (!loadingMore) {
          _assets.clear();
        }

        for (var user in result.groups!) {
          _assets.add(GroupRow(groups: user, isSelected: false));
        }
        _loading = false;
        _loadingMore = false;
        notifyListeners();
      } else {
        for (var user in result.groups!) {
          _assets.add(GroupRow(groups: user, isSelected: false));
        }
        Logger().i(_assets.length);
        _loading = false;
        _loadingMore = false;
        _shouldLoadmore = false;
        notifyListeners();
      }
    } else {
      _assets = [];
      _loading = false;
      _loadingMore = false;
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

  List<int> selectedindex1 = [];

  onItemSelected(index) {
    try {
      //selectedindex1.add(index);
      _assets[index].isSelected = !_assets[index].isSelected!;
    } catch (e) {
      Logger().e(e);
    }
    _isShowFavorite = _assets[index].groups!.IsFavourite!;
    Logger().i(_isShowFavorite);
    notifyListeners();
    checkEditAndDeleteVisibility();
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
          _isShowUnFavorite = true;
        } else {
          _showMenu = true;
          _showDeSelect = true;
          _showEdit = true;
          _isShowDelete = true;
          _isShowUnFavorite = false;
        }
      } else {
        _showEdit = false;
        _showEdit = false;
        _showDeSelect = false;
        _isShowDelete = false;
        _isShowUnFavorite = false;
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
              title: "Delete User",
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
      deleteSelectedUsers();
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
  }

  getGroupFavoriteData(groupId, isFavourite) async {
    showLoadingDialog();
    UpdateResponse? result =
        await _manageUserService!.getFavoriteGroupData(groupId, isFavourite);
    Logger().i(result);
    hideLoadingDialog();
  }

  void deleteSelectedUsers() async {
    Logger().i("deleteSelectedUsers");
    if (showDelete) {
      String ?groupId;
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
          snackbarService!.showSnackbar(message: "Deleted successfully");
        } else {
          snackbarService!.showSnackbar(message: "Deleting failed");
        }
        //  await deleteUsersFromList(groupId);
        hideLoadingDialog();
        // getManagerUserAssetList();
      }
    }
  }

  onClickEditGroupSelected(Groups groups) {
    _navigationService!.navigateToView(
        AddGroupView(
          isEdit: false,
        ),
        arguments: groups);
    // navigateWithTransition(
    //     AddGroupView(
    //       groups: groups,
    //       isEdit: true,
    //     ),
    //     transition: "fade");
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
