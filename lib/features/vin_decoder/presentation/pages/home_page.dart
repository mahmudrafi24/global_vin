import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:get/get.dart';
import 'package:global_vin/core/constants/app_colors.dart';
import 'package:global_vin/core/constants/app_strings.dart';
import 'package:global_vin/core/constants/app_typography.dart';
import 'package:global_vin/core/widgets/glassmorphism_card.dart';
import 'package:global_vin/core/widgets/gradient_button.dart';
import 'package:global_vin/features/profile/presentation/controllers/profile_controller.dart';
import 'package:global_vin/features/recent_searches/presentation/widgets/recent_search_list.dart';
import 'package:global_vin/features/navigation/presentation/controllers/navigation_controller.dart';
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
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 16),
              // App bar
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      Container(
                        width: 36,
                        height: 36,
                        decoration: BoxDecoration(
                          gradient: AppColors.primaryGradient,
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: const Icon(
                          Icons.directions_car_rounded,
                          color: Colors.white,
                          size: 20,
                        ),
                      ),
                      const SizedBox(width: 10),
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

              const SizedBox(height: 24),

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
                    const SizedBox(height: 4),
                    Text(
                      profile.name,
                      style: AppTypography.body.copyWith(fontSize: 16),
                    ),
                  ],
                );
              }).animate().fadeIn(delay: 100.ms, duration: 400.ms),

              const SizedBox(height: 28),

              // VIN Search Card
              _VinSearchCard(controller: controller)
                  .animate()
                  .fadeIn(delay: 200.ms, duration: 500.ms)
                  .slideY(begin: 0.1, end: 0),

              const SizedBox(height: 28),

              // Recent Searches
              const _RecentSearchesSection()
                  .animate()
                  .fadeIn(delay: 300.ms, duration: 500.ms),

              const SizedBox(height: 28),

              // Quick Stats
              const _QuickStatsRow()
                  .animate()
                  .fadeIn(delay: 400.ms, duration: 500.ms),

              const SizedBox(height: 24),
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
      borderColor: AppColors.primary.withOpacity(0.2),
      padding: const EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(AppStrings.enterVin, style: AppTypography.heading4),
          const SizedBox(height: 4),
          Text(
            'Enter a 17-character Vehicle Identification Number',
            style: AppTypography.bodySmall,
          ),
          const SizedBox(height: 16),
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
                    borderRadius: BorderRadius.circular(12),
                    boxShadow: vin.isNotEmpty
                        ? [
                            BoxShadow(
                              color: isValid
                                  ? AppColors.success.withOpacity(0.2)
                                  : vin.length > 0
                                      ? AppColors.primary.withOpacity(0.2)
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
                      hintStyle: AppTypography.vinSmall
                          .copyWith(color: AppColors.textSecondary.withOpacity(0.5)),
                      counterText: '',
                      filled: true,
                      fillColor: AppColors.surfaceLight,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                        borderSide: BorderSide(color: borderColor),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                        borderSide: BorderSide(color: borderColor),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                        borderSide:
                            BorderSide(color: borderColor, width: 1.5),
                      ),
                      suffixIcon: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          if (isValid)
                            const Icon(Icons.check_circle,
                                color: AppColors.success, size: 20),
                          IconButton(
                            onPressed: () {
                              Get.snackbar(
                                'Camera Scan',
                                AppStrings.cameraScanComingSoon,
                                snackPosition: SnackPosition.BOTTOM,
                                backgroundColor: AppColors.surfaceLight,
                                colorText: AppColors.textPrimary,
                                margin: const EdgeInsets.all(16),
                              );
                            },
                            icon: const Icon(
                              Icons.camera_alt_outlined,
                              color: AppColors.textSecondary,
                              size: 20,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 8),
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
                        color: isValid ? AppColors.success : AppColors.textSecondary,
                      ),
                    ),
                  ],
                ),
              ],
            );
          }),
          const SizedBox(height: 16),
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
                padding: const EdgeInsets.only(top: 12),
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
                style: AppTypography.bodySmall
                    .copyWith(color: AppColors.primary),
              ),
            ),
          ],
        ),
        const SizedBox(height: 12),
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
        _StatChip(icon: Icons.pin_outlined, label: AppStrings.stat17Chars),
        const SizedBox(width: 8),
        _StatChip(icon: Icons.public, label: AppStrings.statGlobalDb),
        const SizedBox(width: 8),
        _StatChip(icon: Icons.bolt, label: AppStrings.statInstant),
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
        padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 8),
        decoration: BoxDecoration(
          color: AppColors.surfaceLight,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: AppColors.divider.withOpacity(0.5)),
        ),
        child: Column(
          children: [
            Icon(icon, size: 20, color: AppColors.primary),
            const SizedBox(height: 6),
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
