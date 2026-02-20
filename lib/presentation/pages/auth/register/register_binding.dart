import 'package:get/get.dart';
import 'package:global_vin/presentation/bindings/auth_binding.dart';
import 'package:global_vin/presentation/pages/auth/register/register_controller.dart';

class RegisterBinding extends Bindings {
  @override
  void dependencies() {
    AuthBinding().dependencies();
    Get.lazyPut<RegisterController>(() => RegisterController());
  }
}
