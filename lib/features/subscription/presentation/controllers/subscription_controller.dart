import 'package:get/get.dart';
import 'package:global_vin/core/utils/app_settings.dart';
import '../../domain/entities/plan_entity.dart';

class SubscriptionController extends GetxController {
  final AppSettings _settings;

  SubscriptionController(this._settings);

  final Rx<PlanType> currentPlan = PlanType.basic.obs;
  final RxBool isYearly = false.obs;

  @override
  void onInit() {
    super.onInit();
    _loadPlan();
  }

  void _loadPlan() {
    final planStr = _settings.plan;
    currentPlan.value = PlanType.values.firstWhere(
      (p) => p.name == planStr,
      orElse: () => PlanType.basic,
    );
  }

  int get dailyDecodeLimit {
    switch (currentPlan.value) {
      case PlanType.basic:
        return 3;
      case PlanType.standard:
        return 20;
      case PlanType.premium:
        return 999;
    }
  }

  int get recentSearchLimit {
    switch (currentPlan.value) {
      case PlanType.basic:
        return 5;
      case PlanType.standard:
        return 20;
      case PlanType.premium:
        return 999;
    }
  }

  bool canAccessFeature(String feature) {
    switch (feature) {
      case 'safety':
        return currentPlan.value != PlanType.basic;
      case 'market_value':
        return currentPlan.value == PlanType.premium;
      case 'favorites':
        return currentPlan.value != PlanType.basic;
      case 'pdf':
        return currentPlan.value == PlanType.premium;
      default:
        return true;
    }
  }

  bool get canDecode {
    return _settings.todayDecodeCount < dailyDecodeLimit;
  }

  int get remainingDecodes {
    return dailyDecodeLimit - _settings.todayDecodeCount;
  }

  Future<void> upgradePlan(PlanType plan) async {
    currentPlan.value = plan;
    await _settings.setPlan(plan.name);
  }

  void toggleBilling() {
    isYearly.value = !isYearly.value;
  }
}
