import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:get/get.dart';
import 'package:global_vin/core/constants/app_colors.dart';
import 'package:global_vin/core/constants/app_strings.dart';
import 'package:global_vin/core/constants/app_typography.dart';
import 'package:global_vin/core/widgets/glassmorphism_card.dart';
import 'package:global_vin/core/widgets/core_screen_utils.dart';
import 'package:global_vin/core/widgets/gradient_button.dart';
import 'package:global_vin/features/profile/presentation/controllers/profile_controller.dart';
import 'package:global_vin/features/recent_searches/presentation/widgets/recent_search_list.dart';
import 'package:global_vin/features/navigation/presentation/controllers/navigation_controller.dart';
import '../../../../core/widgets/common_image.dart';
import '../controllers/vin_controller.dart';

class HomePage extends GetView<VinController> {
  const HomePage({super.key});

  String _greeting() {
    final hour = DateTime.now().hour;
    if (hour < 12) return 'Good morning';
    if (hour < 17) return 'Good afternoon';
    return 'Good evening';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: EdgeInsets.symmetric(horizontal: 20.w),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 16.h),
              // App bar
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      Container(
                          width: 36.w,
                          height: 36.w,
                          padding: EdgeInsets.all(7.w),
                          decoration: BoxDecoration(
                            gradient: AppColors.primaryGradient,
                            borderRadius: BorderRadius.circular(10.r),
                          ),
                          child: const CommonImage(
                            src: "assets/images/GLOVIN logo.png",
                            size: 20,
                            imageColor: Colors.white,
                          )),
                      SizedBox(width: 10.w),
                      ShaderMask(
                        shaderCallback: (bounds) =>
                            AppColors.primaryGradient.createShader(bounds),
                        child: Text(
                          AppStrings.appName,
                          style: AppTypography.heading3
                              .copyWith(color: Colors.white),
                        ),
                      ),
                    ],
                  ),
                  IconButton(
                    onPressed: () {},
                    icon: const Icon(
                      Icons.notifications_outlined,
                      color: AppColors.textSecondary,
                    ),
                  ),
                ],
              ).animate().fadeIn(duration: 400.ms),

              SizedBox(height: 24.h),

              // Greeting
              Obx(() {
                final profile = Get.find<ProfileController>().profile.value;
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      '${_greeting()} 👋',
                      style: AppTypography.heading2,
                    ),
                    SizedBox(height: 4.h),
                    Text(
                      profile.name,
                      style: AppTypography.body.copyWith(fontSize: 16.sp),
                    ),
                  ],
                );
              }).animate().fadeIn(delay: 100.ms, duration: 400.ms),

              SizedBox(height: 28.h),

              // VIN Search Card
              _VinSearchCard(controller: controller)
                  .animate()
                  .fadeIn(delay: 200.ms, duration: 500.ms)
                  .slideY(begin: 0.1, end: 0),

              SizedBox(height: 28.h),

              // Recent Searches
              const _RecentSearchesSection()
                  .animate()
                  .fadeIn(delay: 300.ms, duration: 500.ms),

              SizedBox(height: 28.h),

              // Quick Stats
              const _QuickStatsRow()
                  .animate()
                  .fadeIn(delay: 400.ms, duration: 500.ms),

              SizedBox(height: 24.h),
            ],
          ),
        ),
      ),
    );
  }
}

class _VinSearchCard extends StatelessWidget {
  final VinController controller;

  const _VinSearchCard({required this.controller});

  @override
  Widget build(BuildContext context) {
    return GlassmorphismCard(
      borderColor: AppColors.primary.withValues(alpha: 0.2),
      padding: EdgeInsets.all(20.w),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(AppStrings.enterVin, style: AppTypography.heading4),
          SizedBox(height: 4.h),
          Text(
            'Enter a 17-character Vehicle Identification Number',
            style: AppTypography.bodySmall,
          ),
          SizedBox(height: 16.h),
          // VIN Input
          Obx(() {
            final vin = controller.inputVin.value;
            final error = controller.vinValidationError;
            final isValid = controller.isVinValid;

            Color borderColor = AppColors.divider;
            if (vin.isNotEmpty && isValid) {
              borderColor = AppColors.success;
            } else if (vin.isNotEmpty && error != null) {
              borderColor = AppColors.error;
            }

            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12.r),
                    boxShadow: vin.isNotEmpty
                        ? [
                            BoxShadow(
                              color: isValid
                                  ? AppColors.success.withValues(alpha: 0.2)
                                  : vin.isNotEmpty
                                      ? AppColors.primary.withValues(alpha: 0.2)
                                      : Colors.transparent,
                              blurRadius: 12,
                              spreadRadius: 0,
                            ),
                          ]
                        : null,
                  ),
                  child: TextField(
                    controller: controller.vinTextController,
                    style: AppTypography.vinInput,
                    textCapitalization: TextCapitalization.characters,
                    maxLength: 17,
                    inputFormatters: [
                      FilteringTextInputFormatter.allow(
                          RegExp(r'[A-HJ-NPR-Za-hj-npr-z0-9]')),
                      UpperCaseTextFormatter(),
                    ],
                    decoration: InputDecoration(
                      hintText: 'e.g. 1HGBH41JXMN109186',
                      hintStyle: AppTypography.vinSmall.copyWith(
                          color:
                              AppColors.textSecondary.withValues(alpha: 0.5)),
                      counterText: '',
                      filled: true,
                      fillColor: AppColors.surfaceLight,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12.r),
                        borderSide: BorderSide(color: borderColor),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12.r),
                        borderSide: BorderSide(color: borderColor),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12.r),
                        borderSide: BorderSide(color: borderColor, width: 1.5),
                      ),
                      suffixIcon: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          if (isValid)
                            Icon(Icons.check_circle,
                                color: AppColors.success, size: 20.w),
                          IconButton(
                            onPressed: () {
                              Get.snackbar(
                                'Camera Scan',
                                AppStrings.cameraScanComingSoon,
                                snackPosition: SnackPosition.BOTTOM,
                                backgroundColor: AppColors.surfaceLight,
                                colorText: AppColors.textPrimary,
                                margin: EdgeInsets.all(16.w),
                              );
                            },
                            icon: Icon(
                              Icons.camera_alt_outlined,
                              color: AppColors.textSecondary,
                              size: 20.w,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 8.h),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    if (error != null && vin.isNotEmpty)
                      Text(
                        error,
                        style: AppTypography.caption
                            .copyWith(color: AppColors.error),
                      )
                    else
                      const SizedBox(),
                    Text(
                      '${vin.length} / 17',
                      style: AppTypography.caption.copyWith(
                        color: isValid
                            ? AppColors.success
                            : AppColors.textSecondary,
                      ),
                    ),
                  ],
                ),
              ],
            );
          }),
          SizedBox(height: 16.h),
          // Decode button
          Obx(
            () => GradientButton(
              text: AppStrings.decodeVin,
              isLoading: controller.isLoading.value,
              onPressed: controller.isVinValid
                  ? () => controller.decodeVin(controller.inputVin.value)
                  : null,
            ),
          ),
          // Error message
          Obx(() {
            if (controller.errorMessage.value.isNotEmpty) {
              return Padding(
                padding: EdgeInsets.only(top: 12.h),
                child: Text(
                  controller.errorMessage.value,
                  style:
                      AppTypography.bodySmall.copyWith(color: AppColors.error),
                ),
              );
            }
            return const SizedBox.shrink();
          }),
        ],
      ),
    );
  }
}

class _RecentSearchesSection extends StatelessWidget {
  const _RecentSearchesSection();

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(AppStrings.recentSearches, style: AppTypography.heading4),
            GestureDetector(
              onTap: () {
                final navController = Get.find<NavigationController>();
                navController.changePage(1);
              },
              child: Text(
                AppStrings.seeAll,
                style:
                    AppTypography.bodySmall.copyWith(color: AppColors.primary),
              ),
            ),
          ],
        ),
        SizedBox(height: 12.h),
        const RecentSearchList(),
      ],
    );
  }
}

class _QuickStatsRow extends StatelessWidget {
  const _QuickStatsRow();

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        const _StatChip(
            icon: Icons.pin_outlined, label: AppStrings.stat17Chars),
        SizedBox(width: 8.w),
        const _StatChip(icon: Icons.public, label: AppStrings.statGlobalDb),
        SizedBox(width: 8.w),
        const _StatChip(icon: Icons.bolt, label: AppStrings.statInstant),
      ],
    );
  }
}

class _StatChip extends StatelessWidget {
  final IconData icon;
  final String label;

  const _StatChip({required this.icon, required this.label});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        padding: EdgeInsets.symmetric(vertical: 12.h, horizontal: 8.w),
        decoration: BoxDecoration(
          color: AppColors.surfaceLight,
          borderRadius: BorderRadius.circular(12.r),
          border: Border.all(color: AppColors.divider.withOpacity(0.5)),
        ),
        child: Column(
          children: [
            Icon(icon, size: 20.w, color: AppColors.primary),
            SizedBox(height: 6.h),
            Text(
              label,
              style: AppTypography.caption.copyWith(
                color: AppColors.textSecondary,
              ),
              textAlign: TextAlign.center,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
          ],
        ),
      ),
    );
  }
}

class UpperCaseTextFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
    TextEditingValue oldValue,
    TextEditingValue newValue,
  ) {
    return TextEditingValue(
      text: newValue.text.toUpperCase(),
      selection: newValue.selection,
    );
  }
}
