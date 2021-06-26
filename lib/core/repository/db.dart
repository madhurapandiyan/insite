import 'package:hive/hive.dart';
import 'package:insite/core/base/base_service.dart';
import 'package:insite/core/models/customer.dart';
import 'package:insite/core/models/filter_data.dart';
import 'package:insite/core/services/local_service.dart';
import 'package:logger/logger.dart';

import '../locator.dart';

abstract class DataBaseService extends BaseService {
  Customer accountSelected;
  Customer customerSelected;
  var _localService = locator<LocalService>();
  var box;

  setUp() async {
    try {
      box = await Hive.openBox<FilterData>('filter');
      accountSelected = await _localService.getAccountInfo();
      customerSelected = await _localService.getCustomerInfo();
    } catch (e) {
      Logger().e(e);
    }
  }
}
