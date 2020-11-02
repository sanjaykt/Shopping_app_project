import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shopping/screens/user/shipping_address_screen.dart';

import 'common/my_colors.dart';
import 'providers/Database_provider.dart';
import 'providers/auth_provider.dart';
import 'providers/cart_provider.dart';
import 'providers/product_provider.dart';
import 'providers/user_provider.dart';
import 'screens/cart/cart_screen.dart';
import 'screens/home/admin_home_screen.dart';
import 'screens/home/user_home_screen.dart';
import 'screens/login/login_screen.dart';
import 'screens/order/order_screen.dart';
import 'screens/product/admin_product_details_screen.dart';
import 'screens/product/product_list.dart';
import 'screens/product/user_product_details_screen.dart';
import 'screens/user/user_details.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (context) => AuthProvider(),
          lazy: false,
        ),
        ChangeNotifierProvider(create: (ctx) => UserProvider(), lazy: false),
        Provider(create: (context) => DatabaseProvider(), lazy: false),
        ChangeNotifierProxyProvider2<AuthProvider, DatabaseProvider,
            ProductProvider>(
          create: (context) => ProductProvider(),
          lazy: false,
          update: (context, authProvider, databaseProvider, productProvider) =>
              productProvider..update(authProvider, databaseProvider),
        ),
        ChangeNotifierProxyProvider<AuthProvider, CartProvider>(
          create: (context) => CartProvider(),
          lazy: false,
          update: (context, authProvider, cartProvider) =>
              cartProvider..update(authProvider),
        ),
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
              bodyText2:
                  TextStyle(fontSize: 14, fontWeight: FontWeight.normal)),
          buttonTheme: ButtonThemeData(
            height: 50,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
              // side: BorderSide(color: Theme.of(context).accentColor, width: 5),
            ),
            buttonColor: MyColors.accentColor,
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
          AdminHomeScreen.routeName: (BuildContext context) =>
              AdminHomeScreen(),
          ProductListScreen.routeName: (BuildContext context) =>
              ProductListScreen(),
          ProductDetailsScreen.routeName: (BuildContext context) =>
              ProductDetailsScreen(),
          UserProductDetailsScreen.routeName: (BuildContext context) =>
              UserProductDetailsScreen(),
          CartScreen.routeName: (BuildContext context) => CartScreen(),
          OrderScreen.routeName: (BuildContext context) => OrderScreen(),
          ShippingAddressScreen.routeName: (BuildContext context) =>
              ShippingAddressScreen(),
        },
      ),
    );
  }
}
