import 'package:flutter/material.dart';
import 'package:insite/core/base/insite_view_model.dart';
import 'package:insite/core/locator.dart';
import 'package:insite/core/models/add_asset_registration.dart';
import 'package:insite/core/models/plant_heirarchy.dart';
import 'package:insite/core/models/plant_heirarchy.dart';
import 'package:insite/core/models/plant_heirarchy.dart';
import 'package:insite/core/models/plant_heirarchy.dart';
import 'package:insite/core/models/plant_heirarchy.dart';
import 'package:insite/core/models/preview_data.dart';
import 'package:insite/core/models/subscription_dashboard_details.dart';
import 'package:insite/core/models/subscription_dashboard.dart';
import 'package:insite/core/models/subscription_serial_number_results.dart';
import 'package:insite/core/services/subscription_service.dart';
import 'package:insite/utils/enums.dart';
import 'package:intl/intl.dart';
import 'package:logger/logger.dart';
import 'package:stacked/stacked.dart';
import 'package:insite/core/logger.dart';

class SingleAssetRegistrationViewModel extends InsiteViewModel {
  Logger log;

  var _subscriptionService = locator<SubScriptionService>();

  String _filter;
  String get filter => _filter;

  PLANTSUBSCRIPTIONFILTERTYPE _filterType;
  PLANTSUBSCRIPTIONFILTERTYPE get filterType => _filterType;

  bool _loading = true;
  bool get loading => _loading;

  bool _loadingMore = false;
  bool get loadingMore => _loadingMore;

  String _assetModel = "Select Asset Model";
  String get assetModel => _assetModel;

  String _plantDetail = " ";
  String get plantDetail => _plantDetail;

  String _plantCode = " ";
  String get plantCode => _plantCode;

  String _plantEmail = "sivaranjani_k@trimble.com";
  String get plantEmail => _plantEmail;

  bool _shouldLoadmore = true;
  bool get shouldLoadmore => _shouldLoadmore;

  bool _refreshing = false;
  bool get refreshing => _refreshing;

  DateTime _pickedDate = DateTime.now();
  DateTime get pickedDate => _pickedDate;

  int pageNumber = 1;
  int pageSize = 100;
  int pageNumberSecond = 0;
  int pageSizeSecond = 10;
  bool deviceIdType = true;
  bool customerCodetype = true;
  bool customerNameType = true;

  List<DetailResult> _devices = [];
  List<DetailResult> get devices => _devices;

  List<DetailResult> _deviceDetails = [];
  List<DetailResult> get deviceDetails => _deviceDetails;

  List<DetailResult> _customerDetails = [];
  List<DetailResult> get customerDetails => _customerDetails;

  List<String> _gpsDeviceId = [];
  List<String> get gpsDeviceId => _gpsDeviceId;

  List<String> _customerId = [];
  List<String> get customerId => _customerId;

  List<String> _customerCode = [];
  List<String> get customerCode => _customerCode;

  List<String> _customerEmail = [];
  List<String> get customerEmail => _customerEmail;

  List<String> _modelNames = [];
  List<String> get modelNames => _modelNames;

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

  List<String> _plantDetails = [
    "Dharward",
    "Plant",
    "TATA HITACHI KHARAGPUR FACTORY"
  ];
  List<String> get plantDetails => _plantDetails;

  List<String> _plantCodes = ["1005", "1006", "3065"];
  List<String> get plantCodes => _plantCodes;

  SingleAssetRegistrationViewModel(
      String filterKey, PLANTSUBSCRIPTIONFILTERTYPE type) {
    this.log = getLogger(this.runtimeType.toString());
    this._filter = filterKey;
    this._filterType = type;
    plantDetails.add(_plantDetail);

    Future.delayed(Duration(seconds: 1), () {
      getSubcriptionDeviceListData();
      getSubscriptionModelData();
    });
  }

  updateModelValue(String newValue) {
    _assetModel = newValue;
    notifyListeners();
  }

  updateplantDEtail(String newValue) {
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

  getSelectedDate(DateTime value) {
    _pickedDate = value;
    hourMeterDateController.text = DateFormat.yMMMd().format(_pickedDate);
    notifyListeners();
  }

  updateDeviceId(String value) {
    deviceIdController.text = value;
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
        PreviewData(title: 'HRM', value: hourMeterDateController.text);
    _previewDeviceDetails.add(
      hourMeterDate,
    );
    PreviewData hourMeter =
        PreviewData(title: 'HRM Data', value: hourMeterController.text);
    _previewDeviceDetails.add(
      hourMeter,
    );
    _totalList.add(previewDeviceDetails);
    notifyListeners();
  }

  subscriptionAssetRegistration() async {
    AssetValues deviceAssetValues;
    deviceAssetValues = AssetValues(
      deviceId: previewDeviceDetails[0].value,
      machineSlNo: previewDeviceDetails[1].value,
      machineModel: previewDeviceDetails[2].value,
      hMRDate: previewDeviceDetails[3].value,
      hMR: int.parse(previewDeviceDetails[4].value),
      plantName: generalPlantDetails[0].value,
      plantCode: generalPlantDetails[1].value,
      plantEmailID: generalPlantDetails[2].value,
      customerName: generalCustomerDetails[0].value,
      customerCode: generalCustomerDetails[1].value,
      customerEmailID: generalCustomerDetails[2].value,
      dealerName: generalDealerDetails[0].value,
      dealerCode: generalDealerDetails[1].value,
      dealerEmailID: generalDealerDetails[2].value,
      commissioningDate: null,
      primaryIndustry: null,
      secondaryIndustry: null,
    );
    _totalAssetValues.add(deviceAssetValues);

    var result = await _subscriptionService.postSingleAssetRegistration(
        data: _totalAssetValues);

    notifyListeners();
    return result;
  }

  getSubcriptionDeviceListData() async {
    SubscriptionDashboardDetailResult result =
        await _subscriptionService.getSubscriptionDevicesListData(
            filterType: filterType,
            fitler: filter,
            start: pageNumber,
            limit: pageSize);

    if (result != null) {
      if (result.result.isNotEmpty) {
        devices.addAll(result.result[1]);

        _loading = false;
        _loadingMore = false;

        devices.forEach((element) {
          gpsDeviceId.add(element.GPSDeviceID);
        });
      } else {
        _loading = false;
        _loadingMore = false;
        _shouldLoadmore = false;
      }
      _loading = false;
      _loadingMore = false;
      notifyListeners();
    }
  }

  getModelNamebySerialNumber(String value) async {
    SerialNumberResults results = await _subscriptionService
        .getDeviceModelNameBySerialNumber(serialNumber: value);

    if (results != null) {
      String assetModelName = results.result.modelName;

      if (modelNames.contains(assetModelName)) {
        _assetModel = assetModelName;
      } else {
        _assetModel = " ";
      }
    } else {
      return 'no results found';
    }

    notifyListeners();
    _assetModel = results.result.modelName;
  }

  getSubscriptionModelData() async {
    Logger().i("getApplicationAccessData");
    SubscriptionDashboardResult result =
        await _subscriptionService.getResultsFromSubscriptionApi();
    if (result == null) {
      Logger().d('no results found');
      _loading = false;
      return "no results found";
    } else {
      //model names
      final ex70SuperPlus = result.result[2][9].modelName;
      final ex130SuperPlus = result.result[2][3].modelName;
      final shinRaiBx80 = result.result[2][11].modelName;
      final notMapped = "Not Mapped";
      final twl5 = result.result[2][1].modelName;
      final ex110 = result.result[2][2].modelName;
      final ex200lc = result.result[2][4].modelName;
      final ex210lc = result.result[2][6].modelName;
      final ex215 = result.result[2][7].modelName;
      final ex300 = result.result[2][8].modelName;
      final ptl340h = result.result[2][10].modelName;
      final shinraibx80Bviv = result.result[2][12].modelName;
      final shinraipro = result.result[2][13].modelName;
      final th76 = result.result[2][14].modelName;
      final tl340h = result.result[2][15].modelName;
      final th340hPrime = result.result[2][16].modelName;

      _modelNames.addAll([
        "Select Asset Model",
        ex70SuperPlus,
        ex130SuperPlus,
        shinRaiBx80,
        notMapped,
        twl5,
        ex110,
        ex200lc,
        ex210lc,
        ex215,
        ex300,
        ptl340h,
        shinraibx80Bviv,
        shinraipro,
        th76,
        tl340h,
        th340hPrime
      ]);

      _loading = false;
    }
    notifyListeners();
    return _modelNames;
  }

  getSubcriptionDeviceListPerNameOrCode(
      {String name, int code, String type}) async {
    SubscriptionDashboardDetailResult result =
        await _subscriptionService.getSubscriptionDevicesListData(
      filterType: PLANTSUBSCRIPTIONFILTERTYPE.TYPE,
      start: pageNumberSecond,
      name: name,
      code: code,
      fitler: type,
      limit: pageSizeSecond,
    );

    if (result != null) {
      if (result.result.isNotEmpty) {
        deviceDetails.addAll(result.result[1]);
        _loading = false;
        _loadingMore = false;

        deviceDetails.forEach((element) {
          deviceEmailController.text = element.Email;
          deviceCodeController.text = element.Code;
          deviceNameController.text = element.Name;

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

  getSubcriptionListOfNameAndCode({String name, int code, String type}) async {
    SubscriptionDashboardDetailResult result =
        await _subscriptionService.getSubscriptionDevicesListData(
      filterType: PLANTSUBSCRIPTIONFILTERTYPE.TYPE,
      start: pageNumber,
      name: name,
      code: code,
      fitler: type,
      limit: pageSize,
    );

    if (result != null) {
      if (result.result.isNotEmpty) {
        customerDetails.addAll(result.result[1]);

        customerDetails.forEach((element) {
          customerId.add(element.Name);
          customerCode.add(element.Code);
          customerEmail.add(element.Email);
        });

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
      if (value.toLowerCase() == element.Name.toLowerCase()) {
        Logger().e('codet${element.Code}');

        customerCodeController.text = element.Code;
        customerEmailController.text = element.Email;

        Logger().wtf('code: ${element.Code}');

        notifyListeners();
      } else if (value == element.Code) {
        customerNameController.text = element.Name;
        customerEmailController.text = element.Email;
        customerCodeController.text = element.Code;

        notifyListeners();
      }
      return false;
    });
    notifyListeners();
  }

  filterDealerCode(String value) {
    customerDetails.forEach((element) {
      if (value.toLowerCase() == element.Code.toLowerCase()) {
        deviceNameController.text = element.Code;
        deviceEmailController.text = element.Email;
        notifyListeners();
      }
    });
  }

  filterDealerName(String value) {
    customerDetails.forEach((element) {
      if (value.toLowerCase() == element.Name.toLowerCase()) {
        deviceCodeController.text = element.Code;
        deviceEmailController.text = element.Email;
        notifyListeners();
      }
    });
  }
}

enum FieldType {
  CUSTOMERCODE,
  CUSTOMERNAME,
  DEVICEID,
}
