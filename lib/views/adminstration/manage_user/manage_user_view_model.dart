import 'package:flutter/material.dart';
import 'package:insite/core/base/insite_view_model.dart';
import 'package:insite/core/locator.dart';
import 'package:insite/core/models/admin_manage_user.dart';
import 'package:insite/core/services/asset_admin_manage_user_service.dart';
import 'package:insite/views/add_new_user/add_new_user_view.dart';
import 'package:logger/logger.dart';
import 'package:stacked/stacked.dart';
import 'package:insite/core/logger.dart';
import 'package:stacked_services/stacked_services.dart';

class ManageUserViewModel extends InsiteViewModel {
  Logger log;
  var _manageUserService = locator<AssetAdminManagerUserService>();

  var _navigationService = locator<NavigationService>();

  List<Users> _assets = [];
  List<Users> get assets => _assets;

  Users _user;
  Users get userData => _user;

  bool _loadingMore = false;
  bool get loadingMore => _loadingMore;

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
    if (result.users.isNotEmpty) {
      Logger().i("list of assets " + result.users.length.toString());

      _assets.addAll(result.users);
      _loading = false;
      _loadingMore = false;
      notifyListeners();
    } else {
      _assets.addAll(result.users);
      _loading = false;
      _loadingMore = false;
      _shouldLoadmore = false;
      notifyListeners();
    }
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
