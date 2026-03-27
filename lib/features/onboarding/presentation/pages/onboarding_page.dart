import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:get/get.dart';
import 'package:global_vin/core/constants/app_colors.dart';
import 'package:global_vin/core/constants/app_strings.dart';
import 'package:global_vin/core/constants/app_typography.dart';
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
                  : const SizedBox(height: 48)),
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
              padding: const EdgeInsets.symmetric(vertical: 24),
              child: Obx(
                () => Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: List.generate(
                    3,
                    (index) => AnimatedContainer(
                      duration: const Duration(milliseconds: 300),
                      margin: const EdgeInsets.symmetric(horizontal: 4),
                      width: controller.currentPage.value == index ? 24 : 8,
                      height: 8,
                      decoration: BoxDecoration(
                        color: controller.currentPage.value == index
                            ? AppColors.primary
                            : AppColors.surfaceLight,
                        borderRadius: BorderRadius.circular(4),
                      ),
                    ),
                  ),
                ),
              ),
            ),
            // Button
            Padding(
              padding: const EdgeInsets.fromLTRB(24, 0, 24, 32),
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
      padding: const EdgeInsets.symmetric(horizontal: 32),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            width: 160,
            height: 160,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: iconColor.withOpacity(0.1),
              border: Border.all(color: iconColor.withOpacity(0.3)),
            ),
            child: Icon(icon, size: 80, color: iconColor),
          )
              .animate()
              .scale(
                begin: const Offset(0.8, 0.8),
                end: const Offset(1.0, 1.0),
                duration: 600.ms,
                curve: Curves.easeOutBack,
              )
              .fadeIn(duration: 400.ms),
          const SizedBox(height: 48),
          Text(
            title,
            style: AppTypography.heading1,
            textAlign: TextAlign.center,
          ).animate().fadeIn(delay: 200.ms, duration: 400.ms),
          const SizedBox(height: 16),
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
