abstract class ApiConstants {
  static const String baseUrl = 'https://api.example.com';
  static const String apiVersion = '/api/v1';

  // Image base url
  static const String imageUrl = '$baseUrl/storage/';

  // Auth endpoints
  static const String login = '$apiVersion/auth/login';
  static const String register = '$apiVersion/auth/register';
  static const String logout = '$apiVersion/auth/logout';
  static const String refreshToken = '$apiVersion/auth/refresh-token';

  // User endpoints
  static const String userProfile = '$apiVersion/user/profile';
}
