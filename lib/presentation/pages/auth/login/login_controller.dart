import 'package:get/get.dart';
import 'package:global_vin/presentation/controllers/auth_controller.dart';

class LoginController extends GetxController {
  final authController = Get.find<AuthController>();

  final obscurePassword = true.obs;

  void togglePasswordVisibility() {
    obscurePassword.toggle();
  }
}
