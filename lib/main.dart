import 'package:flutter/material.dart';
import 'package:insite/theme/colors.dart';
import 'package:stacked_services/stacked_services.dart';
import 'core/locator.dart';
import 'core/router_constants.dart';
import 'core/router.dart' as router;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
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
      initialRoute: assetViewRoute,
      theme: ThemeData(backgroundColor: mercury, accentColor: Colors.white),
    );
  }
}
