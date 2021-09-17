// [ This is an auto generated file ]

import 'package:flutter/material.dart';
import 'package:insite/core/router_constants_india_stack.dart';
import 'package:insite/views/dashboard/dashboard_view.dart' as view2;
import 'package:insite/views/home/home_view.dart' as view7;
import 'package:insite/views/splash/india_stack_splash_view.dart' as view0;
import 'package:insite/views/account_selection/account_selection_view.dart'
    as view1;
import 'package:insite/views/fleet/fleet_view.dart' as view3;
import 'package:insite/views/login/india_stack_login_view.dart' as view4;
import 'package:insite/views/logout/india_stack_logout_view.dart' as view5;
import 'package:insite/views/global_search/global_search_view.dart' as view6;
import 'package:insite/views/asset_operation/asset_operation_view.dart'
    as view8;
import 'package:insite/views/detail/asset_detail_view.dart' as view9;
import 'package:insite/views/location/location_view.dart' as view10;
import 'package:insite/views/health/health_view.dart' as view11;
import 'package:insite/views/login/login_page.dart' as view12;

class Router {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case indiaStackSplashViewRoute:
        return MaterialPageRoute(builder: (_) => view0.IndiaStackSplashView());
      case customerSelectionViewRoute:
        return MaterialPageRoute(builder: (_) => view1.AccountSelectionView());
      case homeViewRoute:
        return MaterialPageRoute(builder: (_) => view2.DashboardView());
      case fleetViewRoute:
        return MaterialPageRoute(builder: (_) => view3.FleetView());
      case indiaStackLoginViewRoute:
              var loginArgs = settings.arguments as view4.LoginArguments;
        return MaterialPageRoute(
            builder: (_) => view4.IndiaStackLoginView(
                  arguments: loginArgs.response,
                ));
        return MaterialPageRoute(builder: (_) => view4.IndiaStackLoginView());
      case indiaStackLogoutViewRoute:
        return MaterialPageRoute(builder: (_) => view5.IndiaStackLogoutView());
      case globalSearchViewRoute:
        return MaterialPageRoute(builder: (_) => view6.GlobalSearchView());
      case dashboardViewRoute:
        return MaterialPageRoute(builder: (_) => view7.HomeView());
      case assetViewRoute:
        return MaterialPageRoute(builder: (_) => view8.AssetOperationView());
      case assetDetailViewRoute:
        var fleetArgs = settings.arguments as view9.DetailArguments;
        return MaterialPageRoute(
            builder: (_) => view9.AssetDetailView(
                  fleet: fleetArgs.fleet,
                  tabIndex: fleetArgs.index,
                  type: fleetArgs.type,
                ));
      case locationViewRoute:
        return MaterialPageRoute(builder: (_) => view10.LocationView());
      case healthViewRoute:
        return MaterialPageRoute(builder: (_) => view11.HealthView());
      case loginPageRoute:
        return MaterialPageRoute(builder: (_) => view12.LoginPage());
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