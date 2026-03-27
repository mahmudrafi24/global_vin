import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:global_vin/core/constants/app_colors.dart';
import 'package:global_vin/core/constants/app_strings.dart';
import 'package:global_vin/core/constants/app_typography.dart';
import 'package:global_vin/core/widgets/core_screen_utils.dart';
import 'package:global_vin/core/widgets/gradient_button.dart';
import '../controllers/profile_controller.dart';

class EditProfilePage extends GetView<ProfileController> {
  const EditProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    final profile = controller.profile.value;
    final nameController = TextEditingController(text: profile.name);
    final emailController = TextEditingController(text: profile.email);
    final phoneController = TextEditingController(text: profile.phone);
    final countryController = TextEditingController(text: profile.country);

    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        backgroundColor: AppColors.background,
        title: Text(AppStrings.editProfile, style: AppTypography.heading3),
        leading: IconButton(
          onPressed: () => Get.back(),
          icon: const Icon(Icons.arrow_back_rounded),
        ),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(20.w),
        child: Column(
          children: [
            // Avatar
            GestureDetector(
              onTap: () {
                Get.snackbar(
                  'Photo',
                  'Image picker coming soon',
                  snackPosition: SnackPosition.BOTTOM,
                  backgroundColor: AppColors.surfaceLight,
                  colorText: AppColors.textPrimary,
                  margin: const EdgeInsets.all(16),
                );
              },
              child: Stack(
                children: [
                  Container(
                    width: 100.w,
                    height: 100.w,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      gradient: AppColors.primaryGradient,
                    ),
                    child: Center(
                      child: Text(
                        profile.initials,
                        style: AppTypography.heading1
                            .copyWith(fontSize: 32.sp, color: Colors.white),
                      ),
                    ),
                  ),
                  Positioned(
                    bottom: 0,
                    right: 0,
                    child: Container(
                      width: 32.w,
                      height: 32.w,
                      decoration: BoxDecoration(
                        color: AppColors.primary,
                        shape: BoxShape.circle,
                        border: Border.all(color: AppColors.background, width: 2),
                      ),
                      child: Icon(
                        Icons.camera_alt,
                        size: 16.w,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 8.h),
            Text(
              'Change Photo',
              style: AppTypography.bodySmall.copyWith(color: AppColors.primary),
            ),
            SizedBox(height: 32.h),

            // Form fields
            _FormField(
              label: 'Full Name',
              controller: nameController,
              icon: Icons.person_outline,
            ),
            SizedBox(height: 16.h),
            _FormField(
              label: 'Email',
              controller: emailController,
              icon: Icons.email_outlined,
              keyboardType: TextInputType.emailAddress,
            ),
            SizedBox(height: 16.h),
            _FormField(
              label: 'Phone Number',
              controller: phoneController,
              icon: Icons.phone_outlined,
              keyboardType: TextInputType.phone,
            ),
            SizedBox(height: 16.h),
            _FormField(
              label: 'Country',
              controller: countryController,
              icon: Icons.public,
              readOnly: true,
              onTap: () => _showCountryPicker(context, countryController),
            ),
            SizedBox(height: 40.h),

            // Save button
            GradientButton(
              text: AppStrings.saveChanges,
              onPressed: () async {
                final updated = profile.copyWith(
                  name: nameController.text.trim(),
                  email: emailController.text.trim(),
                  phone: phoneController.text.trim(),
                  country: countryController.text.trim(),
                );
                await controller.saveProfile(updated);
                Get.back();
                Get.snackbar(
                  'Success',
                  'Profile updated successfully',
                  snackPosition: SnackPosition.BOTTOM,
                  backgroundColor: AppColors.success.withOpacity(0.2),
                  colorText: AppColors.textPrimary,
                  margin: const EdgeInsets.all(16),
                );
              },
            ),
          ],
        ),
      ),
    );
  }

  void _showCountryPicker(
      BuildContext context, TextEditingController countryCtrl) {
    final countries = [
      'United States',
      'United Kingdom',
      'Canada',
      'Germany',
      'France',
      'Japan',
      'Australia',
      'India',
      'Bangladesh',
      'Brazil',
      'South Korea',
      'Italy',
      'Spain',
      'Netherlands',
      'Sweden',
    ];

    showModalBottomSheet(
      context: context,
      backgroundColor: AppColors.surface,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(24.r)),
      ),
      isScrollControlled: true,
      builder: (_) => DraggableScrollableSheet(
        initialChildSize: 0.6,
        maxChildSize: 0.8,
        minChildSize: 0.3,
        expand: false,
        builder: (_, scrollController) => Column(
          children: [
            Padding(
              padding: EdgeInsets.all(16.w),
              child: Column(
                children: [
                  Container(
                    width: 40.w,
                    height: 4.h,
                    decoration: BoxDecoration(
                      color: AppColors.divider,
                      borderRadius: BorderRadius.circular(2.r),
                    ),
                  ),
                  SizedBox(height: 16.h),
                  Text('Select Country', style: AppTypography.heading4),
                ],
              ),
            ),
            Expanded(
              child: ListView.builder(
                controller: scrollController,
                itemCount: countries.length,
                itemBuilder: (_, i) => ListTile(
                  title: Text(countries[i], style: AppTypography.body),
                  onTap: () {
                    countryCtrl.text = countries[i];
                    Navigator.pop(context);
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _FormField extends StatelessWidget {
  final String label;
  final TextEditingController controller;
  final IconData icon;
  final TextInputType? keyboardType;
  final bool readOnly;
  final VoidCallback? onTap;

  const _FormField({
    required this.label,
    required this.controller,
    required this.icon,
    this.keyboardType,
    this.readOnly = false,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label, style: AppTypography.label),
        SizedBox(height: 8.h),
        TextField(
          controller: controller,
          keyboardType: keyboardType,
          readOnly: readOnly,
          onTap: onTap,
          style: AppTypography.body.copyWith(color: AppColors.textPrimary),
          decoration: InputDecoration(
            prefixIcon: Icon(icon, size: 20.w, color: AppColors.textSecondary),
            suffixIcon: readOnly
                ? const Icon(Icons.arrow_drop_down,
                    color: AppColors.textSecondary)
                : null,
          ),
        ),
      ],
    );
  }
}
