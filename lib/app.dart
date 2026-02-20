import 'package:core_kit/core_kit.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:global_vin/core/constants/api_constants.dart';
import 'package:global_vin/core/theme/app_theme.dart';
import 'package:global_vin/presentation/bindings/initial_binding.dart';
import 'package:global_vin/routes/app_pages.dart';
import 'package:global_vin/routes/app_routes.dart';
import 'package:global_vin/services/storage_service.dart';

GlobalKey<ScaffoldMessengerState> scaffoldMessengerKey =
    GlobalKey<ScaffoldMessengerState>();

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      initialBinding: InitialBinding(),
      scaffoldMessengerKey: scaffoldMessengerKey,
      debugShowCheckedModeBanner: false,
      defaultTransition: Transition.fadeIn,
      transitionDuration: const Duration(milliseconds: 200),
      initialRoute: AppPages.initial,
      theme: AppTheme.lightTheme,
      darkTheme: AppTheme.darkTheme,
      themeMode: ThemeMode.light,
      getPages: AppPages.pages,
      locale: const Locale('en', 'US'),
      supportedLocales: const [
        Locale('en', 'US'),
        Locale('bn', 'BD'),
      ],
      builder: (context, child) {
        return CoreKit.init(
          navigatorKey: Get.key,
          back: () {
            Get.back();
          },
          designSize: const Size(375, 812),
          imageBaseUrl: ApiConstants.imageUrl,
          dioServiceConfig: DioServiceConfig(
            baseUrl: ApiConstants.baseUrl,
            refreshTokenEndpoint: ApiConstants.refreshToken,
            onLogout: () {
              Get.find<StorageService>().clear();
              Get.offAllNamed(AppRoutes.login);
            },
            enableDebugLogs: kDebugMode,
          ),
          tokenProvider: TokenProvider(
            accessToken: () async =>
                Get.find<StorageService>().read<String>('access_token') ?? '',
            refreshToken: () async =>
                Get.find<StorageService>().read<String>('refresh_token') ?? '',
            updateTokens: (data) async {
              final storage = Get.find<StorageService>();
              await storage.write('access_token', data['accessToken']);
              await storage.write('refresh_token', data['refreshToken']);
            },
          ),
          child: child,
        );
      },
    );
  }
}
