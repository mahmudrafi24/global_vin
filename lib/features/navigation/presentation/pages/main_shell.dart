import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:global_vin/core/constants/app_colors.dart';
import 'package:global_vin/core/constants/app_typography.dart';
import 'package:global_vin/core/widgets/core_screen_utils.dart';
import 'package:global_vin/features/subscription/presentation/controllers/subscription_controller.dart';
import 'package:global_vin/features/subscription/domain/entities/plan_entity.dart';
import '../../../vin_decoder/presentation/pages/home_page.dart';
import '../../../recent_searches/presentation/pages/history_page.dart';
import '../../../subscription/presentation/pages/subscription_page.dart';
import '../../../profile/presentation/pages/profile_page.dart';
import '../controllers/navigation_controller.dart';

class MainShell extends GetView<NavigationController> {
  const MainShell({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Obx(
        () => IndexedStack(
          index: controller.currentIndex.value,
          children: const [
            HomePage(),
            HistoryPage(),
            _FavoritesPlaceholder(),
            ProfilePage(),
          ],
        ),
      ),
      bottomNavigationBar: Obx(
        () => Container(
          decoration: const BoxDecoration(
            color: AppColors.surface,
            border: Border(
              top: BorderSide(color: AppColors.divider, width: 0.5),
            ),
          ),
          child: SafeArea(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 8.h),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  _NavItem(
                    icon: Icons.search_rounded,
                    label: 'Decode',
                    isActive: controller.currentIndex.value == 0,
                    onTap: () => controller.changePage(0),
                  ),
                  _NavItem(
                    icon: Icons.history_rounded,
                    label: 'History',
                    isActive: controller.currentIndex.value == 1,
                    onTap: () => controller.changePage(1),
                  ),
                  _NavItem(
                    icon: Icons.star_rounded,
                    label: 'Favorites',
                    isActive: controller.currentIndex.value == 2,
                    onTap: () => _handleFavoritesTap(context),
                  ),
                  _NavItem(
                    icon: Icons.person_rounded,
                    label: 'Profile',
                    isActive: controller.currentIndex.value == 3,
                    onTap: () => controller.changePage(3),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  void _handleFavoritesTap(BuildContext context) {
    final subController = Get.find<SubscriptionController>();
    if (subController.currentPlan.value == PlanType.basic) {
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
              Icon(
                Icons.star_rounded,
                size: 48.w,
                color: AppColors.gold,
              ),
              SizedBox(height: 16.h),
              Text(
                'Upgrade to Standard',
                style: AppTypography.heading3,
              ),
              SizedBox(height: 8.h),
              Text(
                'Save your favorite vehicles and access them anytime with Standard or Premium plan.',
                style: AppTypography.body,
                textAlign: TextAlign.center,
              ),
              SizedBox(height: 24.h),
              SizedBox(
                width: double.infinity,
                height: 48.h,
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
                      Navigator.pop(context);
                      Get.to(() => const SubscriptionPage());
                    },
                    child: Text('View Plans', style: AppTypography.button),
                  ),
                ),
              ),
              SizedBox(height: 16.h),
            ],
          ),
        ),
      );
    } else {
      controller.changePage(2);
    }
  }
}

class _FavoritesPlaceholder extends StatelessWidget {
  const _FavoritesPlaceholder();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.star_border_rounded,
              size: 64.w,
              color: AppColors.textSecondary.withOpacity(0.5),
            ),
            SizedBox(height: 16.h),
            Text('No favorites yet', style: AppTypography.heading4),
            SizedBox(height: 8.h),
            Text(
              'Decode a VIN and save it to favorites',
              style: AppTypography.body,
            ),
          ],
        ),
      ),
    );
  }
}

class _NavItem extends StatelessWidget {
  final IconData icon;
  final String label;
  final bool isActive;
  final VoidCallback onTap;

  const _NavItem({
    required this.icon,
    required this.label,
    required this.isActive,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      behavior: HitTestBehavior.opaque,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        padding: EdgeInsets.symmetric(
          horizontal: isActive ? 16.w : 12.w,
          vertical: 8.h,
        ),
        decoration: BoxDecoration(
          color: isActive ? AppColors.primary.withOpacity(0.15) : Colors.transparent,
          borderRadius: BorderRadius.circular(20.r),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              icon,
              size: 22.w,
              color: isActive ? AppColors.primary : AppColors.textSecondary,
            ),
            if (isActive) ...[
              SizedBox(width: 6.w),
              Text(
                label,
                style: AppTypography.bodySmall.copyWith(
                  color: AppColors.primary,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }
}
