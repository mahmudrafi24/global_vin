import 'dart:ui';
import 'package:flutter/material.dart';
import '../constants/app_colors.dart';

class GlassmorphismCard extends StatelessWidget {
  final Widget child;
  final double borderRadius;
  final EdgeInsetsGeometry? padding;
  final Color? borderColor;
  final double blur;

  const GlassmorphismCard({
    super.key,
    required this.child,
    this.borderRadius = 16,
    this.padding,
    this.borderColor,
    this.blur = 10,
  });

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(borderRadius),
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: blur, sigmaY: blur),
        child: Container(
          padding: padding ?? const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: AppColors.surface.withOpacity(0.7),
            borderRadius: BorderRadius.circular(borderRadius),
            border: Border.all(
              color: borderColor ?? AppColors.divider.withOpacity(0.5),
            ),
          ),
          child: child,
        ),
      ),
    );
  }
}
