import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:global_vin/core/utils/app_settings.dart';
import 'package:global_vin/routes/app_routes.dart';

class OnboardingController extends GetxController {
  final AppSettings _settings;

  OnboardingController(this._settings);

  final PageController pageController = PageController();
  final RxInt currentPage = 0.obs;
  final int totalPages = 3;

  void nextPage() {
    if (currentPage.value < totalPages - 1) {
      pageController.nextPage(
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
    } else {
      completeOnboarding();
    }
  }

  void skip() {
    completeOnboarding();
  }

  Future<void> completeOnboarding() async {
    await _settings.setOnboardingDone(true);
    Get.offAllNamed(AppRoutes.home);
  }

  void onPageChanged(int page) {
    currentPage.value = page;
  }

  @override
  void onClose() {
    pageController.dispose();
    super.onClose();
  }
}
