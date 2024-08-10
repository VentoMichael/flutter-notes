// lib/viewmodels/users_viewmodel.dart
import 'package:flutter/material.dart';
import '../models/user.dart';

class UsersViewModel extends ChangeNotifier {
  final List<User> _users = [
    User(
      userId: '1',
      name: 'Alice Johnson',
      email: 'alice@example.com',
      password: 'password',
      position: 'Manager',
      mainPosition: 'Manager',
      news: 'Alice has been promoted to Senior Manager.',
      role: 'Manager',
    ),
    User(
      userId: '2',
      name: 'Bob Smith',
      email: 'bob@example.com',
      password: 'password',
      position: 'Back-end',
      mainPosition: 'Developer',
      news: 'Bob is working on the new company app.',
      role: 'Developer',
    ),
    User(
      userId: '3',
      name: 'Charlie Davis',
      email: 'charlie@example.com',
      password: 'password',
      position: 'Front-end',
      mainPosition: 'Developer',
      news: 'Charlie has created new designs for the website.',
      role: 'Designer',
    ),
  ];

  List<User> get users => _users;

  User? findUserByEmail(String email) {
    try {
      return _users.firstWhere((user) => user.email == email);
    } catch (e) {
      return null;
    }
  }

  void addUser(User user) {
    _users.add(user);
    notifyListeners();
  }
}
