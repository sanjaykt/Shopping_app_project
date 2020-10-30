import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../models/product.dart';
import '../../providers/auth_provider.dart';
import '../../providers/cart_provider.dart';
import '../../providers/product_provider.dart';
import '../../screens/product/user_product_details_screen.dart';
import '../../widgets/drawer.dart';
import '../../widgets/image_sized_box.dart';
import '../../widgets/widget_repo.dart';

class UserHomeScreen extends StatefulWidget {
  static final routeName = 'user_home_screen';

  @override
  _UserHomeScreenState createState() => _UserHomeScreenState();
}

class _UserHomeScreenState extends State<UserHomeScreen> {
  AuthProvider _authProvider;
  ProductProvider _productProvider;
  CartProvider _cartProvider;

  @override
  Widget build(BuildContext context) {
    _authProvider = Provider.of<AuthProvider>(context);
    _productProvider = Provider.of<ProductProvider>(context);
    _cartProvider = Provider.of<CartProvider>(context);

    return Scaffold(
        appBar: WidgetRepo.getCustomAppBar(context, _cartProvider, 'User Home'),
        drawer: _authProvider.loggedInUser != null ? AppDrawer() : null,
        body: ListView(
          children: [
            _buildHeading('Furniture'),
            _buildProductGrid(),
            Divider(color: Colors.red),
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
      color: Colors.grey.shade200,
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
                              UserProductDetailsScreen(
                                  productId: products[index].id),
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
                              ImageSizedBox(products[index]),
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
}
