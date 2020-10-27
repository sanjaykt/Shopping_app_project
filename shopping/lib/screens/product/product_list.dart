import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import 'package:shopping/models/product.dart';
import 'package:shopping/providers/product_provider.dart';
import 'package:shopping/screens/product/product_details_screen.dart';
import 'package:shopping/widgets/drawer.dart';

class ProductListScreen extends StatefulWidget {
  static final routeName = 'product_list_screen';

  @override
  _ProductListScreenState createState() => _ProductListScreenState();
}

class _ProductListScreenState extends State<ProductListScreen> {
  ProductProvider _productProvider;
  final picker = ImagePicker();

  Future getSetImage(Product product) async {
    PickedFile pickedFile = await picker.getImage(source: ImageSource.gallery);
    product.image = File(pickedFile.path);
  }

  @override
  Widget build(BuildContext context) {
    _productProvider = Provider.of<ProductProvider>(context);

    return Scaffold(
      appBar: AppBar(
        title: Text('Products'),
      ),
      drawer: AppDrawer(),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () {
          Navigator.pushNamed(context, ProductDetailsScreen.routeName);
        },
      ),
      body: Container(
        padding: EdgeInsets.all(10),
        child: FutureBuilder(
          future: _productProvider.getAllProducts(),
          builder: (BuildContext context, snapshot) {
            if (snapshot.connectionState == ConnectionState.done) {
              if (snapshot.hasData) {
                List<Product> products = snapshot.data.data;
                return ListView.builder(
                  itemCount: products.length,
                  itemBuilder: (BuildContext context, int index) {
                    return InkWell(
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (BuildContext context) =>
                                    ProductDetailsScreen(
                                      productToBeEdited: products[index],
                                    )));
                      },
                      child: SizedBox(
                        height: 100,
                        child: Card(
                          child: ListTile(
                            // leading: Image.network(products[index].productImageUrl), // for testing
                            leading: _buildImageSizedBox(products, index),
                            title: Text(products[index].productName),
                            subtitle: Text(products[index].productDetails),
                          ),
                        ),
                      ),
                    );
                  },
                );
//                 return GridView.count(
//                   childAspectRatio: .8,
//                   crossAxisCount: 2,
//                   children: List.generate(
//                     products.length,
//                     (index) {
//                       return InkWell(
//                         onTap: () {
//                           print(products[index].productName);
//                           Navigator.push(
//                             context,
//                             MaterialPageRoute(
//                                 builder: (BuildContext context) =>
//                                     ProductDetailsScreen(
//                                         productToBeEdited: products[index])),
//                           );
//                         },
//                         child: Card(
//                           color: Colors.red[50],
//                           child: Column(
//                             mainAxisAlignment: MainAxisAlignment.center,
//                             children: <Widget>[
// //                              CachedNetworkImage(
// //                                imageUrl: 'http://via.placeholder.com/140x100/000000/FFFFFF/?text=upload_image',
// //                                placeholder: (context, url) => CircularProgressIndicator(),
// //                                errorWidget: (context, url, error) => Icon(Icons.error),
// //                              ),
//                               LimitedBox(
//                                 maxHeight: 100,
//                                 child: products[index].image == null
//                                     ? RaisedButton(
//                                         child: Text('Upload Image'),
//                                         onPressed: () async {
//                                           PickedFile pickedFile =
//                                               await picker.getImage(
//                                                   source: ImageSource.gallery);
//                                           products[index].image =
//                                               File(pickedFile.path);
// //                                          _productProvider.tempUploadImage(products[index]);
//                                           _productProvider.uploadImage(
//                                               products[index].image);
//                                         },
//                                       )
//                                     : Image.file(products[index].image),
//                               ),
//                               Text(products[index].productName),
//                               SizedBox(height: 10),
//                               Text(products[index].productDetails),
//                             ],
//                           ),
//                         ),
//                       );
//                     },
//                   ),
//                 );
              } else {
                return Center(child: Text('no data'));
              }
            } else {
              return Center(child: CircularProgressIndicator());
            }
          },
        ),
      ),
    );
  }

  Widget _buildImageSizedBox(List<Product> products, int index) {
    String imagePath;
    return SizedBox(
      height: 100,
      width: 100,
      child: products[index].image == null
          ? RaisedButton(
              child: Text('Upload Image'),
              onPressed: () async {
                PickedFile pickedFile = await picker.getImage(
                    source: ImageSource.gallery, imageQuality: 10);
                setState(() {
                  products[index].image = File(pickedFile.path);
                  imagePath = pickedFile.path;
                });
                // products[index].productImageUrl = products[index].image.path;
                // _productProvider
                //     .tempUploadImage(products[index]); // for testing
                _productProvider.uploadImageMultiPart(products[index], imagePath);
              },
            )
          : Image.file(products[index].image), // for testing
      // : Image.file(products[index].image),
    );
  }
}
