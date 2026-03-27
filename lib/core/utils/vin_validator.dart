class VinValidator {
  VinValidator._();

  static const _vinRegex = r'^[A-HJ-NPR-Z0-9]{17}$';

  static bool isValid(String vin) {
    if (vin.length != 17) return false;
    return RegExp(_vinRegex).hasMatch(vin.toUpperCase());
  }

  static String? errorMessage(String vin) {
    if (vin.isEmpty) return null;
    if (vin.length < 17) {
      return 'VIN must be 17 characters (${vin.length}/17)';
    }
    if (!RegExp(_vinRegex).hasMatch(vin.toUpperCase())) {
      return 'Invalid VIN format';
    }
    return null;
  }
}
