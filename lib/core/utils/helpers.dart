import 'package:flutter/material.dart';
import 'package:core_kit/core_kit.dart';

class Helpers {
  /// Use core_kit's showSnackBar for notifications
  static void showMessage(String message, {bool isError = false}) {
    showSnackBar(
      message,
      type: isError ? SnackBarType.error : SnackBarType.success,
    );
  }

  static void hideKeyboard(BuildContext context) {
    FocusScope.of(context).unfocus();
  }

  /// Use core_kit's CommonDialogWithActions for confirm dialogs
  static Future<void> showConfirmDialog(
    BuildContext context, {
    required String title,
    required String message,
    String confirmText = 'Confirm',
    String cancelText = 'Cancel',
    VoidCallback? onConfirm,
  }) {
    return CommonDialogWithActions(
      title: title,
      subTitle: message,
      content: [],
      context: context,
      onConfirm: onConfirm ?? () {},
    );
  }
}
