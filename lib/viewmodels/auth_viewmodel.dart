// lib/viewmodels/auth_viewmodel.dart
import 'package:flutter/material.dart';
import '../models/user.dart';
import '../services/auth_service.dart';

class AuthViewModel extends ChangeNotifier {
  User? user;
  final AuthService _authService = AuthService();

  Future<void> login(String email, String password) async {
    try {
      user = await _authService.login(email, password);
      notifyListeners();
    } catch (e) {
      user = null;
      notifyListeners();
    }
  }


  void logout() {
    user = null;
    notifyListeners();
  }
}
