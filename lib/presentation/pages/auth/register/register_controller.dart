import 'package:get/get.dart';
import 'package:global_vin/presentation/controllers/auth_controller.dart';

class RegisterController extends GetxController {
  final authController = Get.find<AuthController>();

  final obscurePassword = true.obs;
  final obscureConfirmPassword = true.obs;

  void togglePasswordVisibility() {
    obscurePassword.toggle();
  }

  void toggleConfirmPasswordVisibility() {
    obscureConfirmPassword.toggle();
  }
}
