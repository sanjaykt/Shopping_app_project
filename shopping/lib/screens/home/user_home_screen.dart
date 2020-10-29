import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shopping/common/constants.dart';
import 'package:shopping/models/product.dart';
import 'package:shopping/providers/auth_provider.dart';
import 'package:shopping/providers/product_provider.dart';
import 'package:shopping/screens/product/user_product_details_screen.dart';
import 'package:shopping/widgets/drawer.dart';

class UserHomeScreen extends StatefulWidget {
  static final routeName = 'user_home_screen';

  @override
  _UserHomeScreenState createState() => _UserHomeScreenState();
}

class _UserHomeScreenState extends State<UserHomeScreen> {
  AuthProvider _authProvider;
  ProductProvider _productProvider;

  @override
  Widget build(BuildContext context) {
    _authProvider = Provider.of<AuthProvider>(context);
    _productProvider = Provider.of<ProductProvider>(context);

    return Scaffold(
        appBar: AppBar(title: Text('User Home')),
        drawer: _authProvider.loggedInUser != null ? AppDrawer() : null,
        body: ListView(
          children: [
            _buildHeading('Furniture'),
            _buildProductGrid(),
            Divider(
              color: Colors.red,
            ),
            _buildHeading('Clothing')
          ],
        ));
  }

  Widget _buildHeading(String name) {
    return Container(
      child: Text(
        name,
        textAlign: TextAlign.center,
        style: TextStyle(fontSize: 18),
      ),
    );
  }

  Widget _buildProductGrid() {
    return Container(
      constraints: BoxConstraints(maxHeight: 400),
      child: FutureBuilder(
        future: _productProvider.getAllProducts(),
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            if (snapshot.hasData) {
              List<Product> products = snapshot.data.data;
              return GridView.builder(
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2, childAspectRatio: .9),
                itemCount: products.length,
                itemBuilder: (BuildContext context, int index) {
                  return InkWell(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (BuildContext context) =>
                              UserProductDetailsScreen(productId: products[index].id),
                        ),
                      );
                    },
                    child: Container(
                      height: 100,
                      width: 50,
                      child: Card(
                        child: SingleChildScrollView(
                          child: Column(
                            // mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              _buildImageSizedBox(products[index]),
                              Text(products[index].productName),
                              Text(products[index].productDetails),
                            ],
                          ),
                        ),
                        // child: ListTile(
                        //   leading: _buildImageSizedBox(products[index]),
                        //   title: Text(products[index].productName),
                        //   subtitle: Text(products[index].productDetails),
                        // ),
                      ),
                    ),
                  );
                },
              );
            } else {
              return Container(
                child: Text('no data'),
              );
            }
          }
          return Center(child: CircularProgressIndicator());
        },
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
