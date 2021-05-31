import 'package:insite/core/base/base_service.dart';
import 'package:insite/core/locator.dart';
import 'package:insite/core/models/customer.dart';
import 'package:insite/core/models/search_data.dart';
import 'package:insite/core/repository/network.dart';
import 'package:insite/core/services/local_service.dart';
import 'package:logger/logger.dart';

class SearchService extends BaseService {
  Customer accountSelected;
  Customer customerSelected;
  var _localService = locator<LocalService>();

  SearchService() {
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

  Future<SearchData> getSearchResult(String searchKeyword, String type) async {
    try {
      if (searchKeyword != null &&
          searchKeyword.isNotEmpty &&
          accountSelected != null &&
          customerSelected != null) {
        if (type == "ID") {
          Logger().i("searchByIDWithCI");
          SearchData searchResponse = await MyApi()
              .getClient()
              .searchByIDWithCI(searchKeyword, customerSelected.CustomerUID,
                  accountSelected.CustomerUID);
          return searchResponse;
        } else if (type == "S/N") {
          Logger().i("searchBySNWithCI");
          SearchData searchResponse = await MyApi()
              .getClient()
              .searchBySNWithCI(searchKeyword, customerSelected.CustomerUID,
                  accountSelected.CustomerUID);
          return searchResponse;
        } else {
          Logger().i("searchByAllWithCI");
          SearchData searchResponse = await MyApi()
              .getClient()
              .searchByAllWithCI(searchKeyword, searchKeyword,
                  customerSelected.CustomerUID, accountSelected.CustomerUID);
          return searchResponse;
        }
      } else if (searchKeyword != null &&
          searchKeyword.isNotEmpty &&
          accountSelected != null) {
        if (type == "ID") {
          Logger().i("searchByID");
          SearchData searchResponse = await MyApi()
              .getClient()
              .searchByID(searchKeyword, accountSelected.CustomerUID);
          return searchResponse;
        } else if (type == "S/N") {
          Logger().i("searchBySN");
          SearchData searchResponse = await MyApi()
              .getClient()
              .searchBySN(searchKeyword, accountSelected.CustomerUID);
          return searchResponse;
        } else {
          Logger().i("searchByAll");
          SearchData searchResponse = await MyApi().getClient().searchByAll(
              searchKeyword, searchKeyword, accountSelected.CustomerUID);
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
