// core_kit provides: capitalize, capitalizeEachWord, capitalizeFirst, newLine
// via its StringExtension on String.
//
// Re-export core_kit extensions and add app-specific ones here.
export 'package:core_kit/core_kit.dart';

extension AppStringExtensions on String {
  bool get isValidVIN {
    return RegExp(r'^[A-HJ-NPR-Z0-9]{17}$').hasMatch(toUpperCase());
  }

  String get removeWhitespace => replaceAll(' ', '');
}
