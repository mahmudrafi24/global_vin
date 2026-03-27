import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:get/get.dart';
import 'package:global_vin/core/constants/app_colors.dart';
import 'package:global_vin/core/constants/app_strings.dart';
import 'package:global_vin/core/constants/app_typography.dart';
import 'package:global_vin/core/widgets/core_screen_utils.dart';
import 'package:global_vin/core/widgets/gradient_button.dart';
import '../controllers/onboarding_controller.dart';

class OnboardingPage extends GetView<OnboardingController> {
  const OnboardingPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: Column(
          children: [
            // Skip button
            Align(
              alignment: Alignment.topRight,
              child: Obx(() => controller.currentPage.value < 2
                  ? TextButton(
                      onPressed: controller.skip,
                      child: Text(
                        'Skip',
                        style: AppTypography.body
                            .copyWith(color: AppColors.primary),
                      ),
                    )
                  : SizedBox(height: 48.h)),
            ),
            // Pages
            Expanded(
              child: PageView(
                controller: controller.pageController,
                onPageChanged: controller.onPageChanged,
                children: [
                  _OnboardingItem(
                    icon: Icons.qr_code_scanner_rounded,
                    iconColor: AppColors.primary,
                    title: AppStrings.onboarding1Title,
                    subtitle: AppStrings.onboarding1Subtitle,
                  ),
                  _OnboardingItem(
                    icon: Icons.description_rounded,
                    iconColor: AppColors.success,
                    title: AppStrings.onboarding2Title,
                    subtitle: AppStrings.onboarding2Subtitle,
                  ),
                  _OnboardingItem(
                    icon: Icons.workspace_premium_rounded,
                    iconColor: AppColors.gold,
                    title: AppStrings.onboarding3Title,
                    subtitle: AppStrings.onboarding3Subtitle,
                  ),
                ],
              ),
            ),
            // Dot indicators
            Padding(
              padding: EdgeInsets.symmetric(vertical: 24.h),
              child: Obx(
                () => Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: List.generate(
                    3,
                    (index) => AnimatedContainer(
                      duration: const Duration(milliseconds: 300),
                      margin: EdgeInsets.symmetric(horizontal: 4.w),
                      width: controller.currentPage.value == index ? 24.w : 8.w,
                      height: 8.w,
                      decoration: BoxDecoration(
                        color: controller.currentPage.value == index
                            ? AppColors.primary
                            : AppColors.surfaceLight,
                        borderRadius: BorderRadius.circular(4.r),
                      ),
                    ),
                  ),
                ),
              ),
            ),
            // Button
            Padding(
              padding: EdgeInsets.fromLTRB(24.w, 0, 24.w, 32.h),
              child: Obx(
                () => GradientButton(
                  text: controller.currentPage.value == 2
                      ? AppStrings.getStarted
                      : 'Next',
                  onPressed: controller.nextPage,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _OnboardingItem extends StatelessWidget {
  final IconData icon;
  final Color iconColor;
  final String title;
  final String subtitle;

  const _OnboardingItem({
    required this.icon,
    required this.iconColor,
    required this.title,
    required this.subtitle,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 32.w),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            width: 160.w,
            height: 160.w,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: iconColor.withOpacity(0.1),
              border: Border.all(color: iconColor.withOpacity(0.3)),
            ),
            child: Icon(icon, size: 80.w, color: iconColor),
          )
              .animate()
              .scale(
                begin: const Offset(0.8, 0.8),
                end: const Offset(1.0, 1.0),
                duration: 600.ms,
                curve: Curves.easeOutBack,
              )
              .fadeIn(duration: 400.ms),
          SizedBox(height: 48.h),
          Text(
            title,
            style: AppTypography.heading1,
            textAlign: TextAlign.center,
          ).animate().fadeIn(delay: 200.ms, duration: 400.ms),
          SizedBox(height: 16.h),
          Text(
            subtitle,
            style: AppTypography.body.copyWith(height: 1.6),
            textAlign: TextAlign.center,
          ).animate().fadeIn(delay: 400.ms, duration: 400.ms),
        ],
      ),
    );
  }
}
