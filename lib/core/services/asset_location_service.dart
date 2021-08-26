import 'package:insite/core/base/base_service.dart';
import 'package:insite/core/locator.dart';
import 'package:insite/core/models/asset_location.dart';
import 'package:insite/core/models/customer.dart';
import 'package:insite/core/models/location_search.dart';
import 'package:insite/core/repository/network.dart';
import 'package:insite/core/services/local_service.dart';
import 'package:insite/utils/enums.dart';
import 'package:insite/utils/filter.dart';
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
            .assetLocationWithCluster(
                Urls.locationSummary,
                latitude,
                longitude,
                pageNumber,
                pageSize,
                radiusKm,
                sort,
                accountSelected.CustomerUID);
        return result;
      }
      return null;
    } catch (e) {
      Logger().e(e);
      return null;
    }
  }

  Future<AssetLocationData> getAssetLocation(startDate, endDate, int pageNumber,
      int pageSize, String sort, appliedFilters) async {
    try {
      if (pageNumber != null &&
          pageSize != null &&
          sort != null &&
          customerSelected != null) {
        AssetLocationData result = await MyApi()
            .getClient()
            .assetLocationSummary(
                Urls.locationSummary +
                    FilterUtils.getFilterURL(
                        startDate,
                        endDate,
                        pageNumber,
                        pageSize,
                        customerSelected.CustomerUID,
                        sort,
                        appliedFilters,
                        ScreenType.LOCATION),
                accountSelected.CustomerUID,
                Urls.vfleetMapPrefix);
        return result;
      } else if (pageNumber != null && pageSize != null && sort != null) {
        AssetLocationData result = await MyApi()
            .getClient()
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
                accountSelected.CustomerUID,
                Urls.vfleetMapPrefix);
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
        if (customerSelected != null) {
          AssetLocationData result = await MyApi()
              .getClient()
              .assetLocationWithOutFilterCustomerUID(
                  Urls.locationSummary,
                  pageNumber,
                  pageSize,
                  sort,
                  customerSelected.CustomerUID,
                  accountSelected.CustomerUID,
                  Urls.vfleetMapPrefix);
          if (result != null) {
            return result;
          } else {
            return null;
          }
        } else {
          AssetLocationData result = await MyApi()
              .getClient()
              .assetLocationWithOutFilter(
                  Urls.locationSummary,
                  pageNumber,
                  pageSize,
                  sort,
                  accountSelected.CustomerUID,
                  Urls.vfleetMapPrefix);
          if (result != null) {
            return result;
          } else {
            return null;
          }
        }
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

  Future<AssetLocationData> getLocationFilterData(
      productFamilyKey, int pageNumber, int pageSize) async {
    try {
      AssetLocationData assetLocationDataResponse = productFamilyKey != null
          ? await MyApi().getClient().locationFilterData(
              Urls.locationSummary,
              pageNumber,
              pageSize,
              productFamilyKey,
              "-lastlocationupdateutc",
              accountSelected.CustomerUID,
              Urls.vfleetMapPrefix)
          : await MyApi().getClient().assetLocationWithOutFilterCustomerUID(
              Urls.locationSummary,
              pageNumber,
              pageSize,
              "-lastlocationupdateutc",
              customerSelected.CustomerUID,
              accountSelected.CustomerUID,
              Urls.vfleetMapPrefix);
      return assetLocationDataResponse;
    } catch (e) {
      Logger().d(e.toString());
    }
    return null;
  }
}
