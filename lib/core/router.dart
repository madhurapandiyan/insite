// [ This is an auto generated file ]

import 'package:flutter/material.dart';
import 'package:insite/core/router_constants.dart';
import 'package:insite/views/splash/splash_view.dart' as view0;
import 'package:insite/views/customer_selection/customer_selection_view.dart'
    as view1;
import 'package:insite/views/home/home_view.dart' as view2;
import 'package:insite/views/fleet/fleet_view.dart' as view3;
import 'package:insite/views/tab_page/tab_page_view.dart' as view3;

class Router {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case splashViewRoute:
        return MaterialPageRoute(builder: (_) => view0.SplashView());
      case customerSelectionViewRoute:
        return MaterialPageRoute(builder: (_) => view1.CustomerSelectionView());
      case homeViewRoute:
        return MaterialPageRoute(builder: (_) => view2.HomeView());
      case tabViewRoute:
        return MaterialPageRoute(builder: (_) => view3.TabPageView());
      case fleetViewRoute:
        return MaterialPageRoute(builder: (_) => view3.FleetView());
      default:
        return MaterialPageRoute(
          builder: (_) => Scaffold(
            body: Center(
              child: Text('No route defined for ${settings.name}'),
            ),
          ),
        );
    }
  }
}
