import 'package:flutter/material.dart';
import 'package:flutter_navigation_with_auth_offline/src/ui/screens/base_screen.dart';

class RestaurantScreen extends StatefulWidget {
  final String restaurantName;
  static final bool isRouteAuthenticated = true;

  RestaurantScreen({Key key, this.restaurantName}) : super(key: key);

  @override
  _RestaurantScreenState createState() => _RestaurantScreenState();
}

class _RestaurantScreenState extends BaseScreenState<RestaurantScreen> {
  @override
  Widget buildScreen(BuildContext context) {
    return Center(
      child: Text(
        "Information of restaurant " + widget.restaurantName,
        style: Theme.of(context).textTheme.headline4,
      ),
    );
  }

  @override
  PreferredSizeWidget buildAppBar(BuildContext context) {
    return AppBar(title: Text('Restaurant'), actions: <Widget>[
      IconButton(icon: Icon(Icons.portrait), onPressed: this.doLogout)
    ]);
  }
}
