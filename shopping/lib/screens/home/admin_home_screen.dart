import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shopping/models/product.dart';
import 'package:shopping/providers/product_provider.dart';
import 'package:shopping/widgets/image_sized_box.dart';
import '../../widgets/drawer.dart';

class AdminHomeScreen extends StatefulWidget {
  static final routeName = 'admin_home_screen';

  @override
  _AdminHomeScreenState createState() => _AdminHomeScreenState();
}

class _AdminHomeScreenState extends State<AdminHomeScreen> {
  ProductProvider _productProvider;

  @override
  Widget build(BuildContext context) {
    _productProvider = Provider.of<ProductProvider>(context);
    Size size = MediaQuery.of(context).size;

    return Scaffold(
      appBar: AppBar(title: Text('Admin Home')),
      drawer: AppDrawer(),
      body: Container(
        child: Column(
          children: [
            buildProductHeading(),
            buildProductViewList(size),
            Divider(),
            buildOrderHeading(),
          ],
        ),
      ),
    );
  }

  Container buildProductHeading() {
    return Container(
      width: double.infinity,
      height: 50,
      decoration: BoxDecoration(
        color: Colors.red[50],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            'Products',
            textAlign: TextAlign.center,
          ),
          SizedBox(width: 10),
          Text('Count?')
        ],
      ),
    );
  }

  Container buildOrderHeading() {
    return Container(
      width: double.infinity,
      height: 50,
      decoration: BoxDecoration(
        color: Colors.red[50],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            'Orders',
            textAlign: TextAlign.center,
          ),
          SizedBox(width: 10),
          Text('Count?')
        ],
      ),
    );
  }

  Container buildProductViewList(Size size) {
    return Container(
      height: size.height / 3,
      child: FutureBuilder(
        future: _productProvider.getAllProducts(),
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            if (snapshot.hasData) {
              List<Product> products = snapshot.data.data;
              return ListView.builder(
                scrollDirection: Axis.vertical,
                itemCount: products.length,
                itemBuilder: (BuildContext context, int index) {
                  return Container(
                    height: 100,
                    child: Card(
                      child: ListTile(
                        leading: ImageSizedBox(products[index]),
                        title: Text(products[index].productName),
                        subtitle: Text(products[index].productDetails),
                      ),
                    ),
                  );
                },
              );
            } else {
              return Text('no data');
            }
          } else {
            return CircularProgressIndicator();
          }
        },
      ),
    );
  }
}
