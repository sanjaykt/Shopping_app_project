import 'package:flutter/material.dart';
import 'package:shopping/widgets/drawer.dart';


class UserHomeScreen extends StatefulWidget {
  static final routeName = 'user_home_screen';
  @override
  _UserHomeScreenState createState() => _UserHomeScreenState();
}

class _UserHomeScreenState extends State<UserHomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('User Home')),
      drawer: AppDrawer(),
      body: Container(
        child: Text('User home...'),
      ),
    );
  }
}
