import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:global_vin/core/utils/app_settings.dart';
import 'package:global_vin/core/utils/vin_validator.dart';
import 'package:global_vin/features/recent_searches/presentation/controllers/recent_search_controller.dart';
import 'package:global_vin/features/subscription/presentation/controllers/subscription_controller.dart';
import 'package:global_vin/routes/app_routes.dart';
import '../../data/mock/mock_vin_data.dart';
import '../../domain/entities/vin_entity.dart';

class VinController extends GetxController {
  final AppSettings _settings;

  VinController(this._settings);

  final TextEditingController vinTextController = TextEditingController();
  final RxBool isLoading = false.obs;
  final RxString errorMessage = ''.obs;
  final Rx<VinEntity?> currentResult = Rx<VinEntity?>(null);
  final RxString inputVin = ''.obs;

  @override
  void onInit() {
    super.onInit();
    vinTextController.addListener(() {
      inputVin.value = vinTextController.text.toUpperCase();
    });
  }

  @override
  void onClose() {
    vinTextController.dispose();
    super.onClose();
  }

  String? get vinValidationError => VinValidator.errorMessage(inputVin.value);
  bool get isVinValid => VinValidator.isValid(inputVin.value);

  Future<void> decodeVin(String vin) async {
    // Validate
    if (!VinValidator.isValid(vin)) {
      errorMessage.value = VinValidator.errorMessage(vin) ?? 'Invalid VIN';
      return;
    }

    // Check plan limit
    final subController = Get.find<SubscriptionController>();
    if (!subController.canDecode) {
      errorMessage.value =
          'Daily decode limit reached. Upgrade your plan for more decodes.';
      return;
    }

    errorMessage.value = '';
    isLoading.value = true;

    // Fake loading
    await Future.delayed(const Duration(milliseconds: 1500));

    // Get mock data
    currentResult.value = MockVinData.getByVin(vin);

    // Increment decode count
    await _settings.incrementDecodeCount();

    // Save to recent searches
    final recentController = Get.find<RecentSearchController>();
    await recentController.addSearch(currentResult.value!);
    await recentController.trimToLimit(subController.recentSearchLimit);

    isLoading.value = false;

    // Navigate to result
    Get.toNamed(AppRoutes.vinResult, arguments: currentResult.value);
  }

  void clearInput() {
    vinTextController.clear();
    inputVin.value = '';
    errorMessage.value = '';
  }
}
