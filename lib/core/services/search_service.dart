import 'package:insite/core/base/base_service.dart';
import 'package:insite/core/locator.dart';
import 'package:insite/core/models/customer.dart';
import 'package:insite/core/models/search_data.dart';
import 'package:insite/core/repository/network.dart';
import 'package:insite/core/services/local_service.dart';
import 'package:insite/utils/filter.dart';
import 'package:insite/utils/urls.dart';
import 'package:logger/logger.dart';

class SearchService extends BaseService {
  Customer? accountSelected;
  Customer? customerSelected;
  LocalService? _localService = locator<LocalService>();

  SearchService() {
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

  Future<SearchData?> getSearchResult(String searchKeyword, String? type) async {
    try {
      if (searchKeyword != null &&
          searchKeyword.isNotEmpty &&
          accountSelected != null) {
        Map<String, String?> queryMap = Map();
        if (type == "ID") {
          queryMap["assetIDContains"] = searchKeyword;
          if (customerSelected != null) {
            queryMap["customerUID"] = customerSelected!.CustomerUID;
          }
        } else if (type == "S/N") {
          queryMap["snContains"] = searchKeyword;
          if (customerSelected != null) {
            queryMap["customerUID"] = customerSelected!.CustomerUID;
          }
        } else {
          queryMap["snContains"] = searchKeyword;
          queryMap["assetIDContains"] = searchKeyword;
          if (customerSelected != null) {
            queryMap["customerUID"] = customerSelected!.CustomerUID;
          }
        }
        if (isVisionLink) {
          SearchData searchResponse = await MyApi().getClient()!.searchVL(
                Urls.searchVL + FilterUtils.constructQueryFromMap(queryMap),
                accountSelected!.CustomerUID,
              );
          return searchResponse;
        } else {
          SearchData searchResponse = await MyApi().getClient()!.search(
              Urls.search + FilterUtils.constructQueryFromMap(queryMap),
              accountSelected!.CustomerUID,
              Urls.vfleetPrefix);
          return searchResponse;
        }
      }
      return null;
    } catch (e) {
      Logger().e(e);
      return null;
    }
  }
}
