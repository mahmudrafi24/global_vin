import 'package:flutter/material.dart';
import 'package:global_vin/presentation/controllers/base_controller.dart';

class AppController extends BaseController {
  final themeMode = ThemeMode.light.obs;

  void toggleTheme() {
    themeMode.value =
        themeMode.value == ThemeMode.light ? ThemeMode.dark : ThemeMode.light;
  }
}
