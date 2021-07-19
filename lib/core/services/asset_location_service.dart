import 'package:insite/core/base/base_service.dart';
import 'package:insite/core/locator.dart';
import 'package:insite/core/models/asset_location.dart';
import 'package:insite/core/models/customer.dart';
import 'package:insite/core/models/filter_data.dart';
import 'package:insite/core/models/location_search.dart';
import 'package:insite/core/repository/network.dart';
import 'package:insite/core/services/local_service.dart';
import 'package:insite/utils/urls.dart';
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

  Future<AssetLocationData> getAssetLocationWithCluster(
    int pageNumber,
    int pageSize,
    String sort,
    double latitude,
    double longitude,
    double radiusKm,
  ) async {
    try {
      if (pageNumber != null && pageSize != null && sort != null) {
        AssetLocationData result = await MyApi()
            .getClient()
            .assetLocationWithCluster(latitude, longitude, pageNumber, pageSize,
                radiusKm, sort, accountSelected.CustomerUID);
        return result;
      }
      return null;
    } catch (e) {
      Logger().e(e);
      return null;
    }
  }

  Future<AssetLocationData> getAssetLocation(
      int pageNumber, int pageSize, String sort, appliedFilters) async {
    try {
      if (pageNumber != null &&
          pageSize != null &&
          sort != null &&
          customerSelected != null) {
        AssetLocationData result = await MyApi()
            .getClient()
            .assetLocationSummary(
                Urls.locationSummary +
                    getFilterUrl(pageNumber, pageSize,
                        customerSelected.CustomerUID, sort, appliedFilters),
                accountSelected.CustomerUID);
        return result;
      } else if (pageNumber != null && pageSize != null && sort != null) {
        AssetLocationData result = await MyApi()
            .getClient()
            .assetLocationSummary(
                Urls.locationSummary +
                    getFilterUrl(
                        pageNumber, pageSize, null, sort, appliedFilters),
                accountSelected.CustomerUID);
        return result;
      }
      return null;
    } catch (e) {
      Logger().e(e);
      return null;
    }
  }

  Future<AssetLocationData> getAssetLocationWithoutFilter(
      int pageNumber, int pageSize, String sort) async {
    try {
      if (pageNumber != null && pageSize != null && sort != null) {
        AssetLocationData result = await MyApi()
            .getClient()
            .assetLocationWithOutFilter(
                pageNumber, pageSize, sort, accountSelected.CustomerUID);
        return result;
      }
      return null;
    } catch (e) {
      Logger().e(e);
      return null;
    }
  }

  Future<List<LocationSearchData>> searchLocation(
      int maxResults, String query) async {
    var authToken = "366658D213F9F1429033919FCAE365FC";
    try {
      LocationSearchResponse result = await MyApi()
          .getClientTwo()
          .getLocations(query, maxResults, authToken);
      List<LocationSearchData> list = result.Locations;
      return list;
    } catch (e) {
      Logger().e(e);
      return null;
    }
  }

  String getFilterUrl(
      pageNumber, pageSize, customerId, sort, List<FilterData> appliedFilters) {
    StringBuffer value = StringBuffer();
    value.write(constructQuery("pageNumber", pageNumber.toString(), true));
    value.write(constructQuery("pageSize", pageSize.toString(), false));
    if (sort != null) {
      value.write(constructQuery("sort", sort, false));
    }
    if (customerId != null) {
      value.write(constructQuery("customerIdentifier", customerId, false));
    }
    if (appliedFilters.isNotEmpty) {
      // manufacturer
      List<FilterData> makeList = appliedFilters
          .where((element) => element.type == FilterType.MAKE)
          .toList();
      Logger().i("filter makeList " + makeList.length.toString());
      if (makeList.isNotEmpty) {
        for (FilterData data in makeList) {
          value.write(constructQuery("manufacturer", data.title, false));
        }
      }
      // productfamily
      List<FilterData> productFamilyList = appliedFilters
          .where((element) => element.type == FilterType.PRODUCT_FAMILY)
          .toList();
      Logger()
          .i("filter productFamilyList " + productFamilyList.length.toString());
      if (productFamilyList.isNotEmpty) {
        for (FilterData data in productFamilyList) {
          value.write(constructQuery("productfamily", data.title, false));
        }
      }
      // model
      List<FilterData> productModelList = appliedFilters
          .where((element) => element.type == FilterType.MODEL)
          .toList();
      Logger()
          .i("filter productModelList " + productModelList.length.toString());
      if (productModelList.isNotEmpty) {
        for (FilterData data in productModelList) {
          value.write(constructQuery("model", data.title, false));
        }
      }
      // subscription
      List<FilterData> productSubscriptionList = appliedFilters
          .where((element) => element.type == FilterType.SUBSCRIPTION_DATE)
          .toList();
      Logger().i("filter productSubscriptionList " +
          productSubscriptionList.length.toString());
      if (productSubscriptionList.isNotEmpty) {
        for (FilterData data in productModelList) {
          value.write(constructQuery("subscription", data.title, false));
        }
      }
      // assetstatus
      List<FilterData> productAssetstatusList = appliedFilters
          .where((element) => element.type == FilterType.ALL_ASSETS)
          .toList();
      Logger().i("filter productAssetstatusList " +
          productAssetstatusList.length.toString());
      if (productAssetstatusList.isNotEmpty) {
        for (FilterData data in productAssetstatusList) {
          value.write(constructQuery("assetstatus", data.title, false));
        }
      }
      // deviceType
      List<FilterData> productDeviceTypeList = appliedFilters
          .where((element) => element.type == FilterType.DEVICE_TYPE)
          .toList();
      Logger().i("filter productDeviceTypeList " +
          productDeviceTypeList.length.toString());
      if (productDeviceTypeList.isNotEmpty) {
        for (FilterData data in productAssetstatusList) {
          value.write(constructQuery("deviceType", data.title, false));
        }
      }
      // fuelLevel
      List<FilterData> fuleLevelList = appliedFilters
          .where((element) => element.type == FilterType.FUEL_LEVEL)
          .toList();
      Logger().i("filter fuleLevelList " + fuleLevelList.length.toString());
      if (fuleLevelList.isNotEmpty) {
        for (FilterData data in fuleLevelList) {
          if (data.title == "100") {
            value.write(
                constructQuery("fuelLevelPercentLTE", data.title, false));
          } else {
            value
                .write(constructQuery("fuelLevelPercentLT", data.title, false));
          }
        }
      }
      // idlingLevel
      List<FilterData> idlingLevelList = appliedFilters
          .where((element) => element.type == FilterType.IDLING_LEVEL)
          .toList();
      Logger().i("filter idlingLevelList " + idlingLevelList.length.toString());
      if (idlingLevelList.isNotEmpty) {
        for (FilterData data in idlingLevelList) {
          Logger().d("idling filter data ${data.extras}");
          if (data.extras.isNotEmpty) {
            if (data.extras[1].isEmpty) {
              value.write(
                  constructQuery("IdleEfficiency.GT", data.extras[0], false));
            } else {
              value.write(
                  constructQuery("IdleEfficiency.GT", data.extras[0], false));
              value.write(
                  constructQuery("IdleEfficiency.LTE", data.extras[1], false));
            }
          }
        }
      }
      // location clustor
      List<FilterData> locationClustorList = appliedFilters
          .where((element) => element.type == FilterType.CLUSTOR)
          .toList();
      Logger().i("filter locationClustorList " +
          locationClustorList.length.toString());
      if (locationClustorList.isNotEmpty) {
        for (FilterData data in locationClustorList) {
          if (data.extras.isNotEmpty) {
            Logger().d("location clustor extras 0 ", data.extras[0]);
            Logger().d("location clustor extras 1", data.extras[1]);
            Logger().d("location clustor extras 2", data.extras[2]);
            value.write(constructQuery("latitude", data.extras[0], false));
            value.write(constructQuery("longitude", data.extras[1], false));
            value.write(constructQuery("radiuskm", data.extras[2], false));
          }
        }
      }

      if (locationClustorList.isEmpty) {
        // location search
        List<FilterData> locationSearchList = appliedFilters
            .where((element) => element.type == FilterType.LOCATION_SEARCH)
            .toList();
        Logger().i("filter locationSearchList " +
            locationSearchList.length.toString());
        if (locationSearchList.isNotEmpty) {
          for (FilterData data in locationSearchList) {
            if (data.extras.isNotEmpty) {
              Logger().d("location search extras 0 ", data.extras[0]);
              Logger().d("location search extras 1", data.extras[1]);
              Logger().d("location search extras 2", data.extras[2]);
              value.write(constructQuery("latitude", data.extras[0], false));
              value.write(constructQuery("longitude", data.extras[1], false));
              value.write(constructQuery("radiuskm", data.extras[2], false));
            }
          }
        }
      }
    }
    return value.toString();
  }
}
