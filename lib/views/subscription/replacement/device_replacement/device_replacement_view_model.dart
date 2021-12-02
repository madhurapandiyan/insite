import 'package:flutter/widgets.dart';
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
  Logger log;
  final replacementService = locator<ReplacementService>();
  final _localService = locator<LocalService>();

  DeviceReplacementViewModel() {
    this.log = getLogger(this.runtimeType.toString());
    getUserId();
  }

  String userId;
  bool initialAlign = false;
  bool finalAlign = false;
  bool showingOldPreview = false;
  bool showNewPreview = false;
  bool isBackPressed = false;
  bool showingDialog = false;

  List<DeviceContainsList> _searchList = [];
  List<DeviceContainsList> get searchList => _searchList;

  DeviceSearchModelResponse _deviceSearchModelResponse;
  DeviceSearchModelResponse get deviceSearchModelResponse =>
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

  ReplaceDeviceModel _replaceDeviceModelData;
  ReplaceDeviceModel get replaceDeviceModelData => _replaceDeviceModelData;

  onDropDownChanged(String value) {
    initialvalue = value;
    notifyListeners();
  }

  getUserId() async {
    userId = await _localService.getUserId();
    Logger().d(userId);
  }

  onBackPressed() {
    // showingOldPreview = true;
    showNewPreview = !showNewPreview;
    // _replaceDeviceModelData = null;
    notifyListeners();
  }

  showingOldDeviceIdPreview() {
    Logger().d("mapko");
    if (isBackPressed) {
      return;
    } else {
      showingOldPreview = !showingOldPreview;
      notifyListeners();
      // showingOldPreview = false;

    }
  }

  onEnteringDeviceId(String searchedWord) async {
    // Logger().wtf(searchedWord);
    if (searchedWord.length < 4) {
      _searchList.clear();
      // Future.delayed(Duration(seconds: 2), () {
        
      // });
      notifyListeners();
      return null;
    } else {
      DeviceSearchModel data =
          await replacementService.getDeviceSearchModel(searchedWord);
      data.result.forEach((element) {
        _searchList = element;
      });
      Logger().w(_searchList.length);
      if (_searchList.isEmpty) {
        snackbarService.showSnackbar(message: "No Data Found");
      }

      notifyListeners();
    }
    notifyListeners();
  }

  onSelectedDeviceId(int i) {
    searchTextController.text = searchList[i].containsList;
    searchList.clear();
    notifyListeners();
  }

  onSelectedNewDeviceId(int i) {
    Logger().e("uiyoih");
    replaceDeviceIdController.text =
        _replaceDeviceModelData.result.first[i].GPSDeviceID;
  }

  onSearchingDeviceId() async {
    try {
      showLoadingDialog();
      _searchList.clear();
      _deviceSearchModelResponse = await replacementService
          .getDeviceSearchModelResponse(searchTextController.text);
      Logger().e(_deviceSearchModelResponse.result.toJson());
      initialAlign = !initialAlign;

      notifyListeners();
      hideLoadingDialog();
    } catch (e) {
      hideLoadingDialog();
      notifyListeners();
    }
  }

  onGettingReplaceDeviceId(String searchWord) async {
    try {
      if (searchWord.length < 4) {
        _replaceDeviceModelData = null;
        _replaceDeviceModelData.result.last.clear();
        notifyListeners();
      } else {
        _replaceDeviceModelData =
            await replacementService.getReplaceDeviceModel(searchWord);
        Logger().d(_replaceDeviceModelData.result.last.first.toJson());
        notifyListeners();
      }
    } catch (e) {}
  }

  onRegister() async {
    try {
      showLoadingDialog();
      finalAlign = true;
      notifyListeners();
      NewDeviceIdDetail NewdeviceData = NewDeviceIdDetail(
          Reason: initialvalue,
          VIN: deviceSearchModelResponse.result.VIN,
          NewDeviceId: replaceDeviceIdController.text,
          OldDeviceId: deviceSearchModelResponse.result.GPSDeviceID);
      //Logger().d(NewdeviceData.toJson());
      //Logger().w(userId);
      ReplacementModel replacementData = ReplacementModel(
          Source: "THC",
          UserID: int.parse(userId) ?? 58839,
          Version: 2.1,
          device: [NewdeviceData]);

      Logger().d(replacementData.toJson());
      var data = await replacementService.savingReplacement(replacementData);
      searchList.clear();
      navigationService.clearTillFirstAndShowView(
        DeviceReplacementStatusView(),
      );
      hideLoadingDialog();
      notifyListeners();
    } catch (e) {
      Logger().e(e.toString());
      hideLoadingDialog();
    }
  }
}
