import 'package:insite/core/base/base_service.dart';
import 'package:insite/core/locator.dart';
import 'package:insite/core/models/customer.dart';
import 'package:insite/core/models/search_data.dart';
import 'package:insite/core/repository/network.dart';
import 'package:insite/core/repository/network_graphql.dart';
import 'package:insite/core/services/graphql_schemas_service.dart';
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

  Future<SearchData?> getSearchResult(
      String searchKeyword, String? type) async {
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
        if (enableGraphQl) {
          var data = await Network().getGraphqlData(
              query: GraphqlSchemaService.globalSearch(
                  searchKeyword, searchKeyword),
              customerId: accountSelected?.CustomerUID,
              subId: customerSelected?.CustomerUID == null
                  ? ""
                  : customerSelected?.CustomerUID,
              userId: (await _localService!.getLoggedInUser())!.sub);
          return SearchData.fromJson(data.data["getSearchSuggestions"]);
        } else {
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
      }
      return null;
    } catch (e) {
      Logger().e(e);
      return null;
    }
  }
}
