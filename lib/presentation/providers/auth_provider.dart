import 'package:flutter/material.dart';

import '../../domain/entities/User.dart';



class AuthProvider with ChangeNotifier {
  final List<User> _registeredUsers = [];
  User? _currentUser;

  User? get currentUser => _currentUser;
  bool get isLoggedIn => _currentUser != null;

  bool login(String email, String password) {
    final user = _registeredUsers.firstWhere(
          (u) => u.email == email && u.password == password,
      orElse: () => User(email: '', password: ''),
    );

    if (user.email.isNotEmpty) {
      _currentUser = user;
      notifyListeners();
      return true;
    }
    return false;
  }

  bool register(String email, String password) {
    final exists = _registeredUsers.any((u) => u.email == email);
    if (exists) return false;

    final newUser = User(email: email, password: password);
    _registeredUsers.add(newUser);
    _currentUser = newUser;
    notifyListeners();
    return true;
  }

  void logout() {
    _currentUser = null;
    notifyListeners();
  }
}
