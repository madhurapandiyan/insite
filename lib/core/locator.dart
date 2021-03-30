import 'package:get_it/get_it.dart';
import 'package:insite/core/services/local_service.dart';
import 'package:insite/core/services/login_service.dart';
import 'package:insite/core/services/native_service.dart';
import 'package:logger/logger.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:stacked_services/stacked_services.dart';

import 'logger.dart';

final GetIt locator = GetIt.instance;

class LocatorInjector {
  static Future<void> setUpLocator() async {
    Logger log = getLogger('Locator Injector');
    log.d('Registering Navigation Service');
    locator.registerLazySingleton(() => NavigationService());
    log.d('Registering Dialog Service');
    locator.registerLazySingleton(() => DialogService());
    log.d('Registering Snackbar Service');
    locator.registerLazySingleton(() => SnackbarService());
    log.d('Registering shared preferences  Service');
    SharedPreferences prefs = await SharedPreferences.getInstance();
    locator.registerLazySingleton(() => prefs);
    log.d('Registering Local storage Service');
    locator.registerLazySingleton(() => LocalService(locator()));
    log.d('Registering login  Service');
    locator.registerLazySingleton(() => LoginService());
    log.d('Registering native  Service');
    locator.registerLazySingleton(() => NativeService(locator()));
  }
}
