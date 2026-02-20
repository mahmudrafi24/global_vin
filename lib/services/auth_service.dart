import 'package:get/get.dart';
import 'package:global_vin/data/providers/local/storage_provider.dart';
import 'package:global_vin/domain/entities/user_entity.dart';

class AuthService extends GetxService {
  final Rx<UserEntity?> currentUser = Rx<UserEntity?>(null);
  final isLoggedIn = false.obs;

  StorageProvider get _storage => Get.find<StorageProvider>();

  bool get isAuthenticated => isLoggedIn.value;

  void setUser(UserEntity user, String token) {
    currentUser.value = user;
    isLoggedIn.value = true;
    _storage.saveToken(token);
  }

  void clearUser() {
    currentUser.value = null;
    isLoggedIn.value = false;
    _storage.clearAll();
  }

  String? getToken() {
    return _storage.getToken();
  }

  Future<void> checkAuthStatus() async {
    final token = _storage.getToken();
    if (token != null) {
      isLoggedIn.value = true;
      // TODO: Fetch user profile with token
    }
  }
}
