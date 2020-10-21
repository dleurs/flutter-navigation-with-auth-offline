class RouteConfig {
  final bool needsAuthentication;

  const RouteConfig(this.needsAuthentication);
}

class AppRoutes {
  static const String initial = '/';
  static const String login = '/login';
  static const String home = '/home';

  static final Map<String, RouteConfig> configs = {
    initial: RouteConfig(true),
    // should be true,
    login: RouteConfig(false),
    home: RouteConfig(true),
  };

  static RouteConfig getConfig(String routeName) {
    if (configs.containsKey(routeName)) {
      return configs[routeName];
    }
    return RouteConfig(false);
  }

  isInitial

}
