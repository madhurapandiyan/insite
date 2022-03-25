import 'package:flutter/material.dart';
import 'package:flutter_downloader/flutter_downloader.dart';
import 'package:insite/core/models/filter_data.dart';
import 'package:insite/core/router_constants_india_stack.dart';
import 'package:insite/theme/colors.dart';
import 'package:insite/utils/urls.dart';
import 'package:load/load.dart';
import 'package:stacked_services/stacked_services.dart';
import 'core/flavor/flavor.dart';
import 'core/locator.dart';
import 'core/models/db/asset_count_data.dart';
import 'core/router_india_stack.dart' as router;
import 'package:hive_flutter/hive_flutter.dart';

import 'core/setup_snackbar_ui.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();
  await FlutterDownloader.initialize(debug: true);
  Hive.registerAdapter<FilterData>(FilterDataAdapter());
  Hive.registerAdapter<FilterType?>(FilterTypeAdapter());
  Hive.registerAdapter<AssetCountData>(AssetCountDataAdapter());
  Hive.registerAdapter<CountData>(CountDataAdapter());
  Hive.registerAdapter<FilterSubType?>(FilterSubTypeAdapter());
  AppConfig(
      baseUrl: "https://cloud.api.trimble.com" + Urls.nameSpace,
      iconPath: "assets/images/ic_trimble_logo.png",
      productFlavor: "trimble",
      enableLogin: true,
      isProd: false,
      enableGraphql: true,
      enalbeNativeLogin: false,
      apiFlavor: "indiastack");
  await LocatorInjector.setUpLocator();
  SnackbarStyling.setupSnackbarUi();
  runApp(MyApp());
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
      theme: indiaStackBlueWhite,
    );
  }
}
