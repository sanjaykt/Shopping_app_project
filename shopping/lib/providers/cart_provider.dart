// import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:shopping/models/item.dart';
import 'package:shopping/models/product.dart';
import 'package:shopping/providers/auth_provider.dart';

class CartProvider extends ChangeNotifier {
  AuthProvider _authProvider;
  List<Item> _itemList = [];
  int _itemCount = 0;

  List<Item> get itemList => _itemList;

  int get itemCount => _itemCount;

  update(AuthProvider authProvider) {
    this._authProvider = authProvider;

    _authProvider.addLoginHandler('CartProvider', loginHandler);
    _authProvider.addLogoutHandler('CartProvider', logoutHandler);
  }

  loginHandler() async {}

  logoutHandler() {
    _itemCount = 0;
    _itemList.clear();
  }

  addItem(Product product) {
    int index;
    if (_itemList.isNotEmpty) {
      index =
          _itemList.indexWhere((element) => element.productId == product.id);
    }

    // add item if list is empty or no duplicate in the list, add item
    if (index == null || index == -1) {
      Item item = Item();
      item.productId = product.id;
      item.price = product.price;
      item.total = item.price;
      item.quantity = 1;
      _itemList.add(item);
      _itemCount += 1;
    } else {
      _itemList[index].quantity += 1;
      _itemList[index].total += _itemList[index].price;
      _itemCount += 1;
    }
    notifyListeners();
  }

  replaceItem(Item item) {
    int index = _itemList.indexOf(item);
    _itemList.removeAt(index);
    _itemList.insert(index, item);
  }

  deleteItem(Item item) {
    int index = _itemList.indexOf(item);
    _itemList.removeAt(index);
    notifyListeners();
  }
}
