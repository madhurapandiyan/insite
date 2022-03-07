import 'dart:isolate';

import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:insite/core/base/insite_view_model.dart';
import 'package:insite/core/locator.dart';
import 'package:insite/core/models/asset_group_summary_response.dart';
import 'package:insite/core/models/asset_status.dart';
import 'package:insite/core/models/filter_data.dart';
import 'package:insite/core/repository/db.dart';
import 'package:insite/core/services/asset_admin_manage_user_service.dart';
import 'package:load/load.dart';
import 'package:logger/logger.dart';
import 'package:insite/core/logger.dart';

import '../../../../core/services/asset_status_service.dart';

class AssetSelectionWidgetViewModel extends InsiteViewModel {
  Logger? log;
  AssetAdminManagerUserService? _manageUserService =
      locator<AssetAdminManagerUserService>();
  AssetStatusService? _assetService = locator<AssetStatusService>();

  AssetGroupSummaryResponse? assetIdresult;
  PageController? pageController;
  ScrollController scrollController = ScrollController();
  ScrollController scrollController1 = ScrollController();
  List<AssetSelectionCategory>? assetSelectionCategory;

  AssetSelectionWidgetViewModel(AssetGroupSummaryResponse? data) {
    this.log = getLogger(this.runtimeType.toString());
    if (isVisionLink) {
      assetSelectionCategory = assetSelectionCategoryVL;
    } else {
      assetSelectionCategory = assetSelectionCategoryIn;
    }
    pageController = PageController(initialPage: _currentPage);
    _assetService!.setUp();
    Future.delayed(Duration(seconds: 1), () {
      if (data == null) {
      } else {
        getGroupListData(data);
      }
    });
  }

  int pageNumber = 1;
  int pageSize = 9999;

  bool _isloading = true;
  bool get isloading => _isloading;

  bool isSearchingSerialNo = false;
  bool isSearchingProductFamily = false;
  bool isSearchingModel = false;
  bool isSearchingManufacture = false;
  bool isSearchingDeviceType = false;

  List<Asset>? _assetId = [];
  List<Asset>? get assetId => _assetId;

  List<Asset>? _assetSerialNumber = [];
  List<Asset>? get assetSerialNumber => _assetSerialNumber;

  List<Asset>? _serialNoSearch = [];
  List<Asset>? get serialNoSearch => _serialNoSearch;

  List<Count> _productFamilyData = [];
  List<Count> get productFamilyData => _productFamilyData;

  List<Count> _manufacturerData = [];
  List<Count> get manufacturerData => _manufacturerData;

  List<Count> _modelData = [];
  List<Count> get modelData => _modelData;

  List<Count> _deviceTypdeData = [];
  List<Count> get deviceTypdeData => _deviceTypdeData;

  List<Asset>? _productFamilyCountData = [];
  List<Asset>? get productFamilyCountData => _productFamilyCountData;

  List<Asset>? _searchProductFamilyCountData = [];
  List<Asset>? get searchProductFamilyCountData =>
      _searchProductFamilyCountData;

  List<Asset>? _subManufacturerList = [];
  List<Asset>? get subManufacturerList => _subManufacturerList;

  List<Asset>? _subModelData = [];
  List<Asset>? get subModelData => _subModelData;

  List<Asset>? _subDeviceList = [];
  List<Asset>? get subDeviceList => _subModelData;

  List<AssetSelectionCategory> assetSelectionCategoryVL = [
    AssetSelectionCategory(
        name: "Asset Id", assetCategoryType: AssetCategoryType.ASSETID),
    AssetSelectionCategory(
        name: "Serial Number", assetCategoryType: AssetCategoryType.SERIALNO),
    AssetSelectionCategory(
        name: "Product Family",
        assetCategoryType: AssetCategoryType.PRODUCTFAMILY),
    AssetSelectionCategory(
        name: "Manufacturer",
        assetCategoryType: AssetCategoryType.MANUFACTURER),
    AssetSelectionCategory(
        name: "Geofences", assetCategoryType: AssetCategoryType.GEOFENCE),
    AssetSelectionCategory(
        name: "Model", assetCategoryType: AssetCategoryType.MODEL),
    AssetSelectionCategory(
        name: "Device Type", assetCategoryType: AssetCategoryType.DEVICETYPE),
    AssetSelectionCategory(
        name: "Account", assetCategoryType: AssetCategoryType.ACCOUNT),
  ];

  List<AssetSelectionCategory> assetSelectionCategoryIn = [
    AssetSelectionCategory(
        name: "Asset Id", assetCategoryType: AssetCategoryType.ASSETID),
    AssetSelectionCategory(
        name: "Serial Number", assetCategoryType: AssetCategoryType.SERIALNO),
    AssetSelectionCategory(
        name: "Product Family",
        assetCategoryType: AssetCategoryType.PRODUCTFAMILY),
    AssetSelectionCategory(
        name: "Manufacturer",
        assetCategoryType: AssetCategoryType.MANUFACTURER),
    AssetSelectionCategory(
        name: "Model", assetCategoryType: AssetCategoryType.MODEL),
    AssetSelectionCategory(
        name: "Device Type", assetCategoryType: AssetCategoryType.DEVICETYPE),
  ];

  int _currentPage = 0;

  getGroupListData(AssetGroupSummaryResponse data) async {
    try {
      assetIdresult = data;
      if (assetIdresult!.assetDetailsRecords!.isNotEmpty) {
        assetIdresult?.assetDetailsRecords?.forEach((asset) {
          if (asset.assetId == null) {
            _assetSerialNumber?.add(asset);
          } else {
            _assetId?.add(asset);
            _assetSerialNumber?.add(asset);
          }
        });
      }
      Logger().e(_assetSerialNumber!.length);
      notifyListeners();
    } catch (e) {
      hideLoadingDialog();
      Logger().e(e.toString());
    }
  }

  getProductFamilyData() async {
    try {
      if (_productFamilyData.isEmpty) {
        showLoadingDialog();
        AssetCount? resultProductfamily = await _assetService!.getAssetCount(
            "productfamily",
            FilterType.PRODUCT_FAMILY,
            graphqlSchemaService!.allAssets);
        Logger().e(resultProductfamily!.toJson());
        if (resultProductfamily != null) {
          for (var productFamilyData in resultProductfamily.countData!) {
            _productFamilyData.add(productFamilyData);
          }
        }
        hideLoadingDialog();
        notifyListeners();
      }
    } catch (e) {}
  }

  getProductFamilyFilterData(String? productFamilKey) async {
    try {
      showLoadingDialog();
      Logger().i(productFamilKey);
      AssetGroupSummaryResponse? result = await _manageUserService!
          .getAdminProductFamilyFilterData(
              pageNumber, pageSize, productFamilKey!);
      _productFamilyCountData?.clear();
      for (var item in result!.assetDetailsRecords!) {
        _productFamilyCountData?.add(item);
      }
      pageController!.animateToPage(4,
          duration: Duration(microseconds: 200), curve: Curves.easeInOut);
      notifyListeners();
      hideLoadingDialog();
    } catch (e) {
      hideLoadingDialog();
    }
  }

  getManufacturerGroupData() async {
    try {
      showLoadingDialog();
      if (_manufacturerData.isEmpty) {
        AssetCount? resultManufacturer = await _assetService!.getAssetCount(
            "manufacturer", FilterType.MAKE, graphqlSchemaService!.allAssets);
        for (var manfactureData in resultManufacturer!.countData!) {
          _manufacturerData.add(manfactureData);
        }
      }
      notifyListeners();
      hideLoadingDialog();
    } catch (e) {
      hideLoadingDialog();
    }
  }

  getFilterManufacturerData(String productFamilyKey) async {
    try {
      showLoadingDialog();
      Logger().i(productFamilyKey);
      assetIdresult = await _manageUserService!
          .getManafactureFilterData(pageNumber, pageSize, "TATA HITACHI");
      subManufacturerList?.clear();
      for (var item in assetIdresult!.assetDetailsRecords!) {
        subManufacturerList?.add(item);
      }
      pageController!.animateToPage(6,
          duration: Duration(microseconds: 200), curve: Curves.easeInOut);
      notifyListeners();
      hideLoadingDialog();
    } catch (e) {
      hideLoadingDialog();
    }
  }

  getModelData() async {
    try {
      if (_modelData.isEmpty) {
        showLoadingDialog();
        AssetCount? resultModel = await _assetService!.getAssetCount(
            "model", FilterType.MODEL, graphqlSchemaService!.allAssets);
        if (resultModel != null) {
          Logger().wtf(resultModel.countData!.last.toJson());
          for (var modelData in resultModel.countData!) {
            _modelData.add(modelData);
          }
        }
        notifyListeners();
        hideLoadingDialog();
      }
    } catch (e) {
      hideLoadingDialog();
    }
  }

  getFilterModelData(String productFamilyKey) async {
    try {
      showLoadingDialog();
      Logger().w("running");
      assetIdresult = await _manageUserService!
          .getModelFilterData(pageNumber, pageSize, productFamilyKey);
      Logger().i(assetIdresult);
      _subModelData?.clear();
      for (var item in assetIdresult!.assetDetailsRecords!) {
        _subModelData?.add(item);
      }
      pageController!.animateToPage(8,
          duration: Duration(microseconds: 200), curve: Curves.easeInOut);
      hideLoadingDialog();
      notifyListeners();
    } catch (e) {
      hideLoadingDialog();
      Logger().e(e.toString());
    }
  }

  getDeviceTypeData() async {
    try {
      if (_deviceTypdeData.isEmpty) {
        showLoadingDialog();
        AssetCount? resultDeviceType = await _assetService!.getAssetCount(
            "deviceType",
            FilterType.DEVICE_TYPE,
            graphqlSchemaService!.allAssets);
        deviceTypdeData.clear();
        for (var deviceTypeData in resultDeviceType!.countData!) {
          _deviceTypdeData.add(deviceTypeData);
        }
        notifyListeners();
        hideLoadingDialog();
      }
    } catch (e) {
      hideLoadingDialog();
    }
  }

  getFilterDeviceTypeData(String productFamilyKey) async {
    try {
      if (subDeviceList!.isEmpty) {
        showLoadingDialog();
        assetIdresult = await _manageUserService!
            .getDeviceTypeData(pageNumber, pageSize, productFamilyKey);
        subDeviceList?.clear();
        for (var item in assetIdresult!.assetDetailsRecords!) {
          subDeviceList?.add(item);
        }
        pageController!.animateToPage(10,
            duration: Duration(microseconds: 200), curve: Curves.easeInOut);
        hideLoadingDialog();
        notifyListeners();
      }
    } catch (e) {
      hideLoadingDialog();
    }
  }

  onSearchingSerialNo(String value) {
    if (value.length == 1) {
      isSearchingSerialNo = false;
    } else {
      isSearchingSerialNo = true;
      _serialNoSearch = _assetSerialNumber!
          .where((element) =>
              element.assetSerialNumber!.contains(value.toUpperCase()))
          .toList();

      if (_serialNoSearch!.isEmpty) {
        isSearchingSerialNo = false;
        Fluttertoast.showToast(msg: "No Asset Found");
      }
    }
    notifyListeners();
  }

  onSearchingProductFamily(String value) {
    if (value.length == 1) {
      isSearchingProductFamily = false;
    } else {
      isSearchingProductFamily = true;
      _searchProductFamilyCountData = _productFamilyCountData!
          .where((element) =>
              element.assetSerialNumber!.contains(value.toUpperCase()))
          .toList();
      if (_searchProductFamilyCountData!.isEmpty) {
        isSearchingProductFamily = false;
        Fluttertoast.showToast(msg: "No Asset Found");
      }
    }
    notifyListeners();
  }

  onAssetIdBackPressed() {
    pageController!.animateToPage(0,
        duration: Duration(microseconds: 200), curve: Curves.easeInOut);
  }

  onProductFamilyBackPressed() {
    pageController!.animateToPage(3,
        duration: Duration(microseconds: 200), curve: Curves.easeInOut);
  }

  onManufacturueBackPressed() {
    pageController!.animateToPage(5,
        duration: Duration(microseconds: 200), curve: Curves.easeInOut);
  }

  onModelBackPressed() {
    pageController!.animateToPage(7,
        duration: Duration(microseconds: 200), curve: Curves.easeInOut);
  }

  onDeviceTypeBackPressed() {
    pageController!.animateToPage(9,
        duration: Duration(microseconds: 200), curve: Curves.easeInOut);
  }

  onClickingRespectiveAssetCategory(AssetCategoryType type) async {
    if (type == AssetCategoryType.ASSETID) {
      pageController!.animateToPage(1,
          duration: Duration(microseconds: 200), curve: Curves.easeInOut);
    } else if (type == AssetCategoryType.SERIALNO) {
      pageController!.animateToPage(2,
          duration: Duration(microseconds: 200), curve: Curves.easeInOut);
    } else if (type == AssetCategoryType.PRODUCTFAMILY) {
      await getProductFamilyData();
      pageController!.animateToPage(3,
          duration: Duration(microseconds: 200), curve: Curves.easeInOut);
    } else if (type == AssetCategoryType.MANUFACTURER) {
      await getManufacturerGroupData();
      pageController!.animateToPage(5,
          duration: Duration(microseconds: 200), curve: Curves.easeInOut);
    } else if (type == AssetCategoryType.MODEL) {
      await getModelData();
      pageController!.animateToPage(7,
          duration: Duration(microseconds: 200), curve: Curves.easeInOut);
    } else if (type == AssetCategoryType.DEVICETYPE) {
      await getDeviceTypeData();
      pageController!.animateToPage(9,
          duration: Duration(microseconds: 200), curve: Curves.easeInOut);
    }
  }
}

class AssetSelectionCategory {
  final String? name;
  final AssetCategoryType? assetCategoryType;

  AssetSelectionCategory({this.name, this.assetCategoryType});
}

enum AssetCategoryType {
  ASSETID,
  SERIALNO,
  ACCOUNT,
  GEOFENCE,
  MODEL,
  PRODUCTFAMILY,
  DEVICETYPE,
  MANUFACTURER
}
