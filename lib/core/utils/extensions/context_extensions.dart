import 'package:flutter/material.dart';

// core_kit provides responsive sizing via .w, .h, .r, .sp extensions.
// This file adds app-specific context extensions.

extension ContextExtensions on BuildContext {
  ThemeData get theme => Theme.of(this);
  TextTheme get textTheme => Theme.of(this).textTheme;
  ColorScheme get colorScheme => Theme.of(this).colorScheme;
  EdgeInsets get padding => MediaQuery.paddingOf(this);
  bool get canPop => Navigator.of(this).canPop();
}
