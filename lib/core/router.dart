// [ This is an auto generated file ]

import 'package:flutter/material.dart';
import 'package:insite/core/router_constants.dart';
import 'package:insite/views/asset_operation/asset_list_view.dart';

import 'package:insite/views/splash/splash_view.dart' as view0;
import 'package:insite/views/customer_selection/customer_selection_view.dart'
    as view1;
import 'package:insite/views/home/home_view.dart' as view2;
import 'package:insite/views/fleet/fleet_view.dart' as view3;
import 'package:insite/views/login/login_view.dart' as view4;
import 'package:insite/views/logout/logout_view.dart' as view5;
import 'package:insite/views/global_search/global_search_view.dart' as view6;
import 'package:insite/views/dashboard/dashboard_view.dart' as view7;
import 'package:insite/views/detail/asset_detail_view.dart' as view9;
import 'package:insite/views/location/location_view.dart' as view10;
import 'package:insite/views/utilization/tabs/graph_view/utilization_graph_view.dart'
    as view12;
import 'package:insite/views/utilization/tabs/list/utilization_list_view.dart'
    as view11;

class Router {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case splashViewRoute:
        return MaterialPageRoute(builder: (_) => view0.SplashView());
      case customerSelectionViewRoute:
        return MaterialPageRoute(builder: (_) => view1.CustomerSelectionView());
      case homeViewRoute:
        return MaterialPageRoute(builder: (_) => view2.HomeView());
      case fleetViewRoute:
        return MaterialPageRoute(builder: (_) => view3.FleetView());
      case loginViewRoute:
        return MaterialPageRoute(builder: (_) => view4.LoginView());
      case logoutViewRoute:
        return MaterialPageRoute(builder: (_) => view5.LogoutView());
      case globalSearchViewRoute:
        return MaterialPageRoute(builder: (_) => view6.GlobalSearchView());
      case dashboardViewRoute:
        return MaterialPageRoute(builder: (_) => view7.DashboardView());

      case assetDetailViewRoute:
        return MaterialPageRoute(builder: (_) => view9.AssetDetailView());
      case locationViewRoute:
        return MaterialPageRoute(builder: (_) => view10.LocationView());
      case utilizationListViewRoute:
        return MaterialPageRoute(builder: (_) => view11.UtilizationListView());
      case utilizationGraphViewRoute:
        return MaterialPageRoute(builder: (_) => view12.UtilizationGraphView());
      case assetViewRoute:
        return MaterialPageRoute(builder: (_) => AssetListView());

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
