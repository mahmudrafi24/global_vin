import 'package:flutter/material.dart';

class CoreScreenUtils {
  CoreScreenUtils._();

  static late Size deviceSize;
  static late double _designWidth;
  static late double _designHeight;

  /// Initialize with your design size (e.g., Figma artboard dimensions).
  /// Default design size is 375x812 (iPhone 13 mini).
  static void init(
    BuildContext context, {
    Size designSize = const Size(375, 812),
    VoidCallback? onComplete,
  }) {
    deviceSize = MediaQuery.of(context).size;
    _designWidth = designSize.width;
    _designHeight = designSize.height;
    onComplete?.call();
  }

  static double _scale() {
    return deviceSize.width / _designWidth < deviceSize.height / _designHeight
        ? deviceSize.width / _designWidth
        : deviceSize.height / _designHeight;
  }

  static double width({required num value}) => value * _scale();
  static double height({required num value}) => value * _scale();
  static double radius({required num value}) => value * _scale();
  static double sp({required num value}) => value * _scale();
}

extension GapExtension on int {
  Widget get width => SizedBox(width: toDouble());
  Widget get height => SizedBox(height: toDouble());
}

extension ResponsiveInt on int {
  double get w => CoreScreenUtils.width(value: this);
  double get h => CoreScreenUtils.height(value: this);
  double get r => CoreScreenUtils.radius(value: this);
  double get sp => CoreScreenUtils.sp(value: this);
}

extension ResponsiveDouble on double {
  double get w => CoreScreenUtils.width(value: this);
  double get h => CoreScreenUtils.height(value: this);
  double get r => CoreScreenUtils.radius(value: this);
  double get sp => CoreScreenUtils.sp(value: this);
}
