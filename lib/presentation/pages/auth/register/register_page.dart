import 'package:flutter/material.dart';
import 'package:core_kit/core_kit.dart';
import 'package:get/get.dart';
import 'package:global_vin/presentation/controllers/auth_controller.dart';
import 'package:global_vin/presentation/pages/auth/register/register_binding.dart';
import 'package:global_vin/routes/app_routes.dart';

class RegisterPage extends StatelessWidget {
  const RegisterPage({super.key});

  @override
  Widget build(BuildContext context) {
    RegisterBinding().dependencies();
    final controller = Get.find<AuthController>();

    return Scaffold(
      appBar: CommonAppBar(title: 'Register'),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: EdgeInsets.all(24.w),
          child: Form(
            key: controller.registerFormKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                20.height,
                CommonText(
                  text: 'Create Account',
                  fontSize: 28.sp,
                  fontWeight: FontWeight.bold,
                ),
                8.height,
                CommonText(
                  text: 'Fill in your details to get started',
                  fontSize: 14.sp,
                ),
                32.height,
                CommonTextField(
                  controller: controller.registerNameController,
                  labelText: 'Full Name',
                  hintText: 'Enter your full name',
                  validationType: ValidationType.validateRequired,
                  prefixIcon: const Icon(Icons.person_outlined),
                ),
                16.height,
                CommonTextField(
                  controller: controller.registerEmailController,
                  labelText: 'Email',
                  hintText: 'Enter your email',
                  validationType: ValidationType.validateEmail,
                  prefixIcon: const Icon(Icons.email_outlined),
                ),
                16.height,
                CommonTextField(
                  controller: controller.registerPasswordController,
                  labelText: 'Password',
                  hintText: 'Enter your password',
                  validationType: ValidationType.validatePassword,
                  //isPassword: true,
                  prefixIcon: const Icon(Icons.lock_outlined),
                ),
                16.height,
                CommonTextField(
                  controller: controller.registerConfirmPasswordController,
                  labelText: 'Confirm Password',
                  hintText: 'Confirm your password',
                  validationType: ValidationType.validateConfirmPassword,
                  prefixIcon: const Icon(Icons.lock_outlined),
                ),
                24.height,
                Obx(() => CommonButton(
                      titleText: 'Register',
                      onTap: () => controller.register(),
                      isLoading: controller.isLoading.value,
                    )),
                16.height,
                Obx(() {
                  if (controller.errorMessage.value.isNotEmpty) {
                    return Padding(
                      padding: EdgeInsets.only(bottom: 16.h),
                      child: CommonText(
                        text: controller.errorMessage.value,
                        fontSize: 12.sp,
                        textColor: Colors.red,
                        textAlign: TextAlign.center,
                      ),
                    );
                  }
                  return const SizedBox.shrink();
                }),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    CommonText(
                        text: 'Already have an account? ', fontSize: 14.sp),
                    TextButton(
                      onPressed: () => Get.toNamed(AppRoutes.login),
                      child: const Text('Login'),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
