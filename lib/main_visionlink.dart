import 'package:flutter/material.dart';
import 'package:flutter_downloader/flutter_downloader.dart';
import 'package:hive/hive.dart';
import 'package:insite/core/flavor/flavor.dart';
import 'package:insite/core/models/filter_data.dart';
import 'package:insite/core/router_constants.dart';
import 'package:insite/theme/colors.dart';
import 'package:load/load.dart';
import 'package:stacked_services/stacked_services.dart';
import 'core/locator.dart';
import 'core/models/db/asset_count_data.dart';
import 'core/router.dart' as router;
import 'package:hive_flutter/hive_flutter.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();
   await FlutterDownloader.initialize(debug: true);
  Hive.registerAdapter<FilterData>(FilterDataAdapter());
  Hive.registerAdapter<FilterType>(FilterTypeAdapter());
  Hive.registerAdapter<AssetCountData>(AssetCountDataAdapter());
  Hive.registerAdapter<CountData>(CountDataAdapter());
  Hive.registerAdapter<FilterSubType>(FilterSubTypeAdapter());
  AppConfig(
      baseUrl: "https://unifiedfleet.myvisionlink.com",
      apiFlavor: "visionlink",
      productFlavor: "unifiedFleet",
      enableLogin: true,
      isProd: false,
      iconPath: "assets/images/hitachi.png");
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
          // ignore: deprecated_member_use
          navigatorKey: locator<NavigationService>().navigatorKey,
          onGenerateRoute: router.Router.generateRoute,
          initialRoute: splashViewRoute,
          theme: indiaStackOrangeBlack,
        ));
  }
}
