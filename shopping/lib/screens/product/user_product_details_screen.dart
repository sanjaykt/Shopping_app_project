import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shopping/common/constants.dart';
import 'package:shopping/models/product.dart';
import 'package:shopping/providers/product_provider.dart';
import 'package:shopping/widgets/drawer.dart';

class UserProductDetailsScreen extends StatefulWidget {
  static final routeName = 'user_product_details_screen';
  final int id;

  UserProductDetailsScreen({@required this.id});

  @override
  _UserProductDetailsScreenState createState() =>
      _UserProductDetailsScreenState();
}

class _UserProductDetailsScreenState extends State<UserProductDetailsScreen> {
  ProductProvider _productProvider;
  Product _product;

  @override
  Widget build(BuildContext context) {
    _productProvider = Provider.of<ProductProvider>(context);

    if (_product == null) {
      _product = Product();
      if (widget.id != null) {
        Product cachedProduct = _productProvider.getProduct(widget.id);
        _product = cachedProduct.clone();
      }
    }

    return Scaffold(
      appBar: AppBar(
        title: Text('Product Details'),
      ),
      drawer: AppDrawer(),
      body: ListView(
        children: [
          Center(
            child: Container(
              child: Text(_product.productName.toString()),
            ),
          ),
          _buildImageSizedBox(_product),
          Center(
            child: Text(_product.productDetails.toString()),
          ),
          Divider(
            height: 2,
            color: Colors.red,
          ),
          Text('Quantity: 1'),
          RaisedButton(
              child: Text('Add to Cart'),
              onPressed: () {

          })
        ],
      ),
    );
  }

  Widget _buildImageSizedBox(Product product) {
    return SizedBox(
      height: 100,
      width: 100,
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
