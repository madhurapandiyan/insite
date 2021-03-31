// [ This is an auto generated file ]

import 'package:flutter/material.dart';
import 'package:insite/assetlist/listitems.dart' as view0;
import 'package:insite/core/router_constants.dart';
import 'package:insite/dashboard/homedash.dart' as view0;
import 'package:insite/tab/tabpage.dart' as view0;

import 'package:insite/views/splash/splash_view.dart' as view0;

class Router {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case splashViewRoute:
        return MaterialPageRoute(builder: (_) => view0.SplashView());
      case dashViewRoute:
        return MaterialPageRoute(builder: (_)=>view0.HomeDash());
        case assetViewRoute:
        return MaterialPageRoute(builder: (_)=>view0.AssetList());
        case tabViewRoute:
        return MaterialPageRoute(builder:(_)=>view0.TabPage());
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