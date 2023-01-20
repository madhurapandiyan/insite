import 'dart:async';

import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';

import 'package:flutter/material.dart';
//import 'package:flutter_downloader/flutter_downloader.dart';
import 'package:insite/core/flavor/flavor.dart';
import 'package:insite/core/models/filter_data.dart';
import 'package:insite/core/router_constants_india_stack.dart';
import 'package:insite/theme/colors.dart';
import 'package:load/load.dart';
import 'package:logger/logger.dart';
import 'package:stacked_services/stacked_services.dart';
import 'core/locator.dart';
import 'core/models/db/asset_count_data.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'core/router_india_stack.dart' as router1;
import 'core/setup_snackbar_ui.dart';

void main() async {
  Logger().d("main visionlink");
  runZonedGuarded<Future<void>>(() async {
    WidgetsFlutterBinding.ensureInitialized();
    await Firebase.initializeApp();
    await Hive.initFlutter();
   // await FlutterDownloader.initialize(debug: true);
    Hive.registerAdapter<FilterData>(FilterDataAdapter());
    Hive.registerAdapter<FilterType?>(FilterTypeAdapter());
    Hive.registerAdapter<AssetCountData>(AssetCountDataAdapter());
    Hive.registerAdapter<CountData>(CountDataAdapter());
    Hive.registerAdapter<FilterSubType?>(FilterSubTypeAdapter());
    
    AppConfig(
        baseUrl: "https://unifiedfleet.myvisionlink.com",
        apiFlavor: "visionlink",
        productFlavor: "unifiedFleet",
        enableLogin: true,
        enalbeNativeLogin: false,
        isProd: false,
        enableGraphql: false,
        iconPath: "assets/images/hitachi.png");
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
      // ignore: deprecated_member_use
      navigatorKey: locator<NavigationService>().navigatorKey,
      onGenerateRoute: router1.Router.generateRoute,
      initialRoute: indiaStackSplashViewRoute,
      theme: indiaStackOrangeWhite,
    );
  }
}
