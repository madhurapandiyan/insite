import 'package:flutter/material.dart';
import 'package:insite/core/base/insite_view_model.dart';
import 'package:insite/core/locator.dart';
import 'package:insite/core/models/plant_heirarchy.dart';
import 'package:insite/core/models/plant_heirarchy.dart';
import 'package:insite/core/models/plant_heirarchy.dart';
import 'package:insite/core/models/plant_heirarchy.dart';
import 'package:insite/core/models/plant_heirarchy.dart';
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

  String _assetModel = " ";
  String get assetModel => _assetModel;
  String _plantDetail = " ";
  String get plantDetail => _plantDetail;

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

  List<String> _finalDeviceDetails = [];
  List<String> get finalDeviceDetails => _finalDeviceDetails;

  List<String> _plantDetails = [
    "Dharward",
    "Plant",
    "TATA HITACHI KHARAGPUR FACTORY"
  ];
  List<String> get plantDetails => _plantDetails;

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
    notifyListeners();
  }

  TextEditingController hourMeterDateController = TextEditingController();
  TextEditingController autocustomTextFieldController = TextEditingController();
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

  getModelNamebySerialNumber(String value) async {
    SerialNumberResults results = await _subscriptionService
        .getDeviceModelNameBySerialNumber(serialNumber: value);

    if (results != null) {
    } else {
      return 'no results found';
    }

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
        assetModel,
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
}
