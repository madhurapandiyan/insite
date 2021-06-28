import 'package:insite/core/repository/db.dart';

class LocalStorageService extends DataBaseService {
  clearAll() async {
    await filterBox.clear();
    await assetCountBox.clear();
  }
}
