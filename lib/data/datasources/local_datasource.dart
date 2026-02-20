import 'package:global_vin/data/providers/local/storage_provider.dart';
import 'package:global_vin/data/models/user_model.dart';

abstract class LocalDatasource {
  Future<void> cacheUser(UserModel user);
  UserModel? getCachedUser();
  Future<void> cacheToken(String token);
  String? getToken();
  Future<void> clearCache();
}

class LocalDatasourceImpl implements LocalDatasource {
  final StorageProvider _storageProvider;

  LocalDatasourceImpl({required StorageProvider storageProvider})
      : _storageProvider = storageProvider;

  @override
  Future<void> cacheUser(UserModel user) async {
    await _storageProvider.saveUserData(user.toJson());
  }

  @override
  UserModel? getCachedUser() {
    final data = _storageProvider.getUserData();
    if (data != null) {
      return UserModel.fromJson(data);
    }
    return null;
  }

  @override
  Future<void> cacheToken(String token) async {
    await _storageProvider.saveToken(token);
  }

  @override
  String? getToken() {
    return _storageProvider.getToken();
  }

  @override
  Future<void> clearCache() async {
    await _storageProvider.clearAll();
  }
}
