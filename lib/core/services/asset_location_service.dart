import 'package:insite/core/base/base_service.dart';
import 'package:insite/core/locator.dart';
import 'package:insite/core/models/asset_location.dart';
import 'package:insite/core/models/customer.dart';
import 'package:insite/core/models/location_search.dart';
import 'package:insite/core/repository/network.dart';
import 'package:insite/core/repository/network_graphql.dart';
import 'package:insite/core/services/graphql_schemas_service.dart';
import 'package:insite/core/services/local_service.dart';
import 'package:insite/utils/enums.dart';
import 'package:insite/utils/filter.dart';
import 'package:insite/utils/helper_methods.dart';
import 'package:insite/utils/urls.dart';
import 'package:logger/logger.dart';

class AssetLocationService extends BaseService {
  Customer? accountSelected;
  Customer? customerSelected;
  LocalService? _localService = locator<LocalService>();
  GraphqlSchemaService? _graphqlSchemaService = locator<GraphqlSchemaService>();

  AssetLocationService() {
    setUp();
  }

  setUp() async {
    try {
      accountSelected = await _localService!.getAccountInfo();
      customerSelected = await _localService!.getCustomerInfo();
    } catch (e) {
      Logger().e(e);
    }
  }

  Future<AssetLocationData?> getAssetLocationWithCluster(
    int pageNumber,
    int pageSize,
    String sort,
    double latitude,
    double longitude,
    double radiusKm,
  ) async {
    Logger().i("getAssetLocationWithCluster");
    try {
      Map<String, String> queryMap = Map();
      if (pageNumber != null) {
        queryMap["pageNumber"] = pageNumber.toString();
      }
      if (pageSize != null) {
        queryMap["pageSize"] = pageSize.toString();
      }
      if (latitude != null) {
        queryMap["latitude"] = latitude.toString();
      }
      if (latitude != null) {
        queryMap["longitude"] = longitude.toString();
      }
      if (sort != null) {
        queryMap["sort"] = sort;
      }
      if (radiusKm != null) {
        queryMap["radiuskm"] = radiusKm.toString();
      }
      if (isVisionLink) {
        if (pageNumber != null && pageSize != null && sort != null) {
          AssetLocationData result = await MyApi()
              .getClient()!
              .assetLocationWithClusterVL(latitude, longitude, pageNumber,
                  pageSize, radiusKm, sort, accountSelected!.CustomerUID);
          return result;
        }
      } else {
        if (pageNumber != null && pageSize != null && sort != null) {
          AssetLocationData result = await MyApi()
              .getClient()!
              .assetLocationWithCluster(
                  Urls.locationSummary,
                  latitude,
                  longitude,
                  pageNumber,
                  pageSize,
                  radiusKm,
                  sort,
                  accountSelected!.CustomerUID,
                  Urls.vfleetMapPrefix);
          return result;
        }
      }
      return null;
    } catch (e) {
      Logger().e(e);
      return null;
    }
  }

  Future<AssetLocationData?> getAssetLocation(startDate, endDate,
      int pageNumber, int pageSize, String sort, appliedFilters, query) async {
    Logger().i("getAssetLocation");
    try {
      if (enableGraphQl) {
        var data = await Network().getGraphqlData(
          query: query,
          customerId: accountSelected?.CustomerUID,
          userId: (await _localService!.getLoggedInUser())!.sub,
          subId: customerSelected?.CustomerUID == null
              ? ""
              : customerSelected?.CustomerUID,
        );
        Logger()
            .wtf("get asset location ${data.data!["fleetLocationDetails"]}");
        AssetLocationData assetOperationData =
            AssetLocationData.fromJson(data.data!["fleetLocationDetails"]);

        return assetOperationData;
      } else {
        if (isVisionLink) {
          if (pageNumber != null &&
              pageSize != null &&
              sort != null &&
              customerSelected != null) {
            AssetLocationData result =
                await MyApi().getClient()!.assetLocationSummaryVL(
                      Urls.locationSummaryVL +
                          FilterUtils.getFilterURL(
                              startDate,
                              endDate,
                              pageNumber,
                              pageSize,
                              customerSelected?.CustomerUID,
                              sort,
                              appliedFilters,
                              ScreenType.LOCATION),
                      accountSelected!.CustomerUID,
                    );
            if (result != null) {
              return result;
            } else {
              return null;
            }
          } else if (pageNumber != null && pageSize != null && sort != null) {
            AssetLocationData result =
                await MyApi().getClient()!.assetLocationSummaryVL(
                      Urls.locationSummaryVL +
                          FilterUtils.getFilterURL(
                              startDate,
                              endDate,
                              pageNumber,
                              pageSize,
                              null,
                              sort,
                              appliedFilters,
                              ScreenType.LOCATION),
                      accountSelected!.CustomerUID,
                    );
            if (result != null) {
              return result;
            } else {
              return null;
            }
          }
        } else {
          if (pageNumber != null &&
              pageSize != null &&
              sort != null &&
              customerSelected != null) {
            AssetLocationData result = await MyApi()
                .getClient()!
                .assetLocationSummary(
                    Urls.locationSummary +
                        FilterUtils.getFilterURL(
                            startDate,
                            endDate,
                            pageNumber,
                            pageSize,
                            customerSelected?.CustomerUID,
                            sort,
                            appliedFilters,
                            ScreenType.LOCATION),
                    accountSelected!.CustomerUID,
                    Urls.vfleetMapPrefix);
            if (result != null) {
              return result;
            } else {
              return null;
            }
          } else if (pageNumber != null && pageSize != null && sort != null) {
            AssetLocationData result = await MyApi()
                .getClient()!
                .assetLocationSummary(
                    Urls.locationSummary +
                        FilterUtils.getFilterURL(
                            startDate,
                            endDate,
                            pageNumber,
                            pageSize,
                            null,
                            sort,
                            appliedFilters,
                            ScreenType.LOCATION),
                    accountSelected!.CustomerUID,
                    Urls.vfleetMapPrefix);
            if (result != null) {
              return result;
            } else {
              return null;
            }
          }
        }
      }
      return null;
    } catch (e) {
      Logger().e(e);
      return null;
    }
  }

  Future<AssetLocationData?> getAssetLocationWithoutFilter(
      int pageNumber, int pageSize, String sort, String query) async {
    Logger().i("getAssetLocationWithoutFilter");
    Map<String, String?> queryMap = Map();
    if (pageNumber != null) {
      queryMap["pageNumber"] = pageNumber.toString();
    }
    if (pageSize != null) {
      queryMap["pageSize"] = pageSize.toString();
    }
    if (customerSelected != null) {
      queryMap["customerIdentifier"] = customerSelected?.CustomerUID;
    }
    if (sort != null) {
      queryMap["sort"] = "-lastlocationupdateutc";
    }
    try {
      if (enableGraphQl) {
        var data = await Network().getGraphqlData(
          query: query,
          customerId: accountSelected?.CustomerUID,
          userId: (await _localService!.getLoggedInUser())!.sub,
          subId: customerSelected?.CustomerUID == null
              ? ""
              : customerSelected?.CustomerUID,
        );

        AssetLocationData assetLocationDataResponse =
            AssetLocationData.fromJson(data.data!["fleetLocationDetails"]);

        Logger().wtf(assetLocationDataResponse.toJson());

        return assetLocationDataResponse;
      } else {
        if (pageNumber != null && pageSize != null && sort != null) {
          if (isVisionLink) {
            AssetLocationData result =
                await MyApi().getClient()!.assetLocationSummaryVL(
                      Urls.locationSummaryVL +
                          FilterUtils.constructQueryFromMap(queryMap),
                      accountSelected!.CustomerUID,
                    );
            if (result != null) {
              return result;
            } else {
              return null;
            }
          } else {
            AssetLocationData result = await MyApi()
                .getClient()!
                .assetLocationSummary(
                    Urls.locationSummary +
                        FilterUtils.constructQueryFromMap(queryMap),
                    accountSelected!.CustomerUID,
                    Urls.vfleetMapPrefix);
            if (result != null) {
              return result;
            } else {
              return null;
            }
          }
        }
        return null;
      }
    } catch (e) {
      Logger().e(e);
      return null;
    }
  }

  Future<List<LocationSearchData>?> searchLocation(
      int maxResults, String query) async {
    Logger().i("searchLocation");
    var authToken = "366658D213F9F1429033919FCAE365FC";
    try {
      if (enableGraphQl) {
        var data = await Network().getGraphqlData(
          query: _graphqlSchemaService!.searchLocation(query),
          customerId: accountSelected?.CustomerUID,
          userId: (await _localService!.getLoggedInUser())!.sub,
          subId: customerSelected?.CustomerUID == null
              ? ""
              : customerSelected?.CustomerUID,
        );

        LocationSearchResponse result =
            LocationSearchResponse.fromJson(data.data["searchLocation"]);
        return result.Locations;
      } else {
        LocationSearchResponse result = await MyApi()
            .getClientTwo()!
            .getLocations(query, maxResults, authToken);
        List<LocationSearchData>? list = result.Locations;
        return list;
      }
    } catch (e) {
      Logger().e(e);
      return null;
    }
  }

  Future<AssetLocationData?> getLocationFilterData(productFamilyKey,
      int pageNumber, int pageSize, String startDate, String endDate) async {
    Logger().i("getLocationFilterData");
    Map<String, String?> queryMap = Map();
    if (productFamilyKey != null) {
      queryMap["productfamily"] = productFamilyKey;
    }
    if (pageNumber != null) {
      queryMap["pageNumber"] = pageNumber.toString();
    }
    if (pageSize != null) {
      queryMap["pageSize"] = pageSize.toString();
    }
    if (customerSelected != null) {
      queryMap["customerIdentifier"] = customerSelected?.CustomerUID;
    }
    queryMap["sort"] = "-lastlocationupdateutc";
    try {
      if (enableGraphQl) {
        var data = await Network().getGraphqlData(
          query: await _graphqlSchemaService
              ?.getFleetLocationDataProductFamilyFilterData(
                  startDate: startDate,
                  endDate: endDate,
                  pageNo: 1,
                  pageSize: 2000,
                  prodFamilyFilter: ["\"" + productFamilyKey + "\""]),
          customerId: accountSelected?.CustomerUID,
          userId: (await _localService!.getLoggedInUser())!.sub,
          subId: customerSelected?.CustomerUID == null
              ? ""
              : customerSelected?.CustomerUID,
        );
        AssetLocationData assetLocationDataResponse =
            AssetLocationData.fromJson(data.data["fleetLocationDetails"]);
        return assetLocationDataResponse;
      }
      if (isVisionLink) {
        AssetLocationData assetLocationDataResponse =
            await MyApi().getClient()!.locationFilterDataVL(
                  Urls.locationSummaryVL +
                      FilterUtils.constructQueryFromMap(queryMap),
                  accountSelected!.CustomerUID,
                );
        return assetLocationDataResponse;
      } else {
        AssetLocationData assetLocationDataResponse = await MyApi()
            .getClient()!
            .locationFilterData(
                Urls.locationSummary +
                    FilterUtils.constructQueryFromMap(queryMap),
                accountSelected!.CustomerUID,
                Urls.vfleetMapPrefix);
        return assetLocationDataResponse;
      }
    } catch (e) {
      Logger().e(e.toString());
    }
    return null;
  }
}
