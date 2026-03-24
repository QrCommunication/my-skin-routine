extension StringExtensions on String {
  /// Capitalizes the first letter of the string.
  String get capitalize {
    if (isEmpty) return this;
    return '${this[0].toUpperCase()}${substring(1)}';
  }

  /// Parses an ISO date string (YYYY-MM-DD or ISO 8601 format) into a DateTime.
  /// Throws [FormatException] if the string is not a valid date format.
  DateTime toDateTime() {
    return DateTime.parse(this);
  }
}
