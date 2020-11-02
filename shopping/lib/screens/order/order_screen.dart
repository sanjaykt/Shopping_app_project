import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shopping/providers/auth_provider.dart';
import 'package:shopping/screens/user/shipping_address_screen.dart';
import 'package:shopping/widgets/drawer.dart';

import '../../models/product.dart';
import '../../providers/cart_provider.dart';
import '../../providers/product_provider.dart';
import '../../widgets/image_sized_box.dart';

class OrderScreen extends StatefulWidget {
  static final routeName = 'order_screen';

  @override
  _OrderScreenState createState() => _OrderScreenState();
}

class _OrderScreenState extends State<OrderScreen> {
  CartProvider _cartProvider;
  ProductProvider _productProvider;
  AuthProvider _authProvider;

  @override
  Widget build(BuildContext context) {
    _cartProvider = Provider.of<CartProvider>(context);
    _productProvider = Provider.of<ProductProvider>(context);
    _authProvider = Provider.of<AuthProvider>(context);

    return Scaffold(
      appBar: AppBar(title: Text('Order')),
      drawer: _authProvider.loggedInUser != null ? AppDrawer() : null,
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: ListView(
          children: [
            _buildItemList(),
            SizedBox(height: 20),
            _buildTotal(),
            SizedBox(height: 20),
            _buildAddAddress(),
            SizedBox(height: 20),
            _buildAddPaymentMethod(),
            SizedBox(height: 20),
            _buildPlaceOrder(),
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
            height: 150,
            child: Card(
              child: Column(
                children: [
                  ListTile(
                    leading: ImageSizedBox(product),
                    title: Text(product.productName),
                    subtitle: Text(product.productDetails +
                        '\n' 'Price: ' +
                        product.price.toString() +
                        '\n' +
                        'Quantity: ' +
                        i.quantity.toString() +
                        '\n' +
                        'Total: ' +
                        i.total.toString()),
                  ),
                ],
              ),
            ),
          ),
        );
      }
    }
    return Column(children: itemCards);
  }

  Widget _buildTotal() {
    var total = 0.0;
    if (_cartProvider.itemList != null && _cartProvider.itemList.isNotEmpty) {
      for (var i in _cartProvider.itemList) {
        if (i.total != null) {
          total += i.total;
        }
      }
    }
    return Container(
      padding: const EdgeInsets.only(right: 10),
      alignment: Alignment.centerRight,
      child: Column(
        children: [
          Text('Items Total: ' + total.toString()),
          SizedBox(height: 5),
          Text('18% GST: ' + (total * 0.18).toStringAsFixed(2)),
          SizedBox(height: 5),
          Text('TOTAL: ' + (total * 1.18).toStringAsFixed(2)),
        ],
      ),
    );
  }

  Widget _buildAddAddress() {
    return Container(
      width: double.infinity,
      child: RaisedButton(
        child: Text('Add Shipping Address'),
        onPressed: () {
          Navigator.pushNamed(context, ShippingAddressScreen.routeName);
        },
      ),
    );
  }

  Widget _buildAddPaymentMethod() {
    return Container(
      width: double.infinity,
      child: RaisedButton(
        child: Text('Add Payment Method'),
        onPressed: () {},
      ),
    );
  }

  Widget _buildPlaceOrder() {
    return Container(
      width: double.infinity,
      child: RaisedButton(
        child: Text('Place Order'),
        onPressed: null,
      ),
    );
  }
}
