import 'package:flutter/widgets.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:insite/core/base/base_service.dart';
import 'package:insite/core/base/insite_view_model.dart';
import 'package:insite/core/locator.dart';
import 'package:insite/core/services/local_service.dart';
import 'package:insite/core/services/replacement_service.dart';
// ignore: unused_import
import 'package:insite/views/subscription/replacement/device_replacement_status/device_replacement_status_view.dart';
import 'package:insite/views/subscription/replacement/model/device_replacement_details.dart';
import 'package:insite/views/subscription/replacement/model/device_search_model.dart';
import 'package:insite/views/subscription/replacement/model/device_search_model_response.dart';
import 'package:insite/views/subscription/replacement/model/replace_deviceId_model.dart';
import 'package:insite/views/subscription/replacement/model/replacement_model.dart';
import 'package:load/load.dart';
import 'package:logger/logger.dart';
import 'package:insite/core/logger.dart';

class DeviceReplacementViewModel extends InsiteViewModel {
  Logger? log;
  final ReplacementService? replacementService = locator<ReplacementService>();
  final LocalService? _localService = locator<LocalService>();

  DeviceReplacementViewModel() {
    this.log = getLogger(this.runtimeType.toString());

    getUserId();
  }

  String? userId;
  bool searchingOldDeviceId = false;
  bool finalAlign = false;
  bool checkingDeviceIdEnter = false;
  bool checkingNewDeviceIdEnter = false;
  bool showingNewDeviceIdPreview = false;
  bool showingDialog = false;
  bool isGettingOldDeviceId = false;
  bool isGettingNewDeviceId = false;
  bool isisShowingHelperText = false;
  int? changingIndex = 0;

  List<DeviceContainsList> _searchList = [];
  List<DeviceContainsList> get searchList => _searchList;

  DeviceSearchModelResponse? _deviceSearchModelResponse;
  DeviceSearchModelResponse? get deviceSearchModelResponse =>
      _deviceSearchModelResponse;

  var searchTextController = TextEditingController();
  var replaceDeviceIdController = TextEditingController();

  List<String> dropDownValues = [
    "Select Reason *",
    "Wrong device id mapped",
    "Network Issue",
    "All connections Ok - Not reporting",
    "Fuel Issue"
  ];

  String initialvalue = "Select Reason *";

  ReplaceDeviceModel? _replaceDeviceModelData;
  ReplaceDeviceModel? get replaceDeviceModelData => _replaceDeviceModelData;

  onDropDownChanged(String value) {
    initialvalue = value;
    notifyListeners();
  }

  getUserId() async {
    userId = await _localService!.getUserId();
    Logger().w(userId);
  }

  onBackPressed() {
    showingNewDeviceIdPreview = !showingNewDeviceIdPreview;
    notifyListeners();
  }

  showingOldDeviceIdPreview() {
    isGettingNewDeviceId = false;
    //showingOldPreview = !showingOldPreview;
    notifyListeners();
    // showingOldPreview = false;
  }

  onBackPressedInNewDeviceIdPreview() async {
    //showNewPreview = false;
    notifyListeners();
    Future.delayed(Duration(seconds: 1), () {
      // showNewPreview = true;
    });
  }

  onEnteringDeviceId(String searchedWord) async {
    try {
      if (searchedWord.length < 4) {
        isisShowingHelperText = false;
        checkingDeviceIdEnter = false;
        _searchList.clear();

        notifyListeners();
        return null;
      } else {
        if (enableGraphQl) {
          SubscriptionDeviceFleetList? deviceFleetList =
              await replacementService!.getSearchedDeviceDetails(
                  graphqlSchemaService!.getDeviceIdReplacement(), {
            "status": "active",
            "model": "",
            "start": 0,
            "limit": 20,
            "search": {"gpsDeviceID": searchedWord}
          });
          if (deviceFleetList?.count == null) {
            isisShowingHelperText = true;
            //  Fluttertoast.showToast(msg: "No Data Found");
          } else {
            isisShowingHelperText = false;
          }

          if (deviceFleetList?.provisioningInfo != null &&
              deviceFleetList!.provisioningInfo!.isNotEmpty) {
            final result = deviceFleetList.provisioningInfo?.first;
            _deviceSearchModelResponse = DeviceSearchModelResponse(
                result: DeviceSearchResponce(
                    GPSDeviceID: result?.gpsDeviceID,
                    Model: result?.model,
                    VIN: result?.model,
                    S_StartDate: result?.subscriptionStartDate));
                    _searchList.clear();
            deviceFleetList!.provisioningInfo!.forEach((element) {
              _searchList.add(DeviceContainsList(
                  containsList: element.gpsDeviceID, count: 1));
            });
          }

          //_searchList = deviceFleetList!.provisioningInfo!;

          Logger().wtf(_searchList.length);
          // if (_searchList.isEmpty) {
          //   Fluttertoast.showToast(msg: "No Data Found");
          //   return;
          // }

          notifyListeners();
        } else {
          DeviceSearchModel? data =
              await replacementService!.getDeviceSearchModel(searchedWord);
          data!.result!.forEach((element) {
            _searchList = element;
          });
          Logger().w(_searchList.length);
          if (_searchList.isEmpty) {
            Fluttertoast.showToast(msg: "No Data Found");
            return;
          }
        }

        notifyListeners();
      }
    } catch (e) {
      Logger().e(e.toString());
    }
    // Logger().wtf(searchedWord);
  }

  onSelectedDeviceId(int i) {
    searchTextController.text = searchList[i].containsList!;
    checkingDeviceIdEnter = true;
    searchList.clear();
    notifyListeners();
  }

  onSelectedNewDeviceId(int i) {
    if (enableGraphQl) {
      replaceDeviceIdController.text =
          _replaceDeviceModelData!.result!.last[i].GPSDeviceID!;
      checkingNewDeviceIdEnter = false;
      notifyListeners();
    } else {
      replaceDeviceIdController.text =
          _replaceDeviceModelData!.result!.last[i].GPSDeviceID!;
      checkingNewDeviceIdEnter = false;
      notifyListeners();
    }
  }

  onChangingPageView(int value) {
    changingIndex = value;
    notifyListeners();
  }

  Future<bool?> onSearchingDeviceId() async {
    try {
      var searchId;
      if (searchTextController.text.length < 4) {
        Fluttertoast.showToast(msg: "Enter valid device id");
        return false;
      } else {
        if (enableGraphQl) {
          final result;
          showLoadingDialog();
          _searchList.clear();
          var searchId = await replacementService!.getSearchedDeviceDetails(
              graphqlSchemaService!.getDeviceIdReplacement(), {
            "status": "active",
            "model": "",
            "start": 0,
            "limit": 20,
            "search": {"gpsDeviceID": searchTextController.text}
          });

          if (searchId?.provisioningInfo != null &&
              searchId!.provisioningInfo!.isNotEmpty) {
            result = searchId.provisioningInfo!.first;
            _deviceSearchModelResponse = DeviceSearchModelResponse(
                result: DeviceSearchResponce(
                    GPSDeviceID: result?.gpsDeviceID,
                    Model: result?.model,
                    VIN: result?.vin,
                    S_StartDate: result?.subscriptionStartDate));
          }

          isGettingOldDeviceId = true;
          searchingOldDeviceId = true;
          hideLoadingDialog();
          notifyListeners();
          return searchingOldDeviceId;
        } else {
          showLoadingDialog();
          _searchList.clear();

          searchId = await replacementService!
              .getDeviceSearchModelResponse(searchTextController.text);

          var value = searchId?.result;
          _deviceSearchModelResponse = DeviceSearchModelResponse(
              result: DeviceSearchResponce(
                  GPSDeviceID: value?.GPSDeviceID,
                  Model: value?.Model,
                  VIN: value?.VIN,
                  S_StartDate: value?.S_StartDate));
          isGettingOldDeviceId = true;
          searchingOldDeviceId = true;
          hideLoadingDialog();
          notifyListeners();
          return searchingOldDeviceId;
        }
      }
    } catch (e) {
      Logger().e(e.toString());
      //searchingOldDeviceId = false;
      Fluttertoast.showToast(msg: "No device Id found");
      hideLoadingDialog();
      notifyListeners();
      return false;
    }
  }

  onItemChange() {}

  onGettingReplaceDeviceId(String searchWord) async {
    try {
      if (searchWord.length < 4) {
        isisShowingHelperText = false;
        _replaceDeviceModelData = null;
        isGettingNewDeviceId = false;
        checkingNewDeviceIdEnter = false;
        notifyListeners();
      } else {
        if (enableGraphQl) {
          var data = await replacementService!.getSearchedDeviceDetails(
              graphqlSchemaService!.getDeviceIdReplacement(), {
            "status": "inactive",
            "model": "",
            "start": 0,
            "limit": 20,
            "search": {"gpsDeviceID": searchWord}
          });
          if (data?.count == null) {
            isisShowingHelperText = true;

            //  Fluttertoast.showToast(msg: "No Data Found");

          } else {
            isisShowingHelperText = false;
          }

          if (data?.provisioningInfo != null &&
              data!.provisioningInfo!.isNotEmpty) {
            List<DeviceModel> searchList = [];
            data.provisioningInfo?.forEach((element) {
              searchList.add(DeviceModel(
                  GPSDeviceID: element.gpsDeviceID,
                  Model: element.model,
                  VIN: element.vin,
                  SubscriptionStartDate: element.subscriptionStartDate));
            });
            _replaceDeviceModelData = ReplaceDeviceModel(result: [searchList]);
            checkingNewDeviceIdEnter = true;
          }

          // if (data.provisioningInfo!.isEmpty) {
          // //  Fluttertoast.showToast(msg: "Device Not Found");
          //   replaceDeviceIdController.clear();
          //   checkingNewDeviceIdEnter = false;
          //   notifyListeners();
          //   return;
          // }

          notifyListeners();
        } else {
          _replaceDeviceModelData =
              await replacementService!.getReplaceDeviceModel(searchWord);
          if (_replaceDeviceModelData!.result!.last.isEmpty) {
            Fluttertoast.showToast(msg: "Device Not Found");
            replaceDeviceIdController.clear();
            notifyListeners();
            return;
          }
          checkingNewDeviceIdEnter = true;
          notifyListeners();
        }
      }
    } catch (e) {
      Logger().e(e.toString());
    }
  }

  onPageChange(int value) {
    changingIndex = value;
    notifyListeners();
  }

  Future<String?> onRegister() async {
    try {
      showLoadingDialog();
      finalAlign = true;
      notifyListeners();
      NewDeviceIdDetail NewdeviceData = NewDeviceIdDetail(
          Reason: initialvalue,
          VIN: deviceSearchModelResponse!.result!.VIN,
          NewDeviceId: replaceDeviceIdController.text,
          OldDeviceId: deviceSearchModelResponse!.result!.GPSDeviceID);
      //Logger().d(NewdeviceData.toJson());
      //Logger().w(userId);
      ReplacementModel replacementData = ReplacementModel(
          Source: "THC",
          UserID: int.parse(userId!),
          Version: 2.0,
          device: [NewdeviceData]);
      var data = await replacementService!
          .savingReplacement(replacementData, graphqlSchemaService!.register());
      if (data["status"] == "success") {
        searchList.clear();
        showingNewDeviceIdPreview = false;
        Logger().e(data);
        Fluttertoast.showToast(msg: "Replacement successfull");

        hideLoadingDialog();
        //onReplacementSuccessful();
        notifyListeners();
        return data["status"];
      } else {
        notifyListeners();
        return "failed";
      }
    } catch (e) {
      Logger().e(e.toString());
      Fluttertoast.showToast(msg: "Invalid Request.Try again Later");
      hideLoadingDialog();
    }
  }

  onReplacementSuccessful() {
    searchTextController.clear();
    replaceDeviceIdController.clear();
    _searchList.clear();
  }
}
