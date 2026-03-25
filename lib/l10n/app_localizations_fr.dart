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
  String get onboardingFirstNameRequired => 'Le prénom est requis';

  @override
  String get onboardingLastNameRequired => 'Le nom est requis';

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
  String get productEdit => 'Modifier le produit';

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
  String get productFormNotesHint => 'Ajouter des notes sur ce produit...';

  @override
  String get productFormPhoto => 'Ajouter une photo';

  @override
  String get productDelete => 'Supprimer le produit';

  @override
  String productDeleteConfirm(String name) {
    return 'Êtes-vous sûr de vouloir supprimer \"$name\" ?';
  }

  @override
  String productDeleteWarning(int count) {
    return 'Ce produit est utilisé dans $count action(s). Les actions seront conservées mais ne seront plus liées à un produit.';
  }

  @override
  String productDeleteUsageWarning(int count) {
    return 'Attention : Ce produit est utilisé dans $count action(s). Cela affectera les routines.';
  }

  @override
  String productDeleted(String name) {
    return 'Produit \"$name\" supprimé';
  }

  @override
  String productNameDeleted(String name) {
    return '$name a été supprimé';
  }

  @override
  String get productUpdatedSuccess => 'Produit modifié avec succès';

  @override
  String get productCreatedSuccess => 'Produit créé avec succès';

  @override
  String get productNameRequired => 'Le nom du produit est requis';

  @override
  String get productNameMaxLength =>
      'Le nom ne doit pas dépasser 100 caractères';

  @override
  String get productBrandRequired => 'La marque est requise';

  @override
  String get productBrandMaxLength =>
      'La marque ne doit pas dépasser 100 caractères';

  @override
  String get productNotUsed => 'Non utilisé dans aucune routine';

  @override
  String productUsedInCount(int count) {
    return 'Utilisé dans $count action(s)';
  }

  @override
  String productDeleteError(String error) {
    return 'Erreur lors de la suppression : $error';
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
  String get routineEdit => 'Éditer Routine';

  @override
  String get routineFormName => 'Nom de la routine';

  @override
  String get routineFormNameHint => 'ex: Routine du matin';

  @override
  String get routineFormNameHelperText => 'Maximum 100 caractères';

  @override
  String get routineFormNameRequired => 'Le nom est requis';

  @override
  String get routineFormNameMaxLength => 'Maximum 100 caractères';

  @override
  String get routineFormDescription => 'Description (optionnel)';

  @override
  String get routineFormDescriptionHint => 'Décrivez votre routine...';

  @override
  String get routineFormDescriptionHelperText => 'Maximum 500 caractères';

  @override
  String get routineFormDescriptionMaxLength => 'Maximum 500 caractères';

  @override
  String get routineFormBodyZone => 'Zone du corps';

  @override
  String get routineFormSkinGoal => 'Objectif';

  @override
  String get routineFormReminder => 'Heure de rappel';

  @override
  String get routineFormReminderNotSet => 'Non défini';

  @override
  String get routineFormActive => 'Routine active';

  @override
  String get routineFormActiveSubtitle => 'Inclure dans les routines actives';

  @override
  String get routineFormUpdate => 'Mettre à jour';

  @override
  String get routineDelete => 'Supprimer la routine';

  @override
  String routineDeleteWarning(int count) {
    return 'Cette routine et ses $count action(s) seront définitivement supprimées.';
  }

  @override
  String get routineNotFound => 'Routine non trouvée';

  @override
  String get routineNotFoundMessage => 'La routine n\'existe pas';

  @override
  String routineActionsCount(int count) {
    return 'Actions ($count)';
  }

  @override
  String get actionsTitle => 'Actions';

  @override
  String get actionNew => 'Nouvelle action';

  @override
  String get actionEdit => 'Éditer Action';

  @override
  String get actionFormName => 'Nom de l\'action';

  @override
  String get actionFormNameHint => 'Ex: Appliquer le sérum';

  @override
  String get actionFormNameRequired => 'Le nom est requis';

  @override
  String get actionFormDescription => 'Description (optionnel)';

  @override
  String get actionFormDescriptionHint => 'Ajoutez des détails optionnels';

  @override
  String get actionFormProduct => 'Produit associé';

  @override
  String get actionFormProductNone => 'Aucun';

  @override
  String get actionFormProductNoneLabel => 'Aucun produit';

  @override
  String get actionFormProductSearch => 'Rechercher un produit...';

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
  String get actionFormValidationNameRequired =>
      'Veuillez entrer un nom pour l\'action';

  @override
  String actionFormSaveAndNew(String save) {
    return '$save + Nouvelle action';
  }

  @override
  String get actionDelete => 'Supprimer l\'action';

  @override
  String get actionIrreversible => 'Cette action est irréversible.';

  @override
  String get progressTitle => 'Suivi';

  @override
  String get progressCalendar => 'Calendrier';

  @override
  String get progressStreaks => 'Streaks';

  @override
  String get progressJournal => 'Journal';

  @override
  String progressDayDetails(String date) {
    return 'Détails du $date';
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
  String get progressNoEntry => 'Aucune entrée journal pour ce jour.';

  @override
  String get streakCurrent => 'Streak actuel';

  @override
  String get streakBest => 'Meilleur streak';

  @override
  String streakDays(int count) {
    return '$count jours';
  }

  @override
  String streakCurrentDays(String label, int count) {
    return '$label: $count jours';
  }

  @override
  String get journalTitle => 'Journal';

  @override
  String get journalNew => 'Nouvelle entrée';

  @override
  String get journalEditTitle => 'Éditer Entrée Journal';

  @override
  String get journalNewTitle => 'Nouvelle Entrée Journal';

  @override
  String get journalDate => 'Date';

  @override
  String get journalPhoto => 'Photo (optionnel)';

  @override
  String get journalAddPhoto => 'Ajouter une photo';

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
  String get journalValidationNotesRequired => 'Veuillez entrer des notes';

  @override
  String get journalValidationFeelingRequired =>
      'Veuillez sélectionner votre ressenti';

  @override
  String get settingsTitle => 'Paramètres';

  @override
  String get settingsLanguage => 'Langue';

  @override
  String get settingsLanguageFrench => 'Français';

  @override
  String get settingsLanguageEnglish => 'English';

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
  String get settingsOpenSourceLicenses => 'Licences open source';

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
  String commonErrorWithDetails(String error) {
    return 'Erreur: $error';
  }

  @override
  String get commonSuccess => 'Opération réussie';

  @override
  String get commonRetry => 'Réessayer';

  @override
  String get commonAll => 'Tous';

  @override
  String get commonNext => 'Suivant';

  @override
  String get commonGotIt => 'Compris !';

  @override
  String get commonEditTooltip => 'Éditer';

  @override
  String get commonDeleteTooltip => 'Supprimer';

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

  @override
  String get navHome => 'Accueil';

  @override
  String get navProducts => 'Produits';

  @override
  String get navRoutines => 'Routines';

  @override
  String get navProgress => 'Suivi';

  @override
  String get tutorialHomeSkinJournalTitle => 'Journal de peau';

  @override
  String get tutorialHomeSkinJournalDescription =>
      'Notez l\'état de votre peau chaque jour.';

  @override
  String get tutorialProductsSearchTitle => 'Recherchez et filtrez';

  @override
  String get tutorialProductsSearchDescription =>
      'Utilisez la barre de recherche ou les filtres par type pour retrouver un produit.';

  @override
  String get tutorialProductsFilterTitle => 'Filtres par catégorie';

  @override
  String get tutorialProductsFilterDescription =>
      'Sélectionnez une catégorie pour afficher uniquement les produits correspondants.';

  @override
  String get tutorialProductsAddTitle => 'Ajoutez les vôtres';

  @override
  String get tutorialProductsAddDescription =>
      'Appuyez sur le bouton + pour ajouter un nouveau produit avec photo.';

  @override
  String get tutorialRoutinesFilterTitle => 'Filtrez vos routines';

  @override
  String get tutorialRoutinesFilterDescription =>
      'Sélectionnez un objectif cutané pour afficher uniquement les routines correspondantes.';

  @override
  String get tutorialRoutinesListTitle => 'Vos routines';

  @override
  String get tutorialRoutinesListDescription =>
      'Chaque routine contient des actions : appliquer un sérum, nettoyer, etc. Activez ou désactivez une routine avec le switch.';

  @override
  String get tutorialRoutinesCreateTitle => 'Créer une nouvelle routine';

  @override
  String get tutorialRoutinesCreateDescription =>
      'Appuyez sur le bouton + pour créer une nouvelle routine personnalisée.';
}
