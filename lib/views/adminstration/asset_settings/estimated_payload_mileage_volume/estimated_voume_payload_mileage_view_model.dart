import 'package:flutter/cupertino.dart';
import 'package:insite/core/base/insite_view_model.dart';
import 'package:insite/core/locator.dart';
import 'package:insite/core/logger.dart';
import 'package:insite/core/models/asset_mileage_settings_list_data.dart';
import 'package:insite/core/models/asset_settings.dart';
import 'package:insite/core/services/asset_admin_manage_user_service.dart';
import 'package:insite/views/adminstration/asset_settings/asset_settings_view.dart';
import 'package:logger/logger.dart';
import 'package:insite/core/models/asset_mileage_settings.dart';
import 'package:stacked_services/stacked_services.dart';

class EstimatedVoumePayloadMileage extends InsiteViewModel {
  Logger log;
  var _manageUserService = locator<AssetAdminManagerUserService>();

  List<String> _assetUId;
  List<String> get assetUId => _assetUId;

  TextEditingController kiloController = TextEditingController();

  EstimatedVoumePayloadMileage(List<String> assetUid) {
    _assetUId = assetUid;
    this.log = getLogger(this.runtimeType.toString());
    getAssetMileageSettingsListData();
  }
  getAssetMileageData(value, BuildContext context) async {
    AssetMileageSettingData result =
        await _manageUserService.getAssetMileageData(assetUId, value);

    if (result != null) {
      Navigator.of(context).pop(true);
    } else {
      Navigator.of(context).pop(false);
    }
    notifyListeners();
  }

  getAssetMileageSettingsListData() async {
    AssetMileageSettingsListData result =
        await _manageUserService.getAssetMileageSettingsListData(assetUId);
    Logger().w(result);
    if (result != null) {
      result.assetMileageSettings.forEach((element) {
        kiloController.text = (element.targetValue * 0.62).toStringAsFixed(1);
        notifyListeners();
      });
    } else {
      kiloController.text = "0";
      notifyListeners();
    }
  }
}
