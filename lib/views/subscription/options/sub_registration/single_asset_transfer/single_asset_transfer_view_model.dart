import 'dart:async';

import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:insite/core/base/base_service.dart';
import 'package:insite/core/base/insite_view_model.dart';
import 'package:insite/core/locator.dart';
import 'package:insite/core/models/add_asset_registration.dart';
import 'package:insite/core/models/add_asset_transfer.dart';
import 'package:insite/core/models/device_details_graphql.dart';
import 'package:insite/core/models/device_details_per_id.dart';
import 'package:insite/core/models/get_asset_details_by_serial_no.dart';
import 'package:insite/core/models/get_single_transfer_deviceId_graphql.dart';
import 'package:insite/core/models/get_single_transfer_device_id.dart';
import 'package:insite/core/models/hierachy_graphql.dart';
import 'package:insite/core/models/hierarchy_model.dart';
import 'package:insite/core/models/prefill_customer_details.dart';
import 'package:insite/core/models/preview_data.dart';
import 'package:insite/core/services/local_service.dart';
import 'package:insite/core/services/subscription_service.dart';
import 'package:insite/utils/enums.dart';
import 'package:insite/views/adminstration/addgeofense/exception_handle.dart';
import 'package:intl/intl.dart';
import 'package:load/load.dart';
import 'package:logger/logger.dart';
import 'package:insite/core/logger.dart';
import 'package:stacked_services/stacked_services.dart';

class SingleAssetTransferViewModel extends InsiteViewModel {
  Logger? log;

  bool _allowTransferAsset = false;
  bool get allowTransferAsset => _allowTransferAsset;

  bool _enableCustomerDetails = true;
  bool get enableCustomerDetails => _enableCustomerDetails;

  SubScriptionService? _subscriptionService = locator<SubScriptionService>();
  LocalService? _localService = locator<LocalService>();

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
  List<SingleFleetDetails>? _deviceDetailsList = [];
  List<SingleFleetDetails>? get deviceDetailsList => _deviceDetailsList;

  List<HierarchyFleetSearch> _deviceIdList = [];
  List<HierarchyFleetSearch> get deviceIdList => _deviceIdList;

  List<ResultData> _deviceValues = [];
  List<ResultData> get deviceValues => _deviceValues;

  List<ResultsValues> _serialValues = [];
  List<ResultsValues> get serialValues => _serialValues;

  List<String> _deviceDetail = [];
  List<String> get deviceDetail => _deviceDetail;

  List<dynamic> _devices = [];
  List<dynamic> get devices => _devices;

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

  String _initialSubIndustryDetailValue = "Select Secondary Details";
  String get initialSubIndustryDetailValue => _initialSubIndustryDetailValue;

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
    "Industrial & commercial Material Handling",
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

  List<String> _industrySubDetails = ["Select Secondary Details"];
  List<String> get industrySubDetails => _industrySubDetails;

  DeviceDetailsPerId? deviceDetailsPerId;
  SelectedDevice? deviceDetailsPerIdGraphql;
  CustomerDetails? customerDetails;

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
  bool isDeviceIdChange = false;

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

  SingleAssetRegistrationSearchModel? dealerNameChange;
  SingleAssetRegistrationSearchModel? dealerCodeChange;
  SingleAssetRegistrationSearchModel? customerNameChange;
  SingleAssetRegistrationSearchModel? customerCodeChange;

  final SnackbarService _snackbarService = locator<SnackbarService>();

  SingleAssetTransferViewModel() {
    this.log = getLogger(this.runtimeType.toString());
    Future.delayed(Duration(seconds: 1), () {});
    getIndustryGraphqlData(initialIndustryDetail);
  }

  allowAssetTransferClicked() async {
    //_enableCustomerDetails = !_enableCustomerDetails;
    if (isDeviceIdChange) {
      await onSelectedDeviceId(deviceIdController.text);
    }

    if (deviceIdController.text.isNotEmpty) {
      if (deviceDetailsPerId!.result!.first.CustomerCode == null &&
          deviceDetailsPerId!.result!.first.CustomerName == null) {
        _allowTransferAsset = !_allowTransferAsset;
        deviceIdController.clear();
        machineSerialNumberController.clear();
        machineModelController.clear();
        // customerCodeController.clear();
        // customerEmailController.clear();
        // customerNameController.clear();
        notifyListeners();
        snackbarService!.showSnackbar(
            message:
                "This Asset/device not provisioned under a Dealer & Customer !!");
        return;
      } else {
        // customerCodeController.text =
        //     deviceDetailsPerId!.result!.first.CustomerCode!;
        // customerNameController.text =
        //     deviceDetailsPerId!.result!.first.CustomerName!;
        // customerEmailController.text =
        //     customerDetails!.customerResult!.customerData!.email!;
        _allowTransferAsset = !_allowTransferAsset;
        notifyListeners();
      }
    } else {
      _allowTransferAsset = !_allowTransferAsset;
      notifyListeners();
    }
  }

  updateLanguage(String value) {
    _initialLanguage = value;
    notifyListeners();
  }

  updateCustomerLanguage(String value) {
    _initialCustLanguage = value;
    notifyListeners();
  }

  onSelectingSubIndustry(String value) {
    _initialSubIndustryDetailValue = value;
    notifyListeners();
  }

  getIndustryGraphqlData(String? value) {
    if (enableGraphQl) {
      _initialIndustryDetail = "Select Industry Details";
      _industryDetails = [];
      _initialSubIndustryDetailValue = "Select Secondary Details";
      _industrySubDetails = [];
      _showSubIndustry = true;
      notifyListeners();
      Logger().w("graphql api  integration");
    } else {
      updateIndustry(value!);
    }
  }

  updateIndustry(String value) {
    _initialSubIndustryDetailValue = "Select Secondary Details";
    _initialIndustryDetail = value;
    if (value == _industryDetails[1]) {
      _industrySubDetails.clear();
      _industrySubDetails.addAll(
          ["Select Secondary Details", "Agriculture", "Palm Oil", "Rubber"]);
    } else if (value == _industryDetails[2]) {
      _industrySubDetails.clear();
      _industrySubDetails
          .addAll(["Select Secondary Details", "Independent_Rental"]);
    } else if (value == _industryDetails[3]) {
      _industrySubDetails.clear();
      _industrySubDetails.addAll([
        "Select Secondary Details",
        "General Construction",
        "Consultant Office / Architectural Firm",
        "Construction Work"
      ]);
    } else if (value == _industryDetails[4]) {
      _industrySubDetails.clear();
      _industrySubDetails.addAll([
        "Select Secondary Details",
        "Civil Engineering",
        "Independent_Rental",
      ]);
    } else if (value == _industryDetails[5]) {
      _industrySubDetails.clear();
      _industrySubDetails.addAll([
        "Select Secondary Details",
        "Aggrigates loading And cleaning",
        "Breaking and loading",
      ]);
    } else if (value == _industryDetails[6]) {
      _industrySubDetails.clear();
      _industrySubDetails.addAll([
        "Select Secondary Details",
        "HCM Group Rental Company",
        "Hire",
      ]);
    } else if (value == _industryDetails[7]) {
      _industrySubDetails.clear();
      _industrySubDetails.addAll([
        "Select Secondary Details",
        "Demolition",
        "Blasting",
        "Crushing",
        "Recycling of Construction Materials"
      ]);
    } else if (value == _industryDetails[8]) {
      _industrySubDetails.clear();
      _industrySubDetails.addAll([
        "Select Secondary Details",
        "Mill",
        "Logging",
        "Replanting",
        "Opening",
        "Others"
      ]);
    } else if (value == _industryDetails[9]) {
      _industrySubDetails.clear();
      _industrySubDetails.addAll([
        "Select Secondary Details",
        "State / Federal Government",
        "Local Government",
        "Parastatal Agency",
        "Military / Defense",
        "Waste Management",
        "Other government body"
      ]);
    } else if (value == _industryDetails[10]) {
      _industrySubDetails.clear();
      _industrySubDetails.addAll([
        "Select Secondary Details",
        "Independent Rental Company",
        "Hire",
        "Repairing",
        "Part supplier",
      ]);
    } else if (value == _industryDetails[11]) {
      _industrySubDetails.clear();
      _industrySubDetails.addAll([
        "Select Secondary Details",
        "Fishery / Aquaculture",
        "Finance / Insurance / Real Estate",
        "Food processing",
        "Utilities",
        "Plant",
        "Textile / Pulp",
        "Chemical / Glass",
        "Machinery",
        "Motor vehicles",
        "Shipbuilding",
        "Other manufacturing",
        "Other manufacturing",
        "Non-manufacturing",
        "Retail",
        "Wholesale",
        "Service",
        "Medical / Education",
        "Metal",
        "Logistics"
      ]);
    } else if (value == _industryDetails[12]) {
      _industrySubDetails.clear();
      _industrySubDetails.addAll([
        "Select Secondary Details",
        "Tunnel",
        "Road construction",
        "Railroad",
        "Drilling",
      ]);
    } else if (value == _industryDetails[13]) {
      _industrySubDetails.clear();
      _industrySubDetails.addAll([
        "Select Secondary Details",
        "Civil Engineering",
        "Drainage",
        "Dam",
        "Piping / Electrical",
      ]);
    } else if (value == _industryDetails[14]) {
      _industrySubDetails.clear();
      _industrySubDetails.addAll([
        "Select Secondary Details",
        "Marine / Harbor / Dredge / River",
        "Horticulture",
      ]);
    } else if (value == _industryDetails[15]) {
      _industrySubDetails.clear();
      _industrySubDetails.addAll([
        "Select Secondary Details",
        "Concrete / Cement",
        "Sandpit",
        "Oil",
        "Gas",
        "Thermal Core",
        "Iron Ore",
        "Copper",
        "Gold",
        "Diamond",
        "Jade",
        "Ruby",
        "Salt",
        "Other mining",
        "Building Materials",
        "Limestone",
        "Other quarry",
        "Apatite",
        "Asbest",
        "Baryte",
        "Bauxite",
        "Chrome",
        "Cobalt",
        "Lithium",
        "Magnesite",
        "Magnetite",
        "Manganese",
        "Mineral Sands",
        "Nickel",
        "Oil Sands",
        "Oil Shale",
        "Phosphate",
        "Platinum",
        "Polymetal",
        "Quarry",
        "Silver",
        "Slate",
        "Sodium Bicarbonate",
        "Taconite",
        "Zink"
      ]);
    } else if (value == _industryDetails[16]) {
      _industrySubDetails.clear();
      _industrySubDetails.addAll([
        "Select Secondary Details",
        "Hire",
        "Independent Rental",
      ]);
    } else if (value == _industryDetails[17]) {
      _industrySubDetails.clear();
      _industrySubDetails.addAll([
        "Select Secondary Details",
        "Hire",
      ]);
    } else if (value == _industryDetails[18]) {
      _industrySubDetails.clear();
      _industrySubDetails.addAll(["Select Secondary Details", "Agriculture"]);
    } else if (value == _industryDetails[19]) {
      _industrySubDetails.clear();
      _industrySubDetails.addAll([
        "Select Secondary Details",
        "Trading company",
        "Used equipment dealer",
        "Others / Miscellaneous"
      ]);
    } else if (value == _industryDetails[20]) {
      _industrySubDetails.clear();
      _industrySubDetails.addAll([
        "Select Secondary Details",
        "Industrial Waste / Landfill",
        "Recycle"
      ]);
    }

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

    var result = await _subscriptionService!
        .postSingleTransferRegistration(transferData: _totalTransferValues);

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
    PreviewData secondary = PreviewData(
        title: 'Secondary Industry', value: _initialSubIndustryDetailValue);
    _generalIndustryDetails.add(secondary);

    _totalList.add(_generalIndustryDetails);
    notifyListeners();
  }

  getSelectedDate(DateTime? value) {
    _pickedDate = value;
    commisioningDateController.text =
        DateFormat("dd/MM/yyyy").format(_pickedDate!);
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
    CustomerDetails result = await (_subscriptionService!
        .getCustomerDetails(deviceID) as Future<CustomerDetails>);

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
    Logger().i(_devices.length);
    if (enableGraphQl) {
      _devices.forEach((element) {
        if (element.name == value) {
          dealerNameController.text = element.name!;
          dealerCodeController.text = element.code!;
          dealerEmailController.text = element.email ?? "";
          _dealerId.clear();
          notifyListeners();
        }
      });
    } else {
      _devices.forEach((element) {
        if (element.Name == value) {
          dealerNameController.text = element.Name;
          dealerCodeController.text = element.Code;
          dealerEmailController.text = element.Email ?? "";
          _dealerId.clear();
          notifyListeners();
        }
      });
    }
  }

  onSelectedCodeTile(String value) {
    Logger().i(_devices.length);
    if (enableGraphQl) {
      _devices.forEach((element) {
        if (element.name == value) {
          dealerNameController.text = element.name!;
          dealerCodeController.text = element.code!;
          dealerEmailController.text = element.email ?? "";
          _dealerId.clear();
          notifyListeners();
        }
      });
    } else {
      _devices.forEach((element) {
        if (element.Name == value) {
          dealerNameController.text = element.Name;
          dealerCodeController.text = element.Code;
          dealerEmailController.text = element.Email ?? "";
          _dealerId.clear();
          notifyListeners();
        }
      });
    }
  }

  onSelectedDealerNameTile(String value) {
    Logger().i(_devices.length);
    if (enableGraphQl) {
      _devices.forEach((element) {
        if (element.name == value) {
          dealerNameController.text = element.name!;
          dealerCodeController.text = element.code!;
          dealerEmailController.text = element.email ?? "";
          _dealerId.clear();
          notifyListeners();
        }
      });
    } else {
      _devices.forEach((element) {
        if (element.Name == value) {
          dealerNameController.text = element.Name;
          dealerCodeController.text = element.Code;
          dealerEmailController.text = element.Email ?? "";
          _dealerId.clear();
          notifyListeners();
        }
      });
    }
  }

  onSelectedDealerCodeTile(String value) {
    Logger().i(_devices.length);
    if (enableGraphQl) {
      _devices.forEach((element) {
        if (element.name == value) {
          dealerNameController.text = element.name!;
          dealerCodeController.text = element.code!;
          dealerEmailController.text = element.email ?? "";
          _dealerId.clear();
          notifyListeners();
        }
      });
    } else {
      _devices.forEach((element) {
        if (element.Name == value) {
          dealerNameController.text = element.Name;
          dealerCodeController.text = element.Code;
          dealerEmailController.text = element.Email ?? "";
          _dealerId.clear();
          notifyListeners();
        }
      });
    }
  }

  onSelectedDeviceId(String value) async {
    try {
      if (enableGraphQl) {
        showLoadingDialog();
        deviceDetailsPerIdGraphql = await _subscriptionService!
            .getDeviceDetailsbyIdGraphql(
                graphqlSchemaService!.getDeviceTransferDetails(value));
        if (deviceDetailsPerIdGraphql?.singleFleetDetails?.first.customerCode ==
                null &&
            deviceDetailsPerIdGraphql?.singleFleetDetails?.first.customerName ==
                null) {
          if (_allowTransferAsset) {
            _snackbarService.showSnackbar(
                message:
                    "This Asset/device not provisioned under a Dealer & Customer !!");
            deviceIdController.clear();
            machineSerialNumberController.clear();
            machineModelController.clear();
            customerCodeController.clear();
            customerEmailController.clear();
            customerNameController.clear();
            notifyListeners();
            return;
          } else {
            customerCodeController.clear();
            customerNameController.clear();
            customerEmailController.clear();
            machineModelController.text =
                deviceDetailsPerIdGraphql!.singleFleetDetails!.first.model!;
          }
        } else {
          Logger()
              .i(deviceDetailsPerIdGraphql!.singleFleetDetails!.first.model!);
          // customerDetails =
          //     await _subscriptionService!.getCustomerDetails(value);
          _deviceDetailsList!
              .addAll(deviceDetailsPerIdGraphql!.singleFleetDetails!);

          Logger().i(_deviceDetailsList);
          deviceIdController.text =
              deviceDetailsPerIdGraphql!.singleFleetDetails!.first.gpsDeviceID!;
          machineSerialNumberController.text =
              deviceDetailsPerIdGraphql!.singleFleetDetails!.first.vin!;
          machineModelController.text =
              deviceDetailsPerIdGraphql!.singleFleetDetails!.first.model!;

          commisioningDateController.text = DateFormat("dd/MM/yyyy").format(
              deviceDetailsPerIdGraphql!
                  .singleFleetDetails!.first.commissioningDate!);

          customerCodeController.text = deviceDetailsPerIdGraphql!
              .singleFleetDetails!.first.customerCode!;
          customerEmailController.text = deviceDetailsPerIdGraphql!
              .singleFleetDetails!.first.customerName!;
          customerNameController.text = deviceDetailsPerIdGraphql!
              .singleFleetDetails!.first.customerName!;
          machineModelController.text =
              deviceDetailsPerId!.result!.first.model!;
        }

        _deviceDetailsList!.forEach((element) {
          if (element.gpsDeviceID == value) {
            deviceIdController.text = element.gpsDeviceID!;
            machineSerialNumberController.text = element.vin!;
            machineModelController.text = element.model!;
            _gpsDeviceIdList.clear();
            notifyListeners();
          }
        });
        hideLoadingDialog();
      } else {
        showLoadingDialog();
        deviceDetailsPerId =
            await _subscriptionService!.getDeviceDetailsPerDeviceId(value);
        if (deviceDetailsPerId?.result?.first.CustomerCode == null &&
            deviceDetailsPerId?.result?.first.CustomerName == null) {
          if (_allowTransferAsset) {
            _snackbarService.showSnackbar(
                message:
                    "This Asset/device not provisioned under a Dealer & Customer !!");
            deviceIdController.clear();
            machineSerialNumberController.clear();
            machineModelController.clear();
            customerCodeController.clear();
            customerEmailController.clear();
            customerNameController.clear();
            notifyListeners();
            return;
          } else {
            customerCodeController.clear();
            customerNameController.clear();
            customerEmailController.clear();
            machineModelController.text =
                deviceDetailsPerId!.result!.first.model!;
          }
        } else {
          Logger().e(deviceDetailsPerId!.result!.first.model!);
          customerDetails =
              await _subscriptionService!.getCustomerDetails(value);
          customerCodeController.text =
              customerDetails!.customerResult!.customerData!.code!;
          customerEmailController.text =
              customerDetails!.customerResult!.customerData!.email!;
          customerNameController.text =
              customerDetails!.customerResult!.customerData!.name!;
          machineModelController.text =
              deviceDetailsPerId!.result!.first.model!;
        }
        _deviceList.forEach((element) {
          if (element.gPSDeviceID == value) {
            deviceIdController.text = element.gPSDeviceID!;
            machineSerialNumberController.text = element.vIN!;
            _gpsDeviceIdList.clear();
            notifyListeners();
          }
        });
        hideLoadingDialog();
      }
    } catch (e) {
      Logger().e(e.toString());
      hideLoadingDialog();
    }
  }

  onSelectedSerialNo(String value) {
    _deviceList.forEach((element) async {
      if (element.vIN == value) {
        var data = await _subscriptionService!
            .getDeviceDetailsPerDeviceId(element.gPSDeviceID!);
        if (data?.result?.first.CustomerCode == null &&
            data?.result?.first.CustomerName == null) {
          if (_allowTransferAsset) {
            _snackbarService.showSnackbar(
                message:
                    "This Asset/device not provisioned under a Dealer & Customer !!");
            deviceIdController.clear();
            machineSerialNumberController.clear();
            machineModelController.clear();
            customerCodeController.clear();
            customerEmailController.clear();
            customerNameController.clear();
            notifyListeners();
            return;
          } else {
            customerCodeController.clear();
            customerNameController.clear();
            customerEmailController.clear();
            machineModelController.text =
                deviceDetailsPerId!.result!.first.model!;
          }
        } else {
          customerDetails = await _subscriptionService!
              .getCustomerDetails(element.gPSDeviceID!);
          customerCodeController.text =
              customerDetails!.customerResult!.customerData!.code!;
          customerEmailController.text =
              customerDetails!.customerResult!.customerData!.email!;
          customerNameController.text =
              customerDetails!.customerResult!.customerData!.name!;
          machineModelController.text = data!.result!.first.model!;
          deviceIdController.text = element.gPSDeviceID!;
          machineSerialNumberController.text = element.vIN!;
          isDeviceIdChange = true;
          _serialNoList.clear();
          onSelectingSerialNo(value);
        }
      }
    });
  }

  onSelectingSerialNo(String value) async {
    var data =
        await _subscriptionService!.getDeviceAssetDetailsBySerialNo(value);
    machineModelController.text = data!.result!.first.model!;
    notifyListeners();
  }

  onCustomerNameChanges({String? name, String? type, int? code}) async {
    try {
      if (enableGraphQl) {
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
            DeviceDataValues? deviceValues = await (_subscriptionService!
                .getSubscriptionDevicesFromGraphQl(
                    graphqlSchemaService!.getDeviceCodeAndName(
              start: pageNumber,
              limit: pageSize,
              type: type,
              name: name == null ? " " : name,
              code: code == null ? " " : code.toString(),
            )));
            Logger().wtf(deviceValues);
            if (deviceValues!.assetOrHierarchyByTypeAndId!.isNotEmpty) {
              deviceValues.assetOrHierarchyByTypeAndId!.forEach((element) {
                _devices.add(element);
                _customerId.add(element.name);
                notifyListeners();
              });
            } else {
              _customerId.clear();
              detailResultList.clear();
              _dealerId.clear();
              notifyListeners();
            }
          }
        }
      } else {
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
            customerNameChange =
                await (_subscriptionService!.getSubscriptionDevicesListData(
              filterType: PLANTSUBSCRIPTIONFILTERTYPE.TYPE,
              start: pageNumber,
              name: name,
              code: code,
              fitler: type,
              limit: pageSize,
            ));
            customerCode.clear();
            if (customerNameChange!.result![1].isNotEmpty) {
              customerNameChange!.result![1].forEach((element) {
                _devices.add(element);
                _customerId.add(element.Name);
                notifyListeners();
              });
            } else {
              _customerId.clear();
              _devices.clear();
              detailResultList.clear();
              notifyListeners();
            }
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
      if (enableGraphQl) {
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
            DeviceDataValues? deviceValues = await (_subscriptionService!
                .getSubscriptionDevicesFromGraphQl(
                    graphqlSchemaService!.getDeviceCodeAndName(
              start: pageNumber,
              limit: pageSize,
              type: type,
              name: name == null ? " " : name,
              code: code == null ? " " : code.toString(),
            )));
            Logger().wtf(deviceValues);
            if (deviceValues!.assetOrHierarchyByTypeAndId!.isNotEmpty) {
              deviceValues.assetOrHierarchyByTypeAndId!.forEach((element) {
                _devices.add(element);
                _customerId.add(element.code);
                notifyListeners();
              });
            } else {
              _customerId.clear();
              detailResultList.clear();
              _dealerId.clear();
              notifyListeners();
            }
          }
        }
      } else {
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
            customerCodeChange =
                await (_subscriptionService!.getSubscriptionDevicesListData(
              filterType: PLANTSUBSCRIPTIONFILTERTYPE.TYPE,
              start: pageNumber,
              name: name,
              code: code,
              fitler: type,
              limit: pageSize,
            ));
            customerId.clear();
            if (customerCodeChange!.result![1].isNotEmpty) {
              customerCodeChange!.result![1].forEach((element) {
                _devices.add(element);
                _customerCode.add(element.Code);
                notifyListeners();
              });
            } else {
              _customerCode.clear();
              _devices.clear();
              detailResultList.clear();
              notifyListeners();
            }
          } else {
            _customerCode.clear();
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
      if (enableGraphQl) {
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
            DeviceDataValues? deviceValues = await (_subscriptionService!
                .getSubscriptionDevicesFromGraphQl(
                    graphqlSchemaService!.getDeviceCodeAndName(
              start: pageNumber,
              limit: pageSize,
              type: type,
              name: name == null ? " " : name,
              code: code == null ? " " : code.toString(),
            )));
            Logger().wtf(deviceValues);
            if (deviceValues!.assetOrHierarchyByTypeAndId!.isNotEmpty) {
              deviceValues.assetOrHierarchyByTypeAndId!.forEach((element) {
                _devices.add(element);
                _dealerId.add(element.name);
                notifyListeners();
              });
            } else {
              _devices.clear();
              detailResultList.clear();
              _dealerId.clear();
              notifyListeners();
            }
          }
        }
      } else {
        detailResultList.clear();
        if (name == null || name.isEmpty) {
          Future.delayed(Duration(seconds: 3), () {
            _dealerId.clear();
            notifyListeners();
          });
        } else {
          _devices.clear();
          _dealerId.clear();
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
            dealerCode.clear();
            if (dealerNameChange!.result![1].isNotEmpty) {
              dealerNameChange!.result![1].forEach((element) {
                _devices.add(element);
                _dealerId.add(element.Name);
                notifyListeners();
              });
            } else {
              _dealerId.clear();
              _devices.clear();
              detailResultList.clear();
              notifyListeners();
            }
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
      if (enableGraphQl) {
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
            DeviceDataValues? deviceValues = await (_subscriptionService!
                .getSubscriptionDevicesFromGraphQl(
                    graphqlSchemaService!.getDeviceCodeAndName(
              start: pageNumber,
              limit: pageSize,
              type: type,
              name: name == null ? " " : name,
              code: code == null ? " " : code.toString(),
            )));
            Logger().wtf(deviceValues);
            if (deviceValues!.assetOrHierarchyByTypeAndId!.isNotEmpty) {
              deviceValues.assetOrHierarchyByTypeAndId!.forEach((element) {
                _devices.add(element);
                _dealerCode.add(element.code);
                notifyListeners();
              });
            } else {
              _devices.clear();
              detailResultList.clear();
              _dealerId.clear();
              notifyListeners();
            }
          }
        }
      } else {
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
            dealerCodeChange =
                await (_subscriptionService!.getSubscriptionDevicesListData(
              filterType: PLANTSUBSCRIPTIONFILTERTYPE.TYPE,
              start: pageNumber,
              name: name,
              code: code,
              fitler: type,
              limit: pageSize,
            ));
            dealerCode.clear();
            if (dealerCodeChange!.result![1].isNotEmpty) {
              dealerCodeChange!.result![1].forEach((element) {
                _devices.add(element);
                _dealerCode.add(element.Code);
                notifyListeners();
              });
            } else {
              _devices.clear();
              _dealerCode.clear();
              detailResultList.clear();
              notifyListeners();
            }
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
        SingleTransferDeviceId? serialNoResults = await (_subscriptionService!
            .getSingleTransferDeviceId(
                filter: "asset",
                filterType: PLANTSUBSCRIPTIONFILTERTYPE.TYPE,
                controllerValue: text,
                start: start == 0 ? start : start + 1,
                limit: limit,
                searchBy: "VIN"));
        gpsDeviceIdList.clear();
        _serialNoList.clear();
        deviceList.clear();

        if (serialNoResults != null) {
          if (serialNoResults.result!.isNotEmpty) {
            deviceList.addAll(serialNoResults.result!);
            _loading = false;
            _loadingMore = false;
            _serialNoList.clear();
            deviceList.forEach((element) {
              if (_serialNoList.any((serialno) => serialno == element.vIN)) {
              } else {
                _serialNoList.add(element.vIN);
              }
            });
          } else {
            _loading = false;
            _loadingMore = false;
          }
          _loading = false;
          _loadingMore = false;
        }
        Logger().wtf(serialNoList.length);
        notifyListeners();
      }
    } on DioError catch (e) {
      final error = DioException.fromDioError(e);
      Fluttertoast.showToast(msg: error.message!);
    }
  }

  getDeviceIds(String text) async {
    try {
      if (enableGraphQl) {
        DeviceIdValues? deviceData = await _subscriptionService!
            .getAssetTransferDeviceIds(graphqlSchemaService!
                .getDeviceIdTransfer(
                    limit: limit,
                    oem: "VEhD",
                    searchkey: "GPSDeviceID",
                    searchValue: text,
                    start: start,
                    userId: (await _localService?.getLoggedInUser())?.sub));
        serialNoList.clear();
        _gpsDeviceIdList.clear();
        deviceIdList.clear();
        if (deviceData != null) {
          if (deviceData.hierarchyFleetSearch!.isNotEmpty) {
            deviceIdList.addAll(deviceData.hierarchyFleetSearch!);
            _loading = false;
            _loadingMore = false;
            deviceIdList.forEach((element) {
              if (_gpsDeviceIdList
                  .any((device) => device == element.gpsDeviceID)) {
              } else {
                _gpsDeviceIdList.add(element.gpsDeviceID);
              }
            });
          } else {
            _loading = false;
            _loadingMore = false;
          }
          _loading = false;
          _loadingMore = false;
        }
        //Logger().wtf(deviceIdResults!.result!.first.gPSDeviceID);
        notifyListeners();
      } else {
        if (text.length >= 3) {
          SingleTransferDeviceId? deviceIdResults = await _subscriptionService!
              .getSingleTransferDeviceId(
                  filter: "asset",
                  filterType: PLANTSUBSCRIPTIONFILTERTYPE.TYPE,
                  controllerValue: text,
                  start: start == 0 ? start : start + 1,
                  limit: limit,
                  searchBy: "GPSDeviceID");
          serialNoList.clear();
          _gpsDeviceIdList.clear();
          deviceList.clear();
          if (deviceIdResults != null) {
            if (deviceIdResults.result!.isNotEmpty) {
              deviceList.addAll(deviceIdResults.result!);
              _loading = false;
              _loadingMore = false;
              deviceList.forEach((element) {
                if (_gpsDeviceIdList
                    .any((device) => device == element.gPSDeviceID)) {
                } else {
                  _gpsDeviceIdList.add(element.gPSDeviceID);
                }
              });
            } else {
              _loading = false;
              _loadingMore = false;
            }
            _loading = false;
            _loadingMore = false;
          }
          //Logger().wtf(deviceIdResults!.result!.first.gPSDeviceID);
          notifyListeners();
        }
      }
    } on DioError catch (e) {
      final error = DioException.fromDioError(e);
      Fluttertoast.showToast(msg: error.message!);
    }
  }

  subscriptionAssetRegistration() async {
    var userId = await _localService!.getUserId();
    try {
      AssetValues deviceAssetValues;
      deviceAssetValues = AssetValues(
        CustomerLanguage:
            initialCustLanguge == languages[0] ? null : initialCustLanguge,
        CustomerMobile: customerMobileNoController.text.isEmpty
            ? null
            : customerMobileNoController.text,
        DealerMobile: dealerMobileNoController.text.isEmpty
            ? null
            : dealerMobileNoController.text,
        DealerLanguage: initialLanguge == languages[0] ? null : initialLanguge,
        deviceId: deviceIdController.text,
        machineSlNo: machineSerialNumberController.text,
        machineModel: machineModelController.text.isEmpty
            ? null
            : machineModelController.text,
        customerName: customerNameController.text.isEmpty
            ? null
            : customerNameController.text,
        customerCode: customerCodeController.text.isEmpty
            ? null
            : customerCodeController.text,
        customerEmailID: customerEmailController.text.isEmpty
            ? null
            : customerEmailController.text,
        dealerName: dealerNameController.text.isEmpty
            ? null
            : dealerNameController.text,
        dealerCode: dealerCodeController.text.isEmpty
            ? null
            : dealerCodeController.text,
        dealerEmailID: dealerEmailController.text.isEmpty
            ? null
            : dealerEmailController.text,
        commissioningDate: null,
        primaryIndustry: _initialIndustryDetail == _industryDetails[0]
            ? null
            : _initialIndustryDetail,
        secondaryIndustry:
            _initialSubIndustryDetailValue == industrySubDetails[0]
                ? null
                : _initialSubIndustryDetailValue,
      );
      _totalAssetValues.clear();
      _totalAssetValues.add(deviceAssetValues);
      AssetTransfer data = AssetTransfer(
          Source: "THC",
          Version: "2.1",
          UserID: int.parse(userId!),
          transfer: _totalAssetValues);
      Logger().i(data.transfer!.length);
      Logger().i(data.transfer!.first.toJson());
      var result =
          await _subscriptionService!.postSingleAssetTransferRegistration(data);
      Logger().e(result);
      onTransferSuccess();
      return result;
    } on DioError catch (e) {
      final error = DioException.fromDioError(e);
      Fluttertoast.showToast(msg: error.message!);
    }
  }

  onPop() {
    totalList[0].clear();
    totalList[1].clear();
    totalList[2].clear();
    totalList[3].clear();
    totalList.clear();
    notifyListeners();
  }

  onTransferSuccess() {
    deviceIdController.clear();
    machineSerialNumberController.clear();
    machineModelController.clear();
    commisioningDateController.clear();
    dealerNameController.clear();
    dealerCodeController.clear();
    dealerEmailController.clear();
    customerNameController.clear();
    customerCodeController.clear();
    customerEmailController.clear();
    customerMobileNoController.clear();
    dealerMobileNoController.clear();
  }
}
