// [ This is an auto generated file ]

import 'package:flutter/material.dart';
import 'package:insite/core/router_constants.dart';
import 'package:insite/dashboard/homedash.dart' as view0;

import 'package:insite/views/splash/splash_view.dart' as view0;

class Router {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case splashViewRoute:
        return MaterialPageRoute(builder: (_) => view0.SplashView());
      case dashViewRoute:
        return MaterialPageRoute(builder: (_)=>view0.HomeDash());
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