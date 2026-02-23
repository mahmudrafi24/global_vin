import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:core_kit/core_kit.dart';
import 'package:get/get.dart';
import 'package:global_vin/core/constants/api_constants.dart';
import 'package:global_vin/core/theme/app_theme.dart';
import 'package:global_vin/presentation/bindings/initial_binding.dart';
import 'package:global_vin/routes/app_pages.dart';
import 'package:global_vin/routes/app_routes.dart';
import 'package:global_vin/services/token_provider_impl.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return CoreKit.init(
      navigatorKey: Get.key,
      designSize: const Size(375, 812),
      imageBaseUrl: ApiConstants.baseUrl,
      dioServiceConfig: DioServiceConfig(
        baseUrl: ApiConstants.baseUrl,
        refreshTokenEndpoint: ApiConstants.refreshToken,
        onLogout: () {
          // StorageService().removeTokens();
          Get.offAllNamed(AppRoutes.splash);
        },
        enableDebugLogs: kDebugMode,
      ),
      tokenProvider: TokenProviderImpl(),
      child: GetMaterialApp(
        title: 'Global VIN',
        debugShowCheckedModeBanner: false,
        //navigatorKey: navigatorKey,
        theme: AppTheme.lightTheme,
        darkTheme: AppTheme.darkTheme,
        themeMode: ThemeMode.light,
        initialRoute: AppPages.initial,
        getPages: AppPages.pages,
        initialBinding: InitialBinding(),
        locale: const Locale('en', 'US'),
        supportedLocales: const [
          Locale('en', 'US'),
          Locale('bn', 'BD'),
        ],
      ),
    );
  }
}
