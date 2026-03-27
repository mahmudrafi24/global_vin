import 'package:get/get.dart';
import 'package:global_vin/core/utils/app_settings.dart';
import '../controllers/vin_controller.dart';

class VinBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<VinController>(
      () => VinController(Get.find<AppSettings>()),
    );
  }
}
