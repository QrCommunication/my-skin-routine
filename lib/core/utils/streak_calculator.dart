import 'package:my_skin_routine/core/constants/enums.dart';
import 'package:my_skin_routine/core/utils/recurrence_utils.dart';

/// Represents an action for streak calculation.
typedef ActionForStreak = ({
  int id,
  RecurrenceType recurrenceType,
  int recurrenceInterval,
  String recurrenceStartDate,
});

/// Calculates the current streak of days where all scheduled actions were completed.
///
/// Iterates backwards from today up to 365 days. For each date:
/// - If no actions are scheduled for that date, skip it (don't break streak).
/// - If all scheduled actions are completed, increment streak counter.
/// - If any scheduled action is incomplete, break the streak and return count.
///
/// Returns the length of the current unbroken streak.
int calculateCurrentStreak({
  required List<ActionForStreak> actions,
  required Map<int, Set<String>> completions,
  required DateTime today,
}) {
  int streak = 0;

  for (int i = 0; i < 365; i++) {
    final date = today.subtract(Duration(days: i));
    final dateStr = _formatDate(date);

    // Find all actions scheduled for this date
    final scheduledActions = actions.where((action) {
      return isActionScheduledForDate(
        action.recurrenceType,
        action.recurrenceInterval,
        action.recurrenceStartDate,
        date,
      );
    }).toList();

    // If no actions scheduled, skip this date
    if (scheduledActions.isEmpty) {
      continue;
    }

    // Check if all scheduled actions are completed
    bool allCompleted = true;
    for (final action in scheduledActions) {
      if (!(completions[action.id]?.contains(dateStr) ?? false)) {
        allCompleted = false;
        break;
      }
    }

    if (allCompleted) {
      streak++;
    } else {
      break;
    }
  }

  return streak;
}

/// Calculates the best (longest) streak from the completions history.
///
/// Analyzes all completion records and finds the maximum consecutive streak
/// where all scheduled actions were completed on each day.
///
/// Returns the length of the longest streak found in the history.
int calculateBestStreak({
  required List<ActionForStreak> actions,
  required Map<int, Set<String>> completions,
  required DateTime today,
}) {
  int bestStreak = 0;
  int currentStreak = 0;

  // Iterate backwards from today
  for (int i = 0; i < 365; i++) {
    final date = today.subtract(Duration(days: i));
    final dateStr = _formatDate(date);

    // Find all actions scheduled for this date
    final scheduledActions = actions.where((action) {
      return isActionScheduledForDate(
        action.recurrenceType,
        action.recurrenceInterval,
        action.recurrenceStartDate,
        date,
      );
    }).toList();

    // If no actions scheduled, skip this date
    if (scheduledActions.isEmpty) {
      continue;
    }

    // Check if all scheduled actions are completed
    bool allCompleted = true;
    for (final action in scheduledActions) {
      if (!(completions[action.id]?.contains(dateStr) ?? false)) {
        allCompleted = false;
        break;
      }
    }

    if (allCompleted) {
      currentStreak++;
      bestStreak = currentStreak > bestStreak ? currentStreak : bestStreak;
    } else {
      currentStreak = 0;
    }
  }

  return bestStreak;
}

/// Formats a DateTime to a date string in 'yyyy-MM-dd' format.
String _formatDate(DateTime date) {
  return date.toIso8601String().split('T')[0];
}
