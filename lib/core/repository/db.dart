import 'package:hive/hive.dart';
import 'package:insite/core/base/base_service.dart';
import 'package:insite/core/models/account.dart';
import 'package:insite/core/models/customer.dart';
import 'package:insite/core/models/db/asset_count_data.dart';
import 'package:insite/core/models/filter_data.dart';
import 'package:insite/core/services/local_service.dart';
import 'package:logger/logger.dart';
import '../locator.dart';

abstract class DataBaseService extends BaseService {
  Customer? accountSelected;
  Customer? customerSelected;
  LocalService? _localService = locator<LocalService>();
  late var filterBox;
  late var assetCountBox;
  late var accountBox;
  setUp() async {
    try {
      filterBox = await Hive.openBox<FilterData>('filter');
      assetCountBox = await Hive.openBox<AssetCountData>('asset_count');
      accountBox = await Hive.openBox<AccountData>('customer_data');
      accountSelected = await _localService!.getAccountInfo();
      customerSelected = await _localService!.getCustomerInfo();
    } catch (e) {
      Logger().e(e);
    }
  }
}
