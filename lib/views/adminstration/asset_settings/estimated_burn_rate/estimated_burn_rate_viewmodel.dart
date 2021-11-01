import 'package:flutter/material.dart';
import 'package:insite/core/base/insite_view_model.dart';
import 'package:insite/core/locator.dart';
import 'package:insite/core/logger.dart';
import 'package:insite/core/models/asset_fuel_burn_rate_settings.dart';
import 'package:insite/core/models/asset_settings.dart';
import 'package:insite/core/services/asset_admin_manage_user_service.dart';
import 'package:insite/views/adminstration/asset_settings/asset_settings_view.dart';
import 'package:logger/logger.dart';
import 'package:stacked_services/stacked_services.dart';

class EstimatedBurnRateViewModel extends InsiteViewModel {
  Logger log;
  TextEditingController workingcontroller = TextEditingController();
  TextEditingController idleController = TextEditingController();
  var _manageUserService = locator<AssetAdminManagerUserService>();
  String _assetUId;
  String get assetUID => _assetUId;
  double _workingValue;
  double get workingValue => _workingValue;

  var _navigationService = locator<NavigationService>();

  double _idleValue;
  double get idleValue => _idleValue;

  EstimatedBurnRateViewModel(AssetSetting assetSetting) {
    this._assetUId = assetSetting.assetUid;
    this.log = getLogger(this.runtimeType.toString());
    workingcontroller.text = "0";
    idleController.text = "0";
  }
  void getIncrementWorkingValue() {
    int currentValue = int.parse(workingcontroller.text);

    currentValue++;
    workingcontroller.text = (currentValue).toString();
    notifyListeners();
  }

  getDecrementWorkingValue() {
    int currentValue = int.parse(workingcontroller.text);
    currentValue--;
    workingcontroller.text = (currentValue > 0 ? currentValue : 0).toString();
    notifyListeners();
  }

  getIncrementIdleValue() {
    int currentValue = int.parse(idleController.text);
    currentValue++;
    idleController.text = (currentValue).toString();
    notifyListeners();
  }

  getDecrementIdleValue() {
    int currentValue = int.parse(idleController.text);
    currentValue--;
    idleController.text = (currentValue > 0 ? currentValue : 0).toString();
    notifyListeners();
  }

  getAssetSettingFuelBurnRateData() async {
    _workingValue = double.parse(workingcontroller.text);
    _idleValue = double.parse(idleController.text);

    AddSettings result = await _manageUserService.getFuelBurnRateSettingsData(
        idleValue, workingValue, assetUID);
    if (result != null) {
      _navigationService.navigateWithTransition(AssetSettingsView(),
          transition: "rightToLeft");
    }

    notifyListeners();
  }
}
