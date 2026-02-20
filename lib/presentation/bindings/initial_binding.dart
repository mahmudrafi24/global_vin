import 'package:get/get.dart';
import 'package:global_vin/core/network/api_client.dart';
import 'package:global_vin/core/network/network_info.dart';
import 'package:global_vin/data/providers/local/cache_provider.dart';
import 'package:global_vin/data/providers/local/storage_provider.dart';
import 'package:global_vin/presentation/controllers/app_controller.dart';
import 'package:global_vin/services/connectivity_service.dart';

class InitialBinding extends Bindings {
  @override
  void dependencies() {
    // Core
    Get.lazyPut<ApiClient>(() => ApiClient(), fenix: true);
    Get.lazyPut<NetworkInfo>(() => NetworkInfoImpl(), fenix: true);

    // Providers
    Get.lazyPut<StorageProvider>(() => StorageProvider(), fenix: true);
    Get.lazyPut<CacheProvider>(() => CacheProvider(), fenix: true);

    // Services
    Get.lazyPut<ConnectivityService>(() => ConnectivityService(), fenix: true);

    // Controllers
    Get.lazyPut<AppController>(() => AppController(), fenix: true);
  }
}
