import 'package:dio/dio.dart';
import 'package:logger/logger.dart';
import '../models/user.dart';

class AuthService {
  final Dio _dio = Dio(BaseOptions(baseUrl: 'http://10.0.2.2:8000/api'));
  final Logger _logger = Logger();

  AuthService() {
    _dio.interceptors.add(InterceptorsWrapper(
      onRequest: (options, handler) {
        _logger.i('Request: ${options.method} ${options.uri}');
        _logger.i('Headers: ${options.headers}');
        _logger.i('Request Data: ${options.data}');
        return handler.next(options);
      },
      onResponse: (response, handler) {
        _logger.i('Response: ${response.statusCode} ${response.requestOptions.uri}');
        _logger.i('Response Data: ${response.data}');
        return handler.next(response);
      },
      onError: (DioError e, handler) {
        _logger.e('Error: ${e.response?.statusCode}');
        _logger.e('Error Request URI: ${e.requestOptions.uri}');
        _logger.e('Error Request Data: ${e.requestOptions.data}');
        _logger.e('Error Response Data: ${e.response?.data}');
        _logger.e('Error Message: ${e.message}');
        return handler.next(e);
      },
    ));
  }

  Future<User> login(String email, String password) async {
    try {
      final response = await _dio.post('/login', data: {
        'email': email,
        'password': password,
      });

      final data = response.data;

      // Ensure the 'user' field exists in the response data
      if (data['user'] == null) {
        throw Exception('Unexpected response format.');
      }

      // Construct and return a User object from response data
      return User(
        userId: data['user']['id']?.toString() ?? '',
        name: data['user']['name'] ?? 'Unknown',
        email: data['user']['email'] ?? 'Unknown',
        position: data['user']['position'] ?? 'Unknown',
        mainPosition: data['user']['mainPosition'] ?? 'Unknown',
        news: data['user']['news'] ?? '',
        role: data['user']['role'] ?? 'User',
        password: password,
      );
    } catch (e) {
      if (e is DioError) {
        switch (e.response?.statusCode) {
          case 401:
            throw Exception('Invalid credentials. Please check your email and password.');
          case 500:
            throw Exception('Server error. Please try again later.');
          default:
            throw Exception('Failed to connect to the server. Please try again later.');
        }
      } else {
        throw Exception('An unexpected error occurred. Please try again later.');
      }
    }
  }
}
