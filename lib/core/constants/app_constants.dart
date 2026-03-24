class AppConstants {
  AppConstants._();

  // Photo constraints
  static const int maxPhotoSize = 1024; // KB
  static const int jpegQuality = 85;

  // Database constraints
  static const int maxProducts = 500;
  static const int maxRoutines = 50;
  static const int maxActionsPerRoutine = 30;
  static const int maxJournalEntries = 1000;

  // Text constraints
  static const int maxNameLength = 100;
  static const int maxDescriptionLength = 500;
  static const int maxNotesLength = 1000;

  // Streak tracking
  static const int streakLookbackDays = 365;

  // File paths
  static const String imageSubdirProducts = 'images/products';
  static const String imageSubdirJournal = 'images/journal';
  static const String exportPrefix = 'my_skin_routine_backup';
  static const String dbFileName = 'my_skin_routine.sqlite';
}
