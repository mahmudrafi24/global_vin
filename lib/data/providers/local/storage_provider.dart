import 'package:get_storage/get_storage.dart';

class StorageProvider {
  late final GetStorage _box;

  StorageProvider() {
    _box = GetStorage();
  }

  Future<void> init() async {
    await GetStorage.init();
  }

  // Token
  Future<void> saveToken(String token) async {
    await _box.write('token', token);
  }

  String? getToken() {
    return _box.read<String>('token');
  }

  // User data
  Future<void> saveUserData(Map<String, dynamic> userData) async {
    await _box.write('user_data', userData);
  }

  Map<String, dynamic>? getUserData() {
    return _box.read<Map<String, dynamic>>('user_data');
  }

  // General
  Future<void> write(String key, dynamic value) async {
    await _box.write(key, value);
  }

  T? read<T>(String key) {
    return _box.read<T>(key);
  }

  Future<void> remove(String key) async {
    await _box.remove(key);
  }

  Future<void> clearAll() async {
    await _box.erase();
  }
}
