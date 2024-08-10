// lib/services/auth_service.dart
import '../models/user.dart';

class AuthService {
  Future<User> login(String email, String password) async {
    await Future.delayed(Duration(seconds: 2));

    if (email == "test@example.com" && password == "password") {
      return User(
        userId: "1",
        name: "John Doe",
        email: email,
        position: 'Software Engineer',
        mainPosition: 'Engineer',
        news: 'Employee of the Month',
        role: 'User', password: '',
      );
    } else {
      throw Exception("Invalid credentials");
    }
  }

  Future<User> register(String name, String email, String password) async {
    await Future.delayed(Duration(seconds: 2));

    return User(
      userId: "1",
      name: name,
      email: email,
      position: 'Software Engineer',
      mainPosition: 'Engineer',
      news: 'New Employee',
      role: 'User', password: '',
    );
  }
}
