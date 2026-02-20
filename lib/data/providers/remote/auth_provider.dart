import 'package:global_vin/core/constants/api_constants.dart';
import 'package:global_vin/core/network/api_client.dart';
import 'package:global_vin/data/models/user_model.dart';

class AuthProvider {
  final ApiClient _apiClient;

  AuthProvider({required ApiClient apiClient}) : _apiClient = apiClient;

  Future<UserModel> login({
    required String email,
    required String password,
  }) async {
    final response = await _apiClient.post(
      ApiConstants.login,
      body: {'email': email, 'password': password},
    );
    return UserModel.fromJson(response['data']);
  }

  Future<UserModel> register({
    required String name,
    required String email,
    required String password,
  }) async {
    final response = await _apiClient.post(
      ApiConstants.register,
      body: {'name': name, 'email': email, 'password': password},
    );
    return UserModel.fromJson(response['data']);
  }

  Future<void> logout() async {
    await _apiClient.post(ApiConstants.logout);
  }
}
