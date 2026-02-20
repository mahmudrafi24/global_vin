import 'package:get/get.dart';
import 'package:global_vin/routes/app_routes.dart';
import 'package:global_vin/presentation/pages/splash/splash_page.dart';
import 'package:global_vin/presentation/pages/splash/splash_binding.dart';
import 'package:global_vin/presentation/pages/auth/login/login_page.dart';
import 'package:global_vin/presentation/pages/auth/login/login_binding.dart';
import 'package:global_vin/presentation/pages/auth/register/register_page.dart';
import 'package:global_vin/presentation/pages/auth/register/register_binding.dart';
import 'package:global_vin/presentation/pages/home/home_page.dart';
import 'package:global_vin/presentation/pages/home/home_binding.dart';

class AppPages {
  static const String initial = AppRoutes.splash;

  static final List<GetPage> pages = [
    GetPage(
      name: AppRoutes.splash,
      page: () => const SplashPage(),
      binding: SplashBinding(),
    ),
    GetPage(
      name: AppRoutes.login,
      page: () => const LoginPage(),
      binding: LoginBinding(),
    ),
    GetPage(
      name: AppRoutes.register,
      page: () => const RegisterPage(),
      binding: RegisterBinding(),
    ),
    GetPage(
      name: AppRoutes.home,
      page: () => const HomePage(),
      binding: HomeBinding(),
    ),
  ];
}
