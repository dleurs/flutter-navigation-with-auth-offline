import 'package:flutter/material.dart';
import 'package:flutter_navigation_with_auth_offline/src/ui/screens/base_screen.dart';

class HomeScreen extends StatefulWidget {
  final String title;
  static final bool isRouteAuthenticated = true;

  HomeScreen({Key key, this.title}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends BaseScreenState<HomeScreen> {
  @override
  Widget buildScreen(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            "Your App",
            style: Theme.of(context).textTheme.headline4,
          ),
        ],
      ),
    );
  }

  @override
  PreferredSizeWidget buildAppBar(BuildContext context) {
    return AppBar(title: Text('Home Screen'), actions: <Widget>[
      IconButton(icon: Icon(Icons.logout), onPressed: this.doLogout)
    ]);
  }
}
