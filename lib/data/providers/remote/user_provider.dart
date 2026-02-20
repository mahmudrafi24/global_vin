import 'package:global_vin/core/constants/api_constants.dart';
import 'package:global_vin/core/network/api_client.dart';
import 'package:global_vin/data/models/user_model.dart';

class UserProvider {
  final ApiClient _apiClient;

  UserProvider({required ApiClient apiClient}) : _apiClient = apiClient;

  Future<UserModel> getProfile() async {
    final response = await _apiClient.get(ApiConstants.userProfile);
    return UserModel.fromJson(response['data']);
  }

  Future<UserModel> updateProfile(Map<String, dynamic> data) async {
    final response = await _apiClient.put(ApiConstants.userProfile, body: data);
    return UserModel.fromJson(response['data']);
  }
}
