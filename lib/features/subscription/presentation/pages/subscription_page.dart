import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:get/get.dart';
import 'package:global_vin/core/constants/app_colors.dart';
import 'package:global_vin/core/constants/app_strings.dart';
import 'package:global_vin/core/constants/app_typography.dart';
import 'package:global_vin/core/widgets/core_screen_utils.dart';
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
        padding: EdgeInsets.symmetric(horizontal: 20.w),
        child: Column(
          children: [
            // Header
            Text(AppStrings.choosePlan, style: AppTypography.heading1)
                .animate()
                .fadeIn(duration: 400.ms),
            SizedBox(height: 8.h),
            Text(
              AppStrings.unlockPower,
              style: AppTypography.body,
              textAlign: TextAlign.center,
            ).animate().fadeIn(delay: 100.ms, duration: 400.ms),
            SizedBox(height: 24.h),

            // Billing toggle
            Obx(
              () => Container(
                padding: EdgeInsets.all(4.w),
                decoration: BoxDecoration(
                  color: AppColors.surfaceLight,
                  borderRadius: BorderRadius.circular(12.r),
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
                          padding: EdgeInsets.symmetric(vertical: 10.h),
                          decoration: BoxDecoration(
                            color: !controller.isYearly.value
                                ? AppColors.primary
                                : Colors.transparent,
                            borderRadius: BorderRadius.circular(10.r),
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
                          padding: EdgeInsets.symmetric(vertical: 10.h),
                          decoration: BoxDecoration(
                            color: controller.isYearly.value
                                ? AppColors.primary
                                : Colors.transparent,
                            borderRadius: BorderRadius.circular(10.r),
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
                              SizedBox(width: 6.w),
                              Container(
                                padding: EdgeInsets.symmetric(
                                    horizontal: 6.w, vertical: 2.h),
                                decoration: BoxDecoration(
                                  color: AppColors.success,
                                  borderRadius: BorderRadius.circular(6.r),
                                ),
                                child: Text(
                                  'Save 30%',
                                  style: AppTypography.caption
                                      .copyWith(color: Colors.white, fontSize: 9.sp),
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

            SizedBox(height: 24.h),

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

            SizedBox(height: 20.h),

            // Bottom note
            Text(
              AppStrings.cancelAnytime,
              style: AppTypography.bodySmall,
            ),
            SizedBox(height: 32.h),
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
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(24.r)),
      ),
      builder: (_) => Padding(
        padding: EdgeInsets.all(24.w),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              width: 40.w,
              height: 4.h,
              decoration: BoxDecoration(
                color: AppColors.divider,
                borderRadius: BorderRadius.circular(2.r),
              ),
            ),
            SizedBox(height: 24.h),
            Text('Confirm Plan', style: AppTypography.heading3),
            SizedBox(height: 16.h),
            Container(
              padding: EdgeInsets.all(16.w),
              decoration: BoxDecoration(
                color: AppColors.surfaceLight,
                borderRadius: BorderRadius.circular(12.r),
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
            SizedBox(height: 24.h),
            SizedBox(
              width: double.infinity,
              height: 52.h,
              child: DecoratedBox(
                decoration: BoxDecoration(
                  gradient: AppColors.primaryGradient,
                  borderRadius: BorderRadius.circular(12.r),
                ),
                child: MaterialButton(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12.r),
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
            SizedBox(height: 16.h),
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
      margin: EdgeInsets.only(bottom: 16.h),
      padding: EdgeInsets.all(20.w),
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(16.r),
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
                    EdgeInsets.symmetric(horizontal: 10.w, vertical: 4.h),
                decoration: BoxDecoration(
                  color: plan.type == PlanType.premium
                      ? AppColors.gold.withOpacity(0.2)
                      : plan.type == PlanType.standard
                          ? AppColors.primary.withOpacity(0.2)
                          : AppColors.surfaceLight,
                  borderRadius: BorderRadius.circular(20.r),
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
          SizedBox(height: 4.h),
          Text(
            isYearly ? plan.yearlyPrice : plan.monthlyPrice,
            style: AppTypography.heading2.copyWith(color: AppColors.primary),
          ),
          if (isYearly && plan.type != PlanType.basic)
            Text('billed annually', style: AppTypography.caption),
          SizedBox(height: 16.h),
          // Features
          ...plan.features.map(
            (f) => Padding(
              padding: EdgeInsets.only(bottom: 8.h),
              child: Row(
                children: [
                  Icon(Icons.check_circle,
                      size: 16.w, color: AppColors.success),
                  SizedBox(width: 8.w),
                  Text(f, style: AppTypography.body),
                ],
              ),
            ),
          ),
          ...plan.disabledFeatures.map(
            (f) => Padding(
              padding: EdgeInsets.only(bottom: 8.h),
              child: Row(
                children: [
                  Icon(Icons.cancel,
                      size: 16.w, color: AppColors.textSecondary.withOpacity(0.5)),
                  SizedBox(width: 8.w),
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
          SizedBox(height: 16.h),
          // CTA
          SizedBox(
            width: double.infinity,
            height: 44.h,
            child: isCurrentPlan
                ? Container(
                    decoration: BoxDecoration(
                      color: AppColors.surfaceLight,
                      borderRadius: BorderRadius.circular(12.r),
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
                      borderRadius: BorderRadius.circular(12.r),
                    ),
                    child: MaterialButton(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12.r),
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
