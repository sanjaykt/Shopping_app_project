import 'package:flutter/material.dart';


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
      body: Container(
        child: Text('User home...'),
      ),
    );
  }
}
