import 'package:flutter/material.dart';

import '../providers/cart_provider.dart';
import '../screens/cart/cart_screen.dart';


class WidgetRepo {
  static getCustomAppBar(BuildContext context,CartProvider cartProvider,String title) {
    return AppBar(
      title: Text(title),
      actions: <Widget>[
        Padding(
          padding: const EdgeInsets.only(right: 20),
          child: Row(
            children: [
              IconButton(
                  icon: Icon(
                    Icons.shopping_basket,
                    size: 40,
                  ),
                  onPressed: () {
                    Navigator.pushNamed(context, CartScreen.routeName);
                  }),
              SizedBox(width: 5),
              if (cartProvider.itemList.isNotEmpty)
                Text(cartProvider.itemCount.toString()),
            ],
          ),
        ),
      ],
    );
  }
}

