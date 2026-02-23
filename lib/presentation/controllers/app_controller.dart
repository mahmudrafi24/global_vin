import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:global_vin/presentation/controllers/base_controller.dart';

class AppController extends BaseController {
  final Rx<ThemeMode> themeMode = Rx<ThemeMode>(ThemeMode.light);

  void toggleTheme() {
    themeMode.value =
        themeMode.value == ThemeMode.light ? ThemeMode.dark : ThemeMode.light;
  }
}
