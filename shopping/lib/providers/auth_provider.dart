import 'package:flutter/material.dart';

import '../models/server_response.dart';
import '../models/user.dart';
import '../services/auth_service.dart';

class AuthProvider extends ChangeNotifier {
  AuthService _authService = AuthService();
  Map<String, Function> _loginHandlers = {};
  Map<String, Function> _logoutHandlers = {};
  User _loggedInUser;

  User get loggedInUser => _loggedInUser;


  AuthProvider();

  Future<ServerResponse> login(String username, String password) async {
    ServerResponse serverResponse = await _authService.login(username, password);
    if (serverResponse.status == SUCCESS) {
      _loggedInUser = serverResponse.data;
      executeLoginHandler();
    }
    return serverResponse;
  }

  addLoginHandler(String key, Function handler) {
    _loginHandlers[key] = handler;
  }

  addLogoutHandler(String key, Function handler) {
    _logoutHandlers[key] = handler;
  }

  executeLoginHandler() {
    for (var handler in _loginHandlers.values) {
      if (handler != null) handler();
    }
  }

  executeLogoutHandler() {
    for (var handler in _logoutHandlers.values) {
      if (handler != null) handler();
    }
  }

  logout() {
    _loggedInUser = null;
    executeLogoutHandler();
  }

}
