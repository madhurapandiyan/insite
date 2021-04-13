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

  Future<SearchData> getSearchResult(String searchKeyword) async {
    try {
      print('Passed Search Key: $searchKeyword');
      if (searchKeyword != null && searchKeyword.isNotEmpty) {
        SearchData searchResponse = await MyApi().getClient().searchDetail(
            '05d2a956-d890-11e9-8108-067b2fce18ef',
            searchKeyword,
            '75ab4554-05f9-e311-8d69-d067e5fd4637');
        return searchResponse;
      }
      return null;
    } catch (e) {
      Logger().e(e);
      return null;
    }
  }
}
