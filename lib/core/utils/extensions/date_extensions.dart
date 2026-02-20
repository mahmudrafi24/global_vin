// core_kit provides DateTime extensions:
//   .time (HH:mm), .date (yyyy-MM-dd), .dayName, .checkTime (relative time)
//
// This file adds app-specific date extensions.

extension AppDateExtensions on DateTime {
  bool get isToday {
    final now = DateTime.now();
    return year == now.year && month == now.month && day == now.day;
  }

  bool get isYesterday {
    final yesterday = DateTime.now().subtract(const Duration(days: 1));
    return year == yesterday.year &&
        month == yesterday.month &&
        day == yesterday.day;
  }
}
