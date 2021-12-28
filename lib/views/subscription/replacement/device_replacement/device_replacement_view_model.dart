import 'package:flutter/widgets.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:insite/core/base/insite_view_model.dart';
import 'package:insite/core/locator.dart';
import 'package:insite/core/services/local_service.dart';
import 'package:insite/core/services/replacement_service.dart';
import 'package:insite/views/subscription/replacement/device_replacement_status/device_replacement_status_view.dart';
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
    Logger().d(userId);
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
        // Future.delayed(Duration(seconds: 2), () {

        // });
        notifyListeners();
        return null;
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

      // searchingOldDeviceId = true;
      notifyListeners();
    } catch (e) {
      Fluttertoast.showToast(msg: "No Data Found");
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
    replaceDeviceIdController.text =
        _replaceDeviceModelData!.result!.last[i].GPSDeviceID!;
    checkingNewDeviceIdEnter = false;
    notifyListeners();
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
        showLoadingDialog();
        _searchList.clear();
        _deviceSearchModelResponse = await replacementService!
            .getDeviceSearchModelResponse(searchTextController.text);
        isGettingOldDeviceId = true;
        Logger().e(_deviceSearchModelResponse!.result!.toJson());
        searchingOldDeviceId = true;
        hideLoadingDialog();
        notifyListeners();
        return searchingOldDeviceId;
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
        _replaceDeviceModelData!.result!.last.clear();
        notifyListeners();
      } else {
        _replaceDeviceModelData =
            await replacementService!.getReplaceDeviceModel(searchWord);
        Logger().d(_replaceDeviceModelData!.result!.last.first.toJson());
        checkingNewDeviceIdEnter = true;
        notifyListeners();
      }
    } catch (e) {}
  }

  onPageChange(int value) {
    changingIndex = value;
    notifyListeners();
  }

  onRegister() async {
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

   Logger().e(userId);
      ReplacementModel replacementData = ReplacementModel(
          Source: "THC",
          UserID: int.parse(userId!),
          Version: 2.1,
          device: [NewdeviceData]);

      Logger().d(replacementData.device!.first.toJson());
      var data = await replacementService!.savingReplacement(replacementData);
      searchList.clear();
      navigationService!.clearTillFirstAndShowView(
        DeviceReplacementStatusView(),
      );
      hideLoadingDialog();
      notifyListeners();
    } catch (e) {
      Logger().e(e.toString());
      Fluttertoast.showToast(msg: "Invalid Request.Try again Later");
      hideLoadingDialog();
    }
  }
}
