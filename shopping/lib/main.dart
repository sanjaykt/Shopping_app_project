import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';
import 'package:shopping/common/constants.dart';
import 'package:shopping/providers/auth_provider.dart';
import 'package:shopping/screens/home/admin_home_screen.dart';
import 'package:shopping/screens/home/user_home_screen.dart';
import 'package:shopping/screens/login/login_screen.dart';
import 'package:shopping/screens/user/user_details.dart';

void main() {
  runApp(MyApp());
}

class MyColors {
  static final Color primaryColor = Color(0xFF6d4c41);
  static final Color primaryColorLight = Color(0xFF6d4c41);
  static final Color primaryColorDark = Color(0xFF9c786c);
  static final Color accentColor = Color(0xFFff9e80);
  static final Color accentColorLight = Color(0xFFffd0b0);
  static final Color accentColorDark = Color(0xFFc96f53);
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => AuthProvider(), lazy: false,),
        // ChangeNotifierProvider(create: (ctx) => UserProvider(), lazy: false),
        // Provider(create: (context) => DatabaseProvider(), lazy: false),
        // ChangeNotifierProxyProvider2<AuthProvider, DatabaseProvider, ProductProvider>(
        //   create: (context) => ProductProvider(),
        //   lazy: false,
        //   update: (context, authProvider ,databaseProvider, productProvider) => productProvider..update(authProvider,databaseProvider),
        // ),
      ],
      child: MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          primarySwatch: Colors.blue,
          primaryColor: MyColors.primaryColor,
          accentColor: MyColors.accentColor,
          visualDensity: VisualDensity.adaptivePlatformDensity,
          textTheme: TextTheme(
              headline1: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              headline2: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              bodyText1: TextStyle(fontSize: 12, fontWeight: FontWeight.normal),
              bodyText2: TextStyle(fontSize: 14, fontWeight: FontWeight.normal)),
          buttonTheme: ButtonThemeData(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(30),
                // side: BorderSide(color: Theme.of(context).accentColor, width: 5),
              ),
              buttonColor: Theme.of(context).accentColor
              // textTheme: ButtonTextTheme.primary
              ),
          backgroundColor: Colors.grey.shade50,
          cursorColor: Colors.redAccent,
          colorScheme: ColorScheme.light(),
          errorColor: Colors.red,
        ),
        routes: {
          LoginScreen.routeName: (BuildContext context) => LoginScreen(),
          UserDetails.routeName: (BuildContext context) => UserDetails(),
          UserHomeScreen.routeName: (BuildContext context) => UserHomeScreen(),
          AdminHomeScreen.routeName: (BuildContext context) => AdminHomeScreen(),
          // ProductListScreen.routeName: (BuildContext context) => ProductListScreen(),
          // ProductDetailsScreen.routeName: (BuildContext context) => ProductDetailsScreen(),
        },
      ),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;

  void _incrementCounter() {
    setState(() {
      _counter++;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).backgroundColor,
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          // horizontal).
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              'You have pushed the button this many times:',
            ),
            Text(
              '$_counter',
              style: Theme.of(context).textTheme.headline4,
            ),
            RaisedButton(
              color: Theme.of(context).accentColor,
              child: Text('Go To Server'),
              onPressed: () async {
                http.Response response = await http.get(Constants.SERVER, headers: Constants.HEADER);
                    // await http.get('http://192.168.43.122:8080', headers: {"Content-Type": "application/json"});
                print(response);
              },
            )
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Theme.of(context).accentColor,
        onPressed: _incrementCounter,
        tooltip: 'Increment',
        child: Icon(Icons.add),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
