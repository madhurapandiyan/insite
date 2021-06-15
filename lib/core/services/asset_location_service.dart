import 'package:insite/core/base/base_service.dart';
import 'package:insite/core/locator.dart';
import 'package:insite/core/models/asset_location.dart';
import 'package:insite/core/models/customer.dart';
import 'package:insite/core/models/filter_data.dart';
import 'package:insite/core/models/location_search.dart';
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
      int pageNumber, int pageSize, String sort, appliedFilters) async {
    try {
      if (pageNumber != null && pageSize != null && sort != null) {
        AssetLocationData result = await MyApi().getClient().assetLocation(
            getFilterJson(pageNumber, pageSize, null, sort, appliedFilters),
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

  Map<String, dynamic> getFilterJson(
      pageNumber, pageSize, customerId, sort, List<FilterData> appliedFilters) {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['pageNumber'] = pageNumber;
    data['pageSize'] = pageSize;
    if (sort != null) {
      data["sort"] = sort;
    }
    if (customerId != null) {
      data["customerUID"] = customerId;
    }
    if (appliedFilters.isNotEmpty) {
      // manufacturer
      List<FilterData> makeList = appliedFilters
          .where((element) => element.type == FilterType.MAKE)
          .toList();
      Logger().i("filter makeList " + makeList.length.toString());
      if (makeList.isNotEmpty) {
        if (makeList.length == 1) {
          data["manufacturer"] = makeList[0].title;
        } else {
          data["manufacturer"] = convertFilterToCommaSeparatedString(makeList);
        }
      }
      // productfamily
      List<FilterData> productFamilyList = appliedFilters
          .where((element) => element.type == FilterType.PRODUCT_FAMILY)
          .toList();
      Logger()
          .i("filter productFamilyList " + productFamilyList.length.toString());
      if (productFamilyList.isNotEmpty) {
        if (productFamilyList.length == 1) {
          data["productfamily"] = productFamilyList[0].title;
        } else {
          data["productfamily"] =
              convertFilterToCommaSeparatedString(productFamilyList);
        }
      }
      // model
      List<FilterData> productModelList = appliedFilters
          .where((element) => element.type == FilterType.MODEL)
          .toList();
      Logger()
          .i("filter productModelList " + productModelList.length.toString());
      if (productModelList.isNotEmpty) {
        if (productModelList.length == 1) {
          data["model"] = productModelList[0].title;
        } else {
          data["model"] = convertFilterToCommaSeparatedString(productModelList);
        }
      }
      // subscription
      List<FilterData> productSubscriptionList = appliedFilters
          .where((element) => element.type == FilterType.SUBSCRIPTION_DATE)
          .toList();
      Logger().i("filter productSubscriptionList " +
          productSubscriptionList.length.toString());
      if (productSubscriptionList.isNotEmpty) {
        if (productSubscriptionList.length == 1) {
          data["subscription"] = productSubscriptionList[0].title;
        } else {
          data["subscription"] =
              convertFilterToCommaSeparatedString(productSubscriptionList);
        }
      }
      // assetstatus
      List<FilterData> productAssetstatusList = appliedFilters
          .where((element) => element.type == FilterType.ALL_ASSETS)
          .toList();
      Logger().i("filter productAssetstatusList " +
          productAssetstatusList.length.toString());
      if (productAssetstatusList.isNotEmpty) {
        if (productAssetstatusList.length == 1) {
          data["assetstatus"] = productAssetstatusList[0].title;
        } else {
          data["assetstatus"] =
              convertFilterToCommaSeparatedString(productAssetstatusList);
        }
      }
      // deviceType
      List<FilterData> productDeviceTypeList = appliedFilters
          .where((element) => element.type == FilterType.DEVICE_TYPE)
          .toList();
      Logger().i("filter productDeviceTypeList " +
          productDeviceTypeList.length.toString());
      if (productDeviceTypeList.isNotEmpty) {
        if (productDeviceTypeList.length == 1) {
          data["deviceType"] = productDeviceTypeList[0].title;
        } else {
          data["deviceType"] =
              convertFilterToCommaSeparatedString(productDeviceTypeList);
        }
      }
    }
    return data;
  }
}
