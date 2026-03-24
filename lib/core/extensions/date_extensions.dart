extension DateTimeExtensions on DateTime {
  /// Returns a date string in "YYYY-MM-DD" format.
  String toDateString() {
    return '$year-${month.toString().padLeft(2, '0')}-${day.toString().padLeft(2, '0')}';
  }

  /// Returns a localized date string.
  /// Uses "fr" locale for French, otherwise English.
  String toDisplayDate(String locale) {
    if (locale.startsWith('fr')) {
      final months = [
        'janvier',
        'février',
        'mars',
        'avril',
        'mai',
        'juin',
        'juillet',
        'août',
        'septembre',
        'octobre',
        'novembre',
        'décembre',
      ];
      final days = ['lundi', 'mardi', 'mercredi', 'jeudi', 'vendredi', 'samedi', 'dimanche'];
      final dayName = days[weekday % 7];
      final monthName = months[month - 1];
      return '$dayName $day $monthName $year';
    } else {
      final months = [
        'January',
        'February',
        'March',
        'April',
        'May',
        'June',
        'July',
        'August',
        'September',
        'October',
        'November',
        'December',
      ];
      final days = ['Monday', 'Tuesday', 'Wednesday', 'Thursday', 'Friday', 'Saturday', 'Sunday'];
      final dayName = days[weekday % 7];
      final monthName = months[month - 1];
      return '$dayName $day $monthName $year';
    }
  }

  /// Returns true if this DateTime is on the same day as [other].
  bool isSameDay(DateTime other) {
    return year == other.year && month == other.month && day == other.day;
  }

  /// Returns a DateTime at the start of the day (00:00:00).
  DateTime get startOfDay {
    return DateTime(year, month, day);
  }

  /// Returns a DateTime at the end of the day (23:59:59.999).
  DateTime get endOfDay {
    return DateTime(year, month, day, 23, 59, 59, 999);
  }
}
