import 'package:insite/core/locator.dart';
import 'package:insite/core/models/asset_status.dart';
import 'package:insite/core/models/customer.dart';
import 'package:insite/core/repository/network.dart';
import 'package:insite/core/services/local_service.dart';
import 'package:logger/logger.dart';

class AssetStatusService {
  var _localService = locator<LocalService>();

  Customer accountSelected;

  AssetStatusService() {
    setup();
  }

  setup() async {
    try {
      accountSelected = await _localService.getAccountInfo();
    } catch (e) {
      Logger().e(e);
    }
  }

  Future<AssetStatusData> getassetStatus() async {
    try {
      AssetStatusData assetStatusResponse = await MyApi()
          .getClient()
          .assetStatus("assetstatus", accountSelected.CustomerUID);
      return assetStatusResponse;
    } catch (e) {
      Logger().e(e);
      return null;
    }
  }
}
