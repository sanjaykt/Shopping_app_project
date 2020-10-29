import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shopping/common/constants.dart';
import 'package:shopping/models/product.dart';
import 'package:shopping/providers/cart_provider.dart';
import 'package:shopping/providers/product_provider.dart';
import 'package:shopping/widgets/drawer.dart';

class CartScreen extends StatefulWidget {
  static final routeName = 'cart_screen';

  @override
  _CartScreenState createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  CartProvider _cartProvider;
  ProductProvider _productProvider;

  @override
  Widget build(BuildContext context) {
    _cartProvider = Provider.of<CartProvider>(context);
    _productProvider = Provider.of<ProductProvider>(context);
    return Scaffold(
      appBar: AppBar(
        title: Text('Cart'),
      ),
      drawer: AppDrawer(),
      body: Container(
        padding: EdgeInsets.all(12),
        child: ListView(
          children: [
            _buildItemList(),
            SizedBox(height: 50),
            Container(
              height: 50,
              child: RaisedButton(
                child: Text('Proceed to Buy'),
                onPressed: () {

                },
              ),
            )
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
                    leading: _buildImageSizedBox(product),
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
                    child: Padding(
                      padding: const EdgeInsets.only(right: 20),
                      child: RaisedButton(
                        child: Text('Delete'),
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

  Widget _buildImageSizedBox(Product product) {
    return SizedBox(
      height: 200,
      child: product.imageUrl != null
          ? CachedNetworkImage(
              imageUrl: Constants.SERVER + product.imageUrl,
              placeholder: (context, url) =>
                  Center(child: CircularProgressIndicator()),
              errorWidget: (context, url, error) => Icon(Icons.error),
            )
          : Container(child: Text('no image')),
    );
  }
}
