import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:insite/core/models/filter_data.dart';
import 'package:insite/core/router_constants_india_stack.dart';
import 'package:insite/theme/colors.dart';
import 'package:stacked_services/stacked_services.dart';
import 'core/flavor/flavor.dart';
import 'core/locator.dart';
import 'core/models/db/asset_count_data.dart';
import 'core/router_india_stack.dart' as router;
import 'package:hive_flutter/hive_flutter.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();
  Hive.registerAdapter<FilterData>(FilterDataAdapter());
  Hive.registerAdapter<FilterType>(FilterTypeAdapter());
  Hive.registerAdapter<AssetCountData>(AssetCountDataAdapter());
  Hive.registerAdapter<CountData>(CountDataAdapter());
  Hive.registerAdapter<FilterSubType>(FilterSubTypeAdapter());
  AppConfig(baseUrl: "https://cloud.api.trimble.com/CTSPulseIndiastg");

  await LocatorInjector.setUpLocator();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      navigatorKey: locator<NavigationService>().navigatorKey,
      onGenerateRoute: router.Router.generateRoute,
      initialRoute: indiaStackSplashViewRoute,
      theme: ThemeData(
          backgroundColor: cod_grey,
          fontFamily: 'Roboto',
          appBarTheme: AppBarTheme(backgroundColor: Colors.white),
          accentColor: Colors.white),
    );
  }
}
