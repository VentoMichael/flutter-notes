// lib/viewmodels/auth_viewmodel.dart
import 'package:flutter/material.dart';
import '../models/user.dart';

class AuthViewModel extends ChangeNotifier {
  User? user;

  Future<void> login(String email, String password) async {
    await Future.delayed(Duration(seconds: 2));

    if (email == 'user@example.com' && password == 'password') {
      user = User(
        userId: '1',
        name: 'John Doe',
        position: 'Developer',
        mainPosition: 'Developer',
        news: '',
        role: 'User',
        email: 'user@example.com',
        password: 'password',
      );
      notifyListeners();
    } else {
      user = null;
    }
  }

  Future<void> register(String name, String email, String password) async {
    await Future.delayed(Duration(seconds: 2));

    if (name.isNotEmpty && email.isNotEmpty && password.isNotEmpty) {
      user = User(
        userId: '2',
        name: name,
        position: 'New User',
        mainPosition: 'New User',
        news: '',
        role: 'User',
        email: email,
        password: password,
      );
      notifyListeners();
    } else {
      user = null;
    }
  }

  void logout() {
    user = null;
    notifyListeners();
  }
}
