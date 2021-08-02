import 'package:insite/core/base/base_service.dart';
import 'package:insite/core/locator.dart';
import 'package:insite/core/models/customer.dart';
import 'package:insite/core/models/health_list_response.dart';
import 'package:insite/core/repository/network.dart';
import 'package:insite/core/services/local_service.dart';
import 'package:logger/logger.dart';

class HealthListService extends BaseService {
  var _localService = locator<LocalService>();
  Customer customerSelected;

  HealthListService() {
    setUp();
  }

  setUp() async {
    try {
      customerSelected = await _localService.getCustomerInfo();
    } catch (e) {
      Logger().e(e);
    }
  }

  Future<HealthListResponse> getHealthListData() async {
    try {
      HealthListResponse healthListResponse = await MyApi()
          .getClient()
          .getHealthListData(
              "4e942945-7bb7-11e9-8103-060d7e00a6d1",
              "2021-08-02T18:29:59Z",
              'en-US',
              20,
              1,
              '2021-08-01T18:30:00Z',
              'd7ac4554-05f9-e311-8d69-d067e5fd4637',
              'Bearer  323892c625e49b8f3c82161fce2218cc');
      return healthListResponse;
    } catch (e) {
      Logger().e(e.toString());
    }
    return null;
  }
}
