// core_kit provides ValidationType enum with 23 built-in validation types
// that are used directly with CommonTextField.
//
// Usage: CommonTextField(validationType: ValidationType.validateEmail)
//
// This file provides app-specific validators not covered by core_kit.
export 'package:core_kit/core_kit.dart' show ValidationType;

class Validators {
  /// Custom VIN number validation (app-specific)
  static String? validateVIN(String? value) {
    if (value == null || value.isEmpty) {
      return 'VIN is required';
    }
    if (value.length != 17) {
      return 'VIN must be exactly 17 characters';
    }
    final vinRegex = RegExp(r'^[A-HJ-NPR-Z0-9]{17}$');
    if (!vinRegex.hasMatch(value.toUpperCase())) {
      return 'Please enter a valid VIN';
    }
    return null;
  }
}
