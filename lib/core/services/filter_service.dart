import 'package:insite/core/base/base_service.dart';
import 'package:insite/core/models/asset_status.dart';
import 'package:insite/core/models/customer.dart';
import 'package:insite/core/repository/network.dart';
import 'package:logger/logger.dart';

import '../locator.dart';
import 'local_service.dart';

class FilterService extends BaseService {
  Customer accountSelected;
  Customer customerSelected;
  var _localService = locator<LocalService>();

  setUp() async {
    try {
      accountSelected = await _localService.getAccountInfo();
      customerSelected = await _localService.getCustomerInfo();
    } catch (e) {
      Logger().e(e);
    }
  }

  Future<AssetStatusData> getAssetCount(type) async {
    try {
      AssetStatusData assetStatusResponse = await MyApi()
          .getClient()
          .assetCount(type, accountSelected.CustomerUID);
      return assetStatusResponse;
    } catch (e) {
      Logger().e(e);
      return null;
    }
  }
}
