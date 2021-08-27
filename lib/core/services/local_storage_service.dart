import 'package:insite/core/models/account.dart';
import 'package:insite/core/repository/db.dart';

class LocalStorageService extends DataBaseService {
  clearAll() async {
    await filterBox.clear();
    await assetCountBox.clear();
    await accountBox.clear();
  }

  addCustomersToDb(List<AccountData> list) {}

  List<AccountData> getCustomersFromDb(id) {
    return [];
  }
}
