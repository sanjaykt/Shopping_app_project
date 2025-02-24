import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shopping/providers/auth_provider.dart';

import '../../common/constants.dart';
import '../../models/product.dart';
import '../../providers/cart_provider.dart';
import '../../providers/product_provider.dart';
import '../../widgets/drawer.dart';
import '../../widgets/widget_repo.dart';

class UserProductDetailsScreen extends StatefulWidget {
  static final routeName = 'user_product_details_screen';
  final int productId;

  UserProductDetailsScreen({@required this.productId});

  @override
  _UserProductDetailsScreenState createState() =>
      _UserProductDetailsScreenState();
}

class _UserProductDetailsScreenState extends State<UserProductDetailsScreen> {
  ProductProvider _productProvider;
  CartProvider _cartProvider;
  AuthProvider _authProvider;
  Product _product;

  @override
  Widget build(BuildContext context) {
    _productProvider = Provider.of<ProductProvider>(context);
    _cartProvider = Provider.of<CartProvider>(context);
    _authProvider = Provider.of<AuthProvider>(context);

    if (_product == null) {
      _product = Product();
      if (widget.productId != null) {
        Product cachedProduct = _productProvider.getProduct(widget.productId);
        _product = cachedProduct.clone();
      }
    }

    return Scaffold(
      appBar:
          WidgetRepo.getCustomAppBar(context, _cartProvider, 'Product Details'),
      drawer: _authProvider.loggedInUser != null ? AppDrawer() : null,
      body: Padding(
        padding: const EdgeInsets.all(18),
        child: ListView(
          children: [
            Center(
              child: Container(
                child: Text(
                  _product.productName.toString(),
                  style: TextStyle(fontSize: 18),
                ),
              ),
            ),
            SizedBox(height: 20),
            _buildImageSizedBox(_product),
            SizedBox(height: 20),
            Center(
              child: Text(
                _product.productDetails.toString(),
                style: TextStyle(fontSize: 14),
              ),
            ),
            SizedBox(height: 40),
            Divider(
              height: 2,
              color: Colors.red,
            ),
            SizedBox(height: 20),
            Text('Quantity: 1'),
            SizedBox(height: 40),
            Container(
              height: 50,
              child: RaisedButton(
                  child: Text('Add to Cart'),
                  onPressed: () {
                    _cartProvider.addItem(_product);
                  }),
            )
          ],
        ),
      ),
    );
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
