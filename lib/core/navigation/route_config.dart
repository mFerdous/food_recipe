import 'package:flutter/material.dart';
import '../../features/home/presentation/screens/home_screen.dart';
import 'route_name.dart';

class RouteConfig {
  Route routes(RouteSettings routeSettings) {
    switch (routeSettings.name) {
      case RouteName.initialRoute:
        return _getInitialRoute();
    }
    return _defaultRoute();
  }

  static MaterialPageRoute _routeBuilder(Widget child) {
    return MaterialPageRoute(builder: (_) => child);
  }

  static MaterialPageRoute _defaultRoute() {
    return _routeBuilder(
      const Scaffold(
        body: Center(
          child: Text('Unknown route'),
        ),
      ),
    );
  }

  static MaterialPageRoute _getInitialRoute() {
    return _routeBuilder(const HomeScreen());
    // return _routeBuilder(const SplashScreen());
  }
}
