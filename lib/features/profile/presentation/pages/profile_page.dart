import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:get/get.dart';
import 'package:global_vin/core/constants/app_colors.dart';
import 'package:global_vin/core/constants/app_strings.dart';
import 'package:global_vin/core/constants/app_typography.dart';
import 'package:global_vin/core/utils/app_settings.dart';
import 'package:global_vin/features/subscription/presentation/controllers/subscription_controller.dart';
import 'package:global_vin/features/subscription/domain/entities/plan_entity.dart';
import 'package:global_vin/core/widgets/core_screen_utils.dart';
import 'package:global_vin/routes/app_routes.dart';
import '../controllers/profile_controller.dart';

class ProfilePage extends GetView<ProfileController> {
  const ProfilePage({super.key});

  Color _planColor(PlanType plan) {
    switch (plan) {
      case PlanType.basic:
        return AppColors.textSecondary;
      case PlanType.standard:
        return AppColors.silver;
      case PlanType.premium:
        return AppColors.gold;
    }
  }

  @override
  Widget build(BuildContext context) {
    final subController = Get.find<SubscriptionController>();

    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: EdgeInsets.symmetric(horizontal: 20.w),
          child: Column(
            children: [
              SizedBox(height: 24.h),
              // Profile Header
              Obx(() {
                final profile = controller.profile.value;
                final plan = subController.currentPlan.value;
                return Column(
                  children: [
                    // Avatar
                    Container(
                      width: 80.w,
                      height: 80.w,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        gradient: AppColors.primaryGradient,
                      ),
                      child: Center(
                        child: Text(
                          profile.initials,
                          style: AppTypography.heading1
                              .copyWith(fontSize: 28.sp, color: Colors.white),
                        ),
                      ),
                    ),
                    SizedBox(height: 16.h),
                    Text(profile.name, style: AppTypography.heading2),
                    SizedBox(height: 4.h),
                    Text(profile.email, style: AppTypography.body),
                    SizedBox(height: 12.h),
                    // Plan badge
                    Container(
                      padding: EdgeInsets.symmetric(
                          horizontal: 14.w, vertical: 6.h),
                      decoration: BoxDecoration(
                        color: _planColor(plan).withOpacity(0.15),
                        borderRadius: BorderRadius.circular(20.r),
                        border: Border.all(
                            color: _planColor(plan).withOpacity(0.4)),
                      ),
                      child: Text(
                        '${plan.name.toUpperCase()} PLAN',
                        style: AppTypography.caption.copyWith(
                          color: _planColor(plan),
                          fontWeight: FontWeight.w600,
                          letterSpacing: 1,
                        ),
                      ),
                    ),
                    SizedBox(height: 16.h),
                    // Edit Profile button
                    OutlinedButton(
                      onPressed: () => Get.toNamed(AppRoutes.editProfile),
                      style: OutlinedButton.styleFrom(
                        side: const BorderSide(color: AppColors.divider),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12.r),
                        ),
                        padding: EdgeInsets.symmetric(
                            horizontal: 24.w, vertical: 10.h),
                      ),
                      child: Text(
                        AppStrings.editProfile,
                        style: AppTypography.bodyBold,
                      ),
                    ),
                  ],
                );
              }).animate().fadeIn(duration: 400.ms),

              SizedBox(height: 32.h),

              // Settings sections
              _SettingsSection(
                title: 'Account',
                items: [
                  _SettingItem(
                    icon: Icons.person_outline,
                    title: 'Edit Profile',
                    onTap: () => Get.toNamed(AppRoutes.editProfile),
                  ),
                  _SettingItem(
                    icon: Icons.lock_outline,
                    title: 'Change Password',
                    onTap: () => _showComingSoon(),
                  ),
                  _NotificationSettingItem(),
                ],
              ).animate().fadeIn(delay: 100.ms, duration: 400.ms),

              _SettingsSection(
                title: 'Preferences',
                items: [
                  _SettingItem(
                    icon: Icons.straighten,
                    title: 'Unit System',
                    subtitle: 'Metric',
                    onTap: () => _showUnitPicker(context),
                  ),
                  _SettingItem(
                    icon: Icons.language,
                    title: 'Language',
                    subtitle: 'English',
                    onTap: () => _showLanguagePicker(context),
                  ),
                ],
              ).animate().fadeIn(delay: 200.ms, duration: 400.ms),

              _SettingsSection(
                title: 'Subscription',
                items: [
                  _SettingItem(
                    icon: Icons.workspace_premium,
                    title: 'Current Plan',
                    trailing: Obx(() => Text(
                          subController.currentPlan.value.name.capitalizeFirst!,
                          style: AppTypography.bodySmall
                              .copyWith(color: AppColors.primary),
                        )),
                    onTap: () => Get.toNamed(AppRoutes.subscription),
                  ),
                  _SettingItem(
                    icon: Icons.receipt_long,
                    title: 'Billing History',
                    onTap: () => _showComingSoon(),
                  ),
                ],
              ).animate().fadeIn(delay: 300.ms, duration: 400.ms),

              _SettingsSection(
                title: 'About',
                items: [
                  _SettingItem(
                    icon: Icons.info_outline,
                    title: 'App Version',
                    trailing: Text(AppStrings.appVersion,
                        style: AppTypography.bodySmall),
                  ),
                  _SettingItem(
                    icon: Icons.privacy_tip_outlined,
                    title: 'Privacy Policy',
                    onTap: () => _showComingSoon(msg: 'Opening...'),
                  ),
                  _SettingItem(
                    icon: Icons.description_outlined,
                    title: 'Terms of Service',
                    onTap: () => _showComingSoon(msg: 'Opening...'),
                  ),
                  _SettingItem(
                    icon: Icons.star_outline,
                    title: 'Rate the App',
                    onTap: () => _showComingSoon(msg: 'Opening store...'),
                  ),
                  _SettingItem(
                    icon: Icons.support_agent,
                    title: 'Contact Support',
                    onTap: () =>
                        _showComingSoon(msg: 'support@vindecode.com'),
                  ),
                ],
              ).animate().fadeIn(delay: 400.ms, duration: 400.ms),

              _SettingsSection(
                title: 'Danger Zone',
                items: [
                  _SettingItem(
                    icon: Icons.logout_rounded,
                    title: 'Sign Out',
                    titleColor: AppColors.error,
                    onTap: () => _showSignOutDialog(context),
                  ),
                  _SettingItem(
                    icon: Icons.delete_forever_rounded,
                    title: 'Delete Account',
                    titleColor: AppColors.error,
                    onTap: () => _showComingSoon(),
                  ),
                ],
              ).animate().fadeIn(delay: 500.ms, duration: 400.ms),

              SizedBox(height: 40.h),
            ],
          ),
        ),
      ),
    );
  }

  void _showComingSoon({String msg = AppStrings.comingSoon}) {
    Get.snackbar(
      'Info',
      msg,
      snackPosition: SnackPosition.BOTTOM,
      backgroundColor: AppColors.surfaceLight,
      colorText: AppColors.textPrimary,
      margin: EdgeInsets.all(16.w),
    );
  }

  void _showUnitPicker(BuildContext context) {
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
            Text('Unit System', style: AppTypography.heading4),
            SizedBox(height: 16.h),
            ListTile(
              title: Text('Metric', style: AppTypography.body),
              leading: const Icon(Icons.check, color: AppColors.primary),
              onTap: () {
                Get.find<AppSettings>().setUnitSystem('metric');
                Navigator.pop(context);
              },
            ),
            ListTile(
              title: Text('Imperial', style: AppTypography.body),
              onTap: () {
                Get.find<AppSettings>().setUnitSystem('imperial');
                Navigator.pop(context);
              },
            ),
          ],
        ),
      ),
    );
  }

  void _showLanguagePicker(BuildContext context) {
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
            Text('Language', style: AppTypography.heading4),
            SizedBox(height: 16.h),
            for (final lang in ['English', 'Arabic', 'French'])
              ListTile(
                title: Text(lang, style: AppTypography.body),
                leading: lang == 'English'
                    ? const Icon(Icons.check, color: AppColors.primary)
                    : SizedBox(width: 24.w),
                onTap: () {
                  Get.find<AppSettings>().setLanguage(
                    lang == 'English'
                        ? 'en'
                        : lang == 'Arabic'
                            ? 'ar'
                            : 'fr',
                  );
                  Navigator.pop(context);
                },
              ),
          ],
        ),
      ),
    );
  }

  void _showSignOutDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        backgroundColor: AppColors.surface,
        title: Text('Sign Out', style: AppTypography.heading4),
        content: Text(
          'Are you sure you want to sign out?',
          style: AppTypography.body,
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(ctx),
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: () async {
              Navigator.pop(ctx);
              await Get.find<AppSettings>().clearAll();
              Get.offAllNamed(AppRoutes.splash);
            },
            child: const Text('Sign Out',
                style: TextStyle(color: AppColors.error)),
          ),
        ],
      ),
    );
  }
}

class _NotificationSettingItem extends StatefulWidget {
  @override
  State<_NotificationSettingItem> createState() =>
      _NotificationSettingItemState();
}

class _NotificationSettingItemState extends State<_NotificationSettingItem> {
  late bool _enabled;

  @override
  void initState() {
    super.initState();
    _enabled = Get.find<AppSettings>().notifications;
  }

  @override
  Widget build(BuildContext context) {
    return _SettingItem(
      icon: Icons.notifications_outlined,
      title: 'Notifications',
      trailing: Switch(
        value: _enabled,
        onChanged: (v) {
          Get.find<AppSettings>().setNotifications(v);
          setState(() => _enabled = v);
        },
        activeTrackColor: AppColors.primary,
      ),
    );
  }
}

class _SettingsSection extends StatelessWidget {
  final String title;
  final List<Widget> items;

  const _SettingsSection({required this.title, required this.items});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title.toUpperCase(),
          style: AppTypography.label.copyWith(letterSpacing: 1.5),
        ),
        SizedBox(height: 8.h),
        Container(
          decoration: BoxDecoration(
            color: AppColors.surface,
            borderRadius: BorderRadius.circular(16.r),
            border: Border.all(color: AppColors.divider.withOpacity(0.5)),
          ),
          child: Column(children: items),
        ),
        SizedBox(height: 20.h),
      ],
    );
  }
}

class _SettingItem extends StatelessWidget {
  final IconData icon;
  final String title;
  final String? subtitle;
  final Color? titleColor;
  final Widget? trailing;
  final VoidCallback? onTap;

  const _SettingItem({
    required this.icon,
    required this.title,
    this.subtitle,
    this.titleColor,
    this.trailing,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(16.r),
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 14.h),
        child: Row(
          children: [
            Icon(icon, size: 20.w, color: titleColor ?? AppColors.textSecondary),
            SizedBox(width: 14.w),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: AppTypography.body.copyWith(
                      color: titleColor ?? AppColors.textPrimary,
                    ),
                  ),
                  if (subtitle != null) ...[
                    SizedBox(height: 2.h),
                    Text(subtitle!, style: AppTypography.caption),
                  ],
                ],
              ),
            ),
            if (trailing != null) trailing!,
            if (onTap != null && trailing == null)
              Icon(Icons.chevron_right_rounded,
                  size: 20.w, color: AppColors.textSecondary),
          ],
        ),
      ),
    );
  }
}
