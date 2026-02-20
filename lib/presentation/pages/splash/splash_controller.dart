import 'package:get/get.dart';
import 'package:global_vin/routes/app_routes.dart';

class SplashController extends GetxController {
  @override
  void onInit() {
    super.onInit();
    _navigateToNext();
  }

  Future<void> _navigateToNext() async {
    await Future.delayed(const Duration(seconds: 2));

    // TODO: Check if user is logged in
    Get.offAllNamed(AppRoutes.login);
  }
}
