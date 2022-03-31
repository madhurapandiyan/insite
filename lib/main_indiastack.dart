import 'dart:async';

import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_downloader/flutter_downloader.dart';
import 'package:hive/hive.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:insite/core/models/filter_data.dart';
import 'package:insite/core/router_constants_india_stack.dart';
import 'package:insite/core/setup_snackbar_ui.dart';
import 'package:insite/theme/colors.dart';
import 'package:insite/utils/urls.dart';
import 'package:load/load.dart';
import 'package:stacked_services/stacked_services.dart';
import 'core/flavor/flavor.dart';
import 'core/locator.dart';
import 'core/models/db/asset_count_data.dart';
import 'core/router_india_stack.dart' as router;
import 'package:hive_flutter/hive_flutter.dart';

void main() async {
  runZonedGuarded<Future<void>>(() async {
    WidgetsFlutterBinding.ensureInitialized();
    await Firebase.initializeApp();
    FlutterError.onError = FirebaseCrashlytics.instance.recordFlutterError;
    await FlutterDownloader.initialize(debug: true);
    await Hive.initFlutter();
    Hive.registerAdapter<FilterData>(FilterDataAdapter());
    Hive.registerAdapter<FilterType?>(FilterTypeAdapter());
    Hive.registerAdapter<AssetCountData>(AssetCountDataAdapter());
    Hive.registerAdapter<CountData>(CountDataAdapter());
    Hive.registerAdapter<FilterSubType?>(FilterSubTypeAdapter());
    AppConfig(
        baseUrl: "https://cloud.api.trimble.com" + Urls.nameSpace,
        iconPath: "assets/images/hitachi.png",
        productFlavor: "tatahitachi",
        enableLogin: false,
        enalbeNativeLogin: false,
        isProd: false,
        enableGraphql: true,
        apiFlavor: "indiastack");
    await LocatorInjector.setUpLocator();
    SnackbarStyling.setupSnackbarUi();
    runApp(MyApp());
  },
      (error, stack) =>
          FirebaseCrashlytics.instance.recordError(error, stack, fatal: true));
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      builder: (context, child) {
        return LoadingProvider(
          themeData: LoadingThemeData(
            loadingBackgroundColor: Colors.white,
            loadingPadding: EdgeInsets.all(24),
            loadingSize: Size(80, 80),
            borderRadius: BorderRadius.circular(4),
          ),
          child: child!,
        );
      },
      debugShowCheckedModeBanner: false,
      navigatorKey: locator<NavigationService>().navigatorKey,
      onGenerateRoute: router.Router.generateRoute,
      initialRoute: indiaStackSplashViewRoute,
      theme: indiaStackOrangeBlack,
    );
  }
}
