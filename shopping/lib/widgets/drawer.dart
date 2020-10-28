import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shopping/providers/auth_provider.dart';
import 'package:shopping/screens/home/admin_home_screen.dart';
import 'package:shopping/screens/login/login_screen.dart';
import 'package:shopping/screens/product/product_list.dart';

AuthProvider _authProvider;

class AppDrawer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    _authProvider = Provider.of<AuthProvider>(context);
    return Drawer(
      child: ListView(
//        padding: EdgeInsets.zero,
        children: <Widget>[
          UserAccountsDrawerHeader(
            accountName: Text(_authProvider.loggedInUser.username),
            accountEmail: Text('temp@mail.com'),
            currentAccountPicture: CircleAvatar(
              backgroundColor: Colors.green,
              child: Text(_authProvider.loggedInUser.username,
                  style: TextStyle(fontSize: 20)),
            ),
          ),
          ListTile(
            leading: Icon(Icons.logout),
            trailing: Container(child: Icon(Icons.arrow_forward),),
            title: Text('Logout' ,style: TextStyle(fontSize: 16),),
            onTap: () {
              Navigator.popAndPushNamed(context, LoginScreen.routeName);
            },
          ),
          if (_authProvider.loggedInUser.role == 'Admin')
            ListTile(
            leading: Icon(Icons.storage),
            trailing: Icon(Icons.arrow_forward),
            title: Text('Products', style: TextStyle(fontSize: 16),),
            onTap: () {
              Navigator.popAndPushNamed(context, ProductListScreen.routeName);
            },
          ),
          if (_authProvider.loggedInUser.role == 'Admin')
            ListTile(
              leading: Icon(Icons.home),
              trailing: Container(child: Icon(Icons.arrow_forward),),
              title: Text('Home' ,style: TextStyle(fontSize: 16),),
              onTap: () {
                Navigator.popAndPushNamed(context, AdminHomeScreen.routeName);
              },
            ),
          if (_authProvider.loggedInUser.role == 'Regular')
            ListTile(
              leading: Icon(Icons.home),
              trailing: Container(child: Icon(Icons.arrow_forward),),
              title: Text('Home' ,style: TextStyle(fontSize: 16),),
              onTap: () {
                Navigator.popAndPushNamed(context, AdminHomeScreen.routeName);
              },
            ),
        ],
      ),
    );
  }
}
