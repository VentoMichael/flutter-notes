// lib/models/user.dart
class User {
  final String userId;
  final String name;
  final String email;
  final String password;
  final String position;
  final String mainPosition;
  final String news;
  final String role;

  User({
    required this.userId,
    required this.name,
    required this.email,
    required this.password,
    required this.position,
    required this.mainPosition,
    required this.news,
    required this.role,
  });
}
