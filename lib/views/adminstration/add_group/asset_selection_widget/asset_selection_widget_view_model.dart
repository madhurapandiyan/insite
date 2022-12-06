import 'package:flutter/cupertino.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:insite/core/base/insite_view_model.dart';
import 'package:insite/core/locator.dart';
import 'package:insite/core/models/asset_group_summary_response.dart';
import 'package:insite/core/models/asset_status.dart';
import 'package:insite/core/models/customer.dart';
import 'package:insite/core/models/filter_data.dart';
import 'package:insite/core/services/asset_admin_manage_user_service.dart';
import 'package:insite/core/services/local_service.dart';
import 'package:insite/core/services/local_storage_service.dart';
import 'package:insite/core/services/login_service.dart';
import 'package:load/load.dart';
import 'package:logger/logger.dart';
import 'package:insite/core/logger.dart';

import '../../../../core/services/asset_status_service.dart';

class AssetSelectionWidgetViewModel extends InsiteViewModel {
  Logger? log;
  AssetAdminManagerUserService? _manageUserService =
      locator<AssetAdminManagerUserService>();
  AssetStatusService? _assetService = locator<AssetStatusService>();

  LoginService? _loginService = locator<LoginService>();

  AssetGroupSummaryResponse? assetIdresult;
  PageController? pageController;
  ScrollController scrollController = ScrollController();
  ScrollController scrollController1 = ScrollController();
  List<AssetSelectionCategory>? assetSelectionCategory;
  LocalService _localService = locator<LocalService>();
  AssetSelectionWidgetViewModel(AssetGroupSummaryResponse? data) {
    this.log = getLogger(this.runtimeType.toString());
    if (isVisionLink) {
      assetSelectionCategory = assetSelectionCategoryVL;
    } else {
      assetSelectionCategory = assetSelectionCategoryIn;
    }
    pageController = PageController(initialPage: _currentPage);

    _assetService!.setUp();
    Future.delayed(Duration(seconds: 1), () async {
      _accountSelected = await _localService.getAccountInfo();
      if (data == null) {
      } else {
        getGroupListData(data);
      }
    });
  }

  int pageNumber = 1;
  int pageSize = 9999;

  bool? isAccountShow = false;

  bool _isloading = true;
  bool get isloading => _isloading;

  bool isSearchingSerialNo = false;
  bool isSearchingProductFamily = false;
  bool isSearchingModel = false;
  bool isSearchingManufacture = false;
  bool isSearchingDeviceType = false;

  List<Asset>? accountAssetSerialNumberList = [];

  List<Asset>? _assetId = [];
  List<Asset>? get assetId => _assetId;

  List<Asset>? _assetSerialNumber = [];
  List<Asset>? get assetSerialNumber => _assetSerialNumber;

  List<AccountSelectedData>? _accountNameData = [];
  List<AccountSelectedData>? get accountNameData => _accountNameData;

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

  Customer? _accountSelected;
  Customer? get accountSelected => _accountSelected;

  int? start = 1;
  int? limit = 100;

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

  AssetCategoryType? selectedType;

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
    // AssetSelectionCategory(
    //     name: "Asset Id", assetCategoryType: AssetCategoryType.ASSETID),
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
    AssetSelectionCategory(
        name: "Account", assetCategoryType: AssetCategoryType.ACCOUNT),
  ];

  int _currentPage = 0;

  getGroupListData(AssetGroupSummaryResponse data) async {
    try {
      assetIdresult = data;
      if (assetIdresult!.assetDetailsRecords!.isNotEmpty) {
        assetIdresult?.assetDetailsRecords?.forEach((asset) {
          if (asset.assetId == null) {
            _assetSerialNumber?.add(Asset(
                assetIcon: asset.assetIcon,
                assetId: asset.assetId,
                assetIdentifier: asset.assetIdentifier,
                assetSerialNumber: asset.assetSerialNumber,
                makeCode: asset.makeCode,
                model: asset.model,
                type: AssetCategoryType.SERIALNO));
          } else {
            _assetId?.add(Asset(
                assetIcon: asset.assetIcon,
                assetId: asset.assetId,
                assetIdentifier: asset.assetIdentifier,
                assetSerialNumber: asset.assetSerialNumber,
                makeCode: asset.makeCode,
                model: asset.model,
                type: AssetCategoryType.ASSETID));
            _assetSerialNumber?.add(Asset(
                assetIcon: asset.assetIcon,
                assetId: asset.assetId,
                assetIdentifier: asset.assetIdentifier,
                assetSerialNumber: asset.assetSerialNumber,
                makeCode: asset.makeCode,
                model: asset.model,
                type: AssetCategoryType.SERIALNO));
          }
        });
      }

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
            graphqlSchemaService!.getAssetCount(grouping: "productfamily"),
            true);
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

  getProductFamilyFilterData(String? productFamilKey, int i) async {
    try {
      showLoadingDialog();
      Logger().i(productFamilKey);
      AssetGroupSummaryResponse? result = await _manageUserService!
          .getAdminProductFamilyFilterData(
              pageNumber,
              pageSize,
              productFamilKey!,
              graphqlSchemaService!.getNotificationAssetList(
                  productfamily: productFamilKey,
                  pageNo: pageNumber,
                  pageSize: pageSize));
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
            "manufacturer",
            FilterType.MAKE,
            graphqlSchemaService!.getAssetCount(grouping: "manufacturer"),
            true);
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
      assetIdresult = await _manageUserService!.getManafactureFilterData(
          pageNumber,
          pageSize,
          "TATA HITACHI",
          graphqlSchemaService!.getNotificationAssetList(
              manufacturer: "TATA HITACHI",
              pageNo: pageNumber,
              pageSize: pageSize));
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
            "model",
            FilterType.MODEL,
            graphqlSchemaService!.getAssetCount(grouping: "model"),
            true);
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
      assetIdresult = await _manageUserService!.getModelFilterData(
          pageNumber,
          pageSize,
          productFamilyKey,
          graphqlSchemaService!.getNotificationAssetList(
              model: productFamilyKey, pageNo: pageNumber, pageSize: pageSize));
      Logger().i(assetIdresult);
      _subModelData?.clear();
      for (var item in assetIdresult!.assetDetailsRecords!) {
        _subModelData?.add(Asset(
            assetIcon: item.assetIcon,
            assetId: item.assetId,
            assetIdentifier: item.assetIdentifier,
            assetSerialNumber: item.assetSerialNumber,
            makeCode: item.makeCode,
            model: item.model,
            type: AssetCategoryType.MODEL));
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
            graphqlSchemaService!.getAssetCount(grouping: "deviceType"),
            true);
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

  getAccountFilterData(String? customIdentifier) async {
    try {
      if (customIdentifier == "0ba12330-cffb-11eb-82e0-0ae8ba8d3970" ||
          customIdentifier == "4f372aa8-aefb-11eb-82ce-0ae8ba8d3970" ||
          customIdentifier == "adc197bc-9c2b-11eb-a8b3-0242ac130003" ||
          customIdentifier == "79d3dff3-ace0-11eb-82ce-0ae8ba8d3970") {
        isAccountShow = true;
        pageController!.animateToPage(13,
            duration: Duration(microseconds: 200), curve: Curves.easeInOut);
        notifyListeners();
      } else {
        showLoadingDialog();
        assetIdresult = await _manageUserService!.getAccountSelectionData(
            pageNumber,
            pageSize,
            customIdentifier!,
            graphqlSchemaService!.getNotificationAssetList(
                customerIdentifier: customIdentifier,
                pageNo: pageNumber,
                pageSize: pageSize));
        if (assetIdresult != null) {
          for (var serialNumber in assetIdresult!.assetDetailsRecords!) {
            accountAssetSerialNumberList!.add(Asset(
                assetIcon: serialNumber.assetIcon,
                assetId: serialNumber.assetId,
                assetIdentifier: serialNumber.assetIdentifier,
                makeCode: serialNumber.makeCode,
                model: serialNumber.model,
                type: AssetCategoryType.ACCOUNT,
                assetSerialNumber: serialNumber.assetSerialNumber));
          }
          isAccountShow = false;

          pageController!.animateToPage(12,
              duration: Duration(microseconds: 200), curve: Curves.easeInOut);
          hideLoadingDialog();
        }
      }

      notifyListeners();
    } catch (e) {
      Logger().e(e.toString());
    }
  }

  getAccountTypeData() async {
    showLoadingDialog();
    List<Customer>? result = await _loginService!.getSubCustomers(
        customerId: accountSelected!.CustomerUID,
        limit: limit,
        start: start,
        isFromPagination: true);
    if (result != null) {
      Logger().wtf(result.first.toJson());

      for (int i = 0; i < result.length; i++) {
        var data = result[i];
        if (data.CustomerUID == "6ea359eb-ada5-11eb-82ce-0ae8ba8d3970") {
          for (int j = 0; j < data.Children!.length; j++) {
            var tataHitachiNameData = data.Children![j];
            _accountNameData!.add(AccountSelectedData(
                name: tataHitachiNameData.Name,
                customerUid: tataHitachiNameData.CustomerUID));
          }
        } else {
          _accountNameData!.add(AccountSelectedData(
              name: data.Name, customerUid: data.CustomerUID));
        }
      }
      hideLoadingDialog();

      Logger().w(accountNameData!.length);
      notifyListeners();
    }
  }

  getFilterDeviceTypeData(String productFamilyKey) async {
    try {
      showLoadingDialog();
      assetIdresult = await _manageUserService!.getDeviceTypeData(
          pageNumber,
          pageSize,
          productFamilyKey,
          graphqlSchemaService!.getNotificationAssetList(
              deviceType: productFamilyKey,
              pageNo: pageNumber,
              pageSize: pageSize));
      subDeviceList?.clear();
      for (var item in assetIdresult!.assetDetailsRecords!) {
        subDeviceList?.add(item);
      }
      pageController!.animateToPage(10,
          duration: Duration(microseconds: 200), curve: Curves.easeInOut);
      hideLoadingDialog();
      notifyListeners();
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

  onAccountTypeBackPressed() {
    pageController!.animateToPage(11,
        duration: Duration(microseconds: 200), curve: Curves.easeInOut);
  }

  onAddingSerialNo(int i, Asset? asset) {
    assetSerialNumber?.removeAt(i);
    notifyListeners();
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
    } else if (type == AssetCategoryType.ACCOUNT) {
      await getAccountTypeData();
      pageController!.animateToPage(11,
          duration: Duration(microseconds: 200), curve: Curves.easeInOut);
    }
  }

  List<Asset>? onAddingAllAsset() {
    switch (selectedType) {
      case AssetCategoryType.ASSETID:
        if (_assetId!.isNotEmpty) {
          return _assetId;
        } else {
          return null;
        }

      case AssetCategoryType.SERIALNO:
        if (_assetSerialNumber!.isNotEmpty) {
          return _assetSerialNumber;
        } else {
          return null;
        }
      case AssetCategoryType.PRODUCTFAMILY:
        if (_productFamilyCountData!.isNotEmpty) {
          return _productFamilyCountData;
        } else {
          return null;
        }
      case AssetCategoryType.MANUFACTURER:
        if (_subManufacturerList!.isNotEmpty) {
          return _subManufacturerList;
        } else {
          return null;
        }
      case AssetCategoryType.MODEL:
        if (_subModelData!.isNotEmpty) {
          return _subModelData;
        } else {
          return null;
        }
      case AssetCategoryType.DEVICETYPE:
        if (_subDeviceList!.isNotEmpty) {
          return _subDeviceList;
        } else {
          return null;
        }
      case AssetCategoryType.ACCOUNT:
        if (accountAssetSerialNumberList!.isNotEmpty) {
          return accountAssetSerialNumberList;
        } else {
          return null;
        }
      default:
    }
  }

  onDeletingSelectedAsset(int i, AssetCategoryType type) {
    switch (type) {
      case AssetCategoryType.ASSETID:
        assetId?.removeAt(i);
        break;
      case AssetCategoryType.SERIALNO:
        assetSerialNumber?.removeAt(i);
        break;
      case AssetCategoryType.PRODUCTFAMILY:
        productFamilyCountData?.removeAt(i);
        break;
      case AssetCategoryType.MANUFACTURER:
        subManufacturerList?.removeAt(i);
        break;
      case AssetCategoryType.DEVICETYPE:
        subDeviceList?.removeAt(i);
        break;
      case AssetCategoryType.MODEL:
        subModelData?.removeAt(i);
        break;
      case AssetCategoryType.ACCOUNT:
        accountAssetSerialNumberList!.removeAt(i);
        break;
      default:
    }
    notifyListeners();
  }

  onAddingDeletedAsset(Asset? data) {
    Logger().w(data?.toJson());
    if (data == null) {
      return;
    }
    switch (data.type) {
      case AssetCategoryType.ASSETID:
        assetId?.add(data);
        break;
      case AssetCategoryType.SERIALNO:
        assetSerialNumber?.add(data);
        break;
      case AssetCategoryType.PRODUCTFAMILY:
        productFamilyCountData?.add(data);
        break;
      case AssetCategoryType.MANUFACTURER:
        subManufacturerList?.add(data);
        break;
      case AssetCategoryType.DEVICETYPE:
        subDeviceList?.add(data);
        break;
      case AssetCategoryType.MODEL:
        subModelData?.add(data);

        break;
      default:
    }

    notifyListeners();
  }

  clearAllValues() {
    _productFamilyCountData!.clear();
    _subManufacturerList!.clear();
    _subDeviceList!.clear();
    _subModelData!.clear();
    accountAssetSerialNumberList!.clear();
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

class AccountSelectedData {
  final String? customerUid;
  final String? name;
  AccountSelectedData({this.customerUid, this.name});
}
