import 'package:insite/core/base/base_service.dart';
import 'package:insite/core/repository/Retrofit.dart';
import 'package:insite/core/repository/network.dart';
import 'package:insite/core/router_constants.dart';
import 'package:stacked_services/stacked_services.dart';
import '../locator.dart';
import 'local_service.dart';

class LoginService extends BaseService {
  final _nagivationService = locator<NavigationService>();
  final _localService = locator<LocalService>();

  Future<UserInfo> getLoggedInUserInfo() async {
    // var payLoad = UserPayLoad(
    //     env: "dev",
    //     code: code,
    //     client_key: "r9GxbyX4uNMjpB1yZge6fiWSGQ4a",
    //     grant_type: "authorization_code",
    //     tenantDomain: "trimble.com",
    //     client_secret: "4Xk8oEFLfxvnyiO821JpQMzHhf8a",
    //     redirect_uri: "eoltool://mobile");
    return await MyApi().getClientOne().getUserInfo();
  }

  void getUser(token) async {
    _localService.setIsloggedIn(true);
    _localService.saveToken(token);
    try {
      UserInfo userInfo = await getLoggedInUserInfo();
      Future.delayed(Duration(seconds: 1), () {
        if (userInfo != null) {
          _localService.saveUserInfo(userInfo);
          _nagivationService.replaceWith(homeViewRoute);
        }
      });
    } catch (e) {
      _nagivationService.replaceWith(homeViewRoute);
    }
  }
}
