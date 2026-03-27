import 'package:get/get.dart';
import 'package:global_vin/core/utils/app_settings.dart';
import 'package:global_vin/features/navigation/presentation/controllers/navigation_controller.dart';
import 'package:global_vin/features/navigation/presentation/pages/main_shell.dart';
import 'package:global_vin/features/onboarding/presentation/controllers/onboarding_controller.dart';
import 'package:global_vin/features/onboarding/presentation/pages/onboarding_page.dart';
import 'package:global_vin/features/profile/presentation/pages/edit_profile_page.dart';
import 'package:global_vin/features/splash/presentation/pages/splash_page.dart';
import 'package:global_vin/features/subscription/presentation/pages/subscription_page.dart';
import 'package:global_vin/features/vin_decoder/presentation/controllers/vin_controller.dart';
import 'package:global_vin/features/vin_decoder/presentation/pages/vin_result_page.dart';
import 'app_routes.dart';

class AppPages {
  AppPages._();

  static const initial = AppRoutes.splash;

  static final pages = <GetPage>[
    GetPage(
      name: AppRoutes.splash,
      page: () => const SplashPage(),
    ),
    GetPage(
      name: AppRoutes.onboarding,
      page: () => const OnboardingPage(),
      binding: BindingsBuilder(() {
        Get.lazyPut(() => OnboardingController(Get.find<AppSettings>()));
      }),
    ),
    GetPage(
      name: AppRoutes.home,
      page: () => const MainShell(),
      binding: BindingsBuilder(() {
        Get.put(NavigationController());
        Get.lazyPut(() => VinController(Get.find<AppSettings>()));
      }),
    ),
    GetPage(
      name: AppRoutes.vinResult,
      page: () => const VinResultPage(),
    ),
    GetPage(
      name: AppRoutes.subscription,
      page: () => const SubscriptionPage(),
    ),
    GetPage(
      name: AppRoutes.editProfile,
      page: () => const EditProfilePage(),
    ),
  ];
}
