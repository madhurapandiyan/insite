import 'package:insite/core/base/base_service.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LocalService extends BaseService {
  final SharedPreferences preferences;
  LocalService(this.preferences);

  Future setIsloggedIn(bool isLoggedIn) async {
    return await preferences.setBool("isLoggedIn", isLoggedIn);
  }

  Future<bool> getIsloggedIn() async {
    return preferences.getBool("isLoggedIn");
  }
}
