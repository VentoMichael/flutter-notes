import 'package:dio/dio.dart';
import 'dart:convert'; // Import this for json.decode()
import '../models/user.dart';

class ApiService {
  static final Dio _dio = Dio(BaseOptions(baseUrl: 'http://10.0.2.2:8000/api'));

  static Future<List<User>> getUsers() async {
    try {
      final response = await _dio.get('/users/json');
      print('Response status code: ${response.statusCode}');
      print('Response data: ${response.data}');

      // Extract list of users from the 'data' field
      final List<dynamic> data = response.data['data'];

      return data.map((json) => User.fromJson(json)).toList();
    } catch (e) {
      print('Error fetching users: $e');
      throw Exception('Failed to load users: $e');
    }
  }

  static Future<User> getUserById(int id) async {
    try {
      final response = await _dio.get('/users/json', queryParameters: {'id': id});
      if (response.statusCode == 200) {
        // Adjust based on actual response structure
        return User.fromJson(response.data['data']);
      } else {
        throw Exception('Failed to load user');
      }
    } catch (e) {
      print('Error fetching user: $e');
      throw Exception('Failed to load user: $e');
    }
  }
}
