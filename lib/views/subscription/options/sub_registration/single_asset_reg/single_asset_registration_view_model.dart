
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:insite/core/base/insite_view_model.dart';
import 'package:insite/core/locator.dart';
import 'package:insite/core/models/add_asset_registration.dart';
import 'package:insite/core/models/hierarchy_model.dart';
import 'package:insite/core/models/preview_data.dart';
import 'package:insite/core/models/subscription_dashboard.dart';
import 'package:insite/core/models/subscription_dashboard_details.dart';
import 'package:insite/core/models/subscription_serial_number_results.dart';
import 'package:insite/core/services/local_service.dart';
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
  LocalService? _localService = locator<LocalService>();
  String? _filter;
  String? get filter => _filter;

  PLANTSUBSCRIPTIONFILTERTYPE? _filterType;
  PLANTSUBSCRIPTIONFILTERTYPE? get filterType => _filterType;

  bool _loading = true;
  bool get loading => _loading;
  int? count = -1;

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

  bool regDealerCodeChange = false;
  bool regDealerNameChange = false;
  bool regCustomerCodeChange = false;
  bool regCustomerNameChange = false;

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

  List<Asset> _totalAsset = [];
  List<Asset> get totalAsset => _totalAsset;

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
      //serialNumberController.clear();
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
    hourMeterDateController.text = Utils.getDateFormatForDatePicker(value!.toString(),userPref);
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
      Asset deviceAsset;
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
      deviceAsset = Asset(
        deviceId: previewDeviceDetails[0].value,
        machineSlNo: previewDeviceDetails[1].value,
        machineModel: previewDeviceDetails[2].value,
        hmrDate: previewDeviceDetails[4].value,
        hmr: previewDeviceDetails[3].value == ""
            ? 0
            : double.parse(previewDeviceDetails[3].value!).toInt(),
        plantName: generalPlantDetails[0].value == ""
            ? null
            : generalPlantDetails[0].value,
        plantCode: generalPlantDetails[1].value,
        plantEmailId: generalPlantDetails[2].value,
        customerName: generalCustomerDetails[0].value!.isEmpty
            ? null
            : generalCustomerDetails[0].value,
        customerCode: generalCustomerDetails[1].value!.isEmpty
            ? null
            : generalCustomerDetails[1].value,
        customerEmailId: generalCustomerDetails[2].value!.isEmpty
            ? null
            : generalCustomerDetails[2].value,
        dealerName: generalDealerDetails[0].value!.isEmpty
            ? null
            : generalDealerDetails[0].value,
        dealerCode: generalDealerDetails[1].value!.isEmpty
            ? null
            : generalDealerDetails[1].value,
        dealerEmailId: generalDealerDetails[2].value!.isEmpty
            ? null
            : generalDealerDetails[2].value,
        commissioningDate: null,
        primaryIndustry: null,
        secondaryIndustry: null,
      );
      _totalAssetValues.add(deviceAssetValues);
      Logger().wtf("${deviceAsset.toJson()}");
      _totalAsset.clear();
      _totalAsset.add(deviceAsset);
      Logger().wtf(_totalAsset);
      _totalAsset.forEach((element) {
        Logger().d("_totalAsset:${element.toJson()}");
      });

      var userId = await _localService!.getUserId();
      var id = int.parse(userId!);
      AssetOperationInput request = AssetOperationInput(
        source: "THC",
        userId: id,
        version: "2.0",
        asset: _totalAsset,
      );
      Logger().w("request: ${request.toJson()}");
      var result;
      if (enableGraphQl) {
        String? gnacc = "";
        result = await _subscriptionService!.postSingleAssetRegistrationGraphql(
            query: graphqlSchemaService!.register(),
            payLoad: {"id": id, "gnacc": gnacc, "request": request.toJson()});
      } else {
        result = await _subscriptionService!
            .postSingleAssetRegistration(data: _totalAssetValues);
      }
      //  result = await _subscriptionService!
      //       .postSingleAssetRegistration(data: _totalAssetValues,query: graphqlSchemaService!.register(id: id,gnacc: gnacc,request: bod));
      _totalAssetValues.clear();
      _totalAsset.clear();
      onRegistrationSuccess();
      
      count = -1;
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
    regDealerCodeChange = false;
    regDealerNameChange = false;
    regCustomerCodeChange = false;
    regCustomerNameChange = false;
     _assetModel = "Select Asset Model";
      modelNames.insert(0, _assetModel);
      modelNames.toSet().toList();
   // await getSubscriptionModelData();
    
    notifyListeners();
  }

  getSubcriptionDeviceListData(
      {required String name, int? code, String? type}) async {
    try {
      _detailResult.clear();
      _gpsDeviceId.clear();
      if (name.length >= 3) {
        if (enableGraphQl) {
          deviceIdChange = await _subscriptionService!
              .getSubscriptionDeviceListData(
                  filter: filter,
                  query: graphqlSchemaService!
                      .getDeviceIdReplacement(name, "inactive", 50));

          if (deviceIdChange != null) {
            if (deviceIdChange!.subscriptionFleetList != null) {
              count = deviceIdChange!.subscriptionFleetList!.count ?? null;
              if (deviceIdChange!.subscriptionFleetList!.provisioningInfo !=
                  null) {
                for (var element in deviceIdChange!
                    .subscriptionFleetList!.provisioningInfo!) {
                  _detailResult.add(DetailResult(
                    vin: element.vin,
                    gpsDeviceId: element.gpsDeviceID,
                    model: element.model,
                    subscriptionStartDate: element.subscriptionStartDate,
                  ));
                }

                _loading = false;
                _loadingMore = false;
                gpsDeviceId.clear();
                deviceIdChange!.subscriptionFleetList!.provisioningInfo!
                    .forEach((element) {
                  if (gpsDeviceId.any((id) => id == element.gpsDeviceID)) {
                  } else {
                    gpsDeviceId.add(element.gpsDeviceID);
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
               
                _loading = false;
                _loadingMore = false;
                _shouldLoadmore = false;
                 notifyListeners();
              }
              _loading = false;
              _loadingMore = false;
            }
          }
          if(deviceIdController.text.isEmpty){
            count=-1;
            notifyListeners();
          }
        } else {
          deviceIdChange = await _subscriptionService!
              .getSubscriptionDeviceListData(
                  filterType: filterType,
                  filter: filter,
                  name: name,
                  start: pageNumber,
                  limit: pageSize);

          if (deviceIdChange != null) {
            count = deviceIdChange?.result?[0].first.count;
            if (deviceIdChange!.result![1].isNotEmpty) {
              _detailResult.addAll(deviceIdChange!.result![1]);
              _loading = false;
              _loadingMore = false;
              gpsDeviceId.clear();
              deviceIdChange!.result![1].forEach((element) {
                if (gpsDeviceId.any((id) => id == element.gpsDeviceId)) {
                } else {
                  gpsDeviceId.add(element.gpsDeviceId);
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
      }
    } on DioError catch (e) {
      final error = DioException.fromDioError(e);
      Fluttertoast.showToast(msg: error.message!);
    }
  }

  getModelNamebySerialNumber(String value) async {
    try {
      SerialNumberResults? results;
      if (enableGraphQl) {
        if (value.length >= 3) {
          results = await _subscriptionService!
              .getDeviceModelNameBySerialNumber(
                  query:
                      graphqlSchemaService!.getModelNameBySerialNumber(value));
          if (results != null) {
            if (results.assetModelByMachineSerialNumber != null) {
              String? assetModelName =
                  results.assetModelByMachineSerialNumber!.modelName;

              if (_assetModel != assetModelName) {
                _assetModel = assetModelName;
                modelNames.replace(0, _assetModel, modelNames);
                Logger().wtf(modelNames.length);
                isSerialNoisValid = false;
              }
            }
          } else {
            return 'no results found';
          }
          notifyListeners();
        }
      } else {
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
            }
            // else {
            //   _assetModel = "Select Asset Model";
            //  // serialNumberController.clear();
            //   isSerialNoisValid = true;
            //   notifyListeners();
            // }
          } else {
            return 'no results found';
          }
          notifyListeners();
        } else {
          isSerialNoisValid = false;
          notifyListeners();
          return;
        }
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
      if(enableGraphQl){
      
          var modelList=[
    "None",
    "EX70",
    "EX70 SUPER PLUS",
    "EX110",
    "EX130 SUPER PLUS",
    "EX200LC",
    "EX200LC SUPER PLUS",
    "EX210LC",
    "EX210 SUPER",
    "EX210LC SUPER PLUS",
    "EX215 SUPER PLUS",
    "SHINRAI - BX80",
    "SHINRAI-BX80-BSIV",
    "TH76",
    "TH86",
    "TL340H"
          ];
          for (var element in modelList) {
            _modelNames.add(element);
            
          }
            notifyListeners();
      }else{
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
      }
     
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

  onSelectedDeviceId(String? value) async {
    if (enableGraphQl) {
      var selectedDeviceId = await _subscriptionService!
          .getSubscriptionDeviceListData(
              filter: filter,
              query: graphqlSchemaService!
                  .getDeviceIdReplacement(value, "inactive", 50));
      selectedDeviceId!.subscriptionFleetList!.provisioningInfo!
          .forEach((element) {
        if (element.gpsDeviceID == value) {
          deviceIdController.text = element.gpsDeviceID!;
          // serialNumberController.text = element.vin!;
          _gpsDeviceId.clear();
          notifyListeners();
        }
      });
    } else {
      _detailResult.forEach((element) {
        if (element.gpsDeviceId == value) {
          deviceIdController.text = element.gpsDeviceId!;
          // serialNumberController.text = element.vin!;
          _gpsDeviceId.clear();
          notifyListeners();
        }
      });
    }
  }

  onSelectedNameTile(String value) async {
    if (enableGraphQl) {
      var selectedCustomerName =
          await (_subscriptionService!.getSubscriptionDevicesListData(
        query: graphqlSchemaService!.getDeviceCodeAndName(
            start: 0, limit: 50, name: value, code: "", type: "CUSTOMER"),
      ));
      selectedCustomerName!.assetOrHierarchyByTypeAndId!
          .forEach((element) async {
        if (element.name == value) {
          customerNameController.text = element.name!;
          customerCodeController.text = element.code!;
          if (customerCodeController.text.isNotEmpty) {
            var data =
                await (_subscriptionService!.getSubscriptionDevicesListData(
              query: graphqlSchemaService!.getDeviceCodeAndName(
                  start: 0,
                  limit: 50,
                  name: "",
                  code: customerCodeController.text,
                  type: "CUSTOMER"),
            ));
          }
          customerEmailController.text = element.email!;
          customerId.clear();
        }
      });
      regCustomerNameChange = false;
      regCustomerCodeChange = false;
      notifyListeners();
    } else {
      _devices.forEach((element) {
        if (element.Name == value) {
          customerNameController.text = element.Name!;
          customerCodeController.text = element.Code!;
          customerEmailController.text = element.Email!;
          customerId.clear();
        }
      });
      regCustomerNameChange = false;
      regCustomerCodeChange = false;
      notifyListeners();
    }
  }

  onSelectedDealerNameTile(String value) async {
    Logger().e(_devices.length);
    if (enableGraphQl) {
      var selectedDealerName =
          await (_subscriptionService!.getSubscriptionDevicesListData(
        query: graphqlSchemaService!.getDeviceCodeAndName(
            start: 0, limit: 50, name: value, code: "", type: "DEALER"),
      ));

      selectedDealerName!.assetOrHierarchyByTypeAndId!.forEach((element) async {
        if (element.name == value) {
          deviceNameController.text = element.name!;
          deviceCodeController.text = element.code!;
          if (deviceCodeController.text.isNotEmpty) {
            var data =
                await (_subscriptionService!.getSubscriptionDevicesListData(
              query: graphqlSchemaService!.getDeviceCodeAndName(
                  start: 0,
                  limit: 50,
                  name: "",
                  code: deviceCodeController.text,
                  type: "DEALER"),
            ));
          }
          deviceEmailController.text = element.email ?? "";
          _dealerId.clear();
          notifyListeners();
        }
      });
      regDealerNameChange = false;
      regDealerCodeChange = false;
      notifyListeners();
    } else {
      _devices.forEach((element) {
        if (element.Name == value) {
          deviceNameController.text = element.Name!;
          deviceCodeController.text = element.Code!;
          deviceEmailController.text = element.Email ?? "";
          _dealerId.clear();
          notifyListeners();
        }
      });
      regDealerNameChange = false;
      regDealerCodeChange = false;
      notifyListeners();
    }
  }

  onSelectedDealerCodeTile(String value) async {
    if (enableGraphQl) {
      var selectedDealerCode =
          await (_subscriptionService!.getSubscriptionDevicesListData(
        query: graphqlSchemaService!.getDeviceCodeAndName(
            start: 0, limit: 50, name: "", code: value, type: "DEALER"),
      ));
      selectedDealerCode!.assetOrHierarchyByTypeAndId!.forEach((element) async {
        if (element.code == value) {
          deviceNameController.text = element.name!;
          if (deviceNameController.text.isNotEmpty) {
            var data =
                await (_subscriptionService!.getSubscriptionDevicesListData(
              query: graphqlSchemaService!.getDeviceCodeAndName(
                  start: 0,
                  limit: 50,
                  name: deviceNameController.text,
                  code: "",
                  type: "DEALER"),
            ));
          }
          deviceCodeController.text = element.code!;
          deviceEmailController.text = element.email!;
          _dealerCode.clear();
          notifyListeners();
        }
      });

      regDealerCodeChange = false;
      regDealerNameChange = false;
      notifyListeners();
    } else {
      _devices.forEach((element) {
        if (element.Code == value) {
          deviceNameController.text = element.Name!;
          deviceCodeController.text = element.Code!;
          deviceEmailController.text = element.Email!;
          _dealerCode.clear();
          notifyListeners();
        }
      });
      regDealerCodeChange = false;
      regDealerNameChange = false;
    }
  }

  onSelectedCodeTile(String value) async {
    Logger().e(value);
    if (enableGraphQl) {
      var selectedCustomerCode =
          await _subscriptionService!.getSubscriptionDevicesListData(
        query: graphqlSchemaService!.getDeviceCodeAndName(
            start: 0, limit: 50, name: "", code: value, type: "CUSTOMER"),
      );
      selectedCustomerCode!.assetOrHierarchyByTypeAndId!
          .forEach((element) async {
        Logger().wtf(value);
        if (element.code == value) {
          customerNameController.text = element.name!;
          if (customerNameController.text.isNotEmpty) {
            var data =
                await _subscriptionService!.getSubscriptionDevicesListData(
              query: graphqlSchemaService!.getDeviceCodeAndName(
                  start: 0,
                  limit: 50,
                  name: customerNameController.text,
                  code: "",
                  type: "CUSTOMER"),
            );
          }
          customerCodeController.text = element.code!;
          customerEmailController.text = element.email!;
          customerCode.clear();
          notifyListeners();
        }
      });
      regCustomerCodeChange = false;
      regCustomerNameChange = false;
      notifyListeners();
    } else {
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
      regCustomerCodeChange = false;
      regCustomerNameChange = false;
    }
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
          if (enableGraphQl) {
            customerNameChange =
                await (_subscriptionService!.getSubscriptionDevicesListData(
              query: graphqlSchemaService!.getDeviceCodeAndName(
                  start: 0,
                  limit: 50,
                  name: name,
                  code: "",
                  type: type),
            ));
            if (customerNameChange!.assetOrHierarchyByTypeAndId != null) {
              if (customerNameChange!.assetOrHierarchyByTypeAndId!.isNotEmpty) {
                customerNameChange!.assetOrHierarchyByTypeAndId!
                    .forEach((element) {
                  _devices.add(HierarchyModel(
                      Code: element.code,
                      Email: element.email,
                      Name: element.name,
                      UserName: element.userName));
                  _customerId.add(element.name);
                  notifyListeners();
                });
              } else {
                regCustomerNameChange = true;
              }
            } else {
              //Fluttertoast.showToast(msg: "No Data Found");
              _devices.clear();
              detailResult.clear();
              _customerId.clear();
              notifyListeners();
            }
          } else {
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
              regCustomerNameChange = true;
              //Fluttertoast.showToast(msg: "No Data Found");
              _devices.clear();
              detailResult.clear();
              _customerId.clear();
              notifyListeners();
            }
          }
        }
        if(customerNameController.text.isEmpty){
      regCustomerNameChange=false;
      notifyListeners();  
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
          if (enableGraphQl) {
            dealerNameChange =
                await (_subscriptionService!.getSubscriptionDevicesListData(
              query: graphqlSchemaService!.getDeviceCodeAndName(
                  start: 0,
                  limit: 50,
                  name: name,
                  code: "",
                  type: type),
            ));

            if (dealerNameChange != null) {
              if (dealerNameChange!.assetOrHierarchyByTypeAndId != null) {
                if (dealerNameChange!.assetOrHierarchyByTypeAndId!.isNotEmpty) {
                  dealerNameChange!.assetOrHierarchyByTypeAndId!
                      .forEach((element) {
                    _devices.add(HierarchyModel(
                      Code: element.code,
                      Email: element.email,
                      Name: element.name,
                      UserName: element.userName,
                    ));
                    _dealerId.add(element.name);
                    notifyListeners();
                  });
                } else {
                  regDealerNameChange = true;
                }
              } else {
                _isShowingHelper = true;
                _devices.clear();
                detailResult.clear();
                _dealerId.clear();
                notifyListeners();
              }
            }
          } else {
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
              regDealerNameChange = true;
              _isShowingHelper = true;
              _devices.clear();
              detailResult.clear();
              _dealerId.clear();
              notifyListeners();
            }
          }
        }
        if(deviceNameController.text.isEmpty){
          regDealerNameChange=false;
          notifyListeners();
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
          if (enableGraphQl) {
            dealerCodeChange =
                await (_subscriptionService!.getSubscriptionDevicesListData(
              query: graphqlSchemaService!.getDeviceCodeAndName(
                  start: 0,
                  limit: 50,
                  name: "",
                  code: code == null ? "" : code.toString(),
                  type: type),
            ));

            if (dealerCodeChange!.assetOrHierarchyByTypeAndId != null) {
              if (dealerCodeChange!.assetOrHierarchyByTypeAndId!.isNotEmpty) {
                dealerCodeChange!.assetOrHierarchyByTypeAndId!
                    .forEach((element) {
                  _devices.add(HierarchyModel(
                    Code: element.code,
                    Email: element.email,
                    Name: element.name,
                    UserName: element.userName,
                  ));
                  _dealerCode.add(element.code);
                  notifyListeners();
                });
              } else {
                regDealerCodeChange = true;
                notifyListeners();
              }
            } else {
              //Fluttertoast.showToast(msg: "New Dealer Code");
              _devices.clear();
              _dealerCode.clear();
              detailResult.clear();
              notifyListeners();
            }
          } else {
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

              regDealerCodeChange = true;
              _devices.clear();
              _dealerCode.clear();
              detailResult.clear();
              notifyListeners();
            }
          }
        }
      if(deviceCodeController.text.isEmpty){
      regDealerCodeChange=false;
      notifyListeners();  
      }
      }
    } on DioError catch (e) {
      final error = DioException.fromDioError(e);
      Fluttertoast.showToast(msg: error.message!);
    }
  }

  onCustomerCodeChanges({String? name, String? type, dynamic code}) async {
    try {
      detailResultList.clear();
      if (code == null) {
        
        Future.delayed(Duration(seconds: 3), () {
          _customerCode.clear();
          notifyListeners();
        });
      } else {
        _customerId.clear();
        _customerCode.clear();
        _devices.clear();
        if (code.toString().length >= 3) {
          if (enableGraphQl) {
            customerCodeChange =
                await _subscriptionService!.getSubscriptionDevicesListData(
              query: graphqlSchemaService!.getDeviceCodeAndName(
                  start: 0,
                  limit: 50,
                  name: "",
                  code: code == null ? " " : code.toString(),
                  type: type),
            );

            Logger().w(customerCodeChange!.assetOrHierarchyByTypeAndId!.length);
            if (customerCodeChange!.assetOrHierarchyByTypeAndId!.isEmpty) {
                regCustomerCodeChange = true;
              _customerCode.clear();
              _devices.clear();
              detailResult.clear();
              notifyListeners();
            } else {
              //  regCustomerCodeChange=true;
               _devices.clear();
               _customerCode.clear();
              customerCodeChange!.assetOrHierarchyByTypeAndId!
                  .forEach((element) {
                _devices.add(HierarchyModel(
                  Code: element.code,
                  Email: element.email,
                  Name: element.name,
                  UserName: element.userName,
                ));
                _customerCode.add(element.code);
                notifyListeners();
              });
            }
          } else {
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
                  duration: Duration(milliseconds: 200),
                );
                 regCustomerCodeChange=true;
                notifyListeners();
              } else {
                if (customerCodeChange!.result![1].isNotEmpty) {
                  customerCodeChange!.result![1].forEach((element) {
                    _devices.add(element);
                    _customerCode.add(element.Code);
                    notifyListeners();
                  });
                } else {
                  regCustomerCodeChange = true;
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
      if(customerCodeController.text.isEmpty){
      regCustomerCodeChange=false;
      notifyListeners();  
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
