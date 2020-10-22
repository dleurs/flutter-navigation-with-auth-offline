class RouteConfig {
  final bool needsAuthentication;

  const RouteConfig(this.needsAuthentication);
}

class AppRoutes {
  static const String initial = '/';
  static const String login = '/login';
  static const String home = '/home';
  static const String restaurant = '/restaurant';

  static final Map<String, RouteConfig> configs = {
    initial: RouteConfig(false),
    login: RouteConfig(false),
    home: RouteConfig(true),
    restaurant: RouteConfig(true),
  };

  static RouteConfig getConfig(String routeName) {
    if (configs.containsKey(routeName)) {
      return configs[routeName];
    }
    return RouteConfig(false);
  }
}
