import 'package:flutter/material.dart';
import 'package:insite/core/base/insite_view_model.dart';
import 'package:insite/core/locator.dart';
import 'package:insite/core/models/asset_settings.dart';
import 'package:insite/core/services/asset_admin_manage_user_service.dart';
import 'package:insite/views/adminstration/asset_settings/asset_settings_filter/asset_settings_filter_view.dart';
import 'package:logger/logger.dart';
import 'package:insite/core/logger.dart';
import 'package:stacked_services/stacked_services.dart';

class AssetSettingsViewModel extends InsiteViewModel {
  Logger log;
  var _manageUserService = locator<AssetAdminManagerUserService>();
  var _navigationservice = locator<NavigationService>();

  int pageSize = 20;
  int pageNumber = 1;

  bool _showEdit = false;
  bool get showEdit => _showEdit;

  bool _isRefreshing = false;
  bool get isRefreshing => _isRefreshing;

  bool _showDeSelect = false;
  bool get showDeSelect => _showDeSelect;

  ScrollController scrollController;

  List<AssetSettingsRow> _assets = [];
  List<AssetSettingsRow> get asset => _assets;

  bool _loading = true;
  bool get loading => _loading;

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
    Future.delayed(Duration(seconds: 1), () {
      getAssetSettingListData();
    });
  }

  getAssetSettingListData() async {
    ManageAssetConfiguration result =
        await _manageUserService.getAssetSettingData(pageSize, pageNumber);

    if (result.assetSettings.isNotEmpty) {
      for (var assetSetting in result.assetSettings) {
        _assets.add(
            AssetSettingsRow(assetSettings: assetSetting, isSelected: false));
      }

      _loading = false;
      _loadingMore = false;
      _isRefreshing = false;

      notifyListeners();
    } else {
      for (var assetSetting in result.assetSettings) {
        _assets.add(
            AssetSettingsRow(assetSettings: assetSetting, isSelected: false));
      }
      _loading = false;
      _loadingMore = false;
      _isRefreshing = false;

      notifyListeners();
    }
  }

  _loadMore() {
    log.i("shouldLoadmore and is already loadingMore " +
        _shouldLoadmore.toString() +
        "  " +
        _loadingMore.toString());
    if (_shouldLoadmore && !_loadingMore && !isRefreshing) {
      log.i("load more called");
      pageNumber++;
      _loadingMore = true;
      notifyListeners();
      getAssetSettingListData();
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
          _showEdit = true;
          _showDeSelect = true;
        } else {
          _showEdit = true;
          _showDeSelect = true;
        }
      } else {
        _showEdit = false;

        _showDeSelect = false;
      }
    } catch (e) {}
    notifyListeners();
  }

  onClickEditselected() {
    List<String> assetUids = [];
    for (int i = 0; i < _assets.length; i++) {
      if (_assets[i].isSelected) {
        assetUids.add(_assets[i].assetSettings.assetUid);
      }
    }
    onCardButtonSelected(assetUids);
  }

  onCardButtonSelected(List<String> assetUid) async {
    var result = await _navigationservice.navigateWithTransition(
        AssetSettingsFilterView(
          assetUids: assetUid,
        ),
        transition: "fade");
    Logger().i(result);
    if (result != null && result) {
      refresh();
    }
  }

  refresh() {
    onItemDeselect();
    getAssetSettingListData();
    _isRefreshing = true;
    notifyListeners();
  }
}
