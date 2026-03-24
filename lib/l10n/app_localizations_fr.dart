// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for French (`fr`).
class AppLocalizationsFr extends AppLocalizations {
  AppLocalizationsFr([String locale = 'fr']) : super(locale);

  @override
  String get onboardingWelcomeTitle => 'My Skin Routine';

  @override
  String get onboardingWelcomeSubtitle => 'Votre compagnon skincare';

  @override
  String get onboardingStart => 'Commencer';

  @override
  String get onboardingProfileTitle => 'Comment vous appelez-vous ?';

  @override
  String get onboardingProfileFirstName => 'Prénom';

  @override
  String get onboardingProfileLastName => 'Nom';

  @override
  String get onboardingContinue => 'Continuer';

  @override
  String get onboardingProductTitle => 'Ajoutez votre premier produit';

  @override
  String get onboardingProductSubtitle =>
      'Vous pourrez en ajouter d\'autres plus tard';

  @override
  String get onboardingRoutineTitle => 'Créez votre première routine';

  @override
  String get onboardingRoutineSubtitle => 'Organisez vos soins quotidiens';

  @override
  String get onboardingSkip => 'Passer';

  @override
  String get onboardingDoneTitle => 'Tout est prêt ! 🎉';

  @override
  String onboardingDoneWelcome(String firstName) {
    return 'Bienvenue $firstName !';
  }

  @override
  String get onboardingDoneButton => 'Découvrir l\'app';

  @override
  String get profileTitle => 'Profil';

  @override
  String get profileEditTitle => 'Modifier le profil';

  @override
  String greetingPersonalized(String firstName) {
    return 'Bonjour $firstName 💜';
  }

  @override
  String get greetingDefault => 'Bonjour 💜';

  @override
  String get homeGreeting => 'Bonjour 💜';

  @override
  String get homeToday => 'Routines du jour';

  @override
  String get homeEmpty => 'Aucune routine active';

  @override
  String get homeEmptySubtitle => 'Créez votre première routine pour commencer';

  @override
  String get homeCreateFirst => 'Créer ma première routine';

  @override
  String get productsTitle => 'Mes produits';

  @override
  String get productsEmpty => 'Aucun produit';

  @override
  String get productsEmptySubtitle => 'Ajoutez vos premiers produits de soin';

  @override
  String get productsSearch => 'Rechercher un produit';

  @override
  String get productNew => 'Nouveau produit';

  @override
  String get productFormName => 'Nom du produit';

  @override
  String get productFormNameHint => 'Ex: Sérum Vitamine C';

  @override
  String get productFormBrand => 'Marque';

  @override
  String get productFormBrandHint => 'Ex: CeraVe';

  @override
  String get productFormType => 'Type de produit';

  @override
  String get productFormNotes => 'Notes (optionnel)';

  @override
  String get productFormPhoto => 'Ajouter une photo';

  @override
  String get productDelete => 'Supprimer le produit';

  @override
  String productDeleteWarning(int count) {
    return 'Ce produit est utilisé dans $count action(s). Les actions seront conservées mais ne seront plus liées à un produit.';
  }

  @override
  String get routinesTitle => 'Mes routines';

  @override
  String get routinesEmpty => 'Aucune routine';

  @override
  String get routinesEmptySubtitle => 'Créez votre première routine de soin';

  @override
  String get routineNew => 'Nouvelle routine';

  @override
  String get routineFormName => 'Nom de la routine';

  @override
  String get routineFormDescription => 'Description (optionnel)';

  @override
  String get routineFormBodyZone => 'Zone du corps';

  @override
  String get routineFormSkinGoal => 'Objectif';

  @override
  String get routineFormReminder => 'Heure de rappel';

  @override
  String get routineFormActive => 'Routine active';

  @override
  String get routineDelete => 'Supprimer la routine';

  @override
  String routineDeleteWarning(int count) {
    return 'Cette routine et ses $count action(s) seront définitivement supprimées.';
  }

  @override
  String get actionsTitle => 'Actions';

  @override
  String get actionNew => 'Nouvelle action';

  @override
  String get actionFormName => 'Nom de l\'action';

  @override
  String get actionFormNameHint => 'Ex: Appliquer le sérum';

  @override
  String get actionFormDescription => 'Description (optionnel)';

  @override
  String get actionFormProduct => 'Produit associé';

  @override
  String get actionFormProductNone => 'Aucun';

  @override
  String get actionFormRecurrence => 'Récurrence';

  @override
  String get actionFormRecurrenceDaily => 'Quotidien';

  @override
  String actionFormRecurrenceEveryN(int count) {
    return 'Tous les $count jours';
  }

  @override
  String get actionFormRecurrenceWeekly => 'Hebdomadaire';

  @override
  String get actionFormInterval => 'Intervalle (jours)';

  @override
  String get actionFormStartDate => 'Date de référence';

  @override
  String get actionDelete => 'Supprimer l\'action';

  @override
  String get progressTitle => 'Suivi';

  @override
  String get progressCalendar => 'Calendrier';

  @override
  String get progressStreaks => 'Streaks';

  @override
  String get progressJournal => 'Journal';

  @override
  String get streakCurrent => 'Streak actuel';

  @override
  String get streakBest => 'Meilleur streak';

  @override
  String streakDays(int count) {
    return '$count jours';
  }

  @override
  String get journalNew => 'Nouvelle entrée';

  @override
  String get journalDate => 'Date';

  @override
  String get journalPhoto => 'Photo (optionnel)';

  @override
  String get journalFeeling => 'Comment va ta peau ?';

  @override
  String get journalFeelingTerrible => 'Terrible';

  @override
  String get journalFeelingNotGreat => 'Pas top';

  @override
  String get journalFeelingNormal => 'Normale';

  @override
  String get journalFeelingGood => 'Bien';

  @override
  String get journalFeelingRadiant => 'Radieuse';

  @override
  String get journalNotes => 'Notes';

  @override
  String get journalNotesHint => 'Comment est votre peau aujourd\'hui ?';

  @override
  String get settingsTitle => 'Paramètres';

  @override
  String get settingsLanguage => 'Langue';

  @override
  String get settingsTheme => 'Thème';

  @override
  String get settingsThemeAuto => 'Auto';

  @override
  String get settingsThemeLight => 'Clair';

  @override
  String get settingsThemeDark => 'Sombre';

  @override
  String get settingsDynamicColor => 'Couleurs dynamiques';

  @override
  String get settingsDynamicColorSubtitle =>
      'Utiliser les couleurs de votre fond d\'écran';

  @override
  String get settingsExport => 'Exporter mes données';

  @override
  String get settingsImport => 'Importer des données';

  @override
  String get settingsImportWarning =>
      'Ceci remplacera toutes vos données actuelles. Cette action est irréversible.';

  @override
  String get settingsAbout => 'À propos';

  @override
  String get settingsVersion => 'Version';

  @override
  String get commonSave => 'Enregistrer';

  @override
  String get commonCancel => 'Annuler';

  @override
  String get commonDelete => 'Supprimer';

  @override
  String get commonConfirm => 'Confirmer';

  @override
  String get commonEdit => 'Modifier';

  @override
  String get commonClose => 'Fermer';

  @override
  String get commonCamera => 'Caméra';

  @override
  String get commonGallery => 'Galerie';

  @override
  String get commonError => 'Une erreur est survenue';

  @override
  String get commonSuccess => 'Opération réussie';

  @override
  String get exportSuccess => 'Export réussi ✓';

  @override
  String get importSuccess => 'Import réussi ✓';

  @override
  String completedOf(int completed, int total) {
    return '$completed/$total complétées';
  }

  @override
  String todayDate(String date) {
    return '$date';
  }
}
