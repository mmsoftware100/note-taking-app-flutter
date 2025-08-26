import 'dart:convert';
import 'package:flutter/material.dart';
import '../services/api_service.dart';

class AuthProvider with ChangeNotifier {
  String? _token;
  String? get token => _token;

  Future<bool> login(String email, String password) async {
    final response = await ApiService.login(email, password);
    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      // ✅ The token is inside "data.access_token"
      _token = data['data']['access_token'];
      ApiService.token = _token;  // store in service
      notifyListeners();
      return true;
    }
    return false;
  }

  Future<bool> register(String name, String email, String password) async {
    final response = await ApiService.register(name, email, password);
    return response.statusCode == 201;
  }

  void logout() {
    _token = null;
    ApiService.token = null;
    notifyListeners();
  }
}
