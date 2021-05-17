import 'package:insite/core/base/base_service.dart';
import 'package:insite/core/locator.dart';
import 'package:insite/core/models/asset_location.dart';
import 'package:insite/core/models/customer.dart';
import 'package:insite/core/repository/network.dart';
import 'package:insite/core/services/local_service.dart';
import 'package:logger/logger.dart';

class AssetLocationService extends BaseService {
  Customer accountSelected;
  Customer customerSelected;
  var _localService = locator<LocalService>();

  AssetLocationService() {
    setUp();
  }

  setUp() async {
    try {
      accountSelected = await _localService.getAccountInfo();
      customerSelected = await _localService.getCustomerInfo();
    } catch (e) {
      Logger().e(e);
    }
  }

  Future<AssetLocationData> getAssetLocation(
      int pageNumber, int pageSize, String sort) async {
    try {
      if (pageNumber != null && pageSize != null && sort != null) {
        AssetLocationData result = await MyApi().getClient().assetLocation(
            pageNumber, pageSize, sort, 'd7ac4554-05f9-e311-8d69-d067e5fd4637');
        return result;
      }
      return null;
    } catch (e) {
      Logger().e(e);
      return null;
    }
  }
}
