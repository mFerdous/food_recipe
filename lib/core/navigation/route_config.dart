import 'package:flutter/material.dart';
import '../../features/home/presentation/screens/home_screen.dart';
import '../../features/home/presentation/widgets/recipe_information_widget.dart';
import 'route_name.dart';

class RouteConfig {
  Route routes(RouteSettings routeSettings) {
    switch (routeSettings.name) {
      case RouteName.initialRoute:
        return _getInitialRoute();
      case RouteName.recipeInformation:
        return _getRecipeInformationRoute();
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

  static MaterialPageRoute _getRecipeInformationRoute() {
    return _routeBuilder(const RecipeInformationWidget());
    // return _routeBuilder(const SplashScreen());
  }
}
