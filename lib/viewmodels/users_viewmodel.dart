import 'package:flutter/material.dart';
import '../models/user.dart';
import '../services/api_service.dart';

class UsersViewModel extends ChangeNotifier {
  List<User>? _users;
  bool _isLoading = false;
  String? _errorMessage;
  User? _currentUser; // Track the current user by ID

  List<User>? get users => _users;
  bool get isLoading => _isLoading;
  String? get errorMessage => _errorMessage;
  User? get currentUser => _currentUser;

  Future<void> fetchUsers() async {
    _isLoading = true;
    notifyListeners();

    try {
      _users = await ApiService.getUsers();
      _errorMessage = null;
    } catch (e) {
      _errorMessage = 'Failed to load users: $e';
      _users = [];
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<void> fetchUserById(int id) async {
    _isLoading = true;
    notifyListeners();

    try {
      _currentUser = await ApiService.getUserById(id); // Fetch user by ID
      _errorMessage = null;
    } catch (e) {
      _errorMessage = 'Failed to load user: $e';
      _currentUser = null;
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }
}
