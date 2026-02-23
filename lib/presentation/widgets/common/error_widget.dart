import 'package:flutter/material.dart';
import 'package:core_kit/core_kit.dart';
import 'package:global_vin/core/theme/app_dimensions.dart';

class AppErrorWidget extends StatelessWidget {
  final String message;
  final VoidCallback? onRetry;

  const AppErrorWidget({
    super.key,
    required this.message,
    this.onRetry,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(AppDimensions.paddingLG),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(Icons.error_outline, size: 64, color: Colors.red),
            16.height,
            CommonText(text: message, textAlign: TextAlign.center),
            if (onRetry != null) ...[
              24.height,
              CommonButton(
                titleText: 'Retry',
                onTap: onRetry,
              ),
            ],
          ],
        ),
      ),
    );
  }
}
