import 'package:my_skin_routine/core/constants/enums.dart';

/// Checks if an action is scheduled for a given date based on its recurrence settings.
///
/// For daily recurrence, always returns true.
/// For other recurrence types, calculates the days between start date and target date,
/// and returns true if the difference is non-negative and divisible by the interval.
bool isActionScheduledForDate(
  RecurrenceType type,
  int interval,
  String startDate,
  DateTime date,
) {
  if (type == RecurrenceType.daily) {
    return true;
  }

  final start = DateTime.parse(startDate);
  final difference = date.difference(start).inDays;

  if (difference < 0) {
    return false;
  }

  return difference % interval == 0;
}

/// Returns a localized label for the recurrence type and interval.
///
/// Returns:
/// - "Quotidien"/"Daily" for daily recurrence
/// - "Hebdomadaire"/"Weekly" for 7-day intervals
/// - "1 jour sur N"/"Every N days" for other intervals
String recurrenceLabel(
  RecurrenceType type,
  int interval,
  String locale,
) {
  if (type == RecurrenceType.daily) {
    return locale == 'fr' ? 'Quotidien' : 'Daily';
  }

  if (interval == 7) {
    return locale == 'fr' ? 'Hebdomadaire' : 'Weekly';
  }

  if (locale == 'fr') {
    return 'Tous les $interval jours';
  } else {
    return 'Every $interval days';
  }
}
