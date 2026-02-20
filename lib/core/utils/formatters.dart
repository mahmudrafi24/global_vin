// core_kit's CoreUtils provides: parseDate, formatDateTime, formatDouble,
// formatDateTimeToHms, formatDateToShortMonth, formatTime, etc.
//
// This file provides app-specific formatters not covered by core_kit.
import 'package:core_kit/core_kit.dart';

class Formatters {
  static String formatDate(DateTime date, {String pattern = 'dd MMM yyyy'}) {
    return CoreUtils.formatDateTime(date);
  }

  static String formatCurrency(double amount, {String symbol = '\$'}) {
    return '$symbol${CoreUtils.formatDouble(amount)}';
  }

  static String formatPhone(String phone) {
    final cleaned = phone.replaceAll(RegExp(r'[^\d]'), '');
    if (cleaned.length == 11) {
      return '+${cleaned.substring(0, 2)} ${cleaned.substring(2, 6)} ${cleaned.substring(6)}';
    }
    return phone;
  }
}
