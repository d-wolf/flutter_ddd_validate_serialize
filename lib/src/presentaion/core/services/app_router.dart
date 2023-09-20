import 'package:bloc_input_valueobject/src/presentaion/core/error/error_page.dart';
import 'package:bloc_input_valueobject/src/presentaion/core/services/injection_container.dart';
import 'package:bloc_input_valueobject/src/presentaion/menu/pages/menu_page.dart';
import 'package:bloc_input_valueobject/src/presentaion/settings/bloc/settings_bloc.dart';
import 'package:bloc_input_valueobject/src/presentaion/settings/pages/settings_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class Routes {
  static const String menuPage = 'menu_page';
  static const String settingsPage = 'settings_page';
}

Route<dynamic> generateRoute(RouteSettings settings) {
  switch (settings.name) {
    case Routes.menuPage:
      return MaterialPageRoute(
        builder: (_) => const MenuPage(),
      );
    case Routes.settingsPage:
      return MaterialPageRoute(
        builder: (_) => BlocProvider(
            create: (_) => sl<SettingsBloc>()..add(const SettingsEventLoad()),
            child: const SettingsPage()),
      );
    default:
      return MaterialPageRoute(
        builder: (_) => ErrorPage(
          param: settings,
        ),
      );
  }
}
