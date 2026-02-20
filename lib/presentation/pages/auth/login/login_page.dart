import 'package:flutter/material.dart';
import 'package:core_kit/core_kit.dart';
import 'package:get/get.dart';
import 'package:global_vin/presentation/controllers/auth_controller.dart';
import 'package:global_vin/routes/app_routes.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<AuthController>();

    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          padding: EdgeInsets.all(24.w),
          child: Form(
            key: controller.loginFormKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                60.height,
                CommonText(
                  'Welcome Back',
                  fontSize: 28.sp,
                  fontWeight: FontWeight.bold,
                ),
                8.height,
                CommonText(
                  'Sign in to continue',
                  fontSize: 14.sp,
                ),
                40.height,
                CommonTextField(
                  controller: controller.loginEmailController,
                  labelText: 'Email',
                  hintText: 'Enter your email',
                  validationType: ValidationType.validateEmail,
                  prefixIcon: const Icon(Icons.email_outlined),
                ),
                16.height,
                CommonTextField(
                  controller: controller.loginPasswordController,
                  labelText: 'Password',
                  hintText: 'Enter your password',
                  validationType: ValidationType.validatePassword,
                  isPassword: true,
                  prefixIcon: const Icon(Icons.lock_outlined),
                ),
                24.height,
                Obx(() => CommonButton(
                      titleText: 'Login',
                      onTap: () => controller.login(),
                      isLoading: controller.isLoading.value,
                    )),
                16.height,
                Obx(() {
                  if (controller.errorMessage.value.isNotEmpty) {
                    return Padding(
                      padding: EdgeInsets.only(bottom: 16.h),
                      child: CommonText(
                        controller.errorMessage.value,
                        fontSize: 12.sp,
                        color: Colors.red,
                        textAlign: TextAlign.center,
                      ),
                    );
                  }
                  return const SizedBox.shrink();
                }),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    CommonText("Don't have an account? ", fontSize: 14.sp),
                    TextButton(
                      onPressed: () => Get.toNamed(AppRoutes.register),
                      child: const Text('Register'),
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
