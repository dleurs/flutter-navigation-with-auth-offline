import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_navigation_with_auth_offline/src/bloc/authentication/bloc.dart';
import 'package:flutter_navigation_with_auth_offline/src/core/authentication/authentication_manager.dart';
import 'package:flutter_navigation_with_auth_offline/src/helpers/route_config.dart';
import 'package:flutter_navigation_with_auth_offline/src/resource/login_repository.dart';
import 'package:flutter_navigation_with_auth_offline/src/ui/screens/home_screen.dart';
import 'package:flutter_navigation_with_auth_offline/src/ui/screens/login_screen.dart';

class App extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return BlocProvider<AuthenticationBloc>(
        create: (context) => AuthenticationBloc(LoginRepository()),
        child: MaterialApp(
          title: 'Flutter Demo',
          theme: ThemeData(
            primarySwatch: Colors.blue,
            visualDensity: VisualDensity.adaptivePlatformDensity,
          ),
          initialRoute: "/", // Cannot be changed
          onGenerateRoute: _generateRoute,
        ));
  }

  ///
  /// Checks if a route needs authentication and if so,
  /// checks the user's authentication status
  ///
  Route<dynamic> _generateRoute(RouteSettings settings) {
    RouteConfig config = AppRoutes.getConfig(settings.name);
    if (config.needsAuthentication) {
      if (AuthenticationManager.instance.isLoggedIn) {
        return _buildAuthorizedRoute(settings);
      } else {
        return MaterialPageRoute(
            builder: (context) => LoginScreen(targetRouteName: settings.name));
      }
    } else {
      return _buildAuthorizedRoute(settings);
    }
  }

  ///
  /// Build final authorized route
  ///
  Route<dynamic> _buildAuthorizedRoute(RouteSettings settings) {
    switch (settings.name) {
      //case AppRoutes.initial:
      case AppRoutes.home:
        return MaterialPageRoute(
            builder: (context) => HomeScreen(
                title:
                    'Flutter Demo flutter_navigation_with_auth_offline App'));
      case AppRoutes.login:
        return MaterialPageRoute(
            builder: (context) => LoginScreen(targetRouteName: AppRoutes.home));
      default:
        return MaterialPageRoute(
            builder: (context) => Scaffold(
                body: Center(
                    child: Text('Unknown route named ${settings.name}'))));
    }
  }
}
