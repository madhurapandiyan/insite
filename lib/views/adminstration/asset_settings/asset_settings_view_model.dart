import 'package:flutter/material.dart';
import 'package:insite/core/base/insite_view_model.dart';
import 'package:insite/core/locator.dart';
import 'package:insite/core/models/asset.dart';
import 'package:insite/core/models/asset_settings.dart';
import 'package:insite/core/services/asset_admin_manage_user_service.dart';
import 'package:logger/logger.dart';
import 'package:stacked/stacked.dart';
import 'package:insite/core/logger.dart';

class AssetSettingsViewModel extends InsiteViewModel {
  Logger log;
  var _manageUserService = locator<AssetAdminManagerUserService>();

  int pageSize = 20;
  int pageNumber = 1;

   ScrollController scrollController;

  List<AssetSetting> _assets = [];
  List<AssetSetting> get asset => _assets;

  bool _loading=true;
  bool get loading=>_loading;

  bool _loadingMore = false;
  bool get loadingMore => _loadingMore;

  bool _shouldLoadmore = true;
  bool get shouldLoadmore => _shouldLoadmore;

  AssetSettingsViewModel() {
    this.log = getLogger(this.runtimeType.toString());
     scrollController = new ScrollController();
    scrollController.addListener(() {
      if (scrollController.position.pixels ==
          scrollController.position.maxScrollExtent) {
        _loadMore();
      }
    });
    Future.delayed(Duration(seconds: 2), () {
     // getAssetSettingListData();
    });
  }

  getAssetSettingListData() async {
    ManageAssetConfiguration result =
        await _manageUserService.getAssetSettingData(pageSize, pageNumber);
       
    if (result.assetSettings.isNotEmpty) {
      _assets.addAll(result.assetSettings);
      _loading=false;
      _loadingMore = false;
      notifyListeners();
    } else {
      _assets.addAll(result.assetSettings);
      _loading=false;
      _loadingMore = false;
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
      getAssetSettingListData();
    }
   }
}
