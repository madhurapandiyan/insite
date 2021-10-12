import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:insite/core/flavor/flavor.dart';
import 'package:insite/core/models/customer.dart';
import 'package:insite/core/models/filter_data.dart';
import 'package:insite/core/router_constants.dart';
import 'package:insite/theme/colors.dart';
import 'package:load/load.dart';
import 'package:stacked_services/stacked_services.dart';
import 'core/locator.dart';
import 'core/models/account.dart';
import 'core/models/db/asset_count_data.dart';
import 'core/router.dart' as router;
import 'package:hive_flutter/hive_flutter.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();
  Hive.registerAdapter<FilterData>(FilterDataAdapter());
  Hive.registerAdapter<FilterType>(FilterTypeAdapter());
  Hive.registerAdapter<AssetCountData>(AssetCountDataAdapter());
  Hive.registerAdapter<CountData>(CountDataAdapter());
  Hive.registerAdapter<FilterSubType>(FilterSubTypeAdapter());
  Hive.registerAdapter<Customer>(CustomerAdapter());
  Hive.registerAdapter<AccountData>(AccountDataAdapter());
  AppConfig(
      baseUrl: "https://unifiedfleet.myvisionlink.com",
      flavor: "visionlink",
      iconPath: "assets/images/hitachi.png");

  await LocatorInjector.setUpLocator();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return LoadingProvider(
      themeData: LoadingThemeData(
        loadingBackgroundColor: tango,
        loadingPadding: EdgeInsets.all(24),
        loadingSize: Size(80, 80),
        borderRadius: BorderRadius.circular(4),
      ),
      child: MaterialApp(
          debugShowCheckedModeBanner: false,
          navigatorKey: locator<NavigationService>().navigatorKey,
          onGenerateRoute: router.Router.generateRoute,
          initialRoute: splashViewRoute,
          theme: indiaStackOrangeBlack),
    );
  }
}
