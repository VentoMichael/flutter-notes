class User {
  final String userId;
  final String name;
  final String email;
  final String position;
  final String mainPosition;
  final String news;
  final String role;
  final String password;

  User({
    required this.userId,
    required this.name,
    required this.email,
    required this.position,
    required this.mainPosition,
    required this.news,
    required this.role,
    required this.password,
  });

  factory User.fromJson(Map<String, dynamic> json) {
    final employment = json['employment'] as Map<String, dynamic>?;
    final category = employment?['category'] as Map<String, dynamic>?;

    return User(
      userId: json['id']?.toString() ?? '',
      name: json['name'] ?? 'Unknown',
      email: json['email'] ?? 'Unknown',
      position: employment?['title'] ?? 'Unknown',
      mainPosition: category?['title'] ?? 'Unknown',
      news: json['news'] ?? '',
      role: json['role'] ?? 'User',
      password: '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': userId,
      'name': name,
      'email': email,
      'position': position,
      'mainPosition': mainPosition,
      'news': news,
      'role': role,
    };
  }
}
