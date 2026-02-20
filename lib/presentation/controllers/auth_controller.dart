import 'package:flutter/material.dart';
import 'package:core_kit/core_kit.dart';
import 'package:get/get.dart';
import 'package:global_vin/domain/entities/user_entity.dart';
import 'package:global_vin/domain/usecases/login_usecase.dart';
import 'package:global_vin/domain/usecases/register_usecase.dart';
import 'package:global_vin/presentation/controllers/base_controller.dart';
import 'package:global_vin/routes/app_routes.dart';

class AuthController extends BaseController {
  final LoginUseCase _loginUseCase;
  final RegisterUseCase _registerUseCase;

  AuthController({
    required LoginUseCase loginUseCase,
    required RegisterUseCase registerUseCase,
  })  : _loginUseCase = loginUseCase,
        _registerUseCase = registerUseCase;

  final Rx<UserEntity?> currentUser = Rx<UserEntity?>(null);

  // Login form
  final loginFormKey = GlobalKey<FormState>();
  final loginEmailController = TextEditingController();
  final loginPasswordController = TextEditingController();

  // Register form
  final registerFormKey = GlobalKey<FormState>();
  final registerNameController = TextEditingController();
  final registerEmailController = TextEditingController();
  final registerPasswordController = TextEditingController();
  final registerConfirmPasswordController = TextEditingController();

  Future<void> login() async {
    if (!loginFormKey.currentState!.validate()) return;

    showLoading();
    clearError();

    final result = await _loginUseCase(
      email: loginEmailController.text.trim(),
      password: loginPasswordController.text,
    );

    hideLoading();

    if (result.failure != null) {
      setError(result.failure!.message);
      showSnackBar(result.failure!.message, type: SnackBarType.error);
    } else {
      currentUser.value = result.user;
      showSnackBar('Login successful!', type: SnackBarType.success);
      Get.offAllNamed(AppRoutes.home);
    }
  }

  Future<void> register() async {
    if (!registerFormKey.currentState!.validate()) return;

    showLoading();
    clearError();

    final result = await _registerUseCase(
      name: registerNameController.text.trim(),
      email: registerEmailController.text.trim(),
      password: registerPasswordController.text,
    );

    hideLoading();

    if (result.failure != null) {
      setError(result.failure!.message);
      showSnackBar(result.failure!.message, type: SnackBarType.error);
    } else {
      currentUser.value = result.user;
      showSnackBar('Registration successful!', type: SnackBarType.success);
      Get.offAllNamed(AppRoutes.home);
    }
  }

  @override
  void onClose() {
    loginEmailController.dispose();
    loginPasswordController.dispose();
    registerNameController.dispose();
    registerEmailController.dispose();
    registerPasswordController.dispose();
    registerConfirmPasswordController.dispose();
    super.onClose();
  }
}
