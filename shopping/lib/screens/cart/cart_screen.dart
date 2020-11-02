import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shopping/common/my_colors.dart';
import 'package:shopping/models/product.dart';
import 'package:shopping/providers/auth_provider.dart';
import 'package:shopping/providers/cart_provider.dart';
import 'package:shopping/providers/product_provider.dart';
import 'package:shopping/screens/order/order_screen.dart';
import 'package:shopping/widgets/drawer.dart';
import 'package:shopping/widgets/image_sized_box.dart';

class CartScreen extends StatefulWidget {
  static final routeName = 'cart_screen';

  @override
  _CartScreenState createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  CartProvider _cartProvider;
  ProductProvider _productProvider;
  AuthProvider _authProvider;

  @override
  Widget build(BuildContext context) {
    _cartProvider = Provider.of<CartProvider>(context);
    _productProvider = Provider.of<ProductProvider>(context);
    _authProvider = Provider.of<AuthProvider>(context);
    return Scaffold(
      appBar: AppBar(title: Text('Cart')),
      drawer: _authProvider.loggedInUser != null ? AppDrawer() : null,
      body: Container(
        padding: EdgeInsets.all(12),
        child: ListView(
          children: [
            _buildItemList(),
            SizedBox(height: 50),
            _buildProceedToBuy()
          ],
        ),
      ),
    );
  }

  Widget _buildItemList() {
    List<Widget> itemCards = [];
    if (_cartProvider.itemList.isNotEmpty) {
      for (var i in _cartProvider.itemList) {
        Product product = _productProvider.getProduct(i.productId);
        itemCards.add(
          Container(
            height: 200,
            child: Card(
              child: Column(
                children: [
                  ListTile(
                    leading: ImageSizedBox(product),
                    title: Text(product.productName),
                    subtitle: Text(
                      product.productDetails +
                          '\n' 'Price: ' +
                          product.price.toString() +
                          '\n' +
                          'Quantity: ' +
                          i.quantity.toString(),
                    ),
                  ),
                  SizedBox(height: 10),
                  Container(
                    alignment: Alignment.topRight,
                    child: Container(
                      padding: const EdgeInsets.only(right: 20),
                      height: 35,
                      child: RaisedButton(
                        color: MyColors.accentColorLight,
                        child: Text(
                          'Delete',
                          style: TextStyle(
                              fontSize: 14, fontWeight: FontWeight.w300),
                        ),
                        onPressed: () {
                          _cartProvider.deleteItem(i);
                        },
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),
        );
      }
    }
    return Column(children: itemCards);
  }

  Widget _buildProceedToBuy() {
    return Container(
      height: 50,
      child: RaisedButton(
        child: Text('Proceed to Buy'),
        onPressed: () {
          Navigator.pushNamed(context, OrderScreen.routeName);
        },
      ),
    );
  }
}
