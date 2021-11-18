import 'package:insite/core/base/base_service.dart';
import 'package:insite/core/locator.dart';
import 'package:insite/core/models/customer.dart';
import 'package:insite/core/models/plant_heirarchy.dart';

import 'package:insite/core/repository/network.dart';
import 'package:insite/core/services/local_service.dart';
import 'package:insite/utils/enums.dart';
import 'package:insite/utils/filter.dart';
import 'package:insite/utils/urls.dart';
import 'package:logger/logger.dart';

class PlantHeirarchyAssetService extends BaseService {
  var _localService = locator<LocalService>();

  Customer accountSelected;
  Customer customerSelected;
  String token;

  PlantHeirarchyAssetService() {
    setUp();
  }

  setUp() async {
    try {
      accountSelected = await _localService.getAccountInfo();
      customerSelected = await _localService.getCustomerInfo();
      token = await _localService.getToken();
    } catch (e) {
      Logger().e(e);
    }
  }

  Future<HierarchyAssets> getResultsFromPlantHierchyApi() async {
    try {
      Map<String, String> queryMap = Map();
      if (accountSelected != null) {
        queryMap["OEM"] = "VEhD";
      }

      HierarchyAssets heierarchyssetsResults =
          await MyApi().getClientNine().getPlantHierarchyAssetsDetails(
                Urls.plantHierarchyAssetsResult +
                    FilterUtils.constructQueryFromMap(queryMap),
              );

      if (heierarchyssetsResults == null) {
        Logger().d('no data found');
      }

      Logger().d('hierarchy result: $heierarchyssetsResults');
      return heierarchyssetsResults;
    } catch (e) {
      Logger().e(e.toString());
      return null;
    }
  }
}