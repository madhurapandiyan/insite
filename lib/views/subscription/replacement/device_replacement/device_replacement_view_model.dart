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
  int? changingIndex = 0;

  List<dynamic> _searchList = [];
  List<dynamic> get searchList => _searchList;

  dynamic _deviceSearchModelResponse;
  dynamic get deviceSearchModelResponse => _deviceSearchModelResponse;

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

  dynamic _replaceDeviceModelData;
  dynamic get replaceDeviceModelData => _replaceDeviceModelData;

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
        _searchList.clear();

        notifyListeners();
        return null;
      } else {
        if (enableGraphQl) {
          SubscriptionDeviceFleetList? deviceFleetList =
              await replacementService!.getSearchedDeviceDetails(
                  graphqlSchemaService!
                      .getDeviceIdReplacement(searchedWord, "active",20));

          _searchList = deviceFleetList!.provisioningInfo!;

          Logger().wtf(_searchList.length);
          if (_searchList.isEmpty) {
            Fluttertoast.showToast(msg: "No Data Found");
            return;
          }

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
    if (enableGraphQl) {
      searchTextController.text = searchList[i].gpsDeviceID!;
      checkingDeviceIdEnter = true;
      searchList.clear();
      notifyListeners();
    } else {
      searchTextController.text = searchList[i].containsList!;
      checkingDeviceIdEnter = true;
      searchList.clear();
      notifyListeners();
    }
  }

  onSelectedNewDeviceId(int i) {
    if (enableGraphQl) {
      replaceDeviceIdController.text =
          _replaceDeviceModelData!.provisioningInfo![i].gpsDeviceID!;
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
      if (searchTextController.text.length < 4) {
        Fluttertoast.showToast(msg: "Enter valid device id");
        return false;
      } else {
        if (enableGraphQl) {
          showLoadingDialog();
          _searchList.clear();
          _deviceSearchModelResponse = await replacementService!
              .getSearchedDeviceDetails(graphqlSchemaService!
                  .getDeviceIdReplacement(searchTextController.text, "active",20));

          isGettingOldDeviceId = true;
          searchingOldDeviceId = true;
          hideLoadingDialog();
          notifyListeners();
          return searchingOldDeviceId;
        } else {
          showLoadingDialog();
          _searchList.clear();
          _deviceSearchModelResponse = await replacementService!
              .getDeviceSearchModelResponse(searchTextController.text);
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
        _replaceDeviceModelData = null;
        isGettingNewDeviceId = false;
        checkingNewDeviceIdEnter = false;
        notifyListeners();
      } else {
        if (enableGraphQl) {
          _replaceDeviceModelData = await replacementService!
              .getSearchedDeviceDetails(graphqlSchemaService!
                  .getDeviceIdReplacement(searchWord, "inactive",20));

          if (_replaceDeviceModelData!.provisioningInfo!.isEmpty) {
            Fluttertoast.showToast(msg: "Device Not Found");
            replaceDeviceIdController.clear();
            notifyListeners();
            return;
          }
          checkingNewDeviceIdEnter = true;
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
          Version: 2.1,
          device: [NewdeviceData]);
      var data = await replacementService!.savingReplacement(replacementData);
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
