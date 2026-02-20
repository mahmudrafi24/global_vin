import 'package:get/get.dart';
import 'package:global_vin/core/network/api_client.dart';
import 'package:global_vin/core/network/network_info.dart';
import 'package:global_vin/data/providers/local/storage_provider.dart';
import 'package:global_vin/data/providers/remote/auth_provider.dart';
import 'package:global_vin/data/repositories/auth_repository_impl.dart';
import 'package:global_vin/domain/repositories/auth_repository.dart';
import 'package:global_vin/domain/usecases/login_usecase.dart';
import 'package:global_vin/domain/usecases/register_usecase.dart';
import 'package:global_vin/presentation/controllers/auth_controller.dart';

class AuthBinding extends Bindings {
  @override
  void dependencies() {
    // Providers
    Get.lazyPut<AuthProvider>(
      () => AuthProvider(apiClient: Get.find<ApiClient>()),
    );

    // Repositories
    Get.lazyPut<AuthRepository>(
      () => AuthRepositoryImpl(
        authProvider: Get.find<AuthProvider>(),
        storageProvider: Get.find<StorageProvider>(),
        networkInfo: Get.find<NetworkInfo>(),
      ),
    );

    // Use cases
    Get.lazyPut(() => LoginUseCase(repository: Get.find<AuthRepository>()));
    Get.lazyPut(() => RegisterUseCase(repository: Get.find<AuthRepository>()));

    // Controllers
    Get.lazyPut<AuthController>(
      () => AuthController(
        loginUseCase: Get.find<LoginUseCase>(),
        registerUseCase: Get.find<RegisterUseCase>(),
      ),
    );
  }
}
