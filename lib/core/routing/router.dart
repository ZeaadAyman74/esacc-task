import 'dart:io';
import 'package:esacc_task/core/routing/routes.dart';
import 'package:esacc_task/features/login/bloc/login_cubit.dart';
import 'package:esacc_task/features/login/screens/login_screen.dart';
import 'package:esacc_task/features/settings/bloc/settings_cubit.dart';
import 'package:esacc_task/features/settings/screens/settings_screen.dart';
import 'package:esacc_task/features/web_view_page/screens/web_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AppRouter {
  AppRouter();

  final navigatorKey = GlobalKey<NavigatorState>();

  Route? generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case Routes.login:
        return _getPageRoute(BlocProvider(
            create: (context) => LoginCubit(), child: const LoginScreen()));
      case Routes.settings:
        return _getPageRoute(BlocProvider(
            create: (context) => SettingsCubit(),
            child: const SettingsScreen()));
      case Routes.webView:
        final url = settings.arguments as String;
        return _getPageRoute(WebScreen(
          url: url,
        ));
    }
    return null;
  }

  PageRoute _getPageRoute(Widget child) {
    if (Platform.isIOS) {
      return CupertinoPageRoute(
        builder: (context) => child,
      );
    } else {
      return CustomPageRouter(child);
    }
  }
}

class CustomPageRouter<T> extends PageRouteBuilder<T> {
  final Widget child;

  CustomPageRouter(this.child)
      : super(
            pageBuilder: (
              BuildContext context,
              Animation<double> animation,
              Animation<double> secondaryAnimation,
            ) =>
                child,
            transitionDuration: const Duration(milliseconds: 300),
            transitionsBuilder: (
              BuildContext context,
              Animation<double> animation,
              Animation<double> secondaryAnimation,
              Widget child,
            ) {
              const begin = 0.0;
              const end = 1.0;
              var tween = Tween<double>(begin: begin, end: end);
              return FadeTransition(
                opacity: animation.drive(tween),
                child: child,
              );
            });
}
