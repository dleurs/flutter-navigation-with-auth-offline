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
    // if (settings.name == '/') => LoginScreen
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
      case AppRoutes.initial:
      case AppRoutes.login:
        return MaterialPageRoute(
            builder: (context) => LoginScreen(targetRouteName: AppRoutes.home));
      case AppRoutes.home:
        return MaterialPageRoute(
            builder: (context) => HomeScreen(title: 'Flutter Demo App'));
      default:
        return MaterialPageRoute(
            builder: (context) => Scaffold(
                body: Center(
                    child: Text('Unknown route named ${settings.name}'))));
    }
  }
}
/* 
class NavApp extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _NavAppState();
}

class _NavAppState extends State<NavApp> {
  NavAppRouterDelegate _routerDelegate = NavAppRouterDelegate();
  NavAppRouteInformationParser _routeInformationParser =
      NavAppRouteInformationParser();

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: 'My App',
      routerDelegate: _routerDelegate,
      routeInformationParser: _routeInformationParser,
    );
  }
}

class NavAppRouteInformationParser
    extends RouteInformationParser<NavAppRoutePath> {
  @override
  Future<NavAppRoutePath> parseRouteInformation(
      RouteInformation routeInformation) async {
    final uri = Uri.parse(routeInformation.location);
    // Handle '/'
    if (uri.pathSegments.length == 0) {
      return NavAppRoutePath.home();
    }

    // Handle '/book/:id'
    if (uri.pathSegments.length == 2) {
      switch (uri.pathSegments[0]) {
        case "home":
          var remaining = uri.pathSegments[1];
          var id = int.tryParse(remaining);
          if (id == null) {
            return NavAppRoutePath.unknown();
          }
          return NavAppRoutePath.details(id);

        case "login":
        case "logout":
        default:
          return NavAppRoutePath.unknown();
      }
    }

    // Handle unknown routes
    return NavAppRoutePath.unknown();
  }

  @override
  RouteInformation restoreRouteInformation(NavAppRoutePath path) {
    if (path.isUnknown) {
      return RouteInformation(location: '/404');
    }
    if (path.isHomePage) {
      return RouteInformation(location: '/');
    }
    if (path.isDetailsPage) {
      return RouteInformation(location: '/book/${path.id}');
    }
    return null;
  }
}

class NavAppRoutePath {
  final int id;
  final bool isUnknown;

  NavAppRoutePath.home()
      : id = null,
        isUnknown = false;

  NavAppRoutePath.details(this.id) : isUnknown = false;

  NavAppRoutePath.unknown()
      : id = null,
        isUnknown = true;

  bool get isHomePage => id == null;

  bool get isDetailsPage => id != null;
}

class NavAppRouterDelegate extends RouterDelegate<NavAppRoutePath>
    with ChangeNotifier, PopNavigatorRouterDelegateMixin<NavAppRoutePath> {
  final GlobalKey<NavigatorState> navigatorKey;

  NavApp _selectedNavApp;
  bool show404 = false;

  List<NavApp> NavApps = [
    NavApp('Stranger in a Strange Land', 'Robert A. Heinlein'),
    NavApp('Foundation', 'Isaac Asimov'),
    NavApp('Fahrenheit 451', 'Ray Bradbury'),
  ];

  NavAppRouterDelegate() : navigatorKey = GlobalKey<NavigatorState>();

  NavAppRoutePath get currentConfiguration {
    if (show404) {
      return NavAppRoutePath.unknown();
    }
    return _selectedNavApp == null
        ? NavAppRoutePath.home()
        : NavAppRoutePath.details(NavApps.indexOf(_selectedNavApp));
  }

  @override
  Widget build(BuildContext context) {
    return Navigator(
      key: navigatorKey,
      pages: [
        MaterialPage(
          key: ValueKey('NavAppsListPage'),
          child: NavAppsListScreen(
            NavApps: NavApps,
            onTapped: _handleNavAppTapped,
          ),
        ),
        if (show404)
          MaterialPage(key: ValueKey('UnknownPage'), child: UnknownScreen())
        else if (_selectedNavApp != null)
          NavAppDetailsPage(NavApp: _selectedNavApp)
      ],
      onPopPage: (route, result) {
        if (!route.didPop(result)) {
          return false;
        }

        // Update the list of pages by setting _selectedNavApp to null
        _selectedNavApp = null;
        show404 = false;
        notifyListeners();

        return true;
      },
    );
  }

  @override
  Future<void> setNewRoutePath(NavAppRoutePath path) async {
    if (path.isUnknown) {
      _selectedNavApp = null;
      show404 = true;
      return;
    }

    if (path.isDetailsPage) {
      if (path.id < 0 || path.id > NavApps.length - 1) {
        show404 = true;
        return;
      }

      _selectedNavApp = NavApps[path.id];
    } else {
      _selectedNavApp = null;
    }

    show404 = false;
  }

  void _handleNavAppTapped(NavApp NavApp) {
    _selectedNavApp = NavApp;
    notifyListeners();
  }
}
 */
