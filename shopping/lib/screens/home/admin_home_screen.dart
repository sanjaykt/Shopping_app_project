import 'package:flutter/material.dart';


class AdminHomeScreen extends StatefulWidget {
  static final routeName = 'admin_home_screen';
  @override
  _AdminHomeScreenState createState() => _AdminHomeScreenState();
}

class _AdminHomeScreenState extends State<AdminHomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Amin Home')),
      body: Container(
        child: Text('Admin home...'),
      ),
    );
  }
}
