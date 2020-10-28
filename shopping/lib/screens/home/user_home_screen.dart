import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shopping/providers/auth_provider.dart';
import 'package:shopping/widgets/drawer.dart';


class UserHomeScreen extends StatefulWidget {
  static final routeName = 'user_home_screen';
  @override
  _UserHomeScreenState createState() => _UserHomeScreenState();
}

class _UserHomeScreenState extends State<UserHomeScreen> {
  AuthProvider _authProvider;

  @override
  Widget build(BuildContext context) {
    _authProvider = Provider.of<AuthProvider>(context);

    return Scaffold(
      appBar: AppBar(title: Text('User Home')),
      drawer: _authProvider.loggedInUser != null ? AppDrawer() : null,
      body: Container(
        child: Text('User home...'),
      ),
    );
  }
}
