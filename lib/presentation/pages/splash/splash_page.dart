import 'package:flutter/material.dart';
import 'package:core_kit/core_kit.dart';
import 'package:get/get.dart';
import 'package:global_vin/core/constants/app_constants.dart';
import 'package:global_vin/core/theme/app_colors.dart';
import 'package:global_vin/presentation/pages/splash/splash_controller.dart';

class SplashPage extends StatelessWidget {
  const SplashPage({super.key});

  @override
  Widget build(BuildContext context) {
    // ignore: unused_local_variable
    final controller = Get.put(SplashController());

    return Scaffold(
      backgroundColor: AppColors.primary,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(
              Icons.directions_car,
              size: 80,
              color: AppColors.white,
            ),
            24.height,
            CommonText(
              text: AppConstants.appName,
              fontSize: 28.sp,
              fontWeight: FontWeight.bold,
              textColor: AppColors.white,
            ),
            48.height,
            const CommonLoader(),
          ],
        ),
      ),
    );
  }
}
