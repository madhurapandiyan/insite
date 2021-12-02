import 'package:insite/core/base/base_service.dart';
import 'package:insite/core/locator.dart';
import 'package:insite/core/models/asset_creation_payload.dart';
import 'package:insite/core/models/asset_creation_reset_data.dart';
import 'package:insite/core/models/asset_creation_response.dart';
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

  Future<AssetCreationResponse> getAssetCreationData(
      String machineSerialNumber) async {
    try {
      Map<String, String> queryMap = Map();
      queryMap["oemName"] = "THC";
      queryMap["machineSerialNumber"] = machineSerialNumber;
      AssetCreationResponse assetCreationResponse = await MyApi()
          .getClientSix()
          .getAssetCreationData(Urls.plantAssetCreationResult +
              FilterUtils.constructQueryFromMap(queryMap));
      return assetCreationResponse;
    } catch (e) {
      Logger().e(e.toString());
    }
    return null;
  }

  Future<AssetCreationResetData> getAssetCreationResetData(
      AssetCreationPayLoad data) async {
    Map<String, String> queryMap = Map();
    queryMap["oemName"] = "THC";

    if (isVisionLink) {
    } else {
      AssetCreationResetData assetCreationResetData = await MyApi()
          .getClientSix()
          .getAssetCreationRestData(
              Urls.assetCreationResetdata +
                  FilterUtils.constructQueryFromMap(queryMap),
              data);
      return assetCreationResetData;
    }

    return null;
  }

  Future<AssetCreationResetData> getDownloadResetData() async {
    try {
      Map<String, String> queryMap = Map();
      queryMap["oemName"] = "THC";
      if (isVisionLink) {
      } else {
        AssetCreationResetData assetCreationResetData = await MyApi()
            .getClientSix()
            .getDownloadResetData(Urls.downloadResetData +
                FilterUtils.constructQueryFromMap(queryMap));
        return assetCreationResetData;
      }
    } catch (e) {
      Logger().e(e.toString());
    }
    return null;
  }
}
