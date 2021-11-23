import 'package:flutter/cupertino.dart';
import 'package:insite/core/base/insite_view_model.dart';
import 'package:insite/core/locator.dart';
import 'package:insite/core/models/device_details_per_id.dart';
import 'package:insite/core/models/get_asset_details_by_serial_no.dart';
import 'package:insite/core/models/get_single_transfer_device_id.dart';
import 'package:insite/core/models/prefill_customer_details.dart';
import 'package:insite/core/models/preview_data.dart';
import 'package:insite/core/models/subscription_dashboard_details.dart';
import 'package:insite/core/services/subscription_service.dart';
import 'package:insite/utils/enums.dart';
import 'package:intl/intl.dart';
import 'package:logger/logger.dart';
import 'package:stacked/stacked.dart';
import 'package:insite/core/logger.dart';

class SingleAssetTransferViewModel extends InsiteViewModel {
  Logger log;

  bool _allowTransferAsset = false;
  bool get allowTransferAsset => _allowTransferAsset;

  bool _enableCustomerDetails = true;
  bool get enableCustomerDetails => _enableCustomerDetails;

  var _subscriptionService = locator<SubScriptionService>();

  int start = 0;
  int limit = 100;

  String _filter;
  String get filter => _filter;

  PLANTSUBSCRIPTIONFILTERTYPE _filterType;
  PLANTSUBSCRIPTIONFILTERTYPE get filterType => _filterType;

  List<String> _gpsDeviceIdList = [];
  List<String> get gpsDeviceIdList => _gpsDeviceIdList;

  List<String> _serialNoList = [];
  List<String> get serialNoList => _serialNoList;

  List<Result> _deviceList = [];
  List<Result> get deviceList => _deviceList;

  List<ResultData> _deviceValues = [];
  List<ResultData> get deviceValues => _deviceValues;

  List<ResultsValues> _serialValues = [];
  List<ResultsValues> get serialValues => _serialValues;

  List<String> _deviceDetail = [];
  List<String> get deviceDetail => _deviceDetail;

  List<DetailResult> _devices = [];
  List<DetailResult> get devices => _devices;

  List<DetailResult> _deviceListData = [];
  List<DetailResult> get deviceListData => _deviceListData;

  List<String> _dealerName = [];
  List<String> get dealerName => _dealerName;

  List<String> _dealerCode = [];
  List<String> get dealerCode => _dealerCode;

  DateTime _pickedDate = DateTime.now();
  DateTime get pickedDate => _pickedDate;

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
    PreviewData commissioningDate =
        PreviewData(title: "HMR Date", value: commisioningDateController.text);
    _generalDealerDetails.add(commissioningDate);

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

  getSelectedDate(DateTime value) {
    _pickedDate = value;
    commisioningDateController.text = DateFormat.yMMMd().format(_pickedDate);
    notifyListeners();
  }

  filterCustomerDeatails(String value) {
    devices.forEach((element) {
      if (value.toLowerCase() == element.Name.toLowerCase()) {
        Logger().e('codet${element.Code}');

        customerCodeController.text = element.Code;
        customerEmailController.text = element.Email;
      } else if (value == element.Code) {
        customerNameController.text = element.Name;
        customerEmailController.text = element.Email;
        customerCodeController.text = element.Code;
      }
      return false;
    });
    notifyListeners();
  }

  filterDealerDetails(String value) {
    devices.forEach((element) {
      if (value.toLowerCase() == element.Name.toLowerCase()) {
        Logger().e('codet${element.Code}');

        dealerCodeController.text = element.Code;
        dealerEmailController.text = element.Email;

        Logger().wtf('code: ${element.Code}');
      } else if (value == element.Code) {
        dealerNameController.text = element.Name;
        dealerEmailController.text = element.Email;
        dealerCodeController.text = element.Code;
      }
      return false;
    });
    notifyListeners();
  }

  getCustomerDetailValues(String deviceID) async {
    CustomerDetails result =
        await _subscriptionService.getCustomerDetails(deviceID);

    customerCodeController.text = result.customerResult.customerData.code;
    customerEmailController.text = result.customerResult.customerData.email;
    customerNameController.text = result.customerResult.customerData.name;
  }

  getDealerNamesData({String name, int code, String type}) async {
    SubscriptionDashboardDetailResult result =
        await _subscriptionService.getSubscriptionDevicesListData(
      fitler: type,
      start: start == 0 ? start : start + 1,
      limit: limit,
      name: name,
      code: code,
      filterType: PLANTSUBSCRIPTIONFILTERTYPE.TYPE,
    );
    if (result != null) {
      if (result.result.isNotEmpty) {
        devices.addAll(result.result[1]);
        deviceListData.addAll(result.result[1]);

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

  updateSerialNumberValues(String text) async {
    machineSerialNumberController.text = text;

    AssetDetailsBySerialNo detailsPerSerialNo = await _subscriptionService
        .getDeviceAssetDetailsBySerialNo(machineSerialNumberController.text);

    if (detailsPerSerialNo != null) {
      if (detailsPerSerialNo.result.isNotEmpty) {
        serialValues.addAll(detailsPerSerialNo.result);

        _loading = false;
        _loadingMore = false;

        serialValues.forEach((element) {
          deviceIdController.text = element.deviceId;
          machineModelController.text = element.model;
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

    DeviceDetailsPerId detailsPerId = await _subscriptionService
        .getDeviceDetailsPerDeviceId(deviceIdController.text);

    if (detailsPerId != null) {
      if (detailsPerId.result.isNotEmpty) {
        deviceValues.addAll(detailsPerId.result);

        _loading = false;
        _loadingMore = false;

        deviceValues.forEach((element) {
          machineSerialNumberController.text = element.serialNo;
          machineModelController.text = element.model;
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
    SingleTransferDeviceId serialNoResults =
        await _subscriptionService.getSingleTransferDeviceId(
            filter: "asset",
            filterType: PLANTSUBSCRIPTIONFILTERTYPE.TYPE,
            controllerValue: text,
            start: start == 0 ? start : start + 1,
            limit: limit,
            searchBy: "VIN");

    if (serialNoResults != null) {
      if (serialNoResults.result.isNotEmpty) {
        deviceList.addAll(serialNoResults.result);

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

    Logger().wtf(serialNoResults.result.first.vIN);
    notifyListeners();
  }

  getDeviceIds(String text) async {
    SingleTransferDeviceId deviceIdResults =
        await _subscriptionService.getSingleTransferDeviceId(
            filter: "asset",
            filterType: PLANTSUBSCRIPTIONFILTERTYPE.TYPE,
            controllerValue: text,
            start: start == 0 ? start : start + 1,
            limit: limit,
            searchBy: "GPSDeviceID");

    if (deviceIdResults != null) {
      if (deviceIdResults.result.isNotEmpty) {
        deviceList.addAll(deviceIdResults.result);

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

    Logger().wtf(deviceIdResults.result.first.gPSDeviceID);
    notifyListeners();
  }
}
