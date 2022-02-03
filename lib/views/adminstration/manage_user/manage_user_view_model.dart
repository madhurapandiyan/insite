import 'dart:async';
import 'package:flutter/material.dart';
import 'package:insite/core/base/insite_view_model.dart';
import 'package:insite/core/locator.dart';
import 'package:insite/core/models/admin_manage_user.dart';
import 'package:insite/core/services/asset_admin_manage_user_service.dart';
import 'package:insite/views/add_new_user/add_new_user_view.dart';
import 'package:insite/widgets/dumb_widgets/insite_dialog.dart';
import 'package:load/load.dart';
import 'package:logger/logger.dart';
import 'package:insite/core/logger.dart';
import 'package:stacked_services/stacked_services.dart';

class ManageUserViewModel extends InsiteViewModel {
  late Logger log;
  AssetAdminManagerUserService? _manageUserService =
      locator<AssetAdminManagerUserService>();
  NavigationService? _navigationService = locator<NavigationService>();

  TextEditingController textEditingController = TextEditingController();

  String _searchKeyword = '';
  set searchKeyword(String keyword) {
    this._searchKeyword = keyword;
  }

  updateSearchDataToEmpty() {
    Logger().d("updateSearchDataToEmpty");
    _assets = [];
    _isSearching = true;
    notifyListeners();
    getManagerUserAssetList();
  }

  int _totalCount = 0;
  int get totalCount => _totalCount;

  List<UserRow> _assets = [];
  List<UserRow> get assets => _assets;

  Users? _user;
  Users? get userData => _user;

  bool _loadingMore = false;
  bool get loadingMore => _loadingMore;

  bool _isSearching = false;
  bool get isSearching => _isSearching;

  bool _showEdit = false;
  bool get showEdit => _showEdit;

  bool _showDelete = false;
  bool get showDelete => _showDelete;

  bool _showDeSelect = false;
  bool get showDeSelect => _showDeSelect;

  int pageNumber = 1;

  bool _refreshing = false;
  bool get refreshing => _refreshing;

  bool _shouldLoadmore = true;
  bool get shouldLoadmore => _shouldLoadmore;

  ScrollController? scrollController;

  bool _loading = true;
  bool get loading => _loading;

  ManageUserViewModel() {
    try {
      this.log = getLogger(this.runtimeType.toString());
      setUp();
      _manageUserService!.setUp();
      scrollController = new ScrollController();
      scrollController!.addListener(() {
        if (scrollController!.position.pixels ==
            scrollController!.position.maxScrollExtent) {
          _loadMore();
        }
      });
      Future.delayed(Duration(seconds: 1), () {
        getSelectedFilterData();
      });
      Future.delayed(Duration(seconds: 2), () {
        getManagerUserAssetList();
      });
    } catch (e) {
      Logger().e(e.toString());
    }
  }

  Timer? debounce;

  searchUsers(String searchValue) {
    Logger().d("search users $searchValue");
    pageNumber = 1;
    _isSearching = true;
    notifyListeners();
    if (debounce != null) debounce!.cancel();
    debounce = Timer(Duration(seconds: 2), () {
      _searchKeyword = searchValue;
      getManagerUserAssetList();
    });
  }

  getManagerUserAssetList() async {
    try {
      Logger().i("getManagerUserAssetList");
      AdminManageUser? result = await _manageUserService!
          .getAdminManageUserListData(pageNumber, _searchKeyword,
              appliedFilters, graphqlSchemaService!.userManagementUserList());
      if (result != null) {
        if (result.total != null) {
          _totalCount = result.total!.items!;
        }
        if (result.users!.isNotEmpty) {
          Logger().i("list of assets " + result.users!.length.toString());
          if (!loadingMore) {
            Logger().i("assets");
            _assets.clear();
          }
          for (var user in result.users!) {
            _assets.add(UserRow(user: user, isSelected: false));
          }
          _loading = false;
          _loadingMore = false;
          _isSearching = false;
          notifyListeners();
        } else {
          for (var user in result.users!) {
            _assets.add(UserRow(user: user, isSelected: false));
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
        _refreshing = false;
        _isSearching = false;
        notifyListeners();
      }
    } catch (e) {
      Logger().e(e.toString());
    }
  }

  onItemSelected(index) {
    try {
      _assets[index].isSelected = !_assets[index].isSelected;
    } catch (e) {
      Logger().e(e);
    }
    notifyListeners();
    checkEditAndDeleteVisibility();
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

  onEditClicked() {
    UserRow row = _assets.firstWhere((element) => element.isSelected);
    onCardButtonSelected(row.user!);
  }

  onDeleteClicked(BuildContext context) async {
    bool? value = await showDialog(
      context: context,
      builder: (BuildContext context) {
        return Dialog(
            backgroundColor: Theme.of(context).backgroundColor,
            child: InsiteDialog(
              title: "Delete User",
              message:
                  "Are you sure you want to permanently remove this user account?",
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

  deleteSelectedUsers() async {
    Logger().i("deleteSelectedUsers");
    if (showDelete) {
      List<String> userIds = [];
      for (int i = 0; i < assets.length; i++) {
        var data = assets[i];
        if (data.isSelected) {
          userIds.add(data.user!.userUid!);
        }
      }
      if (userIds.isNotEmpty) {
        showLoadingDialog();
        var result = await _manageUserService!.deleteUsers(userIds);
        if (result != null) {
          await deleteUsersFromList(userIds);
          snackbarService!.showSnackbar(message: "Deleted successfully");
        } else {
          snackbarService!.showSnackbar(message: "Deleting failed");
        }

        hideLoadingDialog();
        // getManagerUserAssetList();
      }
    }
  }

  deleteUsersFromList(List<String?> ids) async {
    Logger().i("deleteUsersFromList");
    for (int i = 0; i < assets.length; i++) {
      var data = assets[i];
      for (int j = 0; j < ids.length; j++) {
        if (data.user!.userUid == ids[j]) {
          assets.removeAt(i);
        }
      }
    }
    _totalCount = _totalCount - ids.length;
    notifyListeners();
    checkEditAndDeleteVisibility();
  }

  checkEditAndDeleteVisibility() {
    Logger().i("checkEditAndDeleteVisibility");
    try {
      var count = 0;
      for (int i = 0; i < _assets.length; i++) {
        var data = _assets[i];
        if (data.isSelected) {
          count++;
        }
      }
      if (count > 0) {
        if (count > 1) {
          _showEdit = false;
          _showDelete = true;
          _showDeSelect = true;
        } else {
          _showEdit = true;
          _showDelete = true;
          _showDeSelect = true;
        }
      } else {
        _showEdit = false;
        _showDelete = false;
        _showDeSelect = false;
      }
    } catch (e) {}
    notifyListeners();
  }

  _loadMore() {
    log.i("shouldLoadmore and is already loadingMore " +
        _shouldLoadmore.toString() +
        "  " +
        _loadingMore.toString());
    if (_shouldLoadmore && !_loadingMore) {
      log.i("load more called");
      pageNumber++;
      _loadingMore = true;
      notifyListeners();
      getManagerUserAssetList();
    }
  }

  onCardButtonSelected(Users user) {
    Logger().i("onCardButtonSelected");
    _navigationService!.navigateWithTransition(
        AddNewUserView(
          user: user,
          isEdit: true,
        ),
        transition: "fade");
  }

  onAddNewUserClicked() {
    Logger().i("onAddNewUserClicked");
    _navigationService!.navigateWithTransition(
        AddNewUserView(
          isEdit: false,
          user: null,
        ),
        transition: "fade");
  }

  void refresh() async {
    Logger().i("refresh");
    await getSelectedFilterData();
    pageNumber = 1;
    _refreshing = true;
    _shouldLoadmore = true;
    notifyListeners();
    AdminManageUser? result = await _manageUserService!
        .getAdminManageUserListData(pageNumber, _searchKeyword, appliedFilters,
            graphqlSchemaService!.userManagementUserList());
    if (result != null) {
      if (result.total != null) {
        _totalCount = result.total!.items!;
      }
      if (result.users!.isNotEmpty) {
        Logger().i("list of assets " + result.users!.length.toString());
        _assets.clear();
        for (var user in result.users!) {
          _assets.add(UserRow(user: user, isSelected: false));
        }
        _loading = false;
        _loadingMore = false;
        _refreshing = false;
        notifyListeners();
      } else {
        for (var user in result.users!) {
          _assets.add(UserRow(user: user, isSelected: false));
        }
        _loading = false;
        _loadingMore = false;
        _shouldLoadmore = false;
        _refreshing = false;
        notifyListeners();
      }
    } else {
      _assets = [];
      _loading = false;
      _loadingMore = false;
      _refreshing = false;
      notifyListeners();
    }
  }
}
