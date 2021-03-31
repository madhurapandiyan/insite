import 'package:insite/core/base/base_service.dart';
import 'package:insite/core/repository/Retrofit.dart';
import 'package:insite/core/repository/network.dart';

class LoginService extends BaseService {
  Future<UserInfo> getLoggedInUserInfo(code) async {
    var payLoad = UserPayLoad(
        env: "dev",
        code: code,
        client_key: "r9GxbyX4uNMjpB1yZge6fiWSGQ4a",
        grant_type: "authorization_code",
        tenantDomain: "trimble.com",
        client_secret: "4Xk8oEFLfxvnyiO821JpQMzHhf8a",
        redirect_uri: "eoltool://mobile");
    return await MyApi().getClient().getUserInfo(payLoad);
  }

  Future<AuthenticationResponse> authenticate() async {
    return await MyApi().getClient().authenticate(openId: "&amp;scope");
  }
}
