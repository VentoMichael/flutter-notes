import 'package:flutter/material.dart';
import '../models/user.dart';

class UsersViewModel extends ChangeNotifier {
  final List<User> _users = [
    User(name: 'Alice Johnson', position: 'Manager', mainPosition: 'Manager', news: 'Alice has been promoted to Senior Manager.', role: 'Developer', userId: '1'),
    User(name: 'Bob Smith', position: 'Back-end',mainPosition: 'Developer', news: 'Bob is working on the new company app.', role: 'Developer', userId: '2'),
    User(name: 'Charlie Davis', position: 'Front-end',mainPosition: 'Developer', news: 'Charlie has created new designs for the website.', role: 'Designer', userId: '3'),
  ];

  List<User> get users => _users;
}
