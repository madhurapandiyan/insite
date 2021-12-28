import 'package:flutter/material.dart';
import 'package:insite/core/base/insite_view_model.dart';
import 'package:insite/core/locator.dart';
import 'package:insite/core/logger.dart';
import 'package:insite/core/models/asset_fuel_burn_rate_settings.dart';
import 'package:insite/core/models/asset_fuel_burn_rate_settings_list_data.dart';
import 'package:insite/core/services/asset_admin_manage_user_service.dart';
import 'package:logger/logger.dart';

class EstimatedBurnRateViewModel extends InsiteViewModel {
  Logger? log;
  TextEditingController workingcontroller = TextEditingController();
  TextEditingController idleController = TextEditingController();
  AssetAdminManagerUserService? _manageUserService = locator<AssetAdminManagerUserService>();
  List<String?>? _assetUId;
  List<String?>? get assetUID => _assetUId;

  double? _workingValue;
  double? get workingValue => _workingValue;

  double galConversionValue = 3.784;

  double? _idleValue;
  double? get idleValue => _idleValue;

  EstimatedBurnRateViewModel(List<String?>? assetUid) {
    this._assetUId = assetUid;
    this.log = getLogger(this.runtimeType.toString());

    getAssetFuelBurnRateSettingsListData();
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

  getAssetSettingFuelBurnRateData(BuildContext context) async {
    _workingValue = double.parse(workingcontroller.text);
    _idleValue = double.parse(idleController.text);

    AddSettings? result = await _manageUserService!.getFuelBurnRateSettingsData(
        idleValue! * galConversionValue,
        workingValue! * galConversionValue,
        assetUID);
    if (result != null) {
      Navigator.of(context).pop(true);
    } else {
      Navigator.of(context).pop(false);
    }

    notifyListeners();
  }

  getAssetFuelBurnRateSettingsListData() async {
    AssetFuelBurnRateSettingsListData? result =
        await _manageUserService!.getAssetFuelBurnRateListData(assetUID);
    if (result != null) {
      result.assetFuelBurnRateSettings!.forEach((element) {
        double workingValue = element.workTargetValue! / galConversionValue;
        double idleValue = element.idleTargetValue! / galConversionValue;
        workingcontroller.text = workingValue.toInt().toString();
        idleController.text = idleValue.toInt().toString();
        notifyListeners();
      });
    } else {
      workingcontroller.text = "0";
      idleController.text = "0";
      notifyListeners();
    }

    Logger().w(result);
  }
}
