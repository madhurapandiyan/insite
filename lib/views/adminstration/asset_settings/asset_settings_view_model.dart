import 'dart:async';
import 'package:flutter/material.dart';
import 'package:insite/core/base/insite_view_model.dart';
import 'package:insite/core/locator.dart';
import 'package:insite/core/models/asset_settings.dart';
import 'package:insite/core/models/device_type.dart';
import 'package:insite/core/services/asset_admin_manage_user_service.dart';
import 'package:insite/views/adminstration/asset_settings/asset_settings_filter/asset_settings_filter_view.dart';
import 'package:insite/views/adminstration/asset_settings_configure/asset_settings_configure_view.dart';
import 'package:logger/logger.dart';
import 'package:insite/core/logger.dart';
import 'package:stacked_services/stacked_services.dart';

class AssetSettingsViewModel extends InsiteViewModel {
  Logger? log;
  var _manageUserService = locator<AssetAdminManagerUserService>();
  var _navigationservice = locator<NavigationService>();
  TextEditingController textEditingController = TextEditingController();

  List<String> deviceTypeList = ["ALL"];
  String deviceTypeSelected = "ALL";

  onDeviceTypeSelected(value) {
    deviceTypeSelected = value;
    notifyListeners();
    pageNumber = 1;
    getAssetSettingListData();
  }

  int pageSize = 20;
  int pageNumber = 1;

  int _totalCount = 0;
  int get totalCount => _totalCount;

  bool _showEdit = false;
  bool get showEdit => _showEdit;

  bool _showMenu = false;
  bool get showMenu => _showMenu;

  bool _showDeSelect = false;
  bool get showDeSelect => _showDeSelect;

  bool _isRefreshing = false;
  bool get isRefreshing => _isRefreshing;

  ScrollController? scrollController;

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
    _manageUserService.setUp();
    scrollController!.addListener(() {
      if (scrollController!.position.pixels ==
          scrollController!.position.maxScrollExtent) {
        _loadMore();
      }
    });
    Future.delayed(Duration(seconds: 1), () {
      getAssetSettingListData();
      getDeviceTypeData();
    });
  }

  getDeviceTypeData() async {
    ListDeviceTypeResponse? result = await _manageUserService.getDeviceTypes();
    if (result != null) {
      for (DeviceType deviceType in result.deviceTypes!) {
        deviceTypeList.add(deviceType.name!);
      }
    }
    notifyListeners();
  }

  getAssetSettingListData() async {
    ManageAssetConfiguration? result =
        await _manageUserService.getAssetSettingData(
            pageSize, pageNumber, _searchKeyword, deviceTypeSelected);
    if (result != null && result.assetSettings!.isNotEmpty) {
      if (result.pageInfo != null) {
        _totalCount = result.pageInfo!.totalRecords!;
      }
      if (!loadingMore) {
        _assets.clear();
      }
      for (var assetSetting in result.assetSettings!) {
        _assets.add(
            AssetSettingsRow(assetSettings: assetSetting, isSelected: false));
      }
      _loading = false;
      _loadingMore = false;
      _isRefreshing = false;
      notifyListeners();
    } else {
      for (var assetSetting in result!.assetSettings!) {
        _assets.add(
            AssetSettingsRow(assetSettings: assetSetting, isSelected: false));
      }
      _loading = false;
      _loadingMore = false;
      _isRefreshing = false;
      notifyListeners();
    }
  }

  Timer? debounce;

  String _searchKeyword = '';
  set searchKeyword(String keyword) {
    this._searchKeyword = keyword;
  }

  searchAssets(String searchValue) {
    pageNumber = 1;
    if (debounce != null) debounce!.cancel();
    debounce = Timer(Duration(seconds: 2), () {
      _searchKeyword = searchValue;
      getAssetSettingListData();
    });
  }

  updateSearchDataToEmpty() {
    _assets = [];
    // notifyListeners();
  }

  _loadMore() {
    log!.i("shouldLoadmore and is already loadingMore " +
        _shouldLoadmore.toString() +
        "  " +
        _loadingMore.toString());
    if (_shouldLoadmore && !_loadingMore && !isRefreshing) {
      log!.i("load more called");
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
        _showMenu = true;
        _showDeSelect = true;
        _showEdit = true;
      } else {
        _showMenu = false;
        _showEdit = false;
        _showDeSelect = false;
      }
    } catch (e) {}
    notifyListeners();
  }

  onClickEditselected() {
    List<String?> assetUids = [];
    for (int i = 0; i < _assets.length; i++) {
      if (_assets[i].isSelected) {
        assetUids.add(_assets[i].assetSettings!.assetUid);
      }
    }

    onCardButtonSelected(assetUids);
  }

  onSelectedItemClicK(String value) {
    if (value == "Configure") {
      onItemSelectConfigure();
    } else if (value == "Show/Edit Target") {
      onClickEditselected();
    } else if (value == "Deselect All") {
      onItemDeselect();
    }
  }

  onCardButtonSelected(List<String?> assetUid) async {
    var result = await _navigationservice.navigateWithTransition(
        AssetSettingsFilterView(
          assetUids: assetUid,
        ),
        transition: "fade");

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

  onItemSelectConfigure() {
    String? configureAssetUId;
    for (int i = 0; i < _assets.length; i++) {
      if (_assets[i].isSelected) {
        configureAssetUId = _assets[i].assetSettings!.assetUid;
      }
    }
    onClickRespectiveConfigurePage(configureAssetUId);
  }

  onClickRespectiveConfigurePage(String? assetUid) {
    _navigationservice.navigateWithTransition(
        AssetSettingsConfigureView(
          assetUids: assetUid,
        ),
        transition: "fade");
  }
}
