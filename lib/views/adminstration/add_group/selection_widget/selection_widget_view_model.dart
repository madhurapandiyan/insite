import 'package:flutter/widgets.dart';
import 'package:insite/core/base/insite_view_model.dart';
import 'package:insite/core/locator.dart';
import 'package:insite/core/logger.dart';
import 'package:insite/core/models/asset_status.dart';
import 'package:insite/core/models/customer.dart';
import 'package:insite/core/models/edit_group_response.dart';
import 'package:insite/core/models/filter_data.dart';
import 'package:insite/core/models/group_summary_response.dart';
import 'package:insite/core/models/manage_group_summary_response.dart';
import 'package:insite/core/repository/network.dart';
import 'package:insite/core/services/asset_admin_manage_user_service.dart';
import 'package:insite/core/services/asset_status_service.dart';
import 'package:insite/core/services/local_service.dart';
import 'package:insite/core/services/login_service.dart';
import 'package:insite/utils/enums.dart';
import 'package:insite/views/adminstration/add_group/model/add_group_model.dart';
import 'package:logger/logger.dart';

class SelectionWidgetViewModel extends InsiteViewModel {
  Logger? log;

  AssetAdminManagerUserService? _manageUserService =
      locator<AssetAdminManagerUserService>();
  AssetStatusService? _assetService = locator<AssetStatusService>();
  LoginService? _loginService = locator<LoginService>();
  LocalService? _localService = locator<LocalService>();

  List<String> _assetId = [];
  List<String> get assetId => _assetId;

  int? selectedIndex;

  List<String> _productFamilyData = [];
  List<String> get productFamilyData => _productFamilyData;

  List<Customer> _displayName = [];
  List<Customer> get displayName => _displayName;

  List<String> _productFamilyCountData = [];
  List<String> get productFamilyCountData => _productFamilyCountData;

  List<String> _assetSerialNumber = [];
  List<String> get assetSerialNumber => _assetSerialNumber;

  List<String> _manfactureData = [];
  List<String> get manfactureData => _manfactureData;

  List<String> _manfactureCountData = [];
  List<String> get manfactureCountData => _manfactureCountData;

  List<String> _geofenceData = [];
  List<String> get geofenceData => _geofenceData;

  List<String> _geofenceCountData = [];
  List<String> get geofenceCountData => _geofenceCountData;

  int pageNumber = 1;
  int pageSize = 9999;

  List<String> _modelData = [];
  List<String> get modelData => _modelData;

  GroupSummaryResponse? assetIdresult;

  List<String> _modelCountData = [];
  List<String> get modelCountData => _modelCountData;

  bool _isShowingState = false;
  bool get isShowingState => _isShowingState;

  bool _isShowingManaFactureState = false;
  bool get isShowingManaFactureState => _isShowingManaFactureState;

  bool _isShowingModelState = false;
  bool get isShowingModelState => _isShowingModelState;

  bool _isShowingAccountSelectedState = true;
  bool get isShowingAccountSelectedState => _isShowingAccountSelectedState;

  bool _isShowingDeviceTypeState = false;
  bool get isShowingDeviceTypeState => _isShowingDeviceTypeState;

  bool _isaccountSelectionState = false;
  bool get isaccountSelectionState => _isaccountSelectionState;

  bool isFilterChangeState = false;

  bool isLoading = true;

  List<String> _deviceTypeData = [];
  List<String> get deviceTypdeData => _deviceTypeData;

  List<String> subProductFamilyList = [];
  List<String> subManfactureList = [];
  List<String> subModelList = [];
  List<String> deviceTypeList = [];
  List<String> accountSelectionList = [];
  List<String> productFamilySubList = [];

  List<String> _deviceTypeCountData = [];
  List<String> get deviceTypeCountData => _deviceTypeCountData;

  TextEditingController accountController = TextEditingController();
  TextEditingController assetIDController = TextEditingController();
  TextEditingController serialNumberController = TextEditingController();
  TextEditingController productFamilyController = TextEditingController();
  TextEditingController manafactureController = TextEditingController();
  TextEditingController modelController = TextEditingController();
  TextEditingController deviceTypeController = TextEditingController();

  //SUBCONTROLLER
  TextEditingController productFamilySubController = TextEditingController();
  TextEditingController manafactureSubController = TextEditingController();
  TextEditingController modelSubController = TextEditingController();
  TextEditingController deviceTypeSubController = TextEditingController();
  TextEditingController accountSubController = TextEditingController();

  TextEditingController selectedItemController = TextEditingController();

  ScrollController _controller = ScrollController();
  ScrollController get controller => _controller;

  PageController? pageController;
  int currentPage = 0;

  bool _isAssetLoading = true;
  bool get isAssetLoading => _isAssetLoading;

  List<Customer> accountDisplayList = [];
  List<String> assetIdDisplayList = [];
  List<String> assetSeriaNumberList = [];
  List<String> productFamilyList = [];
  List<String> manfactureList = [];
  List<String> modelList = [];
  List<String> devicetypeList = [];

  //SUBACCOUNTSEARCHLIST
  List<String> subProductFamilySearchList = [];
  List<String> subManafactureSearchList = [];
  List<String> subModelSearchList = [];
  List<String> subDeviceTypeSearchList = [];
  List<String> subAccountSearchList = [];

  //SELECTEDASSETWIDGET

  List<AddGroupModel> assetIdSelecteList = [];
  List<String> assetIdentifier = [];
  List<AddGroupModel> searchSelectedItemList = [];

  bool isloading = false;
  List<String?>? assetIdentifierData = [];

  SelectionWidgetViewModel(
      Groups? group, List<String?>? assetId, bool? isEdit) {
    Future.delayed(Duration(seconds: 1), () {
      if (group == null || isEdit!) {
        Logger().wtf(isEdit);
        getGroupListData();
      } else {
        getGroupListData().then((value) => initial(assetId!, value));
      }
    });

    this.log = getLogger(this.runtimeType.toString());

    _manageUserService!.setUp();
    _assetService!.setUp();

    pageController = PageController(initialPage: currentPage);

    accountController.addListener(() {
      onSearchTextChanged(accountController.text);
    });
    assetIDController.addListener(() {
      onSearchAssetIdTextChanged(assetIDController.text);
    });
    serialNumberController.addListener(() {
      onSerialNumberSearchTextChanged(serialNumberController.text);
    });
    productFamilyController.addListener(() {
      onSearchProductFamilySearchTextChanged(productFamilyController.text);
    });
    manafactureController.addListener(() {
      onSearchManafactureTextChanged(manafactureController.text);
    });
    modelController.addListener(() {
      onSearchModelTextChanged(modelController.text);
    });
    deviceTypeController.addListener(() {
      onSearchdeviceTypeTextChanged(deviceTypeController.text);
    });
    productFamilySubController.addListener(() {
      onSearchProductFamilySubSearchTextChanged(
          productFamilySubController.text);
    });
    manafactureSubController.addListener(() {
      onSearchSubManafactureTextChanged(manafactureSubController.text);
    });
    modelSubController.addListener(() {
      onSearchModelSubTextChanged(modelSubController.text);
    });
    deviceTypeSubController.addListener(() {
      onSearchDeviceTypeSubTextChanged(deviceTypeSubController.text);
    });
    accountSubController.addListener(() {
      onSearchSubAccountTextChanged(accountSubController.text);
    });
    selectedItemController.addListener(() {
      onSearchSelectedItemList(selectedItemController.text);
    });
  }

  Future<GroupSummaryResponse?> getGroupListData() async {
    if (_assetId.isEmpty && _assetSerialNumber.isEmpty) {
      assetIdresult = await _manageUserService!.getGroupListData();

      assetIdresult!.assetDetailsRecords!.forEach((element) {
        if (element.assetId != null) {
          _assetId.add(element.assetId!);
          _isAssetLoading = false;
        }
      });
      assetIdresult!.assetDetailsRecords!.forEach((element) {
        _assetSerialNumber.add(element.assetSerialNumber!);
      });
    }
    notifyListeners();
    return assetIdresult;
  }

  onPreviousClicked() async {
    currentPage--;
    notifyListeners();
  }

  onNextClicked() async {
    currentPage++;
    notifyListeners();
  }

  initial(List<String?>? data, GroupSummaryResponse? value) {
    searchingAssetId(data, value);
  }

  searchingAssetId(
      List<String?>? value, GroupSummaryResponse? assetValue) async {
    assetIdentifierData = value;
    //assetIdresult = await _manageUserService!.getGroupListData();

    var data = assetValue!.assetDetailsRecords!.where((e) {
      return value!.any((element) => element == e.assetIdentifier);
    }).toList();

    assetValue.assetDetailsRecords!.removeWhere(
        (e) => value!.any((element) => element == e.assetIdentifier));
    _assetId.clear();
    _assetSerialNumber.clear();

    assetValue.assetDetailsRecords!.forEach((element) {
      if (element.assetId != null) {
        _assetId.add(element.assetId!);

        _isAssetLoading = false;
      }
    });

    assetValue.assetDetailsRecords!.forEach((element) {
      _assetSerialNumber.add(element.assetSerialNumber!);
    });

    data.forEach((element) {
      assetIdSelecteList.add(AddGroupModel(
        assetIdentifier: element.assetIdentifier,
        assetId: element.assetId,
        make: element.makeCode,
        model: element.model,
        serialNo: element.assetSerialNumber,
      ));
    });

    _isAssetLoading = false;
    notifyListeners();
  }

  getProductFamilyData() async {
    if (_productFamilyData.isEmpty && productFamilyCountData.isEmpty) {
      AssetCount? resultProductfamily = await _assetService!.getAssetCount(
          "productfamily",
          FilterType.PRODUCT_FAMILY,
          graphqlSchemaService!.allAssets);
      if (resultProductfamily != null) {
        for (var productFamilyData in resultProductfamily.countData!) {
          _productFamilyData.add(productFamilyData.countOf!);
          _productFamilyCountData.add(productFamilyData.count.toString());
          _isAssetLoading = false;
        }

        notifyListeners();
      }
    }
  }

  getManfactureGroupData() async {
    if (_manfactureData.isEmpty && _manfactureCountData.isEmpty) {
      AssetCount? resultManufacturer = await _assetService!.getAssetCount(
          "manufacturer", FilterType.MAKE, graphqlSchemaService!.allAssets);
      for (var manfactureData in resultManufacturer!.countData!) {
        _manfactureData.add(manfactureData.countOf!);
        _manfactureCountData.add(manfactureData.count.toString());
        _isAssetLoading = false;
        notifyListeners();
      }
    }
  }

  getGeoFenceData() async {
    if (_geofenceData.isEmpty && _geofenceCountData.isEmpty) {
      AssetCount? result = await _manageUserService!.getGeofenceCountData();
      if (result != null) {
        for (var geoFenceData in result.countData!) {
          _geofenceData.add(geoFenceData.countOf!);
          _geofenceCountData.add(geoFenceData.count.toString());
          _isAssetLoading = false;
          notifyListeners();
        }
      }
    }
  }

  getModelData() async {
    if (_modelData.isEmpty && modelCountData.isEmpty) {
      AssetCount? resultModel = await _assetService!.getAssetCount(
          "model", FilterType.MODEL, graphqlSchemaService!.allAssets);
      if (resultModel != null) {
        Logger().wtf(resultModel.countData!.last.toJson());
        for (var modelData in resultModel.countData!) {
          _modelData.add(modelData.countOf!);
          _modelCountData.add(modelData.count.toString());
          _isAssetLoading = false;
          notifyListeners();
        }
      }
    }
  }

  getDeviceTypeData() async {
    if (_geofenceData.isEmpty && _geofenceCountData.isEmpty) {
      AssetCount? resultDeviceType = await _assetService!.getAssetCount(
          "deviceType",
          FilterType.DEVICE_TYPE,
          graphqlSchemaService!.allAssets);
      deviceTypdeData.clear();
      deviceTypeCountData.clear();
      for (var deviceTypeData in resultDeviceType!.countData!) {
        _deviceTypeData.add(deviceTypeData.countOf!);
        _deviceTypeCountData.add(deviceTypeData.count.toString());
        _isAssetLoading = false;
        notifyListeners();
      }
    }
  }

  Future<List<Customer>?> getSubCustomerList() async {
    try {
      if (displayName.isEmpty) {
        var cusomerInfo = await _localService!.getAccountInfo();
        Logger().d("getSubCustomerList");

        List<Customer>? result =
            await _loginService!.getSubCustomers(cusomerInfo!.CustomerUID);
        if (result != null) {
          for (var nameData in result) {
            _displayName.add(nameData);
          }
          _isAssetLoading = false;
        }
        notifyListeners();
        return result;
      }
    } catch (e) {
      Logger().e(e.toString());
    }
  }

  var dropdownList = ["All", "ID", "S/N"];
  var dropDownValue = "All";

  onSearchTextChanged(String? text) async {
    Logger().i("query typeed " + text!);

    if (text != null) {
      if (text.trim().isNotEmpty) {
        List<Customer> tempList = [];
        tempList.clear();
        displayName.forEach((item) {
          if (item.Name!.toLowerCase().contains(text.toLowerCase()))
            tempList.add(item);
        });
        accountDisplayList = tempList;
        Logger().i("total list size " + displayName.length.toString());
        Logger()
            .i("searched list size " + accountDisplayList.length.toString());
        notifyListeners();
      } else {
        accountDisplayList = displayName;
        notifyListeners();
      }
    }
  }

  void onSearchAssetIdTextChanged(String? text) {
    Logger().i("query typeed " + text!);

    if (text != null) {
      if (text.trim().isNotEmpty) {
        List<String> tempList = [];
        tempList.clear();
        assetId.forEach((item) {
          if (item.toLowerCase().contains(text.toLowerCase()))
            tempList.add(item);
        });
        assetIdDisplayList = tempList;
        Logger().i("total list size " + displayName.length.toString());
        Logger()
            .i("searched list size " + assetIdDisplayList.length.toString());
        notifyListeners();
      } else {
        assetIdDisplayList = assetId;
        notifyListeners();
      }
    }
  }

  filterSelectedItemSelectWidgetState() {
    isFilterChangeState = !isFilterChangeState;
    notifyListeners();
  }

  getProductFamilyFilterData(String? productFamilKey) async {
    Logger().i(productFamilKey);
    onNextClicked();

    GroupSummaryResponse? result = await _manageUserService!
        .getAdminProductFamilyFilterData(
            pageNumber, pageSize, productFamilKey!);
    subProductFamilyList.clear();
    for (var item in result!.assetDetailsRecords!) {
      subProductFamilyList.add(item.assetSerialNumber!);
    }
    Logger().i(result);
    _isShowingState = true;
    _isAssetLoading = false;
    notifyListeners();
  }

  getBackButtonState() {
    onPreviousClicked();
    _isShowingState = false;
    _isShowingManaFactureState = false;
    _isShowingModelState = false;
    _isShowingDeviceTypeState = false;
    _isaccountSelectionState = false;
    notifyListeners();
  }

  getFilterManafactureData(String productFamilyKey) async {
    Logger().i(productFamilyKey);
    onNextClicked();
    assetIdresult = await _manageUserService!
        .getManafactureFilterData(pageNumber, pageSize, "TATA HITACHI");
    subManfactureList.clear();
    for (var item in assetIdresult!.assetDetailsRecords!) {
      subManfactureList.add(item.assetSerialNumber!);
    }
    Logger().i(assetIdresult);
    _isShowingManaFactureState = true;
    _isAssetLoading = false;
    notifyListeners();
  }

  getFilterModelData(String productFamilyKey) async {
    try {
      Logger().w("running");
      onNextClicked();
      assetIdresult = await _manageUserService!
          .getModelFilterData(pageNumber, pageSize, productFamilyKey);
      Logger().i(assetIdresult);
      subModelList.clear();
      for (var item in assetIdresult!.assetDetailsRecords!) {
        subModelList.add(item.assetSerialNumber!);
      }
      _isShowingModelState = true;
      _isAssetLoading = false;
      notifyListeners();
    } catch (e) {
      Logger().e(e.toString());
    }
  }

  getFilterDeviceTypeData(String productFamilyKey) async {
    onNextClicked();

    assetIdresult = await _manageUserService!
        .getDeviceTypeData(pageNumber, pageSize, productFamilyKey);
    deviceTypeList.clear();
    for (var item in assetIdresult!.assetDetailsRecords!) {
      deviceTypeList.add(item.assetSerialNumber!);
    }
    _isAssetLoading = false;
    _isShowingDeviceTypeState = true;
    Logger().i(assetIdresult);
    notifyListeners();
  }

  getAccountSelectionData(String productFamilyKey) async {
    _isShowingAccountSelectedState = false;
    assetIdresult = await _manageUserService!
        .getAccountSelectionData(pageNumber, pageSize, productFamilyKey);
    accountSelectionList.clear();
    for (var item in assetIdresult!.assetDetailsRecords!) {
      accountSelectionList.add(item.assetSerialNumber!);
    }
    Logger().i(assetIdresult);
    _isaccountSelectionState = true;

    _isAssetLoading = false;
    notifyListeners();
  }

  void onSerialNumberSearchTextChanged(String? text) {
    if (text != null) {
      if (text.trim().isNotEmpty) {
        List<String> tempList = [];
        tempList.clear();
        assetSerialNumber.forEach((item) {
          if (item.toLowerCase().contains(text.toLowerCase()))
            tempList.add(item);
        });
        assetSeriaNumberList = tempList;
        Logger().i("total list size " + assetSerialNumber.length.toString());
        Logger()
            .i("searched list size " + assetSeriaNumberList.length.toString());
        notifyListeners();
      } else {
        assetSeriaNumberList = assetSerialNumber;
        notifyListeners();
      }
    }
  }

  void onSearchProductFamilySearchTextChanged(String? text) {
    if (text != null) {
      if (text.trim().isNotEmpty) {
        List<String> tempList = [];
        tempList.clear();
        productFamilyData.forEach((item) {
          if (item.toLowerCase().contains(text.toLowerCase()))
            tempList.add(item);
        });
        productFamilyList = tempList;
        Logger().i("total list size " + productFamilyData.length.toString());
        Logger().i("searched list size " + productFamilyList.length.toString());
        notifyListeners();
      } else {
        productFamilyList = productFamilyData;
        notifyListeners();
      }
    }
  }

  void onSearchManafactureTextChanged(String? text) {
    if (text != null) {
      if (text.trim().isNotEmpty) {
        List<String> tempList = [];
        tempList.clear();
        manfactureData.forEach((item) {
          if (item.toLowerCase().contains(text.toLowerCase()))
            tempList.add(item);
        });
        manfactureList = tempList;
        Logger().i("total list size " + manfactureData.length.toString());
        Logger().i("searched list size " + manfactureList.length.toString());
        notifyListeners();
      } else {
        manfactureList = manfactureData;
        notifyListeners();
      }
    }
  }

  void onSearchModelTextChanged(String? text) {
    if (text != null) {
      if (text.trim().isNotEmpty) {
        List<String> tempList = [];
        tempList.clear();
        modelData.forEach((item) {
          if (item.toLowerCase().contains(text.toLowerCase()))
            tempList.add(item);
        });
        modelList = tempList;
        Logger().i("total list size " + modelData.length.toString());
        Logger().i("searched list size " + modelList.length.toString());
        notifyListeners();
      } else {
        modelList = modelData;
        notifyListeners();
      }
    }
  }

  void onSearchdeviceTypeTextChanged(String? text) {
    if (text != null) {
      if (text.trim().isNotEmpty) {
        List<String> tempList = [];
        tempList.clear();
        deviceTypdeData.forEach((item) {
          if (item.toLowerCase().contains(text.toLowerCase()))
            tempList.add(item);
        });
        devicetypeList = tempList;
        Logger().i("total list size " + deviceTypdeData.length.toString());
        Logger().i("searched list size " + devicetypeList.length.toString());
        notifyListeners();
      } else {
        modelList = deviceTypdeData;
        notifyListeners();
      }
    }
  }

  void onSearchProductFamilySubSearchTextChanged(String? text) {
    if (text != null) {
      if (text.trim().isNotEmpty) {
        List<String> tempList = [];
        tempList.clear();
        subProductFamilyList.forEach((item) {
          if (item.toLowerCase().contains(text.toLowerCase()))
            tempList.add(item);
        });
        subProductFamilySearchList = tempList;
        Logger().i("total list size " + subProductFamilyList.toString());
        Logger().i("searched list size " +
            subProductFamilySearchList.length.toString());
        notifyListeners();
      } else {
        subProductFamilySearchList = subProductFamilyList;
        notifyListeners();
      }
    }
  }

  void onSearchSubManafactureTextChanged(String? text) {
    if (text != null) {
      if (text.trim().isNotEmpty) {
        List<String> tempList = [];
        tempList.clear();
        subManfactureList.forEach((item) {
          if (item.toLowerCase().contains(text.toLowerCase()))
            tempList.add(item);
        });
        subManafactureSearchList = tempList;
        Logger().i("total list size " + subManfactureList.toString());
        Logger().i(
            "searched list size " + subManafactureSearchList.length.toString());
        notifyListeners();
      } else {
        subManafactureSearchList = subManfactureList;
        notifyListeners();
      }
    }
  }

  void onSearchModelSubTextChanged(String? text) {
    if (text != null) {
      if (text.trim().isNotEmpty) {
        List<String> tempList = [];
        tempList.clear();
        subModelList.forEach((item) {
          if (item.toLowerCase().contains(text.toLowerCase()))
            tempList.add(item);
        });
        subModelSearchList = tempList;
        Logger().i("total list size " + subModelList.toString());
        Logger()
            .i("searched list size " + subModelSearchList.length.toString());
        notifyListeners();
      } else {
        subModelSearchList = subModelList;
        notifyListeners();
      }
    }
  }

  void onSearchDeviceTypeSubTextChanged(String? text) {
    if (text != null) {
      if (text.trim().isNotEmpty) {
        List<String> tempList = [];
        tempList.clear();
        deviceTypeList.forEach((item) {
          if (item.toLowerCase().contains(text.toLowerCase()))
            tempList.add(item);
        });
        subDeviceTypeSearchList = tempList;
        Logger().i("total list size " + deviceTypeList.toString());
        Logger().i(
            "searched list size " + subDeviceTypeSearchList.length.toString());
        notifyListeners();
      } else {
        subDeviceTypeSearchList = deviceTypeList;
        notifyListeners();
      }
    }
  }

  void onSearchSubAccountTextChanged(String? text) {
    if (text != null) {
      if (text.trim().isNotEmpty) {
        List<String> tempList = [];
        tempList.clear();
        accountSelectionList.forEach((item) {
          if (item.toLowerCase().contains(text.toLowerCase()))
            tempList.add(item);
        });
        subAccountSearchList = tempList;
        Logger().i("total list size " + accountSelectionList.toString());
        Logger()
            .i("searched list size " + subAccountSearchList.length.toString());
        notifyListeners();
      } else {
        subAccountSearchList = accountSelectionList;
        notifyListeners();
      }
    }
  }

  onSearchSelectedItemList(String? text) {
    if (text != null) {
      if (text.trim().isNotEmpty) {
        List<AddGroupModel> tempList = [];
        tempList.clear();
        assetIdSelecteList.forEach((item) {
          if (item.serialNo!.toLowerCase().contains(text.toLowerCase()))
            tempList.add(item);
        });
        searchSelectedItemList = tempList;
        Logger().i("total list size " + assetIdSelecteList.toString());
        Logger().i(
            "searched list size " + searchSelectedItemList.length.toString());
        notifyListeners();
      } else {
        searchSelectedItemList = assetIdSelecteList;
        notifyListeners();
      }
    }
  }

  List<String> associatedAssetId = [];
  List<String> dissociatedAssetId = [];
  selectedIndexData(value, int index) {
    assetIdresult!.assetDetailsRecords!.forEach((element) {
      if (element.assetId == value) {
        assetIdentifier.add(element.assetIdentifier!);
        associatedAssetId.add(element.assetIdentifier!);
        assetIdSelecteList.add(AddGroupModel(
          assetId: element.assetId,
          make: element.makeCode,
          serialNo: element.assetSerialNumber,
          model: element.model,
          assetIdentifier: element.assetIdentifier,
        ));

        _assetId.removeAt(index);

        notifyListeners();
      }
    });
  }

  selectedSerialNumberIndexData(value, int index) {
    assetIdresult!.assetDetailsRecords!.forEach((element) {
      if (element.assetSerialNumber == value) {
        assetIdentifier.add(element.assetIdentifier!);
        associatedAssetId.add(element.assetIdentifier!);
        assetIdSelecteList.add(AddGroupModel(
            assetId: element.assetId,
            make: element.makeCode,
            serialNo: element.assetSerialNumber,
            model: element.model,
            assetIdentifier: element.assetIdentifier));
        subProductFamilyList.removeWhere((element) => value == element);
        subManfactureList.removeWhere((element) => value == element);
        subModelList.removeWhere((element) => value == element);
        deviceTypeList.removeWhere((element) => value == element);
        accountSelectionList.removeWhere((element) => value == element);
        _assetSerialNumber.removeWhere((element) => value == element);
        notifyListeners();
      }
    });
    Logger().i(assetIdSelecteList.length);
  }

  selectedProductFamilyData(valueData, int index) {
    assetIdresult!.assetDetailsRecords!.forEach((element) {
      if (element.assetSerialNumber == valueData) {
        assetIdentifier.add(element.assetIdentifier!);
        associatedAssetId.add(element.assetIdentifier!);
        assetIdSelecteList.add(AddGroupModel(
            assetId: element.assetId,
            make: element.makeCode,
            serialNo: element.assetSerialNumber,
            model: element.model,
            assetIdentifier: element.assetIdentifier));
        subManfactureList.removeWhere((element) => valueData == element);
        subModelList.removeWhere((element) => valueData == element);
        deviceTypeList.removeWhere((element) => valueData == element);
        accountSelectionList.removeWhere((element) => valueData == element);
        _assetSerialNumber.removeWhere((element) => valueData == element);
        subProductFamilyList.removeWhere((element) => valueData == element);

        notifyListeners();
      }
    });
  }

  selectedManfactureListData(valueData, int index) {
    assetIdresult!.assetDetailsRecords!.forEach((element) {
      if (element.assetSerialNumber == valueData) {
        assetIdentifier.add(element.assetIdentifier!);
        associatedAssetId.add(element.assetIdentifier!);
        assetIdSelecteList.add(AddGroupModel(
            assetId: element.assetId,
            make: element.makeCode,
            serialNo: element.assetSerialNumber,
            model: element.model,
            assetIdentifier: element.assetIdentifier));
        subManfactureList.removeWhere((element) => valueData == element);
        subModelList.removeWhere((element) => valueData == element);
        deviceTypeList.removeWhere((element) => valueData == element);
        accountSelectionList.removeWhere((element) => valueData == element);
        _assetSerialNumber.removeWhere((element) => valueData == element);
        subProductFamilyList.removeWhere((element) => valueData == element);

        Logger().w(subManfactureList.length);
        notifyListeners();
      }
    });
  }

  selectedModelData(valueData, int index) {
    Logger().wtf(assetIdresult!.assetDetailsRecords!
        .any((element) => element.assetSerialNumber == valueData));
    assetIdresult!.assetDetailsRecords!.forEach((element) {
      if (element.assetSerialNumber == valueData) {
        assetIdentifier.add(element.assetIdentifier!);
        associatedAssetId.add(element.assetIdentifier!);
        assetIdSelecteList.add(AddGroupModel(
            assetId: element.assetId,
            make: element.makeCode,
            serialNo: element.assetSerialNumber,
            model: element.model,
            assetIdentifier: element.assetIdentifier));
        subManfactureList.removeWhere((element) => valueData == element);
        subModelList.removeWhere((element) => valueData == element);
        deviceTypeList.removeWhere((element) => valueData == element);
        accountSelectionList.removeWhere((element) => valueData == element);
        _assetSerialNumber.removeWhere((element) => valueData == element);
        subProductFamilyList.removeWhere((element) => valueData == element);

        notifyListeners();
      }
    });
  }

  selectedDeviceTypeData(valueData, int index) {
    assetIdresult!.assetDetailsRecords!.forEach((element) {
      if (element.assetSerialNumber == valueData) {
        assetIdentifier.add(element.assetIdentifier!);
        associatedAssetId.add(element.assetIdentifier!);
        assetIdSelecteList.add(AddGroupModel(
            assetId: element.assetId,
            make: element.makeCode,
            serialNo: element.assetSerialNumber,
            model: element.model,
            assetIdentifier: element.assetIdentifier));
        subManfactureList.removeWhere((element) => valueData == element);
        subModelList.removeWhere((element) => valueData == element);
        deviceTypeList.removeWhere((element) => valueData == element);
        accountSelectionList.removeWhere((element) => valueData == element);
        _assetSerialNumber.removeWhere((element) => valueData == element);
        subProductFamilyList.removeWhere((element) => valueData == element);

        notifyListeners();
      }
    });
  }

  selectedAccountSelectionData(valueData, int index) {
    assetIdresult!.assetDetailsRecords!.forEach((element) {
      if (element.assetSerialNumber == valueData) {
        assetIdentifier.add(element.assetIdentifier!);
        associatedAssetId.add(element.assetIdentifier!);
        assetIdSelecteList.add(AddGroupModel(
            assetId: element.assetId,
            make: element.makeCode,
            serialNo: element.assetSerialNumber,
            model: element.model,
            assetIdentifier: element.assetIdentifier));
        subManfactureList.removeWhere((element) => valueData == element);
        subModelList.removeWhere((element) => valueData == element);
        deviceTypeList.removeWhere((element) => valueData == element);
        accountSelectionList.removeWhere((element) => valueData == element);
        _assetSerialNumber.removeWhere((element) => valueData == element);
        subProductFamilyList.removeWhere((element) => valueData == element);

        notifyListeners();
      }
    });
  }

  onRemoveSelectedIndex(int index, String assetId) {
    var addData = assetIdSelecteList.elementAt(index);
    if (addData.assetId == null) {
      if (_assetSerialNumber.any((element) => element == addData.serialNo)) {
        Logger().i("already data in serial Number");
      } else {
        _assetSerialNumber.add(addData.serialNo!);
        subModelList.add(addData.serialNo!);
        subProductFamilyList.add(addData.serialNo!);
        subManfactureList.add(addData.serialNo!);
        deviceTypeList.add(addData.serialNo!);
        subManfactureList.add(addData.serialNo!);
        accountSelectionList.add(addData.serialNo!);

        assetIdSelecteList.removeAt(index);
        assetIdentifier.clear();
      }
    } else {
      if (_assetId.any((element) => element == addData.assetId)) {
        Logger().i("already data in asset Id");
      } else {
        _assetId.add(addData.assetId!);

        assetIdSelecteList.removeAt(index);

        assetIdentifier.clear();
      }
    }
    notifyListeners();
  }

  getDropDownListData(String value) {
    dropDownValue = value;
    notifyListeners();
  }
}
