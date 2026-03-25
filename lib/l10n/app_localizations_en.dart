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
  String get onboardingFirstNameRequired => 'First name is required';

  @override
  String get onboardingLastNameRequired => 'Last name is required';

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
  String get productEdit => 'Edit Product';

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
  String get productFormNotesHint => 'Add notes about this product...';

  @override
  String get productFormPhoto => 'Add a Photo';

  @override
  String get productDelete => 'Delete Product';

  @override
  String productDeleteConfirm(String name) {
    return 'Are you sure you want to delete \"$name\"?';
  }

  @override
  String productDeleteWarning(int count) {
    return 'This product is used in $count action(s). Actions will be kept but no longer linked to a product.';
  }

  @override
  String productDeleteUsageWarning(int count) {
    return 'Warning: This product is used in $count action(s). This will affect routines.';
  }

  @override
  String productDeleted(String name) {
    return 'Product \"$name\" deleted';
  }

  @override
  String productNameDeleted(String name) {
    return '$name has been deleted';
  }

  @override
  String get productUpdatedSuccess => 'Product updated successfully';

  @override
  String get productCreatedSuccess => 'Product created successfully';

  @override
  String get productNameRequired => 'Product name is required';

  @override
  String get productNameMaxLength => 'Name must not exceed 100 characters';

  @override
  String get productBrandRequired => 'Brand is required';

  @override
  String get productBrandMaxLength => 'Brand must not exceed 100 characters';

  @override
  String get productNotUsed => 'Not used in any routine';

  @override
  String productUsedInCount(int count) {
    return 'Used in $count action(s)';
  }

  @override
  String productDeleteError(String error) {
    return 'Error deleting: $error';
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
  String get routineEdit => 'Edit Routine';

  @override
  String get routineFormName => 'Routine Name';

  @override
  String get routineFormNameHint => 'e.g. Morning Routine';

  @override
  String get routineFormNameHelperText => 'Maximum 100 characters';

  @override
  String get routineFormNameRequired => 'Name is required';

  @override
  String get routineFormNameMaxLength => 'Maximum 100 characters';

  @override
  String get routineFormDescription => 'Description (optional)';

  @override
  String get routineFormDescriptionHint => 'Describe your routine...';

  @override
  String get routineFormDescriptionHelperText => 'Maximum 500 characters';

  @override
  String get routineFormDescriptionMaxLength => 'Maximum 500 characters';

  @override
  String get routineFormBodyZone => 'Body Zone';

  @override
  String get routineFormSkinGoal => 'Skin Goal';

  @override
  String get routineFormReminder => 'Reminder Time';

  @override
  String get routineFormReminderNotSet => 'Not set';

  @override
  String get routineFormActive => 'Active Routine';

  @override
  String get routineFormActiveSubtitle => 'Include in active routines';

  @override
  String get routineFormUpdate => 'Update';

  @override
  String get routineDelete => 'Delete Routine';

  @override
  String routineDeleteWarning(int count) {
    return 'This routine and its $count action(s) will be permanently deleted.';
  }

  @override
  String get routineNotFound => 'Routine not found';

  @override
  String get routineNotFoundMessage => 'This routine does not exist';

  @override
  String routineActionsCount(int count) {
    return 'Actions ($count)';
  }

  @override
  String get actionsTitle => 'Actions';

  @override
  String get actionNew => 'New Action';

  @override
  String get actionEdit => 'Edit Action';

  @override
  String get actionFormName => 'Action Name';

  @override
  String get actionFormNameHint => 'E.g. Apply serum';

  @override
  String get actionFormNameRequired => 'Name is required';

  @override
  String get actionFormDescription => 'Description (optional)';

  @override
  String get actionFormDescriptionHint => 'Add optional details';

  @override
  String get actionFormProduct => 'Associated Product';

  @override
  String get actionFormProductNone => 'None';

  @override
  String get actionFormProductNoneLabel => 'No product';

  @override
  String get actionFormProductSearch => 'Search a product...';

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
  String get actionFormValidationNameRequired =>
      'Please enter a name for the action';

  @override
  String actionFormSaveAndNew(String save) {
    return '$save + New action';
  }

  @override
  String get actionDelete => 'Delete Action';

  @override
  String get actionIrreversible => 'This action is irreversible.';

  @override
  String get progressTitle => 'Progress';

  @override
  String get progressCalendar => 'Calendar';

  @override
  String get progressStreaks => 'Streaks';

  @override
  String get progressJournal => 'Journal';

  @override
  String progressDayDetails(String date) {
    return 'Details for $date';
  }

  @override
  String progressNotes(String notes) {
    return 'Notes: $notes';
  }

  @override
  String progressPhoto(String path) {
    return 'Photo: $path';
  }

  @override
  String progressFeeling(int feeling) {
    return 'Feeling: $feeling/5';
  }

  @override
  String get progressNoEntry => 'No journal entry for this day.';

  @override
  String get streakCurrent => 'Current Streak';

  @override
  String get streakBest => 'Best Streak';

  @override
  String streakDays(int count) {
    return '$count days';
  }

  @override
  String streakCurrentDays(String label, int count) {
    return '$label: $count days';
  }

  @override
  String get journalTitle => 'Journal';

  @override
  String get journalNew => 'New Entry';

  @override
  String get journalEditTitle => 'Edit Journal Entry';

  @override
  String get journalNewTitle => 'New Journal Entry';

  @override
  String get journalDate => 'Date';

  @override
  String get journalPhoto => 'Photo (optional)';

  @override
  String get journalAddPhoto => 'Add a photo';

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
  String get journalValidationNotesRequired => 'Please enter some notes';

  @override
  String get journalValidationFeelingRequired =>
      'Please select how your skin feels';

  @override
  String get settingsTitle => 'Settings';

  @override
  String get settingsLanguage => 'Language';

  @override
  String get settingsLanguageFrench => 'Français';

  @override
  String get settingsLanguageEnglish => 'English';

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
  String get settingsOpenSourceLicenses => 'Open source licenses';

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
  String commonErrorWithDetails(String error) {
    return 'Error: $error';
  }

  @override
  String get commonSuccess => 'Operation successful';

  @override
  String get commonRetry => 'Retry';

  @override
  String get commonAll => 'All';

  @override
  String get commonNext => 'Next';

  @override
  String get commonGotIt => 'Got it!';

  @override
  String get commonEditTooltip => 'Edit';

  @override
  String get commonDeleteTooltip => 'Delete';

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

  @override
  String get navHome => 'Home';

  @override
  String get navProducts => 'Products';

  @override
  String get navRoutines => 'Routines';

  @override
  String get navProgress => 'Progress';

  @override
  String get tutorialHomeSkinJournalTitle => 'Skin Journal';

  @override
  String get tutorialHomeSkinJournalDescription =>
      'Record your skin condition every day.';

  @override
  String get tutorialProductsSearchTitle => 'Search and filter';

  @override
  String get tutorialProductsSearchDescription =>
      'Use the search bar or type filters to find a product.';

  @override
  String get tutorialProductsFilterTitle => 'Category filters';

  @override
  String get tutorialProductsFilterDescription =>
      'Select a category to show only matching products.';

  @override
  String get tutorialProductsAddTitle => 'Add your own';

  @override
  String get tutorialProductsAddDescription =>
      'Tap the + button to add a new product with photo.';

  @override
  String get tutorialRoutinesFilterTitle => 'Filter your routines';

  @override
  String get tutorialRoutinesFilterDescription =>
      'Select a skin goal to show only matching routines.';

  @override
  String get tutorialRoutinesListTitle => 'Your routines';

  @override
  String get tutorialRoutinesListDescription =>
      'Each routine contains actions: apply serum, cleanse, etc. Enable or disable a routine with the switch.';

  @override
  String get tutorialRoutinesCreateTitle => 'Create a new routine';

  @override
  String get tutorialRoutinesCreateDescription =>
      'Tap the + button to create a new custom routine.';
}
