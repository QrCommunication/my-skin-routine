import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/intl.dart' as intl;

import 'app_localizations_en.dart';
import 'app_localizations_fr.dart';

// ignore_for_file: type=lint

/// Callers can lookup localized strings with an instance of AppLocalizations
/// returned by `AppLocalizations.of(context)`.
///
/// Applications need to include `AppLocalizations.delegate()` in their app's
/// `localizationDelegates` list, and the locales they support in the app's
/// `supportedLocales` list. For example:
///
/// ```dart
/// import 'l10n/app_localizations.dart';
///
/// return MaterialApp(
///   localizationsDelegates: AppLocalizations.localizationsDelegates,
///   supportedLocales: AppLocalizations.supportedLocales,
///   home: MyApplicationHome(),
/// );
/// ```
///
/// ## Update pubspec.yaml
///
/// Please make sure to update your pubspec.yaml to include the following
/// packages:
///
/// ```yaml
/// dependencies:
///   # Internationalization support.
///   flutter_localizations:
///     sdk: flutter
///   intl: any # Use the pinned version from flutter_localizations
///
///   # Rest of dependencies
/// ```
///
/// ## iOS Applications
///
/// iOS applications define key application metadata, including supported
/// locales, in an Info.plist file that is built into the application bundle.
/// To configure the locales supported by your app, you’ll need to edit this
/// file.
///
/// First, open your project’s ios/Runner.xcworkspace Xcode workspace file.
/// Then, in the Project Navigator, open the Info.plist file under the Runner
/// project’s Runner folder.
///
/// Next, select the Information Property List item, select Add Item from the
/// Editor menu, then select Localizations from the pop-up menu.
///
/// Select and expand the newly-created Localizations item then, for each
/// locale your application supports, add a new item and select the locale
/// you wish to add from the pop-up menu in the Value field. This list should
/// be consistent with the languages listed in the AppLocalizations.supportedLocales
/// property.
abstract class AppLocalizations {
  AppLocalizations(String locale)
    : localeName = intl.Intl.canonicalizedLocale(locale.toString());

  final String localeName;

  static AppLocalizations? of(BuildContext context) {
    return Localizations.of<AppLocalizations>(context, AppLocalizations);
  }

  static const LocalizationsDelegate<AppLocalizations> delegate =
      _AppLocalizationsDelegate();

  /// A list of this localizations delegate along with the default localizations
  /// delegates.
  ///
  /// Returns a list of localizations delegates containing this delegate along with
  /// GlobalMaterialLocalizations.delegate, GlobalCupertinoLocalizations.delegate,
  /// and GlobalWidgetsLocalizations.delegate.
  ///
  /// Additional delegates can be added by appending to this list in
  /// MaterialApp. This list does not have to be used at all if a custom list
  /// of delegates is preferred or required.
  static const List<LocalizationsDelegate<dynamic>> localizationsDelegates =
      <LocalizationsDelegate<dynamic>>[
        delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
      ];

  /// A list of this localizations delegate's supported locales.
  static const List<Locale> supportedLocales = <Locale>[
    Locale('en'),
    Locale('fr'),
  ];

  /// No description provided for @onboardingWelcomeTitle.
  ///
  /// In fr, this message translates to:
  /// **'My Skin Routine'**
  String get onboardingWelcomeTitle;

  /// No description provided for @onboardingWelcomeSubtitle.
  ///
  /// In fr, this message translates to:
  /// **'Votre compagnon skincare'**
  String get onboardingWelcomeSubtitle;

  /// No description provided for @onboardingStart.
  ///
  /// In fr, this message translates to:
  /// **'Commencer'**
  String get onboardingStart;

  /// No description provided for @onboardingProfileTitle.
  ///
  /// In fr, this message translates to:
  /// **'Comment vous appelez-vous ?'**
  String get onboardingProfileTitle;

  /// No description provided for @onboardingProfileFirstName.
  ///
  /// In fr, this message translates to:
  /// **'Prénom'**
  String get onboardingProfileFirstName;

  /// No description provided for @onboardingProfileLastName.
  ///
  /// In fr, this message translates to:
  /// **'Nom'**
  String get onboardingProfileLastName;

  /// No description provided for @onboardingContinue.
  ///
  /// In fr, this message translates to:
  /// **'Continuer'**
  String get onboardingContinue;

  /// No description provided for @onboardingProductTitle.
  ///
  /// In fr, this message translates to:
  /// **'Ajoutez votre premier produit'**
  String get onboardingProductTitle;

  /// No description provided for @onboardingProductSubtitle.
  ///
  /// In fr, this message translates to:
  /// **'Vous pourrez en ajouter d\'autres plus tard'**
  String get onboardingProductSubtitle;

  /// No description provided for @onboardingRoutineTitle.
  ///
  /// In fr, this message translates to:
  /// **'Créez votre première routine'**
  String get onboardingRoutineTitle;

  /// No description provided for @onboardingRoutineSubtitle.
  ///
  /// In fr, this message translates to:
  /// **'Organisez vos soins quotidiens'**
  String get onboardingRoutineSubtitle;

  /// No description provided for @onboardingSkip.
  ///
  /// In fr, this message translates to:
  /// **'Passer'**
  String get onboardingSkip;

  /// No description provided for @onboardingDoneTitle.
  ///
  /// In fr, this message translates to:
  /// **'Tout est prêt ! 🎉'**
  String get onboardingDoneTitle;

  /// No description provided for @onboardingDoneWelcome.
  ///
  /// In fr, this message translates to:
  /// **'Bienvenue {firstName} !'**
  String onboardingDoneWelcome(String firstName);

  /// No description provided for @onboardingDoneButton.
  ///
  /// In fr, this message translates to:
  /// **'Découvrir l\'app'**
  String get onboardingDoneButton;

  /// No description provided for @onboardingFirstNameRequired.
  ///
  /// In fr, this message translates to:
  /// **'Le prénom est requis'**
  String get onboardingFirstNameRequired;

  /// No description provided for @onboardingLastNameRequired.
  ///
  /// In fr, this message translates to:
  /// **'Le nom est requis'**
  String get onboardingLastNameRequired;

  /// No description provided for @profileTitle.
  ///
  /// In fr, this message translates to:
  /// **'Profil'**
  String get profileTitle;

  /// No description provided for @profileEditTitle.
  ///
  /// In fr, this message translates to:
  /// **'Modifier le profil'**
  String get profileEditTitle;

  /// No description provided for @greetingPersonalized.
  ///
  /// In fr, this message translates to:
  /// **'Bonjour {firstName} 💜'**
  String greetingPersonalized(String firstName);

  /// No description provided for @greetingDefault.
  ///
  /// In fr, this message translates to:
  /// **'Bonjour 💜'**
  String get greetingDefault;

  /// No description provided for @homeGreeting.
  ///
  /// In fr, this message translates to:
  /// **'Bonjour 💜'**
  String get homeGreeting;

  /// No description provided for @homeToday.
  ///
  /// In fr, this message translates to:
  /// **'Routines du jour'**
  String get homeToday;

  /// No description provided for @homeEmpty.
  ///
  /// In fr, this message translates to:
  /// **'Aucune routine active'**
  String get homeEmpty;

  /// No description provided for @homeEmptySubtitle.
  ///
  /// In fr, this message translates to:
  /// **'Créez votre première routine pour commencer'**
  String get homeEmptySubtitle;

  /// No description provided for @homeCreateFirst.
  ///
  /// In fr, this message translates to:
  /// **'Créer ma première routine'**
  String get homeCreateFirst;

  /// No description provided for @productsTitle.
  ///
  /// In fr, this message translates to:
  /// **'Mes produits'**
  String get productsTitle;

  /// No description provided for @productsEmpty.
  ///
  /// In fr, this message translates to:
  /// **'Aucun produit'**
  String get productsEmpty;

  /// No description provided for @productsEmptySubtitle.
  ///
  /// In fr, this message translates to:
  /// **'Ajoutez vos premiers produits de soin'**
  String get productsEmptySubtitle;

  /// No description provided for @productsSearch.
  ///
  /// In fr, this message translates to:
  /// **'Rechercher un produit'**
  String get productsSearch;

  /// No description provided for @productNew.
  ///
  /// In fr, this message translates to:
  /// **'Nouveau produit'**
  String get productNew;

  /// No description provided for @productEdit.
  ///
  /// In fr, this message translates to:
  /// **'Modifier le produit'**
  String get productEdit;

  /// No description provided for @productFormName.
  ///
  /// In fr, this message translates to:
  /// **'Nom du produit'**
  String get productFormName;

  /// No description provided for @productFormNameHint.
  ///
  /// In fr, this message translates to:
  /// **'Ex: Sérum Vitamine C'**
  String get productFormNameHint;

  /// No description provided for @productFormBrand.
  ///
  /// In fr, this message translates to:
  /// **'Marque'**
  String get productFormBrand;

  /// No description provided for @productFormBrandHint.
  ///
  /// In fr, this message translates to:
  /// **'Ex: CeraVe'**
  String get productFormBrandHint;

  /// No description provided for @productFormType.
  ///
  /// In fr, this message translates to:
  /// **'Type de produit'**
  String get productFormType;

  /// No description provided for @productFormNotes.
  ///
  /// In fr, this message translates to:
  /// **'Notes (optionnel)'**
  String get productFormNotes;

  /// No description provided for @productFormNotesHint.
  ///
  /// In fr, this message translates to:
  /// **'Ajouter des notes sur ce produit...'**
  String get productFormNotesHint;

  /// No description provided for @productFormPhoto.
  ///
  /// In fr, this message translates to:
  /// **'Ajouter une photo'**
  String get productFormPhoto;

  /// No description provided for @productDelete.
  ///
  /// In fr, this message translates to:
  /// **'Supprimer le produit'**
  String get productDelete;

  /// No description provided for @productDeleteConfirm.
  ///
  /// In fr, this message translates to:
  /// **'Êtes-vous sûr de vouloir supprimer \"{name}\" ?'**
  String productDeleteConfirm(String name);

  /// No description provided for @productDeleteWarning.
  ///
  /// In fr, this message translates to:
  /// **'Ce produit est utilisé dans {count} action(s). Les actions seront conservées mais ne seront plus liées à un produit.'**
  String productDeleteWarning(int count);

  /// No description provided for @productDeleteUsageWarning.
  ///
  /// In fr, this message translates to:
  /// **'Attention : Ce produit est utilisé dans {count} action(s). Cela affectera les routines.'**
  String productDeleteUsageWarning(int count);

  /// No description provided for @productDeleted.
  ///
  /// In fr, this message translates to:
  /// **'Produit \"{name}\" supprimé'**
  String productDeleted(String name);

  /// No description provided for @productNameDeleted.
  ///
  /// In fr, this message translates to:
  /// **'{name} a été supprimé'**
  String productNameDeleted(String name);

  /// No description provided for @productUpdatedSuccess.
  ///
  /// In fr, this message translates to:
  /// **'Produit modifié avec succès'**
  String get productUpdatedSuccess;

  /// No description provided for @productCreatedSuccess.
  ///
  /// In fr, this message translates to:
  /// **'Produit créé avec succès'**
  String get productCreatedSuccess;

  /// No description provided for @productNameRequired.
  ///
  /// In fr, this message translates to:
  /// **'Le nom du produit est requis'**
  String get productNameRequired;

  /// No description provided for @productNameMaxLength.
  ///
  /// In fr, this message translates to:
  /// **'Le nom ne doit pas dépasser 100 caractères'**
  String get productNameMaxLength;

  /// No description provided for @productBrandRequired.
  ///
  /// In fr, this message translates to:
  /// **'La marque est requise'**
  String get productBrandRequired;

  /// No description provided for @productBrandMaxLength.
  ///
  /// In fr, this message translates to:
  /// **'La marque ne doit pas dépasser 100 caractères'**
  String get productBrandMaxLength;

  /// No description provided for @productNotUsed.
  ///
  /// In fr, this message translates to:
  /// **'Non utilisé dans aucune routine'**
  String get productNotUsed;

  /// No description provided for @productUsedInCount.
  ///
  /// In fr, this message translates to:
  /// **'Utilisé dans {count} action(s)'**
  String productUsedInCount(int count);

  /// No description provided for @productDeleteError.
  ///
  /// In fr, this message translates to:
  /// **'Erreur lors de la suppression : {error}'**
  String productDeleteError(String error);

  /// No description provided for @routinesTitle.
  ///
  /// In fr, this message translates to:
  /// **'Mes routines'**
  String get routinesTitle;

  /// No description provided for @routinesEmpty.
  ///
  /// In fr, this message translates to:
  /// **'Aucune routine'**
  String get routinesEmpty;

  /// No description provided for @routinesEmptySubtitle.
  ///
  /// In fr, this message translates to:
  /// **'Créez votre première routine de soin'**
  String get routinesEmptySubtitle;

  /// No description provided for @routineNew.
  ///
  /// In fr, this message translates to:
  /// **'Nouvelle routine'**
  String get routineNew;

  /// No description provided for @routineEdit.
  ///
  /// In fr, this message translates to:
  /// **'Éditer Routine'**
  String get routineEdit;

  /// No description provided for @routineFormName.
  ///
  /// In fr, this message translates to:
  /// **'Nom de la routine'**
  String get routineFormName;

  /// No description provided for @routineFormNameHint.
  ///
  /// In fr, this message translates to:
  /// **'ex: Routine du matin'**
  String get routineFormNameHint;

  /// No description provided for @routineFormNameHelperText.
  ///
  /// In fr, this message translates to:
  /// **'Maximum 100 caractères'**
  String get routineFormNameHelperText;

  /// No description provided for @routineFormNameRequired.
  ///
  /// In fr, this message translates to:
  /// **'Le nom est requis'**
  String get routineFormNameRequired;

  /// No description provided for @routineFormNameMaxLength.
  ///
  /// In fr, this message translates to:
  /// **'Maximum 100 caractères'**
  String get routineFormNameMaxLength;

  /// No description provided for @routineFormDescription.
  ///
  /// In fr, this message translates to:
  /// **'Description (optionnel)'**
  String get routineFormDescription;

  /// No description provided for @routineFormDescriptionHint.
  ///
  /// In fr, this message translates to:
  /// **'Décrivez votre routine...'**
  String get routineFormDescriptionHint;

  /// No description provided for @routineFormDescriptionHelperText.
  ///
  /// In fr, this message translates to:
  /// **'Maximum 500 caractères'**
  String get routineFormDescriptionHelperText;

  /// No description provided for @routineFormDescriptionMaxLength.
  ///
  /// In fr, this message translates to:
  /// **'Maximum 500 caractères'**
  String get routineFormDescriptionMaxLength;

  /// No description provided for @routineFormBodyZone.
  ///
  /// In fr, this message translates to:
  /// **'Zone du corps'**
  String get routineFormBodyZone;

  /// No description provided for @routineFormSkinGoal.
  ///
  /// In fr, this message translates to:
  /// **'Objectif'**
  String get routineFormSkinGoal;

  /// No description provided for @routineFormReminder.
  ///
  /// In fr, this message translates to:
  /// **'Heure de rappel'**
  String get routineFormReminder;

  /// No description provided for @routineFormReminderNotSet.
  ///
  /// In fr, this message translates to:
  /// **'Non défini'**
  String get routineFormReminderNotSet;

  /// No description provided for @routineFormActive.
  ///
  /// In fr, this message translates to:
  /// **'Routine active'**
  String get routineFormActive;

  /// No description provided for @routineFormActiveSubtitle.
  ///
  /// In fr, this message translates to:
  /// **'Inclure dans les routines actives'**
  String get routineFormActiveSubtitle;

  /// No description provided for @routineFormUpdate.
  ///
  /// In fr, this message translates to:
  /// **'Mettre à jour'**
  String get routineFormUpdate;

  /// No description provided for @routineDelete.
  ///
  /// In fr, this message translates to:
  /// **'Supprimer la routine'**
  String get routineDelete;

  /// No description provided for @routineDeleteWarning.
  ///
  /// In fr, this message translates to:
  /// **'Cette routine et ses {count} action(s) seront définitivement supprimées.'**
  String routineDeleteWarning(int count);

  /// No description provided for @routineNotFound.
  ///
  /// In fr, this message translates to:
  /// **'Routine non trouvée'**
  String get routineNotFound;

  /// No description provided for @routineNotFoundMessage.
  ///
  /// In fr, this message translates to:
  /// **'La routine n\'existe pas'**
  String get routineNotFoundMessage;

  /// No description provided for @routineActionsCount.
  ///
  /// In fr, this message translates to:
  /// **'Actions ({count})'**
  String routineActionsCount(int count);

  /// No description provided for @actionsTitle.
  ///
  /// In fr, this message translates to:
  /// **'Actions'**
  String get actionsTitle;

  /// No description provided for @actionNew.
  ///
  /// In fr, this message translates to:
  /// **'Nouvelle action'**
  String get actionNew;

  /// No description provided for @actionEdit.
  ///
  /// In fr, this message translates to:
  /// **'Éditer Action'**
  String get actionEdit;

  /// No description provided for @actionFormName.
  ///
  /// In fr, this message translates to:
  /// **'Nom de l\'action'**
  String get actionFormName;

  /// No description provided for @actionFormNameHint.
  ///
  /// In fr, this message translates to:
  /// **'Ex: Appliquer le sérum'**
  String get actionFormNameHint;

  /// No description provided for @actionFormNameRequired.
  ///
  /// In fr, this message translates to:
  /// **'Le nom est requis'**
  String get actionFormNameRequired;

  /// No description provided for @actionFormDescription.
  ///
  /// In fr, this message translates to:
  /// **'Description (optionnel)'**
  String get actionFormDescription;

  /// No description provided for @actionFormDescriptionHint.
  ///
  /// In fr, this message translates to:
  /// **'Ajoutez des détails optionnels'**
  String get actionFormDescriptionHint;

  /// No description provided for @actionFormProduct.
  ///
  /// In fr, this message translates to:
  /// **'Produit associé'**
  String get actionFormProduct;

  /// No description provided for @actionFormProductNone.
  ///
  /// In fr, this message translates to:
  /// **'Aucun'**
  String get actionFormProductNone;

  /// No description provided for @actionFormProductNoneLabel.
  ///
  /// In fr, this message translates to:
  /// **'Aucun produit'**
  String get actionFormProductNoneLabel;

  /// No description provided for @actionFormProductSearch.
  ///
  /// In fr, this message translates to:
  /// **'Rechercher un produit...'**
  String get actionFormProductSearch;

  /// No description provided for @actionFormRecurrence.
  ///
  /// In fr, this message translates to:
  /// **'Récurrence'**
  String get actionFormRecurrence;

  /// No description provided for @actionFormRecurrenceDaily.
  ///
  /// In fr, this message translates to:
  /// **'Quotidien'**
  String get actionFormRecurrenceDaily;

  /// No description provided for @actionFormRecurrenceEveryN.
  ///
  /// In fr, this message translates to:
  /// **'Tous les {count} jours'**
  String actionFormRecurrenceEveryN(int count);

  /// No description provided for @actionFormRecurrenceWeekly.
  ///
  /// In fr, this message translates to:
  /// **'Hebdomadaire'**
  String get actionFormRecurrenceWeekly;

  /// No description provided for @actionFormInterval.
  ///
  /// In fr, this message translates to:
  /// **'Intervalle (jours)'**
  String get actionFormInterval;

  /// No description provided for @actionFormStartDate.
  ///
  /// In fr, this message translates to:
  /// **'Date de référence'**
  String get actionFormStartDate;

  /// No description provided for @actionFormValidationNameRequired.
  ///
  /// In fr, this message translates to:
  /// **'Veuillez entrer un nom pour l\'action'**
  String get actionFormValidationNameRequired;

  /// No description provided for @actionFormSaveAndNew.
  ///
  /// In fr, this message translates to:
  /// **'{save} + Nouvelle action'**
  String actionFormSaveAndNew(String save);

  /// No description provided for @actionDelete.
  ///
  /// In fr, this message translates to:
  /// **'Supprimer l\'action'**
  String get actionDelete;

  /// No description provided for @actionIrreversible.
  ///
  /// In fr, this message translates to:
  /// **'Cette action est irréversible.'**
  String get actionIrreversible;

  /// No description provided for @progressTitle.
  ///
  /// In fr, this message translates to:
  /// **'Suivi'**
  String get progressTitle;

  /// No description provided for @progressCalendar.
  ///
  /// In fr, this message translates to:
  /// **'Calendrier'**
  String get progressCalendar;

  /// No description provided for @progressStreaks.
  ///
  /// In fr, this message translates to:
  /// **'Streaks'**
  String get progressStreaks;

  /// No description provided for @progressJournal.
  ///
  /// In fr, this message translates to:
  /// **'Journal'**
  String get progressJournal;

  /// No description provided for @progressDayDetails.
  ///
  /// In fr, this message translates to:
  /// **'Détails du {date}'**
  String progressDayDetails(String date);

  /// No description provided for @progressNotes.
  ///
  /// In fr, this message translates to:
  /// **'Notes: {notes}'**
  String progressNotes(String notes);

  /// No description provided for @progressPhoto.
  ///
  /// In fr, this message translates to:
  /// **'Photo: {path}'**
  String progressPhoto(String path);

  /// No description provided for @progressFeeling.
  ///
  /// In fr, this message translates to:
  /// **'Feeling: {feeling}/5'**
  String progressFeeling(int feeling);

  /// No description provided for @progressNoEntry.
  ///
  /// In fr, this message translates to:
  /// **'Aucune entrée journal pour ce jour.'**
  String get progressNoEntry;

  /// No description provided for @streakCurrent.
  ///
  /// In fr, this message translates to:
  /// **'Streak actuel'**
  String get streakCurrent;

  /// No description provided for @streakBest.
  ///
  /// In fr, this message translates to:
  /// **'Meilleur streak'**
  String get streakBest;

  /// No description provided for @streakDays.
  ///
  /// In fr, this message translates to:
  /// **'{count} jours'**
  String streakDays(int count);

  /// No description provided for @streakCurrentDays.
  ///
  /// In fr, this message translates to:
  /// **'{label}: {count} jours'**
  String streakCurrentDays(String label, int count);

  /// No description provided for @journalTitle.
  ///
  /// In fr, this message translates to:
  /// **'Journal'**
  String get journalTitle;

  /// No description provided for @journalNew.
  ///
  /// In fr, this message translates to:
  /// **'Nouvelle entrée'**
  String get journalNew;

  /// No description provided for @journalEditTitle.
  ///
  /// In fr, this message translates to:
  /// **'Éditer Entrée Journal'**
  String get journalEditTitle;

  /// No description provided for @journalNewTitle.
  ///
  /// In fr, this message translates to:
  /// **'Nouvelle Entrée Journal'**
  String get journalNewTitle;

  /// No description provided for @journalDate.
  ///
  /// In fr, this message translates to:
  /// **'Date'**
  String get journalDate;

  /// No description provided for @journalPhoto.
  ///
  /// In fr, this message translates to:
  /// **'Photo (optionnel)'**
  String get journalPhoto;

  /// No description provided for @journalAddPhoto.
  ///
  /// In fr, this message translates to:
  /// **'Ajouter une photo'**
  String get journalAddPhoto;

  /// No description provided for @journalFeeling.
  ///
  /// In fr, this message translates to:
  /// **'Comment va ta peau ?'**
  String get journalFeeling;

  /// No description provided for @journalFeelingTerrible.
  ///
  /// In fr, this message translates to:
  /// **'Terrible'**
  String get journalFeelingTerrible;

  /// No description provided for @journalFeelingNotGreat.
  ///
  /// In fr, this message translates to:
  /// **'Pas top'**
  String get journalFeelingNotGreat;

  /// No description provided for @journalFeelingNormal.
  ///
  /// In fr, this message translates to:
  /// **'Normale'**
  String get journalFeelingNormal;

  /// No description provided for @journalFeelingGood.
  ///
  /// In fr, this message translates to:
  /// **'Bien'**
  String get journalFeelingGood;

  /// No description provided for @journalFeelingRadiant.
  ///
  /// In fr, this message translates to:
  /// **'Radieuse'**
  String get journalFeelingRadiant;

  /// No description provided for @journalNotes.
  ///
  /// In fr, this message translates to:
  /// **'Notes'**
  String get journalNotes;

  /// No description provided for @journalNotesHint.
  ///
  /// In fr, this message translates to:
  /// **'Comment est votre peau aujourd\'hui ?'**
  String get journalNotesHint;

  /// No description provided for @journalValidationNotesRequired.
  ///
  /// In fr, this message translates to:
  /// **'Veuillez entrer des notes'**
  String get journalValidationNotesRequired;

  /// No description provided for @journalValidationFeelingRequired.
  ///
  /// In fr, this message translates to:
  /// **'Veuillez sélectionner votre ressenti'**
  String get journalValidationFeelingRequired;

  /// No description provided for @settingsTitle.
  ///
  /// In fr, this message translates to:
  /// **'Paramètres'**
  String get settingsTitle;

  /// No description provided for @settingsLanguage.
  ///
  /// In fr, this message translates to:
  /// **'Langue'**
  String get settingsLanguage;

  /// No description provided for @settingsLanguageFrench.
  ///
  /// In fr, this message translates to:
  /// **'Français'**
  String get settingsLanguageFrench;

  /// No description provided for @settingsLanguageEnglish.
  ///
  /// In fr, this message translates to:
  /// **'English'**
  String get settingsLanguageEnglish;

  /// No description provided for @settingsTheme.
  ///
  /// In fr, this message translates to:
  /// **'Thème'**
  String get settingsTheme;

  /// No description provided for @settingsThemeAuto.
  ///
  /// In fr, this message translates to:
  /// **'Auto'**
  String get settingsThemeAuto;

  /// No description provided for @settingsThemeLight.
  ///
  /// In fr, this message translates to:
  /// **'Clair'**
  String get settingsThemeLight;

  /// No description provided for @settingsThemeDark.
  ///
  /// In fr, this message translates to:
  /// **'Sombre'**
  String get settingsThemeDark;

  /// No description provided for @settingsDynamicColor.
  ///
  /// In fr, this message translates to:
  /// **'Couleurs dynamiques'**
  String get settingsDynamicColor;

  /// No description provided for @settingsDynamicColorSubtitle.
  ///
  /// In fr, this message translates to:
  /// **'Utiliser les couleurs de votre fond d\'écran'**
  String get settingsDynamicColorSubtitle;

  /// No description provided for @settingsExport.
  ///
  /// In fr, this message translates to:
  /// **'Exporter mes données'**
  String get settingsExport;

  /// No description provided for @settingsImport.
  ///
  /// In fr, this message translates to:
  /// **'Importer des données'**
  String get settingsImport;

  /// No description provided for @settingsImportWarning.
  ///
  /// In fr, this message translates to:
  /// **'Ceci remplacera toutes vos données actuelles. Cette action est irréversible.'**
  String get settingsImportWarning;

  /// No description provided for @settingsAbout.
  ///
  /// In fr, this message translates to:
  /// **'À propos'**
  String get settingsAbout;

  /// No description provided for @settingsVersion.
  ///
  /// In fr, this message translates to:
  /// **'Version'**
  String get settingsVersion;

  /// No description provided for @settingsOpenSourceLicenses.
  ///
  /// In fr, this message translates to:
  /// **'Licences open source'**
  String get settingsOpenSourceLicenses;

  /// No description provided for @commonSave.
  ///
  /// In fr, this message translates to:
  /// **'Enregistrer'**
  String get commonSave;

  /// No description provided for @commonCancel.
  ///
  /// In fr, this message translates to:
  /// **'Annuler'**
  String get commonCancel;

  /// No description provided for @commonDelete.
  ///
  /// In fr, this message translates to:
  /// **'Supprimer'**
  String get commonDelete;

  /// No description provided for @commonConfirm.
  ///
  /// In fr, this message translates to:
  /// **'Confirmer'**
  String get commonConfirm;

  /// No description provided for @commonEdit.
  ///
  /// In fr, this message translates to:
  /// **'Modifier'**
  String get commonEdit;

  /// No description provided for @commonClose.
  ///
  /// In fr, this message translates to:
  /// **'Fermer'**
  String get commonClose;

  /// No description provided for @commonCamera.
  ///
  /// In fr, this message translates to:
  /// **'Caméra'**
  String get commonCamera;

  /// No description provided for @commonGallery.
  ///
  /// In fr, this message translates to:
  /// **'Galerie'**
  String get commonGallery;

  /// No description provided for @commonError.
  ///
  /// In fr, this message translates to:
  /// **'Une erreur est survenue'**
  String get commonError;

  /// No description provided for @commonErrorWithDetails.
  ///
  /// In fr, this message translates to:
  /// **'Erreur: {error}'**
  String commonErrorWithDetails(String error);

  /// No description provided for @commonSuccess.
  ///
  /// In fr, this message translates to:
  /// **'Opération réussie'**
  String get commonSuccess;

  /// No description provided for @commonRetry.
  ///
  /// In fr, this message translates to:
  /// **'Réessayer'**
  String get commonRetry;

  /// No description provided for @commonAll.
  ///
  /// In fr, this message translates to:
  /// **'Tous'**
  String get commonAll;

  /// No description provided for @commonNext.
  ///
  /// In fr, this message translates to:
  /// **'Suivant'**
  String get commonNext;

  /// No description provided for @commonGotIt.
  ///
  /// In fr, this message translates to:
  /// **'Compris !'**
  String get commonGotIt;

  /// No description provided for @commonEditTooltip.
  ///
  /// In fr, this message translates to:
  /// **'Éditer'**
  String get commonEditTooltip;

  /// No description provided for @commonDeleteTooltip.
  ///
  /// In fr, this message translates to:
  /// **'Supprimer'**
  String get commonDeleteTooltip;

  /// No description provided for @exportSuccess.
  ///
  /// In fr, this message translates to:
  /// **'Export réussi ✓'**
  String get exportSuccess;

  /// No description provided for @importSuccess.
  ///
  /// In fr, this message translates to:
  /// **'Import réussi ✓'**
  String get importSuccess;

  /// No description provided for @completedOf.
  ///
  /// In fr, this message translates to:
  /// **'{completed}/{total} complétées'**
  String completedOf(int completed, int total);

  /// No description provided for @todayDate.
  ///
  /// In fr, this message translates to:
  /// **'{date}'**
  String todayDate(String date);

  /// No description provided for @navHome.
  ///
  /// In fr, this message translates to:
  /// **'Accueil'**
  String get navHome;

  /// No description provided for @navProducts.
  ///
  /// In fr, this message translates to:
  /// **'Produits'**
  String get navProducts;

  /// No description provided for @navRoutines.
  ///
  /// In fr, this message translates to:
  /// **'Routines'**
  String get navRoutines;

  /// No description provided for @navProgress.
  ///
  /// In fr, this message translates to:
  /// **'Suivi'**
  String get navProgress;

  /// No description provided for @tutorialHomeSkinJournalTitle.
  ///
  /// In fr, this message translates to:
  /// **'Journal de peau'**
  String get tutorialHomeSkinJournalTitle;

  /// No description provided for @tutorialHomeSkinJournalDescription.
  ///
  /// In fr, this message translates to:
  /// **'Notez l\'état de votre peau chaque jour.'**
  String get tutorialHomeSkinJournalDescription;

  /// No description provided for @tutorialProductsSearchTitle.
  ///
  /// In fr, this message translates to:
  /// **'Recherchez et filtrez'**
  String get tutorialProductsSearchTitle;

  /// No description provided for @tutorialProductsSearchDescription.
  ///
  /// In fr, this message translates to:
  /// **'Utilisez la barre de recherche ou les filtres par type pour retrouver un produit.'**
  String get tutorialProductsSearchDescription;

  /// No description provided for @tutorialProductsFilterTitle.
  ///
  /// In fr, this message translates to:
  /// **'Filtres par catégorie'**
  String get tutorialProductsFilterTitle;

  /// No description provided for @tutorialProductsFilterDescription.
  ///
  /// In fr, this message translates to:
  /// **'Sélectionnez une catégorie pour afficher uniquement les produits correspondants.'**
  String get tutorialProductsFilterDescription;

  /// No description provided for @tutorialProductsAddTitle.
  ///
  /// In fr, this message translates to:
  /// **'Ajoutez les vôtres'**
  String get tutorialProductsAddTitle;

  /// No description provided for @tutorialProductsAddDescription.
  ///
  /// In fr, this message translates to:
  /// **'Appuyez sur le bouton + pour ajouter un nouveau produit avec photo.'**
  String get tutorialProductsAddDescription;

  /// No description provided for @tutorialRoutinesFilterTitle.
  ///
  /// In fr, this message translates to:
  /// **'Filtrez vos routines'**
  String get tutorialRoutinesFilterTitle;

  /// No description provided for @tutorialRoutinesFilterDescription.
  ///
  /// In fr, this message translates to:
  /// **'Sélectionnez un objectif cutané pour afficher uniquement les routines correspondantes.'**
  String get tutorialRoutinesFilterDescription;

  /// No description provided for @tutorialRoutinesListTitle.
  ///
  /// In fr, this message translates to:
  /// **'Vos routines'**
  String get tutorialRoutinesListTitle;

  /// No description provided for @tutorialRoutinesListDescription.
  ///
  /// In fr, this message translates to:
  /// **'Chaque routine contient des actions : appliquer un sérum, nettoyer, etc. Activez ou désactivez une routine avec le switch.'**
  String get tutorialRoutinesListDescription;

  /// No description provided for @tutorialRoutinesCreateTitle.
  ///
  /// In fr, this message translates to:
  /// **'Créer une nouvelle routine'**
  String get tutorialRoutinesCreateTitle;

  /// No description provided for @tutorialRoutinesCreateDescription.
  ///
  /// In fr, this message translates to:
  /// **'Appuyez sur le bouton + pour créer une nouvelle routine personnalisée.'**
  String get tutorialRoutinesCreateDescription;
}

class _AppLocalizationsDelegate
    extends LocalizationsDelegate<AppLocalizations> {
  const _AppLocalizationsDelegate();

  @override
  Future<AppLocalizations> load(Locale locale) {
    return SynchronousFuture<AppLocalizations>(lookupAppLocalizations(locale));
  }

  @override
  bool isSupported(Locale locale) =>
      <String>['en', 'fr'].contains(locale.languageCode);

  @override
  bool shouldReload(_AppLocalizationsDelegate old) => false;
}

AppLocalizations lookupAppLocalizations(Locale locale) {
  // Lookup logic when only language code is specified.
  switch (locale.languageCode) {
    case 'en':
      return AppLocalizationsEn();
    case 'fr':
      return AppLocalizationsFr();
  }

  throw FlutterError(
    'AppLocalizations.delegate failed to load unsupported locale "$locale". This is likely '
    'an issue with the localizations generation tool. Please file an issue '
    'on GitHub with a reproducible sample app and the gen-l10n configuration '
    'that was used.',
  );
}
