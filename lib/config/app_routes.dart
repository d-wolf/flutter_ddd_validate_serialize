import 'package:flutter/material.dart';

import '../presentaion/pages/error/error_page.dart';
import '../presentaion/pages/menu/menu_page.dart';
import '../presentaion/pages/settings/settings_page.dart';

class Routes {
  static const String menuPage = 'menu_page';
  static const String settingsPage = 'settings_page';
}

class RouteGenerator {
  const RouteGenerator._();

  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case Routes.menuPage:
        return MaterialPageRoute(
          builder: (_) => const MenuPage(),
        );
      case Routes.settingsPage:
        return MaterialPageRoute(
          builder: (_) => const SettingsPage(),
        );
      default:
        return MaterialPageRoute(
          builder: (_) => ErrorPage(
            param: settings,
          ),
        );
    }
  }
}
