// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for English (`en`).
class AppLocalizationsEn extends AppLocalizations {
  AppLocalizationsEn([String locale = 'en']) : super(locale);

  @override
  String get onboardingWelcomeTitle => 'My Skin Routine';

  @override
  String get onboardingWelcomeSubtitle => 'Your skincare companion';

  @override
  String get onboardingStart => 'Get Started';

  @override
  String get onboardingProfileTitle => 'What\'s your name?';

  @override
  String get onboardingProfileFirstName => 'First Name';

  @override
  String get onboardingProfileLastName => 'Last Name';

  @override
  String get onboardingContinue => 'Continue';

  @override
  String get onboardingProductTitle => 'Add your first product';

  @override
  String get onboardingProductSubtitle => 'You can add more later';

  @override
  String get onboardingRoutineTitle => 'Create your first routine';

  @override
  String get onboardingRoutineSubtitle => 'Organize your daily skincare';

  @override
  String get onboardingSkip => 'Skip';

  @override
  String get onboardingDoneTitle => 'All set! 🎉';

  @override
  String onboardingDoneWelcome(String firstName) {
    return 'Welcome $firstName!';
  }

  @override
  String get onboardingDoneButton => 'Explore the App';

  @override
  String get profileTitle => 'Profile';

  @override
  String get profileEditTitle => 'Edit Profile';

  @override
  String greetingPersonalized(String firstName) {
    return 'Hello $firstName 💜';
  }

  @override
  String get greetingDefault => 'Hello 💜';

  @override
  String get homeGreeting => 'Hello 💜';

  @override
  String get homeToday => 'Today\'s Routines';

  @override
  String get homeEmpty => 'No active routines';

  @override
  String get homeEmptySubtitle => 'Create your first routine to get started';

  @override
  String get homeCreateFirst => 'Create My First Routine';

  @override
  String get productsTitle => 'My Products';

  @override
  String get productsEmpty => 'No products';

  @override
  String get productsEmptySubtitle => 'Add your first skincare products';

  @override
  String get productsSearch => 'Search a product';

  @override
  String get productNew => 'New Product';

  @override
  String get productFormName => 'Product Name';

  @override
  String get productFormNameHint => 'E.g. Vitamin C Serum';

  @override
  String get productFormBrand => 'Brand';

  @override
  String get productFormBrandHint => 'E.g. CeraVe';

  @override
  String get productFormType => 'Product Type';

  @override
  String get productFormNotes => 'Notes (optional)';

  @override
  String get productFormPhoto => 'Add a Photo';

  @override
  String get productDelete => 'Delete Product';

  @override
  String productDeleteWarning(int count) {
    return 'This product is used in $count action(s). Actions will be kept but no longer linked to a product.';
  }

  @override
  String get routinesTitle => 'My Routines';

  @override
  String get routinesEmpty => 'No routines';

  @override
  String get routinesEmptySubtitle => 'Create your first skincare routine';

  @override
  String get routineNew => 'New Routine';

  @override
  String get routineFormName => 'Routine Name';

  @override
  String get routineFormDescription => 'Description (optional)';

  @override
  String get routineFormBodyZone => 'Body Zone';

  @override
  String get routineFormSkinGoal => 'Skin Goal';

  @override
  String get routineFormReminder => 'Reminder Time';

  @override
  String get routineFormActive => 'Active Routine';

  @override
  String get routineDelete => 'Delete Routine';

  @override
  String routineDeleteWarning(int count) {
    return 'This routine and its $count action(s) will be permanently deleted.';
  }

  @override
  String get actionsTitle => 'Actions';

  @override
  String get actionNew => 'New Action';

  @override
  String get actionFormName => 'Action Name';

  @override
  String get actionFormNameHint => 'E.g. Apply serum';

  @override
  String get actionFormDescription => 'Description (optional)';

  @override
  String get actionFormProduct => 'Associated Product';

  @override
  String get actionFormProductNone => 'None';

  @override
  String get actionFormRecurrence => 'Recurrence';

  @override
  String get actionFormRecurrenceDaily => 'Daily';

  @override
  String actionFormRecurrenceEveryN(int count) {
    return 'Every $count days';
  }

  @override
  String get actionFormRecurrenceWeekly => 'Weekly';

  @override
  String get actionFormInterval => 'Interval (days)';

  @override
  String get actionFormStartDate => 'Start Date';

  @override
  String get actionDelete => 'Delete Action';

  @override
  String get progressTitle => 'Progress';

  @override
  String get progressCalendar => 'Calendar';

  @override
  String get progressStreaks => 'Streaks';

  @override
  String get progressJournal => 'Journal';

  @override
  String get streakCurrent => 'Current Streak';

  @override
  String get streakBest => 'Best Streak';

  @override
  String streakDays(int count) {
    return '$count days';
  }

  @override
  String get journalNew => 'New Entry';

  @override
  String get journalDate => 'Date';

  @override
  String get journalPhoto => 'Photo (optional)';

  @override
  String get journalFeeling => 'How is your skin?';

  @override
  String get journalFeelingTerrible => 'Terrible';

  @override
  String get journalFeelingNotGreat => 'Not Great';

  @override
  String get journalFeelingNormal => 'Normal';

  @override
  String get journalFeelingGood => 'Good';

  @override
  String get journalFeelingRadiant => 'Radiant';

  @override
  String get journalNotes => 'Notes';

  @override
  String get journalNotesHint => 'How is your skin today?';

  @override
  String get settingsTitle => 'Settings';

  @override
  String get settingsLanguage => 'Language';

  @override
  String get settingsTheme => 'Theme';

  @override
  String get settingsThemeAuto => 'Auto';

  @override
  String get settingsThemeLight => 'Light';

  @override
  String get settingsThemeDark => 'Dark';

  @override
  String get settingsDynamicColor => 'Dynamic Colors';

  @override
  String get settingsDynamicColorSubtitle => 'Use wallpaper colors';

  @override
  String get settingsExport => 'Export My Data';

  @override
  String get settingsImport => 'Import Data';

  @override
  String get settingsImportWarning =>
      'This will replace all your current data. This action is irreversible.';

  @override
  String get settingsAbout => 'About';

  @override
  String get settingsVersion => 'Version';

  @override
  String get commonSave => 'Save';

  @override
  String get commonCancel => 'Cancel';

  @override
  String get commonDelete => 'Delete';

  @override
  String get commonConfirm => 'Confirm';

  @override
  String get commonEdit => 'Edit';

  @override
  String get commonClose => 'Close';

  @override
  String get commonCamera => 'Camera';

  @override
  String get commonGallery => 'Gallery';

  @override
  String get commonError => 'An error occurred';

  @override
  String get commonSuccess => 'Operation successful';

  @override
  String get exportSuccess => 'Export successful ✓';

  @override
  String get importSuccess => 'Import successful ✓';

  @override
  String completedOf(int completed, int total) {
    return '$completed/$total completed';
  }

  @override
  String todayDate(String date) {
    return '$date';
  }
}
