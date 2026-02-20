import 'package:get/get.dart';
import 'package:global_vin/presentation/bindings/auth_binding.dart';
import 'package:global_vin/presentation/pages/auth/login/login_controller.dart';

class LoginBinding extends Bindings {
  @override
  void dependencies() {
    AuthBinding().dependencies();
    Get.lazyPut<LoginController>(() => LoginController());
  }
}
