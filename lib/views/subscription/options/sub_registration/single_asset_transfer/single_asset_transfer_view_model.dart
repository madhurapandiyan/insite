import 'dart:async';

import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:insite/core/base/insite_view_model.dart';
import 'package:insite/core/locator.dart';
import 'package:insite/core/models/add_asset_registration.dart';
import 'package:insite/core/models/add_asset_transfer.dart';
import 'package:insite/core/models/device_details_per_id.dart';
import 'package:insite/core/models/get_asset_details_by_serial_no.dart';
import 'package:insite/core/models/get_single_transfer_device_id.dart';
import 'package:insite/core/models/hierarchy_model.dart';
import 'package:insite/core/models/prefill_customer_details.dart';
import 'package:insite/core/models/preview_data.dart';
import 'package:insite/core/services/subscription_service.dart';
import 'package:insite/utils/enums.dart';
import 'package:insite/views/adminstration/addgeofense/exception_handle.dart';
import 'package:intl/intl.dart';
import 'package:logger/logger.dart';
import 'package:insite/core/logger.dart';

class SingleAssetTransferViewModel extends InsiteViewModel {
  Logger? log;

  bool _allowTransferAsset = false;
  bool get allowTransferAsset => _allowTransferAsset;

  bool _enableCustomerDetails = true;
  bool get enableCustomerDetails => _enableCustomerDetails;

  SubScriptionService? _subscriptionService = locator<SubScriptionService>();

  int start = 0;
  int limit = 100;

  String? _filter;
  String? get filter => _filter;

  PLANTSUBSCRIPTIONFILTERTYPE? _filterType;
  PLANTSUBSCRIPTIONFILTERTYPE? get filterType => _filterType;

  List<String?> _gpsDeviceIdList = [];
  List<String?> get gpsDeviceIdList => _gpsDeviceIdList;

  List<String?> _serialNoList = [];
  List<String?> get serialNoList => _serialNoList;

  List<Result> _deviceList = [];
  List<Result> get deviceList => _deviceList;

  List<ResultData> _deviceValues = [];
  List<ResultData> get deviceValues => _deviceValues;

  List<ResultsValues> _serialValues = [];
  List<ResultsValues> get serialValues => _serialValues;

  List<String> _deviceDetail = [];
  List<String> get deviceDetail => _deviceDetail;

  List<HierarchyModel> _devices = [];
  List<HierarchyModel> get devices => _devices;

  List<HierarchyModel> _deviceListData = [];
  List<HierarchyModel> get deviceListData => _deviceListData;

  List<String?> _dealerName = [];
  List<String?> get dealerName => _dealerName;

  List<String?> _dealerCode = [];
  List<String?> get dealerCode => _dealerCode;

  DateTime? _pickedDate = DateTime.now();
  DateTime? get pickedDate => _pickedDate;

  bool _loading = true;
  bool get loading => _loading;

  bool _showSubIndustry = false;
  bool get showSubIndustry => _showSubIndustry;

  bool _loadingMore = false;
  bool get loadingMore => _loadingMore;

  bool _fillCustomerDetails = false;
  bool get fillCustomerDetails => _fillCustomerDetails;

  String _initialLanguage = "Select Language";
  String get initialLanguge => _initialLanguage;

  String _initialCustLanguage = "Select Language";
  String get initialCustLanguge => _initialCustLanguage;

  List<String> _languages = ["Select Language", "ENGLISH", "HINDI"];
  List<String> get languages => _languages;

  String _initialIndustryDetail = "Select Industry Details";
  String get initialIndustryDetail => _initialIndustryDetail;

  List<String> _industryDetails = [
    "Select Industry Details",
    "Agriculture",
    "Bricks sand Loading",
    "Building Construction",
    "Canal Work",
    "Crusher",
    "Dealer or Manufacturer Affiliated Rental",
    "Demolition & Recycling of Construction Materials",
    "Forestry",
    "Government",
    "Independent Rental",
    "industrial & commercial Material Handling",
    "Infrastructure-Transportation",
    "Infrastructure - Utilities & Other civil Engineering",
    "LandScaping/Gardening",
    "Mining and Quarrying",
    "Railway Work",
    "Rental Work",
    "TarPlant",
    "Use not yet known(auction & Brokerage firms)",
    "Waste management"
  ];
  List<String> get industryDetails => _industryDetails;

  List<String> _popUpCardTitles = [
    "Entity Details",
    "Dealer Details",
    "Customer Details",
    "Industry Details"
  ];
  List<String> get popUpCardTitles => _popUpCardTitles;

  List<Transfer> _totalTransferValues = [];
  List<Transfer> get totalTransferValues => _totalTransferValues;

  List<List<PreviewData>> _totalList = [];
  List<List<PreviewData>> get totalList => _totalList;

  List<PreviewData> _previewEntityDetails = [];
  List<PreviewData> get previewEntityDetails => _previewEntityDetails;

  List<PreviewData> _generalIndustryDetails = [];
  List<PreviewData> get generalIndustryDetails => _generalIndustryDetails;

  List<PreviewData> _generalDealerDetails = [];
  List<PreviewData> get generalDealerDetails => _generalDealerDetails;

  List<PreviewData> _generalCustomerDetails = [];
  List<PreviewData> get generalCustomerDetails => _generalCustomerDetails;

  List<String?> _dealerId = [];
  List<String?> get dealerId => _dealerId;

  List<String?> _customerId = [];
  List<String?> get customerId => _customerId;

  List<String?> _customerCode = [];
  List<String?> get customerCode => _customerCode;

  List<AssetValues> _totalAssetValues = [];
  List<AssetValues> get totalAssetValues => _totalAssetValues;

  int pageNumber = 0;
  int pageSize = 100;

  List<HierarchyModel> detailResultList = [];

  TextEditingController deviceIdController = TextEditingController();
  TextEditingController machineSerialNumberController = TextEditingController();
  TextEditingController machineModelController = TextEditingController();
  TextEditingController commisioningDateController = TextEditingController();
  TextEditingController dealerNameController = TextEditingController();
  TextEditingController dealerCodeController = TextEditingController();
  TextEditingController dealerEmailController = TextEditingController();
  TextEditingController dealerMobileNoController = TextEditingController();
  TextEditingController customerNameController = TextEditingController();
  TextEditingController customerCodeController = TextEditingController();
  TextEditingController customerEmailController = TextEditingController();
  TextEditingController customerMobileNoController = TextEditingController();

  SingleAssetTransferViewModel() {
    this.log = getLogger(this.runtimeType.toString());
    Future.delayed(Duration(seconds: 1), () {});
  }

  allowAssetTransferClicked() {
    _allowTransferAsset = !_allowTransferAsset;
    _enableCustomerDetails = !_enableCustomerDetails;

    notifyListeners();
  }

  updateLanguage(String value) {
    _initialLanguage = value;
    notifyListeners();
  }

  updateCustomerLanguage(String value) {
    _initialCustLanguage = value;
    notifyListeners();
  }

  updateIndustry(String value) {
    _initialIndustryDetail = value;
    _showSubIndustry = true;

    notifyListeners();
  }

  getTotalDataDetails() {
    getEntityDetails();
    getDealerDetails();
    getCustomerDetails();
    getPreviewIndutryDetails();
    notifyListeners();
  }

  subscriptionAssetTransfer() async {
    Transfer deviceTransferValues;
    deviceTransferValues = Transfer(
        deviceId: previewEntityDetails[0].value,
        machineModel: previewEntityDetails[2].value,
        hMR: null,
        hMRDate: null,
        plantCode: null,
        plantEmailID: null,
        plantName: null,
        primaryIndustry: generalIndustryDetails[0].value,
        secondaryIndustry: generalIndustryDetails[0].value,
        dealerLanguage: generalDealerDetails[4].value,
        dealerMobile: generalDealerDetails[3].value,
        customerLanguage: generalCustomerDetails[4].value,
        customerMobile: generalCustomerDetails[3].value,
        machineSlNo: previewEntityDetails[1].value,
        commissioningDate: previewEntityDetails[3].value,
        dealerName: generalDealerDetails[0].value,
        dealerCode: generalDealerDetails[1].value,
        dealerEmailID: generalDealerDetails[2].value,
        customerName: generalCustomerDetails[0].value,
        customerCode: generalCustomerDetails[1].value,
        customerEmailID: generalCustomerDetails[2].value);
    _totalTransferValues.add(deviceTransferValues);

    var result = await _subscriptionService!.postSingleTransferRegistration(
        transferData: _totalTransferValues);

    notifyListeners();
    return result;
  }

  getEntityDetails() {
    PreviewData deviceId =
        PreviewData(title: "Device Id", value: deviceIdController.text);
    _previewEntityDetails.add(deviceId);

    PreviewData serialNumber = PreviewData(
        title: "Serial Number", value: machineSerialNumberController.text);
    _previewEntityDetails.add(serialNumber);
    PreviewData machineModel =
        PreviewData(title: "Machine Model", value: machineModelController.text);
    _previewEntityDetails.add(machineModel);

    PreviewData commissioningDate =
        PreviewData(title: "HMR Date", value: commisioningDateController.text);
    _previewEntityDetails.add(commissioningDate);

    _totalList.add(_previewEntityDetails);
    notifyListeners();
  }

  getDealerDetails() {
    PreviewData dealerName =
        PreviewData(title: "Dealer Name", value: dealerNameController.text);
    _generalDealerDetails.add(dealerName);
    PreviewData dealerCode =
        PreviewData(title: "Dealer Code", value: dealerCodeController.text);
    _generalDealerDetails.add(dealerCode);
    PreviewData dealerEmailValue =
        PreviewData(title: "Dealer Email", value: dealerEmailController.text);
    _generalDealerDetails.add(dealerEmailValue);

    PreviewData dealerMobileNoValue = PreviewData(
        title: "Dealer Mobile Number", value: dealerMobileNoController.text);
    _generalDealerDetails.add(dealerMobileNoValue);
    PreviewData dealerMobileLanguage =
        PreviewData(title: "Dealer Mobile Language", value: _initialLanguage);
    _generalDealerDetails.add(dealerMobileLanguage);

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
    PreviewData customerMobileNo = PreviewData(
        title: "Customer Mobile Number",
        value: customerMobileNoController.text);
    _generalCustomerDetails.add(customerMobileNo);
    PreviewData customerMobileLanguage = PreviewData(
        title: "Customer Mobile Language", value: _initialCustLanguage);
    _generalCustomerDetails.add(customerMobileLanguage);

    _totalList.add(_generalCustomerDetails);
    notifyListeners();
  }

  getPreviewIndutryDetails() {
    PreviewData primary =
        PreviewData(title: 'Primary Industry', value: _initialIndustryDetail);
    _generalIndustryDetails.add(primary);
    PreviewData secondary =
        PreviewData(title: 'Secondary Industry', value: _initialIndustryDetail);
    _generalIndustryDetails.add(secondary);

    _totalList.add(_generalIndustryDetails);
    notifyListeners();
  }

  getSelectedDate(DateTime? value) {
    _pickedDate = value;
    commisioningDateController.text = DateFormat.yMMMd().format(_pickedDate!);
    notifyListeners();
  }

  filterCustomerDeatails(String value) {
    devices.forEach((element) {
      if (value.toLowerCase() == element.Name!.toLowerCase()) {
        Logger().e('codet${element.Code}');

        customerCodeController.text = element.Code!;
        customerEmailController.text = element.Email!;
      } else if (value == element.Code) {
        customerNameController.text = element.Name!;
        customerEmailController.text = element.Email!;
        customerCodeController.text = element.Code!;
      }
     // return false;
    });
    notifyListeners();
  }

  filterDealerDetails(String value) {
    devices.forEach((element) {
      if (value.toLowerCase() == element.Name!.toLowerCase()) {
        Logger().e('codet${element.Code}');

        dealerCodeController.text = element.Code!;
        dealerEmailController.text = element.Email!;

        Logger().wtf('code: ${element.Code}');
      } else if (value == element.Code) {
        dealerNameController.text = element.Name!;
        dealerEmailController.text = element.Email!;
        dealerCodeController.text = element.Code!;
      }
      //return false;
    });
    notifyListeners();
  }

  getCustomerDetailValues(String deviceID) async {
    CustomerDetails result =
        await (_subscriptionService!.getCustomerDetails(deviceID) as Future<CustomerDetails>);

    customerCodeController.text = result.customerResult!.customerData!.code!;
    customerEmailController.text = result.customerResult!.customerData!.email!;
    customerNameController.text = result.customerResult!.customerData!.name!;
  }

  getDealerNamesData({String? name, int? code, String? type}) async {
    SingleAssetRegistrationSearchModel? result =
        await _subscriptionService!.getSubscriptionDevicesListData(
      fitler: type,
      start: start == 0 ? start : start + 1,
      limit: limit,
      name: name,
      code: code,
      filterType: PLANTSUBSCRIPTIONFILTERTYPE.TYPE,
    );
    if (result != null) {
      if (result.result!.isNotEmpty) {
        devices.addAll(result.result![1]);
        deviceListData.addAll(result.result![1]);

        _loading = false;
        _loadingMore = false;

        devices.forEach((element) {
          dealerName.add(element.Name);
          dealerCode.add(element.Code);
        });
      } else {
        _loading = false;
        _loadingMore = false;
      }
      _loading = false;
      _loadingMore = false;
      notifyListeners();
    }
  }

  onSelectedNameTile(String value) {
    Logger().e(value);
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

  onSelectedDealerNameTile(String value) {
    Logger().e(_devices.length);
    _devices.forEach((element) {
      if (element.Name == value) {
        dealerNameController.text = element.Name!;
        dealerCodeController.text = element.Code!;
        dealerEmailController.text = element.Email!;
        _dealerId.clear();
        notifyListeners();
      }
    });
  }

  onSelectedDealerCodeTile(String value) {
    _devices.forEach((element) {
      if (element.Code == value) {
        dealerNameController.text = element.Name!;
        dealerCodeController.text = element.Code!;
        dealerEmailController.text = element.Email!;
        _dealerCode.clear();
        notifyListeners();
      }
    });
  }

  onSelectedDeviceId(String value) {
    _deviceList.forEach((element) {
      if (element.gPSDeviceID == value) {
        deviceIdController.text = element.gPSDeviceID!;
        machineSerialNumberController.text = element.vIN!;
        _gpsDeviceIdList.clear();
        notifyListeners();
      }
    });
  }

  onSelectedSerialNo(String value) {
    _deviceList.forEach((element) {
      if (element.vIN == value) {
        deviceIdController.text = element.gPSDeviceID!;
        machineSerialNumberController.text = element.vIN!;
        _serialNoList.clear();
        notifyListeners();
      }
    });
  }

  onCustomerNameChanges({String? name, String? type, int? code}) async {
    try {
      detailResultList.clear();
      if (name == null || name.isEmpty) {
        Logger().e("if");
        Future.delayed(Duration(seconds: 3), () {
          _customerId.clear();
          notifyListeners();
        });
      } else {
        _customerId.clear();
        _devices.clear();
        Logger().e("type");
        if (name.length >= 3) {
          SingleAssetRegistrationSearchModel result =
              await (_subscriptionService!.getSubscriptionDevicesListData(
            filterType: PLANTSUBSCRIPTIONFILTERTYPE.TYPE,
            start: pageNumber,
            name: name,
            code: code,
            fitler: type,
            limit: pageSize,
          ) as Future<SingleAssetRegistrationSearchModel>);
          if (result.result![1].isNotEmpty) {
            result.result![1].forEach((element) {
              _devices.add(element);
              _customerId.add(element.Name);
              notifyListeners();
            });
          } else {
            Fluttertoast.showToast(msg: "No Data Found");
            _customerId.clear();
            _devices.clear();
            detailResultList.clear();
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
      if (code == null || code.toString().isEmpty) {
        Future.delayed(Duration(seconds: 3), () {
          _customerCode.clear();
          notifyListeners();
        });
      } else {
        _customerCode.clear();
        _devices.clear();
        if (code.toString().length >= 3) {
          SingleAssetRegistrationSearchModel result =
              await (_subscriptionService!.getSubscriptionDevicesListData(
            filterType: PLANTSUBSCRIPTIONFILTERTYPE.TYPE,
            start: pageNumber,
            name: name,
            code: code,
            fitler: type,
            limit: pageSize,
          ) as FutureOr<SingleAssetRegistrationSearchModel>);
          if (result.result![1].isNotEmpty) {
            result.result![1].forEach((element) {
              _devices.add(element);
              _customerCode.add(element.Code);
              notifyListeners();
            });
          } else {
            Fluttertoast.showToast(msg: "No Data Found");
            _customerCode.clear();
            _devices.clear();
            detailResultList.clear();
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
        Logger().e("if");
        Future.delayed(Duration(seconds: 3), () {
          _dealerId.clear();
          notifyListeners();
        });
      } else {
        _devices.clear();
        _dealerId.clear();
        Logger().e("type");
        if (name.length >= 3) {
          SingleAssetRegistrationSearchModel result =
              await (_subscriptionService!.getSubscriptionDevicesListData(
            filterType: PLANTSUBSCRIPTIONFILTERTYPE.TYPE,
            start: pageNumber,
            name: name,
            code: code,
            fitler: type,
            limit: pageSize,
          ) as FutureOr<SingleAssetRegistrationSearchModel>);
          if (result.result![1].isNotEmpty) {
            result.result![1].forEach((element) {
              _devices.add(element);
              _dealerId.add(element.Name);
              notifyListeners();
            });
          } else {
            Fluttertoast.showToast(msg: "No Data Found");
            _dealerId.clear();
            _devices.clear();
            detailResultList.clear();
            notifyListeners();
          }
        }
      }
    } on DioError catch (e) {
      final error = DioException.fromDioError(e);
      Fluttertoast.showToast(msg: error.message!);
    }
  }

  onDealerCodeChanges({String? name, String? type, int? code}) async {
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

        if (code.toString().length >= 3) {
          SingleAssetRegistrationSearchModel result =
              await (_subscriptionService!.getSubscriptionDevicesListData(
            filterType: PLANTSUBSCRIPTIONFILTERTYPE.TYPE,
            start: pageNumber,
            name: name,
            code: code,
            fitler: type,
            limit: pageSize,
          ) as FutureOr<SingleAssetRegistrationSearchModel>);
          if (result.result![1].isNotEmpty) {
            result.result![1].forEach((element) {
              _devices.add(element);
              _dealerCode.add(element.Code);
              notifyListeners();
            });
          } else {
            Fluttertoast.showToast(msg: "No Data Found");
            _devices.clear();
            _dealerCode.clear();
            detailResultList.clear();
            notifyListeners();
          }
        }
      }
    } on DioError catch (e) {
      final error = DioException.fromDioError(e);
      Fluttertoast.showToast(msg: error.message!);
    }
  }

  updateSerialNumberValues(String text) async {
    machineSerialNumberController.text = text;

    AssetDetailsBySerialNo? detailsPerSerialNo = await _subscriptionService!
        .getDeviceAssetDetailsBySerialNo(machineSerialNumberController.text);

    if (detailsPerSerialNo != null) {
      if (detailsPerSerialNo.result!.isNotEmpty) {
        serialValues.addAll(detailsPerSerialNo.result!);

        _loading = false;
        _loadingMore = false;

        serialValues.forEach((element) {
          deviceIdController.text = element.deviceId!;
          machineModelController.text = element.model!;
        });

        Logger().wtf(_deviceDetail);
      } else {
        _loading = false;
        _loadingMore = false;
      }
      _loading = false;
      _loadingMore = false;
    }

    notifyListeners();
  }

  updateDeviceIdValues(String text) async {
    deviceIdController.text = text;

    DeviceDetailsPerId? detailsPerId = await _subscriptionService!
        .getDeviceDetailsPerDeviceId(deviceIdController.text);

    if (detailsPerId != null) {
      if (detailsPerId.result!.isNotEmpty) {
        deviceValues.addAll(detailsPerId.result!);

        _loading = false;
        _loadingMore = false;

        deviceValues.forEach((element) {
          machineSerialNumberController.text = element.serialNo!;
          machineModelController.text = element.model!;
        });

        Logger().wtf(_deviceDetail);
      } else {
        _loading = false;
        _loadingMore = false;
      }
      _loading = false;
      _loadingMore = false;
    }

    notifyListeners();
  }

  getSerialNumbers(String text) async {
    try {
      if (text.length > 3) {
        SingleTransferDeviceId serialNoResults =
            await (_subscriptionService!.getSingleTransferDeviceId(
                filter: "asset",
                filterType: PLANTSUBSCRIPTIONFILTERTYPE.TYPE,
                controllerValue: text,
                start: start == 0 ? start : start + 1,
                limit: limit,
                searchBy: "VIN") as FutureOr<SingleTransferDeviceId>);

        if (serialNoResults != null) {
          if (serialNoResults.result!.isNotEmpty) {
            deviceList.addAll(serialNoResults.result!);

            _loading = false;
            _loadingMore = false;

            deviceList.forEach((element) {
              _serialNoList.add(element.vIN);
            });
          } else {
            _loading = false;
            _loadingMore = false;
          }
          _loading = false;
          _loadingMore = false;
        }
        Logger().wtf(serialNoResults.result!.first.vIN);
        notifyListeners();
      }
    } on DioError catch (e) {
      final error = DioException.fromDioError(e);
      Fluttertoast.showToast(msg: error.message!);
    }
  }

  getDeviceIds(String text) async {
    try {
      if (text.length >= 3) {
        SingleTransferDeviceId deviceIdResults =
            await (_subscriptionService!.getSingleTransferDeviceId(
                filter: "asset",
                filterType: PLANTSUBSCRIPTIONFILTERTYPE.TYPE,
                controllerValue: text,
                start: start == 0 ? start : start + 1,
                limit: limit,
                searchBy: "GPSDeviceID") as FutureOr<SingleTransferDeviceId>);

        if (deviceIdResults != null) {
          if (deviceIdResults.result!.isNotEmpty) {
            deviceList.addAll(deviceIdResults.result!);

            _loading = false;
            _loadingMore = false;

            deviceList.forEach((element) {
              _gpsDeviceIdList.add(element.gPSDeviceID);
            });
          } else {
            _loading = false;
            _loadingMore = false;
          }
          _loading = false;
          _loadingMore = false;
        }
        Logger().wtf(deviceIdResults.result!.first.gPSDeviceID);
        notifyListeners();
      }
    } on DioError catch (e) {
      final error = DioException.fromDioError(e);
      Fluttertoast.showToast(msg: error.message!);
    }
  }

  subscriptionAssetRegistration() async {
    try {
      AssetValues deviceAssetValues;
      deviceAssetValues = AssetValues(
        CustomerLanguage: initialCustLanguge,
        CustomerMobile: customerMobileNoController.text,
        DealerMobile: dealerMobileNoController.text,
        DealerLanguage: initialLanguge,
        deviceId: deviceIdController.text,
        machineSlNo: machineSerialNumberController.text,
        machineModel: machineModelController.text,
        customerName: customerNameController.text,
        customerCode: customerCodeController.text,
        customerEmailID: customerEmailController.text,
        dealerName: dealerNameController.text,
        dealerCode: dealerCodeController.text,
        dealerEmailID: dealerEmailController.text,
        commissioningDate: null,
        primaryIndustry: initialIndustryDetail,
        secondaryIndustry: null,
      );
      _totalAssetValues.add(deviceAssetValues);
      AddAssetRegistrationData data = AddAssetRegistrationData(
          source: "THC",
          version: "2.1",
          userID: 58839,
          asset: _totalAssetValues);

      var result =
          await _subscriptionService!.postSingleAssetTransferRegistration(data);
      Logger().e(result);
      return result;
    } on DioError catch (e) {
      final error = DioException.fromDioError(e);
      Fluttertoast.showToast(msg: error.message!);
    }
  }
}
