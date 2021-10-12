import 'package:flutter/material.dart';
import 'package:insite/core/base/insite_view_model.dart';
import 'package:insite/core/locator.dart';
import 'package:insite/core/models/admin_manage_user.dart';
import 'package:insite/core/services/asset_admin_manage_user_service.dart';
import 'package:insite/views/add_new_user/add_new_user_view.dart';
import 'package:load/load.dart';
import 'package:logger/logger.dart';
import 'package:insite/core/logger.dart';
import 'package:stacked_services/stacked_services.dart';

class ManageUserViewModel extends InsiteViewModel {
  Logger log;
  var _manageUserService = locator<AssetAdminManagerUserService>();
  var _navigationService = locator<NavigationService>();

  List<UserRow> _assets = [];
  List<UserRow> get assets => _assets;

  Users _user;
  Users get userData => _user;

  bool _loadingMore = false;
  bool get loadingMore => _loadingMore;

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

  ScrollController scrollController;

  bool _loading = true;
  bool get loading => _loading;

  ManageUserViewModel() {
    this.log = getLogger(this.runtimeType.toString());
    _manageUserService.setUp();
    scrollController = new ScrollController();
    scrollController.addListener(() {
      if (scrollController.position.pixels ==
          scrollController.position.maxScrollExtent) {
        _loadMore();
      }
    });
    Future.delayed(Duration(seconds: 2), () {
      getManagerUserAssetList();
    });
  }

  getManagerUserAssetList() async {
    AdminManageUser result =
        await _manageUserService.getAdminManageUserListData(pageNumber);
    if (result != null) {
      if (result.users.isNotEmpty) {
        Logger().i("list of assets " + result.users.length.toString());
        for (var user in result.users) {
          _assets.add(UserRow(user: user, isSelected: false));
        }
        _loading = false;
        _loadingMore = false;
        notifyListeners();
      } else {
        for (var user in result.users) {
          _assets.add(UserRow(user: user, isSelected: false));
        }
        _loading = false;
        _loadingMore = false;
        _shouldLoadmore = false;
        notifyListeners();
      }
    } else {
      _loading = false;
      _loadingMore = false;
      notifyListeners();
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
    onCardButtonSelected(row.user);
  }

  onDeleteClicked(BuildContext context) async {
    bool value = await showDialog(
      context: context,
      builder: (BuildContext context) {
        return Dialog(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.only(bottom: 12.0),
                  child: Text("Delete User",
                      style: TextStyle(
                          color: Colors.black, fontWeight: FontWeight.bold)),
                ),
                Padding(
                  padding: const EdgeInsets.only(bottom: 12.0),
                  child: Text(
                    "Are you sure you want to permanently remove this user account?",
                    style: TextStyle(color: Colors.black),
                  ),
                ),
                ButtonBar(children: [
                  TextButton(
                    child: Text(
                      "NO",
                      style: TextStyle(color: Colors.black),
                    ),
                    onPressed: () async {
                      Navigator.pop(context, false);
                    },
                  ),
                  SizedBox(
                    width: 5,
                  ),
                  TextButton(
                    child: Text(
                      'YES',
                      style: TextStyle(color: Colors.black),
                    ),
                    onPressed: () async {
                      Navigator.pop(context, true);
                    },
                  ),
                ]),
              ],
            ),
          ),
        );
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
          userIds.add(data.user.userUid);
        }
      }
      if (userIds.isNotEmpty) {
        showLoadingDialog();
        var result = await _manageUserService.deleteUsers(userIds);
        await deleteUsersFromList(userIds);
        hideLoadingDialog();
        // getManagerUserAssetList();
      }
    }
  }

  deleteUsersFromList(List<String> ids) async {
    for (int i = 0; i < assets.length; i++) {
      var data = assets[i];
      for (int j = 0; j < ids.length; j++) {
        if (data.user.userUid == ids[j]) {
          assets.removeAt(i);
        }
      }
    }
    notifyListeners();
    checkEditAndDeleteVisibility();
  }

  checkEditAndDeleteVisibility() {
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
    _navigationService.navigateWithTransition(
        AddNewUserView(
          user: user,
          isEdit: true,
        ),
        transition: "fade");
  }

  onAddNewUserClicked() {
    _navigationService.navigateWithTransition(
        AddNewUserView(
          isEdit: false,
          user: null,
        ),
        transition: "fade");
  }

  // void refresh() async {
  //   pageNumber = 1;

  //   if (_assets.isEmpty) {
  //     _loading = true;
  //   } else {
  //     _refreshing = true;
  //   }
  //   _shouldLoadmore = true;
  //   notifyListeners();

  //   AdminManageUser result =
  //       await _manageUserService.getAdminManageUserListData(pageNumber);
  //   if (result != null) {
  //     _assets.clear();
  //     _assets.addAll(result.users);
  //     _loading = false;
  //     _refreshing = false;
  //     notifyListeners();
  //   } else {
  //     _loading = false;
  //     _refreshing = false;
  //     notifyListeners();
  //   }
  //   Logger().i("list of assets " + result.users.length.toString());
  // }
}
