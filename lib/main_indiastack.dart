import 'package:flutter/material.dart';
import 'package:flutter_downloader/flutter_downloader.dart';
import 'package:hive/hive.dart';
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

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await FlutterDownloader.initialize(debug: true);
  await Hive.initFlutter();
  Hive.registerAdapter<FilterData>(FilterDataAdapter());
  Hive.registerAdapter<FilterType>(FilterTypeAdapter());
  Hive.registerAdapter<AssetCountData>(AssetCountDataAdapter());
  Hive.registerAdapter<CountData>(CountDataAdapter());
  Hive.registerAdapter<FilterSubType>(FilterSubTypeAdapter());
  AppConfig(
      baseUrl: "https://cloud.api.trimble.com" + Urls.nameSpace,
      iconPath: "assets/images/hitachi.png",
      productFlavor: "tatahitachi",
      enableLogin: false,
      isProd: false,
      apiFlavor: "indiastack");

  await LocatorInjector.setUpLocator();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return LoadingProvider(
        themeData: LoadingThemeData(
          loadingBackgroundColor: Colors.white,
          loadingPadding: EdgeInsets.all(24),
          loadingSize: Size(80, 80),
          borderRadius: BorderRadius.circular(4),
        ),
        child: MaterialApp(
          debugShowCheckedModeBanner: false,
          navigatorKey: locator<NavigationService>().navigatorKey,
          onGenerateRoute: router.Router.generateRoute,
          initialRoute: indiaStackSplashViewRoute,
          theme: indiaStackOrangeBlack,
        ));
  }
}
