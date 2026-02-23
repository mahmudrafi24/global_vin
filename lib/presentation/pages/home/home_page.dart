import 'package:flutter/material.dart';
import 'package:core_kit/core_kit.dart';
import 'package:get/get.dart';
import 'package:global_vin/core/constants/app_constants.dart';
import 'package:global_vin/presentation/pages/home/home_binding.dart';
import 'package:global_vin/presentation/pages/home/home_controller.dart';
import 'package:global_vin/routes/app_routes.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    HomeBinding().dependencies();
    // ignore: unused_local_variable
    final controller = Get.find<HomeController>();

    return Scaffold(
      appBar: CommonAppBar(
        title: AppConstants.appName,
        actions: [
          IconButton(
            icon: const Icon(Icons.logout),
            onPressed: () => Get.toNamed(AppRoutes.login),
          ),
        ],
      ),
      body: Center(
        child: CommonText(
          text: 'Welcome to ${AppConstants.appName}!',
          fontSize: 24.sp,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }
}
