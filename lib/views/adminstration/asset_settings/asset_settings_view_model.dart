import 'package:insite/core/base/insite_view_model.dart';
import 'package:insite/core/locator.dart';
import 'package:insite/core/models/asset.dart';
import 'package:insite/core/models/asset_settings.dart';
import 'package:insite/core/services/asset_admin_manage_user_service.dart';
import 'package:logger/logger.dart';
import 'package:stacked/stacked.dart';
import 'package:insite/core/logger.dart';

class AssetSettingsViewModel extends InsiteViewModel {
  Logger log;
  var _manageUserService = locator<AssetAdminManagerUserService>();

  int pageSize = 20;
  int pageNumber = 1;

  List<AssetSetting> _assets = [];
  List<AssetSetting> get asset => _assets;

  AssetSettingsViewModel() {
    this.log = getLogger(this.runtimeType.toString());
    Future.delayed(Duration(seconds: 2), () {
      getAssetSettingListData();
    });
  }

  getAssetSettingListData() async {
    ManageAssetConfiguration result =
        await _manageUserService.getAssetSettingData(pageSize, pageNumber);
    _assets.addAll(result.assetSettings);
    notifyListeners();
  }
}
