import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:get/get.dart';
import 'package:global_vin/core/constants/app_colors.dart';
import 'package:global_vin/core/constants/app_strings.dart';
import 'package:global_vin/core/constants/app_typography.dart';
import '../../domain/entities/plan_entity.dart';
import '../controllers/subscription_controller.dart';

class SubscriptionPage extends GetView<SubscriptionController> {
  const SubscriptionPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        backgroundColor: AppColors.background,
        leading: IconButton(
          onPressed: () => Get.back(),
          icon: const Icon(Icons.arrow_back_rounded),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          children: [
            // Header
            Text(AppStrings.choosePlan, style: AppTypography.heading1)
                .animate()
                .fadeIn(duration: 400.ms),
            const SizedBox(height: 8),
            Text(
              AppStrings.unlockPower,
              style: AppTypography.body,
              textAlign: TextAlign.center,
            ).animate().fadeIn(delay: 100.ms, duration: 400.ms),
            const SizedBox(height: 24),

            // Billing toggle
            Obx(
              () => Container(
                padding: const EdgeInsets.all(4),
                decoration: BoxDecoration(
                  color: AppColors.surfaceLight,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Row(
                  children: [
                    Expanded(
                      child: GestureDetector(
                        onTap: () {
                          if (controller.isYearly.value) {
                            controller.toggleBilling();
                          }
                        },
                        child: Container(
                          padding: const EdgeInsets.symmetric(vertical: 10),
                          decoration: BoxDecoration(
                            color: !controller.isYearly.value
                                ? AppColors.primary
                                : Colors.transparent,
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Text(
                            'Monthly',
                            textAlign: TextAlign.center,
                            style: AppTypography.bodyBold.copyWith(
                              color: !controller.isYearly.value
                                  ? Colors.white
                                  : AppColors.textSecondary,
                            ),
                          ),
                        ),
                      ),
                    ),
                    Expanded(
                      child: GestureDetector(
                        onTap: () {
                          if (!controller.isYearly.value) {
                            controller.toggleBilling();
                          }
                        },
                        child: Container(
                          padding: const EdgeInsets.symmetric(vertical: 10),
                          decoration: BoxDecoration(
                            color: controller.isYearly.value
                                ? AppColors.primary
                                : Colors.transparent,
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                'Yearly',
                                style: AppTypography.bodyBold.copyWith(
                                  color: controller.isYearly.value
                                      ? Colors.white
                                      : AppColors.textSecondary,
                                ),
                              ),
                              const SizedBox(width: 6),
                              Container(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 6, vertical: 2),
                                decoration: BoxDecoration(
                                  color: AppColors.success,
                                  borderRadius: BorderRadius.circular(6),
                                ),
                                child: Text(
                                  'Save 30%',
                                  style: AppTypography.caption
                                      .copyWith(color: Colors.white, fontSize: 9),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ).animate().fadeIn(delay: 200.ms, duration: 400.ms),

            const SizedBox(height: 24),

            // Plan cards
            ...PlanEntity.plans.asMap().entries.map(
                  (entry) => Obx(
                    () => _PlanCard(
                      plan: entry.value,
                      isCurrentPlan:
                          controller.currentPlan.value == entry.value.type,
                      isYearly: controller.isYearly.value,
                      onSelect: () => _showConfirmSheet(context, entry.value),
                    ),
                  )
                      .animate()
                      .fadeIn(
                        delay: Duration(milliseconds: 300 + entry.key * 100),
                        duration: 400.ms,
                      )
                      .slideY(begin: 0.1, end: 0),
                ),

            const SizedBox(height: 20),

            // Bottom note
            Text(
              AppStrings.cancelAnytime,
              style: AppTypography.bodySmall,
            ),
            const SizedBox(height: 32),
          ],
        ),
      ),
    );
  }

  void _showConfirmSheet(BuildContext context, PlanEntity plan) {
    if (controller.currentPlan.value == plan.type) return;

    showModalBottomSheet(
      context: context,
      backgroundColor: AppColors.surface,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
      ),
      builder: (_) => Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              width: 40,
              height: 4,
              decoration: BoxDecoration(
                color: AppColors.divider,
                borderRadius: BorderRadius.circular(2),
              ),
            ),
            const SizedBox(height: 24),
            Text('Confirm Plan', style: AppTypography.heading3),
            const SizedBox(height: 16),
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: AppColors.surfaceLight,
                borderRadius: BorderRadius.circular(12),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('${plan.name} Plan', style: AppTypography.bodyBold),
                      Text(
                        controller.isYearly.value
                            ? '${plan.yearlyPrice} billed annually'
                            : plan.monthlyPrice,
                        style: AppTypography.body,
                      ),
                    ],
                  ),
                  if (plan.type != PlanType.basic)
                    Text(
                      '7-day free trial',
                      style: AppTypography.bodySmall
                          .copyWith(color: AppColors.success),
                    ),
                ],
              ),
            ),
            const SizedBox(height: 24),
            SizedBox(
              width: double.infinity,
              height: 52,
              child: DecoratedBox(
                decoration: BoxDecoration(
                  gradient: AppColors.primaryGradient,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: MaterialButton(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  onPressed: () {
                    controller.upgradePlan(plan.type);
                    Navigator.pop(context);
                    Get.snackbar(
                      'Success!',
                      'You are now on the ${plan.name} plan',
                      snackPosition: SnackPosition.BOTTOM,
                      backgroundColor: AppColors.success.withOpacity(0.2),
                      colorText: AppColors.textPrimary,
                      margin: const EdgeInsets.all(16),
                    );
                  },
                  child: Text('Confirm', style: AppTypography.button),
                ),
              ),
            ),
            const SizedBox(height: 16),
          ],
        ),
      ),
    );
  }
}

class _PlanCard extends StatelessWidget {
  final PlanEntity plan;
  final bool isCurrentPlan;
  final bool isYearly;
  final VoidCallback onSelect;

  const _PlanCard({
    required this.plan,
    required this.isCurrentPlan,
    required this.isYearly,
    required this.onSelect,
  });

  Color get _borderColor {
    if (isCurrentPlan) return AppColors.primary;
    if (plan.type == PlanType.standard) return AppColors.primary.withOpacity(0.5);
    if (plan.type == PlanType.premium) return AppColors.gold.withOpacity(0.5);
    return AppColors.divider;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      margin: const EdgeInsets.only(bottom: 16),
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: _borderColor, width: isCurrentPlan ? 2 : 1),
        boxShadow: isCurrentPlan
            ? [
                BoxShadow(
                  color: AppColors.primary.withOpacity(0.15),
                  blurRadius: 20,
                  spreadRadius: 0,
                ),
              ]
            : null,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(plan.name, style: AppTypography.heading3),
              Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                decoration: BoxDecoration(
                  color: plan.type == PlanType.premium
                      ? AppColors.gold.withOpacity(0.2)
                      : plan.type == PlanType.standard
                          ? AppColors.primary.withOpacity(0.2)
                          : AppColors.surfaceLight,
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Text(
                  plan.badge,
                  style: AppTypography.caption.copyWith(
                    color: plan.type == PlanType.premium
                        ? AppColors.gold
                        : plan.type == PlanType.standard
                            ? AppColors.primary
                            : AppColors.textSecondary,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 4),
          Text(
            isYearly ? plan.yearlyPrice : plan.monthlyPrice,
            style: AppTypography.heading2.copyWith(color: AppColors.primary),
          ),
          if (isYearly && plan.type != PlanType.basic)
            Text('billed annually', style: AppTypography.caption),
          const SizedBox(height: 16),
          // Features
          ...plan.features.map(
            (f) => Padding(
              padding: const EdgeInsets.only(bottom: 8),
              child: Row(
                children: [
                  const Icon(Icons.check_circle,
                      size: 16, color: AppColors.success),
                  const SizedBox(width: 8),
                  Text(f, style: AppTypography.body),
                ],
              ),
            ),
          ),
          ...plan.disabledFeatures.map(
            (f) => Padding(
              padding: const EdgeInsets.only(bottom: 8),
              child: Row(
                children: [
                  Icon(Icons.cancel,
                      size: 16, color: AppColors.textSecondary.withOpacity(0.5)),
                  const SizedBox(width: 8),
                  Text(
                    f,
                    style: AppTypography.body.copyWith(
                      color: AppColors.textSecondary.withOpacity(0.5),
                    ),
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 16),
          // CTA
          SizedBox(
            width: double.infinity,
            height: 44,
            child: isCurrentPlan
                ? Container(
                    decoration: BoxDecoration(
                      color: AppColors.surfaceLight,
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Center(
                      child: Text(
                        AppStrings.currentPlan,
                        style: AppTypography.bodyBold
                            .copyWith(color: AppColors.textSecondary),
                      ),
                    ),
                  )
                : DecoratedBox(
                    decoration: BoxDecoration(
                      gradient: plan.type == PlanType.premium
                          ? AppColors.goldGradient
                          : AppColors.primaryGradient,
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: MaterialButton(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      onPressed: onSelect,
                      child: Text(
                        plan.type == PlanType.basic
                            ? AppStrings.getStarted
                            : AppStrings.startFreeTrial,
                        style: AppTypography.bodyBold.copyWith(
                          color: plan.type == PlanType.premium
                              ? Colors.black
                              : Colors.white,
                        ),
                      ),
                    ),
                  ),
          ),
        ],
      ),
    );
  }
}
