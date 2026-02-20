import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:global_vin/app.dart';
import 'package:global_vin/services/storage_service.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await initServices();
  runApp(const MyApp());
}

Future<void> initServices() async {
  await Get.putAsync(() => StorageService().init());
}
