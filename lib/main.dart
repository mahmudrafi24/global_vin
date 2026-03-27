import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:global_vin/core/constants/app_strings.dart';
import 'package:global_vin/core/theme/app_theme.dart';
import 'package:global_vin/core/utils/app_settings.dart';
import 'package:global_vin/features/profile/data/datasources/profile_local_datasource.dart';
import 'package:global_vin/features/profile/presentation/controllers/profile_controller.dart';
import 'package:global_vin/features/recent_searches/data/datasources/recent_search_local_datasource.dart';
import 'package:global_vin/features/recent_searches/presentation/controllers/recent_search_controller.dart';
import 'package:global_vin/features/subscription/presentation/controllers/subscription_controller.dart';
import 'package:global_vin/routes/app_pages.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Set status bar style
  SystemChrome.setSystemUIOverlayStyle(
    const SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
      statusBarIconBrightness: Brightness.light,
    ),
  );

  // Initialize Hive
  await Hive.initFlutter();

  // Initialize services
  await _initServices();

  runApp(const VinDecodeApp());
}

Future<void> _initServices() async {
  // App Settings
  final settings = AppSettings();
  await settings.init();
  Get.put(settings);

  // Recent Search Datasource
  final recentSearchDs = RecentSearchLocalDatasource();
  await recentSearchDs.init();
  Get.put(recentSearchDs);

  // Profile Datasource
  final profileDs = ProfileLocalDatasource();
  await profileDs.init();
  Get.put(profileDs);

  // Controllers (global - persist across routes)
  Get.put(SubscriptionController(settings));
  Get.put(RecentSearchController(recentSearchDs));
  Get.put(ProfileController(profileDs));
}

class VinDecodeApp extends StatelessWidget {
  const VinDecodeApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: AppStrings.appName,
      debugShowCheckedModeBanner: false,
      theme: AppTheme.darkTheme,
      darkTheme: AppTheme.darkTheme,
      themeMode: ThemeMode.dark,
      initialRoute: AppPages.initial,
      getPages: AppPages.pages,
      defaultTransition: Transition.cupertino,
    );
  }
}
