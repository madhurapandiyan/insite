import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get_it/get_it.dart';
import 'package:insite/core/base/insite_view_model.dart';
import 'package:insite/core/locator.dart';
import 'package:insite/core/models/add_asset_registration.dart';
import 'package:insite/core/models/hierarchy_model.dart';
import 'package:insite/core/models/preview_data.dart';
import 'package:insite/core/models/subscription_dashboard.dart';
import 'package:insite/core/models/subscription_dashboard_details.dart';
import 'package:insite/core/models/subscription_serial_number_results.dart';
import 'package:insite/core/services/subscription_service.dart';
import 'package:insite/utils/enums.dart';
import 'package:insite/utils/helper_methods.dart';
import 'package:insite/views/adminstration/addgeofense/exception_handle.dart';
import 'package:intl/intl.dart';
import 'package:logger/logger.dart';
import 'package:insite/core/logger.dart';

class SingleAssetRegistrationViewModel extends InsiteViewModel {
  Logger? log;

  SubScriptionService? _subscriptionService = locator<SubScriptionService>();

  String? _filter;
  String? get filter => _filter;

  PLANTSUBSCRIPTIONFILTERTYPE? _filterType;
  PLANTSUBSCRIPTIONFILTERTYPE? get filterType => _filterType;

  bool _loading = true;
  bool get loading => _loading;

  bool isSerialNoisValid = false;

  bool _loadingMore = false;
  bool get loadingMore => _loadingMore;

  String? _assetModel = "Select Asset Model";
  String? get assetModel => _assetModel;

  String? _plantDetail = "";
  String? get plantDetail => _plantDetail;

  String? _plantCode;
  String? get plantCode => _plantCode;

  String? _plantEmail;
  String? get plantEmail => _plantEmail;

  bool _shouldLoadmore = true;
  bool get shouldLoadmore => _shouldLoadmore;

  bool _refreshing = false;
  bool get refreshing => _refreshing;

  bool _isShowingHelper = false;
  bool get isShowingHelper => _isShowingHelper;

  DateTime? _pickedDate = DateTime.now();
  DateTime? get pickedDate => _pickedDate;

  int pageNumber = 0;
  int pageSize = 100;
  int pageNumberSecond = 0;
  int pageSizeSecond = 10;
  bool deviceCodeType = true;
  bool deviceNametype = true;
  bool customerCodetype = true;
  bool customerNameType = true;

  bool isSerialNoSelected = false;
  List<HierarchyModel> _devices = [];
  List<HierarchyModel> get devices => _devices;

  List<DetailResult> _detailResult = [];
  List<DetailResult> get detailResult => _detailResult;

  List<HierarchyModel> _deviceDetails = [];
  List<HierarchyModel> get deviceDetails => _deviceDetails;

  List<HierarchyModel> _customerDetails = [];
  List<HierarchyModel> get customerDetails => _customerDetails;

  List<String?> _gpsDeviceId = [];
  List<String?> get gpsDeviceId => _gpsDeviceId;

  List<String?> _customerId = [];
  List<String?> get customerId => _customerId;

  List<String?> _dealerId = [];
  List<String?> get dealerId => _dealerId;

  List<String?> _dealerCode = [];
  List<String?> get dealerCode => _dealerCode;

  List<String?> _customerCode = [];
  List<String?> get customerCode => _customerCode;

  List<String?> _customerEmail = [];
  List<String?> get customerEmail => _customerEmail;

  List<String?> _modelNames = [
    "Select Asset Model",
  ];
  List<String?> get modelNames => _modelNames;

  List<String> _serialNoList = [];
  List<String> get serialNoList => _serialNoList;

  List<String> _popUpCardTitles = [
    "Entity Details",
    "Plant Details",
    "Dealer Details",
    "Customer Details"
  ];
  List<String> get popUpCardTitles => _popUpCardTitles;

  List<List<PreviewData>> _totalList = [];
  List<List<PreviewData>> get totalList => _totalList;

  List<PreviewData> _previewDeviceDetails = [];
  List<PreviewData> get previewDeviceDetails => _previewDeviceDetails;

  List<PreviewData> _generalPlantDetails = [];
  List<PreviewData> get generalPlantDetails => _generalPlantDetails;

  List<PreviewData> _generalDealerDetails = [];
  List<PreviewData> get generalDealerDetails => _generalDealerDetails;

  List<PreviewData> _generalCustomerDetails = [];
  List<PreviewData> get generalCustomerDetails => _generalCustomerDetails;

  List<String> _finalDeviceDetails = [];
  List<String> get finalDeviceDetails => _finalDeviceDetails;

  List<AssetValues> _totalAssetValues = [];
  List<AssetValues> get totalAssetValues => _totalAssetValues;

  List<HierarchyModel> detailResultList = [];

  List<String?> _plantDetails = [
    "Dharward",
    "Plant",
    "TATA HITACHI KHARAGPUR FACTORY",
  ];
  List<String?> get plantDetails => _plantDetails;

  List<String?> _plantCodes = ["1005", "1006", "3065"];
  List<String?> get plantCodes => _plantCodes;

  SubscriptionDashboardDetailResult? deviceIdChange;
  SingleAssetRegistrationSearchModel? dealerNameChange;
  SingleAssetRegistrationSearchModel? dealerCodeChange;
  SingleAssetRegistrationSearchModel? customerNameChange;
  SingleAssetRegistrationSearchModel? customerCodeChange;

  SingleAssetRegistrationViewModel(
      String? filterKey, PLANTSUBSCRIPTIONFILTERTYPE? type) {
    this.log = getLogger(this.runtimeType.toString());
    this._filter = filterKey;
    this._filterType = type;
    plantDetails.add(_plantDetail);
    Future.delayed(Duration(seconds: 1), () {
      // getSubcriptionDeviceListData();
      getSubscriptionModelData();
    });
  }

  updateModelValue(String newValue) {
    if (newValue == "SHINRAI-BX80") {
      _assetModel = newValue;
      notifyListeners();
    } else {
      _assetModel = newValue;
      serialNumberController.clear();
      notifyListeners();
    }
  }

  updateplantDEtail(String? newValue) {
    _plantDetail = newValue;
    if (_plantDetail == plantDetails[0]) {
      _plantCode = plantCodes[0];
    } else if (_plantDetail == plantDetails[1]) {
      _plantCode = plantCodes[1];
    } else if (_plantDetail == plantDetails[2]) {
      _plantCode = plantCodes[2];
    }

    Logger().wtf(_plantCode);

    notifyListeners();
  }

  TextEditingController hourMeterDateController = TextEditingController();
  TextEditingController deviceIdController = TextEditingController();
  TextEditingController serialNumberController = TextEditingController();

  TextEditingController hourMeterController = TextEditingController();
  TextEditingController deviceNameController = TextEditingController();
  TextEditingController deviceCodeController = TextEditingController();
  TextEditingController deviceEmailController = TextEditingController();

  TextEditingController customerNameController = TextEditingController();
  TextEditingController customerCodeController = TextEditingController();
  TextEditingController customerEmailController = TextEditingController();

  getSelectedDate(DateTime? value) {
    Logger().e(value);
    _pickedDate = value;
    var outputFormat = DateFormat('dd-MM-yyyy');
    //var dateTime = DateFormat("dd-MM-yyyy").parse(_pickedDate.toString());
    hourMeterDateController.text = outputFormat.format(value!);
    // DateFormat.yMMMd().format(_pickedDate!);
    notifyListeners();
  }

  updateDeviceId(String? value) {
    deviceIdController.text = value!;
    notifyListeners();
  }

  getTotalDataDetails() {
    getPreviewDeviceDetails();
    getPlantDetails();
    getDealerDetails();
    getCustomerDetails();
    notifyListeners();
  }

  getPlantDetails() {
    PreviewData plantName =
        PreviewData(title: "Plant Name", value: plantDetail);
    _generalPlantDetails.add(plantName);
    PreviewData plantCodeValue =
        PreviewData(title: "Plant Code", value: plantCode);
    _generalPlantDetails.add(plantCodeValue);
    PreviewData plantEmailValue =
        PreviewData(title: "Plant Email", value: plantEmail);
    _generalPlantDetails.add(plantEmailValue);

    _totalList.add(_generalPlantDetails);
    notifyListeners();
  }

  getDealerDetails() {
    PreviewData dealerName =
        PreviewData(title: "Dealer Name", value: deviceNameController.text);
    _generalDealerDetails.add(dealerName);
    PreviewData dealerCode =
        PreviewData(title: "Dealer Code", value: deviceCodeController.text);
    _generalDealerDetails.add(dealerCode);
    PreviewData dealerEmailValue =
        PreviewData(title: "Dealer Email", value: deviceEmailController.text);
    _generalDealerDetails.add(dealerEmailValue);

    _totalList.add(_generalDealerDetails);
    notifyListeners();
  }

  getCustomerDetails() {
    PreviewData customerName =
        PreviewData(title: "Customer Name", value: customerNameController.text);
    _generalCustomerDetails.add(customerName);
    PreviewData customerCode =
        PreviewData(title: "Customer Code", value: customerCodeController.text);
    _generalCustomerDetails.add(customerCode);
    PreviewData customerEmailValue = PreviewData(
        title: "Customer Email", value: customerEmailController.text);
    _generalCustomerDetails.add(customerEmailValue);

    _totalList.add(_generalCustomerDetails);
    notifyListeners();
  }

  getPreviewDeviceDetails() {
    PreviewData deviceId =
        PreviewData(title: 'Device ID', value: deviceIdController.text);
    _previewDeviceDetails.add(
      deviceId,
    );
    PreviewData serialnumber =
        PreviewData(title: 'Serial Number', value: serialNumberController.text);
    _previewDeviceDetails.add(
      serialnumber,
    );

    PreviewData machineModel =
        PreviewData(title: 'Machine Model', value: _assetModel);
    _previewDeviceDetails.add(
      machineModel,
    );
    PreviewData hourMeterDate =
        PreviewData(title: 'HMR', value: hourMeterController.text);
    _previewDeviceDetails.add(
      hourMeterDate,
    );
    PreviewData hourMeter =
        PreviewData(title: 'HMR Date', value: hourMeterDateController.text);
    _previewDeviceDetails.add(
      hourMeter,
    );
    _totalList.add(previewDeviceDetails);
    notifyListeners();
  }

  subscriptionAssetRegistration() async {
    try {
      Logger().e(previewDeviceDetails[3].value!);
      AssetValues deviceAssetValues;
      deviceAssetValues = AssetValues(
        deviceId: previewDeviceDetails[0].value,
        machineSlNo: previewDeviceDetails[1].value,
        machineModel: previewDeviceDetails[2].value,
        hMRDate: previewDeviceDetails[4].value,
        hMR: previewDeviceDetails[3].value == ""
            ? 0
            : double.parse(previewDeviceDetails[3].value!).toInt(),
        plantName: generalPlantDetails[0].value == ""
            ? null
            : generalPlantDetails[0].value,
        plantCode: generalPlantDetails[1].value,
        plantEmailID: generalPlantDetails[2].value,
        customerName: generalCustomerDetails[0].value!.isEmpty
            ? null
            : generalCustomerDetails[0].value,
        customerCode: generalCustomerDetails[1].value!.isEmpty
            ? null
            : generalCustomerDetails[1].value,
        customerEmailID: generalCustomerDetails[2].value!.isEmpty
            ? null
            : generalCustomerDetails[2].value,
        dealerName: generalDealerDetails[0].value!.isEmpty
            ? null
            : generalDealerDetails[0].value,
        dealerCode: generalDealerDetails[1].value!.isEmpty
            ? null
            : generalDealerDetails[1].value,
        dealerEmailID: generalDealerDetails[2].value!.isEmpty
            ? null
            : generalDealerDetails[2].value,
        commissioningDate: null,
        primaryIndustry: null,
        secondaryIndustry: null,
      );
      _totalAssetValues.add(deviceAssetValues);
      var result = await _subscriptionService!
          .postSingleAssetRegistration(data: _totalAssetValues);
      _totalAssetValues.clear();
      onRegistrationSuccess();
      return result;
    } catch (e) {
      Logger().e(e.toString());
    }
  }

  onRegistrationSuccess() async {
    deviceCodeController.clear();
    deviceEmailController.clear();
    serialNumberController.clear();
    deviceIdController.clear();
    hourMeterController.clear();
    hourMeterDateController.clear();
    customerCodeController.clear();
    customerEmailController.clear();
    deviceNameController.clear();
    deviceIdController.clear();
    customerNameController.clear();
    _assetModel = "Select Asset Model";
    await getSubscriptionModelData();
    notifyListeners();
  }

  getSubcriptionDeviceListData(
      {required String name, int? code, String? type}) async {
    try {
      _detailResult.clear();
      _gpsDeviceId.clear();
      if (name.length >= 3) {
        deviceIdChange = await _subscriptionService!
            .getSubscriptionDeviceListData(
                filterType: filterType,
                filter: filter,
                name: name,
                start: pageNumber,
                limit: pageSize);

        if (deviceIdChange != null) {
          if (deviceIdChange!.result![1].isNotEmpty) {
            _detailResult.addAll(deviceIdChange!.result![1]);
            _loading = false;
            _loadingMore = false;
            gpsDeviceId.clear();
            deviceIdChange!.result![1].forEach((element) {
              if (gpsDeviceId.any((id) => id == element.GPSDeviceID)) {
              } else {
                gpsDeviceId.add(element.GPSDeviceID);
              }
            });
            notifyListeners();
            // _detailResult.forEach((element) {
            //   gpsDeviceId.add(element.GPSDeviceID);
            // });
          } else {
            //Fluttertoast.showToast(msg: "No Data Found");
            _devices.clear();
            detailResult.clear();
            gpsDeviceId.clear();
            notifyListeners();
            _loading = false;
            _loadingMore = false;
            _shouldLoadmore = false;
          }
          _loading = false;
          _loadingMore = false;
        }
      }
    } on DioError catch (e) {
      final error = DioException.fromDioError(e);
      Fluttertoast.showToast(msg: error.message!);
    }
  }

  getModelNamebySerialNumber(String value) async {
    try {
      if (value.length >= 7) {
        SerialNumberResults? results = await _subscriptionService!
            .getDeviceModelNameBySerialNumber(serialNumber: value);
        if (results != null) {
          String? assetModelName = results.result!.modelName;
          if (results.status == "success") {
            if (_assetModel != assetModelName) {
              _assetModel = assetModelName;
              modelNames.replace(0, _assetModel, modelNames);
              Logger().wtf(modelNames.length);
              isSerialNoisValid = false;
            }
          } else {
            _assetModel = "Select Asset Model";
            serialNumberController.clear();
            isSerialNoisValid = true;
            notifyListeners();
          }
        } else {
          return 'no results found';
        }
        notifyListeners();
      } else {
        isSerialNoisValid = false;
        notifyListeners();
        return;
      }
    } on DioError catch (e) {
      serialNumberController.clear();
      _assetModel = "Select Asset Model";
      modelNames.replace(0, _assetModel, modelNames);
      isSerialNoisValid = true;
      notifyListeners();
      Logger().w(e.toString());
      final error = DioException.fromDioError(e);
      //Fluttertoast.showToast(msg: error.message!);
    }
  }

  getSubscriptionModelData() async {
    try {
      Logger().i("getApplicationAccessData");
      SubscriptionDashboardResult? result =
          await _subscriptionService!.getResultsFromSubscriptionApi("");
      if (result == null) {
        Logger().d('no results found');
        _loading = false;
        return "no results found";
      } else {
        //model names
        for (var i = 0; i < result.result!.elementAt(2).length; i++) {
          if (i == 0) {
          } else {
            _modelNames.add(result.result!.elementAt(2)[i].modelName);
          }
        }

        _loading = false;
      }
      notifyListeners();
    } on DioError catch (e) {
      final error = DioException.fromDioError(e);
      Fluttertoast.showToast(msg: error.message!);
    }

    return _modelNames;
  }

  getSubcriptionDeviceListPerNameOrCode(
      {String? name, int? code, String? type}) async {
    SingleAssetRegistrationSearchModel? result =
        await _subscriptionService!.getSubscriptionDevicesListData(
      filterType: PLANTSUBSCRIPTIONFILTERTYPE.TYPE,
      start: pageNumberSecond,
      name: name,
      code: code,
      fitler: type,
      limit: pageSizeSecond,
    );

    if (result != null) {
      if (result.result!.isNotEmpty) {
        deviceDetails.addAll(result.result![1]);
        _loading = false;
        _loadingMore = false;

        deviceDetails.forEach((element) {
          deviceEmailController.text = element.Email!;
          deviceCodeController.text = element.Code!;
          deviceNameController.text = element.Name!;

          deviceCodeController.selection = TextSelection.fromPosition(
              TextPosition(offset: deviceCodeController.text.length));
          deviceEmailController.selection = TextSelection.fromPosition(
              TextPosition(offset: deviceEmailController.text.length));
          deviceNameController.selection = TextSelection.fromPosition(
              TextPosition(offset: deviceNameController.text.length));
        });

        _finalDeviceDetails.addAll([
          deviceCodeController.text,
          deviceEmailController.text,
          deviceNameController.text
        ]);

        notifyListeners();
      } else {
        _loading = false;
        _loadingMore = false;
        _shouldLoadmore = false;
        notifyListeners();
      }
      _loading = false;
      _loadingMore = false;
      notifyListeners();
    }
  }

  onSelectedDeviceId(String? value) {
    _detailResult.forEach((element) {
      if (element.GPSDeviceID == value) {
        deviceIdController.text = element.GPSDeviceID!;
        serialNumberController.text = element.VIN!;
        _gpsDeviceId.clear();
        notifyListeners();
      }
    });
  }

  onSelectedNameTile(String value) {
    _devices.forEach((element) {
      if (element.Name == value) {
        customerNameController.text = element.Name!;
        customerCodeController.text = element.Code!;
        customerEmailController.text = element.Email!;
        customerId.clear();
      }
    });
    notifyListeners();
  }

  onSelectedDealerNameTile(String value) {
    Logger().e(_devices.length);
    _devices.forEach((element) {
      if (element.Name == value) {
        deviceNameController.text = element.Name!;
        deviceCodeController.text = element.Code!;
        deviceEmailController.text = element.Email ?? "";
        _dealerId.clear();
        notifyListeners();
      }
    });
  }

  onSelectedDealerCodeTile(String value) {
    _devices.forEach((element) {
      if (element.Code == value) {
        deviceNameController.text = element.Name!;
        deviceCodeController.text = element.Code!;
        deviceEmailController.text = element.Email!;
        _dealerCode.clear();
        notifyListeners();
      }
    });
  }

  onSelectedCodeTile(String value) {
    Logger().e(value);
    _devices.forEach((element) {
      Logger().wtf(value);
      if (element.Code == value) {
        customerNameController.text = element.Name!;
        customerCodeController.text = element.Code!;
        customerEmailController.text = element.Email!;
        customerCode.clear();
        notifyListeners();
      }
    });
  }

  onCustomerNameChanges({String? name, String? type, int? code}) async {
    try {
      detailResultList.clear();
      if (name == null || name.isEmpty) {
        Future.delayed(Duration(seconds: 3), () {
          _customerId.clear();
          notifyListeners();
        });
      } else {
        _customerId.clear();
        _customerCode.clear();
        _devices.clear();
        if (name.length >= 3) {
          customerNameChange =
              await (_subscriptionService!.getSubscriptionDevicesListData(
            filterType: PLANTSUBSCRIPTIONFILTERTYPE.TYPE,
            start: pageNumber,
            name: name,
            code: code,
            fitler: type,
            limit: pageSize,
          ));
          if (customerNameChange!.result![1].isNotEmpty) {
            customerNameChange!.result![1].forEach((element) {
              _devices.add(element);
              _customerId.add(element.Name);
              notifyListeners();
            });
          } else {
            //Fluttertoast.showToast(msg: "No Data Found");
            _devices.clear();
            detailResult.clear();
            _customerId.clear();
            notifyListeners();
          }
        }
      }
    } on DioError catch (e) {
      final error = DioException.fromDioError(e);
      Fluttertoast.showToast(msg: error.message!);
    }
  }

  onDealerNameChanges({String? name, String? type, int? code}) async {
    try {
      detailResultList.clear();
      if (name == null || name.isEmpty) {
        Future.delayed(Duration(seconds: 3), () {
          _dealerId.clear();
          notifyListeners();
        });
      } else {
        _devices.clear();
        _dealerId.clear();
        _dealerCode.clear();
        if (name.length >= 3) {
          dealerNameChange =
              await (_subscriptionService!.getSubscriptionDevicesListData(
            filterType: PLANTSUBSCRIPTIONFILTERTYPE.TYPE,
            start: pageNumber,
            name: name,
            code: code,
            fitler: type,
            limit: pageSize,
          ));
          if (dealerNameChange!.result![1].isNotEmpty) {
            dealerNameChange!.result![1].forEach((element) {
              _devices.add(element);
              _dealerId.add(element.Name);
              notifyListeners();
            });
          } else {
            _isShowingHelper = true;
            _devices.clear();
            detailResult.clear();
            _dealerId.clear();
            notifyListeners();
          }
        }
      }
    } on DioError catch (e) {
      final error = DioException.fromDioError(e);
      Fluttertoast.showToast(msg: error.message!);
    }
  }

  onDealerCodeChanges({String? name, String? type, dynamic code}) async {
    try {
      detailResultList.clear();
      if (code == null || code.toString().isEmpty) {
        Future.delayed(Duration(seconds: 3), () {
          _dealerCode.clear();
          notifyListeners();
        });
      } else {
        _devices.clear();
        _dealerCode.clear();
        _dealerId.clear();

        if (code.toString().length >= 3) {
          dealerCodeChange =
              await (_subscriptionService!.getSubscriptionDevicesListData(
            filterType: PLANTSUBSCRIPTIONFILTERTYPE.TYPE,
            start: pageNumber,
            name: name,
            code: code,
            fitler: type,
            limit: pageSize,
          ));
          if (dealerCodeChange!.result![1].isNotEmpty) {
            dealerCodeChange!.result![1].forEach((element) {
              _devices.add(element);
              _dealerCode.add(element.Code);
              notifyListeners();
            });
          } else {
            //Fluttertoast.showToast(msg: "New Dealer Code");
            _devices.clear();
            _dealerCode.clear();
            detailResult.clear();
            notifyListeners();
          }
        }
      }
    } on DioError catch (e) {
      final error = DioException.fromDioError(e);
      Fluttertoast.showToast(msg: error.message!);
    }
  }

  onCustomerCodeChanges({String? name, String? type, int? code}) async {
    try {
      detailResultList.clear();
      if (code == null) {
        Logger().e("if");
        Future.delayed(Duration(seconds: 3), () {
          _customerCode.clear();
          notifyListeners();
        });
      } else {
        _customerCode.clear();
        _devices.clear();
        if (code.toString().length >= 3) {
          customerCodeChange =
              await _subscriptionService!.getSubscriptionDevicesListData(
            filterType: PLANTSUBSCRIPTIONFILTERTYPE.TYPE,
            start: pageNumber,
            name: name,
            code: code,
            fitler: type,
            limit: pageSize,
          );
          if (code == null) {
            return;
          } else {
            if (customerCodeChange!.result![1].isEmpty) {
              _customerCode.clear();
              snackbarService!.showSnackbar(
                message: "No Data Found",
                duration: Duration(seconds: 1),
              );
              notifyListeners();
            } else {
              if (customerCodeChange!.result![1].isNotEmpty) {
                customerCodeChange!.result![1].forEach((element) {
                  _devices.add(element);
                  _customerCode.add(element.Code);
                  notifyListeners();
                });
              } else {
                //Fluttertoast.showToast(msg: "No Data Found");
                _devices.clear();
                detailResult.clear();
                customerCode.clear();
                notifyListeners();
              }
            }
          }
        }
      }
    } on DioError catch (e) {
      final error = DioException.fromDioError(e);
      Fluttertoast.showToast(msg: error.message!);
    }
  }

  getSubcriptionListOfNameAndCode(
      {String? name, int? code, String? type}) async {
    if (name == null || name.isEmpty) {
      customerCode.clear();
      _customerId.clear();
      customerId.clear();
      customerEmail.clear();
      name = null;
      notifyListeners();
    } else {
      SingleAssetRegistrationSearchModel? result =
          await _subscriptionService!.getSubscriptionDevicesListData(
        filterType: PLANTSUBSCRIPTIONFILTERTYPE.TYPE,
        start: pageNumber,
        name: name,
        code: code,
        fitler: type,
        limit: pageSize,
      );

      if (result != null) {
        if (result.result![1].isNotEmpty) {
          customerDetails.addAll(result.result![1]);

          customerDetails.forEach((element) {
            customerId.add(element.Name);
            customerCode.add(element.Code);
            customerEmail.add(element.Email);
          });

          notifyListeners();
        } else {
          //  Fluttertoast.showToast(msg: "No Data Found");
          _devices.clear();
          detailResult.clear();
          _loading = false;
          _loadingMore = false;
          _shouldLoadmore = false;
          notifyListeners();
        }
        _loading = false;
        _loadingMore = false;
        notifyListeners();
      }
    }
  }

  updateSelectedName(String value) {
    customerNameController.text = value;
    notifyListeners();
  }

  updateSelectedCode(String value) {
    customerCodeController.text = value;
    notifyListeners();
  }

  filterCustomerDetails(String value) {
    customerDetails.forEach((element) {
      if (value.toLowerCase() == element.Name!.toLowerCase()) {
        Logger().e('codet${element.Code}');
        customerCodeController.text = element.Code!;
        customerEmailController.text = element.Email!;
        Logger().wtf('code: ${element.Code}');
        notifyListeners();
      } else if (value == element.Code) {
        customerNameController.text = element.Name!;
        customerEmailController.text = element.Email!;
        customerCodeController.text = element.Code!;

        notifyListeners();
      }
      //  return false;
    });
    notifyListeners();
  }

  filterDealerCode(String value) {
    customerDetails.forEach((element) {
      if (value.toLowerCase() == element.Code!.toLowerCase()) {
        deviceNameController.text = element.Code!;
        deviceEmailController.text = element.Email!;
        notifyListeners();
      }
    });
  }

  filterDealerName(String value) {
    customerDetails.forEach((element) {
      if (value.toLowerCase() == element.Name!.toLowerCase()) {
        deviceCodeController.text = element.Code!;
        deviceEmailController.text = element.Email!;
        notifyListeners();
      }
    });
  }

  onTappingCustomerName() {
    String data;

    customerCodetype = true;
    customerNameType = false;
    customerCodeController.clear();
    customerEmailController.clear();
    customerNameController.clear();
    notifyListeners();
  }

  onTappingCustomerCode() {
    Logger().wtf("customerCode tapped");
    Logger().w(customerNameController.text);
    customerNameType = true;
    customerCodetype = false;
    customerNameController.clear();
    customerEmailController.clear();
    customerCodeController.clear();
    notifyListeners();
  }

  onPop() {
    totalList[0].clear();
    totalList[1].clear();
    totalList[2].clear();
    totalList[3].clear();
    totalList.clear();
    notifyListeners();
  }
}

enum FieldType {
  CUSTOMERCODE,
  CUSTOMERNAME,
  DEVICEID,
}

extension on List<dynamic> {
  Future replace(int int, dynamic value, List listData) async {
    try {
      if (value.runtimeType == listData.first.runtimeType) {
        listData.remove(value);
        for (var i = 0; i < listData.length; i++) {
          if (i == int) {
            listData[i] = value;
          }
        }
      } else {
        throw Exception("Type Error");
      }
    } catch (e) {
      Logger().e(e.toString());
    }
  }
}