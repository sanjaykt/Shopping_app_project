import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../common/constants.dart';
import '../../models/product.dart';
import '../../models/server_response.dart';
import '../../providers/product_provider.dart';

class ProductDetailsScreen extends StatefulWidget {
  static final routeName = 'product_details_screen';
  final Product productToBeEdited;

  ProductDetailsScreen({this.productToBeEdited});

  @override
  _ProductDetailsScreenState createState() => _ProductDetailsScreenState();
}

class _ProductDetailsScreenState extends State<ProductDetailsScreen> {
  final _formKey = GlobalKey<FormState>();
  Product productEditOrCreate;
  ProductProvider _productProvider;
  TextEditingController _productNameCtrl = TextEditingController();
  TextEditingController _productDetailsCtrl = TextEditingController();
  TextEditingController _productBrandCtrl = TextEditingController();
  TextEditingController _productBarcodeCtrl = TextEditingController();
  TextEditingController _productPriceCtrl = TextEditingController();

  @override
  Widget build(BuildContext context) {
    _productProvider = Provider.of<ProductProvider>(context);

    if (productEditOrCreate == null) {
      productEditOrCreate = Product();
      if (widget.productToBeEdited != null) {
        productEditOrCreate = widget.productToBeEdited.clone();
        _productNameCtrl.text = productEditOrCreate.productName;
        _productDetailsCtrl.text = productEditOrCreate.productDetails;
        _productBrandCtrl.text = productEditOrCreate.productBrand.toString();
        _productBarcodeCtrl.text = productEditOrCreate.productBarcode;
        _productPriceCtrl.text = productEditOrCreate.price.toString();
      }
    }

    return Scaffold(
      appBar: AppBar(
        title: Text('Product Details'),
      ),
      body: Container(
        padding: EdgeInsets.all(10),
        child: Form(
          key: _formKey,
          child: ListView(
            children: <Widget>[
              buildProductNameTextFormField(),
              buildProductDetailsTextFormField(),
              buildProductBrandTextFormField(),
              buildProductBarCodeTextFormField(),
              buildProductPriceTextFormField(),
              Divider(),
              _buildSubmitButton(context),
            ],
          ),
        ),
      ),
    );
  }

  Widget buildProductNameTextFormField() {
    return TextFormField(
      keyboardType: TextInputType.text,
      controller: _productNameCtrl,
      decoration: InputDecoration(
        prefixIcon: Icon(Icons.label),
        labelText: 'product name',
        hintText: 'product name',
      ),
      onChanged: (value) {
        productEditOrCreate.productName = value;
      },
      onSaved: (value) {
        productEditOrCreate.productName = value;
      },
    );
  }

  Widget buildProductBrandTextFormField() {
    return TextFormField(
      keyboardType: TextInputType.text,
      controller: _productBrandCtrl,
      decoration: InputDecoration(
        prefixIcon: Icon(Icons.label),
        labelText: 'product brand',
        hintText: 'product brand',
      ),
      onChanged: (value) {
        productEditOrCreate.productBrand = value;
      },
      onSaved: (value) {
        productEditOrCreate.productBrand = value;
      },
    );
  }

  Widget buildProductBarCodeTextFormField() {
    return TextFormField(
      keyboardType: TextInputType.text,
      controller: _productBarcodeCtrl,
      decoration: InputDecoration(
        prefixIcon: Icon(Icons.label),
        labelText: 'product barcode',
        hintText: 'product barcode',
      ),
      onChanged: (value) {
        productEditOrCreate.productBarcode = value;
      },
      onSaved: (value) {
        productEditOrCreate.productBarcode = value;
      },
    );
  }

  Widget buildProductDetailsTextFormField() {
    return TextFormField(
      keyboardType: TextInputType.text,
      controller: _productDetailsCtrl,
      maxLines: 5,
      minLines: 3,
      decoration: InputDecoration(
        prefixIcon: Icon(Icons.more),
        labelText: 'product details',
        hintText: 'product details',
      ),
      onChanged: (value) {
        productEditOrCreate.productDetails = value;
      },
      onSaved: (value) {
        productEditOrCreate.productDetails = value;
      },
    );
  }

  Widget buildProductPriceTextFormField() {
    return TextFormField(
      keyboardType: TextInputType.numberWithOptions(decimal: true),
      controller: _productPriceCtrl,
      decoration: InputDecoration(
        prefixIcon: Icon(Icons.money),
        labelText: 'product price',
        hintText: 'product price',
      ),
      onChanged: (value) {
        productEditOrCreate.price = double.parse(value).toDouble();
      },
      onSaved: (value) {
        productEditOrCreate.price = double.parse(value).toDouble();
      },
    );
  }

  Widget _buildSubmitButton(BuildContext context) {
    return RaisedButton(
      child: widget.productToBeEdited == null ? Text('Create') : Text('Update'),
      onPressed: () async {
        if (_formKey.currentState.validate()) {
          try {
            _formKey.currentState.save();
          } catch(error) {
            logger.d(error);
          }
          ServerResponse serverResponse = ServerResponse();
          if (widget.productToBeEdited == null) {
            serverResponse =
                await _productProvider.createProduct(productEditOrCreate);
          } else {
            serverResponse =
                await _productProvider.editProduct(productEditOrCreate);
          }
          print(serverResponse.message);
          if (serverResponse.status == SUCCESS) {
            Navigator.of(context).pop();
          }
        } else {
          print('problem submitting');
        }
      },
    );
  }
}
