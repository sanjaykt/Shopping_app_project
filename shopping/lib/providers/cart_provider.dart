// import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:shopping/models/item.dart';
import 'package:shopping/providers/auth_provider.dart';

class CartProvider extends ChangeNotifier {
  AuthProvider _authProvider;
  List<Item> _items = [];

  List<Item> get itemList => _items;

  update(AuthProvider authProvider) {
    this._authProvider = authProvider;

    _authProvider.addLoginHandler('CartProvider', loginHandler);
  }

  loginHandler() async {}

  addItem(Item item) {
    _items.add(item);
  }

  replaceItem(Item item) {
    // _items.map((i) => i.id == item.id);
    //
    // for (var i in _items) {
    //   if (i.id == item.id) {
    //     i = item;
    //     break;
    //   }
    // }
    int index = _items.indexOf(item);
    // _items.replaceRange(index, index+1, [item]);
    _items.removeAt(index);
    _items.insert(index, item);
  }

  deleteItem(Item item) {
    int index = _items.indexOf(item);
    _items.removeAt(index);
  }
}
