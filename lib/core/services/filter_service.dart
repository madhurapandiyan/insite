import 'package:insite/core/base/base_service.dart';
import 'package:insite/core/models/customer.dart';
import 'package:logger/logger.dart';

import '../locator.dart';
import 'local_service.dart';

class FilterService extends BaseService {
  Customer accountSelected;
  Customer customerSelected;
  var _localService = locator<LocalService>();

  setUp() async {
    try {
      accountSelected = await _localService.getAccountInfo();
      customerSelected = await _localService.getCustomerInfo();
    } catch (e) {
      Logger().e(e);
    }
  }
}
