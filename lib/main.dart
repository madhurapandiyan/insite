import 'package:flutter/material.dart';
import 'package:insite/core/router_constants.dart';
import 'package:insite/theme/colors.dart';
import 'package:stacked_services/stacked_services.dart';
import 'core/locator.dart';
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
      initialRoute: customerSelectionViewRoute,
      theme: ThemeData(
          backgroundColor: cod_grey,
          appBarTheme: AppBarTheme(backgroundColor: Colors.white),
          accentColor: Colors.white),
    );
  }
}
