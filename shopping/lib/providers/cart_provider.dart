// import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:shopping/models/item.dart';
import 'package:shopping/providers/auth_provider.dart';

class CartProvider extends ChangeNotifier {
  AuthProvider _authProvider;
  List<Item> _itemList = [];

  List<Item> get itemList => _itemList;

  update(AuthProvider authProvider) {
    this._authProvider = authProvider;

    _authProvider.addLoginHandler('CartProvider', loginHandler);
  }

  loginHandler() async {}

  addItem(Item item) {
    if (_itemList.isNotEmpty) {
      int index = _itemList
          .indexWhere((element) => element.productId == item.productId);
      if (index == -1) {
        _itemList.add(item);
      } else {
        _itemList[index].quantity += 1;
      }
    } else {
      _itemList.add(item);
    }

    notifyListeners();
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
    int index = _itemList.indexOf(item);
    // _items.replaceRange(index, index+1, [item]);
    _itemList.removeAt(index);
    _itemList.insert(index, item);
  }

  deleteItem(Item item) {
    int index = _itemList.indexOf(item);
    _itemList.removeAt(index);
    notifyListeners();
  }
}
