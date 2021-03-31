import 'package:insite/core/base/base_service.dart';
import 'package:insite/core/repository/Retrofit.dart';
import 'package:insite/core/repository/network.dart';

class LoginService extends BaseService {
  Future<UserInfo> getLoggedInUserInfo() async {
    return await MyApi().getClient().getUserInfo();
  }
}
