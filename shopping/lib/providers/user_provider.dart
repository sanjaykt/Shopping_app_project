import 'package:flutter/cupertino.dart';
import 'package:shopping/models/user.dart';
import 'package:shopping/services/user_service.dart';

class UserProvider extends ChangeNotifier {
  UserService _userService = UserService();

  Future<String> createUser(User user) {
    return _userService.createUser(user);
  }

//  Future<ServerResponse> login(String username, String password) {
//    return _userService.login(username, password);
//  }
}
