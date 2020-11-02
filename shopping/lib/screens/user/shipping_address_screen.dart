import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shopping/models/address.dart';
import 'package:shopping/providers/auth_provider.dart';
import 'package:shopping/providers/cart_provider.dart';
import 'package:shopping/widgets/drawer.dart';
import 'package:shopping/widgets/widget_repo.dart';

class ShippingAddressScreen extends StatefulWidget {
  static final routeName = 'shipping_address_screen';
  @override
  _ShippingAddressScreenState createState() => _ShippingAddressScreenState();
}

class _ShippingAddressScreenState extends State<ShippingAddressScreen> {
  CartProvider _cartProvider;
  AuthProvider _authProvider;
  @override
  Widget build(BuildContext context) {
    _cartProvider = Provider.of<CartProvider>(context);
    _authProvider = Provider.of<AuthProvider>(context);
    return Scaffold(
      appBar: WidgetRepo.getCustomAppBar(
          context, _cartProvider, 'Shipping Address'),
      drawer: _authProvider.loggedInUser != null ? AppDrawer() : null,
      body: Container(
        child: ListView(
          children: [
            Text('Saved Shipping Address'),
            _buildSavedShippingAddresses(),
            // TODO: _buildNewShippingAddress()
          ],
        ),
      ),
    );
  }

  Widget _buildSavedShippingAddresses() {
    List<Address> addresses = [];
    if (_authProvider.loggedInUser.addressId != null) {
      // TODO: 1. set up node address route,
      //  TODO: 2. fetch all the addresses belong to the user,
      //  TODO: 3. go through all the addressed and display it in a widget
    }

    return Text('TODO: saved addresses');
  }
}
