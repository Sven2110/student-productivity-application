// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for French (`fr`).
class AppLocalizationsFr extends AppLocalizations {
  AppLocalizationsFr([String locale = 'fr']) : super(locale);

  @override
  String get appTitle => 'Productivité Étudiante';

  @override
  String get cancel => 'Annuler';

  @override
  String get save => 'Enregistrer';

  @override
  String get delete => 'Supprimer';

  @override
  String get edit => 'Modifier';

  @override
  String get add => 'Ajouter';

  @override
  String get confirm => 'Confirmer';

  @override
  String get required => 'Champ requis';

  @override
  String get somethingWentWrong => 'Une erreur est survenue';

  @override
  String get unknownUser => 'Utilisateur inconnu';

  @override
  String get loginWelcomeBack => 'Content de vous revoir';

  @override
  String get loginSignInToContinue => 'Connectez-vous pour continuer';

  @override
  String get loginEmailLabel => 'E-mail';

  @override
  String get loginPasswordLabel => 'Mot de passe';

  @override
  String get loginButton => 'Connexion';

  @override
  String get loginNoAccount => 'Vous n\'avez pas de compte ?';

  @override
  String get loginRegisterLink => 'S\'inscrire';

  @override
  String get loginFailed => 'Échec de la connexion';

  @override
  String get validationEmailRequired => 'L\'e-mail est requis';

  @override
  String get validationEmailInvalid => 'Saisissez un e-mail valide';

  @override
  String get validationPasswordRequired => 'Le mot de passe est requis';

  @override
  String get validationPasswordMinLength => 'Minimum 6 caractères';

  @override
  String get registerTitle => 'Créer un compte';

  @override
  String get registerHeading => 'Rejoignez Productivité Étudiante';

  @override
  String get registerConfirmPasswordLabel => 'Confirmer le mot de passe';

  @override
  String get registerButton => 'S\'inscrire';

  @override
  String get registerFailed => 'Échec de l\'inscription';

  @override
  String get validationPasswordsDoNotMatch =>
      'Les mots de passe ne correspondent pas';

  @override
  String get navDashboard => 'Accueil';

  @override
  String get navCalendar => 'Calendrier';

  @override
  String get navTasks => 'Tâches';

  @override
  String get navProjects => 'Projets';

  @override
  String get navSettings => 'Réglages';

  @override
  String get dashboardTitle => 'Accueil';

  @override
  String get dashboardWelcome => 'Bienvenue !';

  @override
  String get dashboardOverview => 'Aperçu';

  @override
  String get dashboardTasksDue => 'Tâches à faire';

  @override
  String get dashboardProgress => 'Progression';

  @override
  String get dashboardQuickAccess => 'Accès rapide';

  @override
  String get dashboardNotes => 'Notes';

  @override
  String dashboardCourseYear(String course, int year) {
    return '$course • Année $year';
  }

  @override
  String get settingsTitle => 'Réglages';

  @override
  String get settingsSignedIn => 'Connecté';

  @override
  String get settingsSecuritySection => 'SÉCURITÉ';

  @override
  String get settingsBiometricUnlock => 'Déverrouillage biométrique';

  @override
  String get settingsBiometricUnlockSubtitle =>
      'Exiger votre empreinte ou votre visage pour ouvrir l\'application';

  @override
  String get settingsLanguageSection => 'LANGUE';

  @override
  String get settingsLanguage => 'Langue';

  @override
  String get settingsLanguageSubtitle =>
      'Choisissez la langue d\'affichage de l\'application';

  @override
  String get settingsChooseLanguage => 'Choisir la langue';

  @override
  String get settingsLogout => 'Déconnexion';

  @override
  String get biometricNotAvailable =>
      'L\'authentification biométrique n\'est pas disponible sur cet appareil.';

  @override
  String get biometricNotEnrolled =>
      'Aucune empreinte ou visage n\'est configuré sur cet appareil. Ajoutez-en un dans les réglages de l\'appareil.';

  @override
  String get biometricAuthCancelled => 'L\'authentification a été annulée.';

  @override
  String get biometricEnableReason =>
      'Authentifiez-vous pour activer le déverrouillage biométrique';

  @override
  String get languageEnglish => 'Anglais';

  @override
  String get languageFrench => 'Français';

  @override
  String get languageSpanish => 'Espagnol';

  @override
  String get languageGerman => 'Allemand';

  @override
  String get languageJapanese => 'Japonais';

  @override
  String get languageChinese => 'Chinois';

  @override
  String get languageSystemDefault => 'Langue du système';

  @override
  String get calendarTitle => 'Calendrier';

  @override
  String get calendarDay => 'Jour';

  @override
  String get calendarWeek => 'Semaine';

  @override
  String get calendarMonth => 'Mois';

  @override
  String get calendarYear => 'Année';

  @override
  String get calendarJumpToToday => 'Aller à aujourd\'hui';

  @override
  String get calendarNothingScheduled => 'Rien de prévu';

  @override
  String get calendarAddClass => 'Ajouter un cours';

  @override
  String get calendarAddTask => 'Ajouter une tâche';

  @override
  String get calendarAddAssignment => 'Ajouter un devoir';

  @override
  String get calendarAddReminder => 'Ajouter un rappel';

  @override
  String get calendarAddEvent => 'Ajouter un événement';

  @override
  String calendarToday(String date) {
    return 'Aujourd\'hui, $date';
  }

  @override
  String calendarDeleteItemTitle(String type) {
    return 'Supprimer $type ?';
  }

  @override
  String calendarDeleteItemBody(String title) {
    return 'Supprimer « $title » ? Cette action est irréversible.';
  }

  @override
  String get calendarCompleted => 'Terminé';

  @override
  String get calendarTaskDue => 'Tâche à rendre';

  @override
  String get calendarClassLabel => 'Cours';

  @override
  String get calendarTaskLabel => 'Tâche';

  @override
  String get calendarAllDay => 'Toute la journée';

  @override
  String eventFormNewTitle(String category) {
    return 'Nouveau : $category';
  }

  @override
  String eventFormEditTitle(String category) {
    return 'Modifier : $category';
  }

  @override
  String get eventFormTitleLabel => 'Titre';

  @override
  String get eventFormDescriptionLabel => 'Description (facultatif)';

  @override
  String get eventFormAllDay => 'Toute la journée';

  @override
  String eventFormStart(String time) {
    return 'Début : $time';
  }

  @override
  String eventFormEnd(String time) {
    return 'Fin : $time';
  }

  @override
  String get eventFormReminder => 'Rappel';

  @override
  String get eventFormColor => 'Couleur';

  @override
  String get eventFormEndBeforeStart =>
      'L\'heure de fin doit être après l\'heure de début';

  @override
  String get categoryAssignment => 'Devoir';

  @override
  String get categoryReminder => 'Rappel';

  @override
  String get categoryEvent => 'Événement';

  @override
  String get classFormNewTitle => 'Ajouter un cours';

  @override
  String get classFormEditTitle => 'Modifier le cours';

  @override
  String get classFormSubject => 'Matière';

  @override
  String get classFormLocation => 'Lieu / Salle';

  @override
  String get classFormDay => 'Jour';

  @override
  String classFormStart(String time) {
    return 'Début : $time';
  }

  @override
  String classFormEnd(String time) {
    return 'Fin : $time';
  }

  @override
  String get classFormColor => 'Couleur';

  @override
  String get reminderNone => 'Aucun rappel';

  @override
  String get reminderMinutes5 => '5 minutes avant';

  @override
  String get reminderMinutes15 => '15 minutes avant';

  @override
  String get reminderMinutes30 => '30 minutes avant';

  @override
  String get reminderHour1 => '1 heure avant';

  @override
  String get reminderDay1 => '1 jour avant';

  @override
  String get reminderRequiresDueDateHelper =>
      'Nécessite une date d\'échéance. Utilise 9h00 si aucune heure n\'est définie.';

  @override
  String get tasksTitle => 'Tâches';

  @override
  String get tasksEmpty =>
      'Aucune tâche pour l\'instant — appuyez sur + pour en ajouter une';

  @override
  String tasksPendingCount(int count) {
    return 'En cours ($count)';
  }

  @override
  String tasksCompletedCount(int count) {
    return 'Terminées ($count)';
  }

  @override
  String taskDue(String date) {
    return 'Échéance $date';
  }

  @override
  String get taskFormNewTitle => 'Nouvelle tâche';

  @override
  String get taskFormEditTitle => 'Modifier la tâche';

  @override
  String get taskFormTitleLabel => 'Titre';

  @override
  String get taskFormDescriptionLabel => 'Description (facultatif)';

  @override
  String get taskFormDueDatePlaceholder => 'Date d\'échéance';

  @override
  String get taskFormDueTimePlaceholder => 'Heure d\'échéance';

  @override
  String get taskFormPriority => 'Priorité';

  @override
  String get priorityLow => 'Basse';

  @override
  String get priorityMedium => 'Moyenne';

  @override
  String get priorityHigh => 'Haute';

  @override
  String get taskFormReminderRequiresDueDate =>
      'Définissez une date d\'échéance pour utiliser un rappel';

  @override
  String get taskDeleteTitle => 'Supprimer la tâche ?';

  @override
  String taskDeleteBody(String title) {
    return 'Supprimer « $title » ?';
  }

  @override
  String get notesTitle => 'Notes';

  @override
  String get notesSearchHint => 'Rechercher des notes...';

  @override
  String get notesEmpty =>
      'Aucune note pour l\'instant — appuyez sur + pour en créer une';

  @override
  String get notesNoMatch => 'Aucune note ne correspond à votre recherche';

  @override
  String get filterAll => 'Toutes';

  @override
  String get noteDeleteTitle => 'Supprimer la note ?';

  @override
  String noteDeleteBody(String title) {
    return 'Supprimer « $title » ?';
  }

  @override
  String get noteUntitled => 'Sans titre';

  @override
  String get noteEditorNewTitle => 'Nouvelle note';

  @override
  String get noteEditorEditTitle => 'Modifier la note';

  @override
  String get noteTitleHint => 'Titre';

  @override
  String get noteSubjectHint => 'Matière / Module';

  @override
  String get noteSubjectOther => 'Autre...';

  @override
  String get noteContentHint => 'Commencez à écrire vos notes...';

  @override
  String get noteEnterTitleError => 'Veuillez saisir un titre';

  @override
  String get noteSaveFailed => 'Échec de l\'enregistrement de la note';

  @override
  String noteTodayAt(String time) {
    return 'Aujourd\'hui, $time';
  }

  @override
  String get progressTitle => 'Progression Académique';

  @override
  String get progressOverview => 'Aperçu';

  @override
  String get progressSyllabusProgress => 'Progression\ndu programme';

  @override
  String get progressTaskCompletion => 'Tâches\nterminées';

  @override
  String get progressSyllabusCoverage => 'Couverture du programme par matière';

  @override
  String get progressEmpty =>
      'Aucune matière suivie pour l\'instant — appuyez sur + pour commencer';

  @override
  String get progressFormTitle => 'Suivre une nouvelle matière';

  @override
  String get progressFormSubject => 'Matière';

  @override
  String get progressFormSubjectOther => 'Autre...';

  @override
  String get progressFormSubjectName => 'Nom de la matière';

  @override
  String get progressFormTotalTopics =>
      'Nombre total de sujets / chapitres au programme';

  @override
  String get progressFormTotalTopicsError => 'Entrez un nombre d\'au moins 1';

  @override
  String get progressFormSubjectRequired =>
      'Veuillez sélectionner ou saisir une matière';

  @override
  String get progressFormStartTracking => 'Commencer le suivi';

  @override
  String progressTopicsCount(int completed, int total, String percent) {
    return '$completed / $total sujets ($percent %)';
  }

  @override
  String get projectsTitle => 'Bibliothèque de projets';

  @override
  String get projectEmpty => 'Aucun projet ici pour l\'instant';

  @override
  String get projectDeleteTitle => 'Supprimer le projet ?';

  @override
  String projectDeleteBody(String title) {
    return 'Supprimer « $title » ?';
  }

  @override
  String get projectFormNewTitle => 'Nouveau projet';

  @override
  String get projectFormEditTitle => 'Modifier le projet';

  @override
  String get projectFormTitleLabel => 'Titre du projet';

  @override
  String get projectFormDescriptionLabel => 'Description (facultatif)';

  @override
  String get projectFormSetDueDate => 'Définir une échéance (facultatif)';

  @override
  String projectFormDuePrefix(String date) {
    return 'Échéance : $date';
  }

  @override
  String get projectFormStatus => 'Statut';

  @override
  String projectDue(String date) {
    return 'Échéance $date';
  }

  @override
  String get projectStatusOngoing => 'En cours';

  @override
  String get projectStatusPending => 'En attente';

  @override
  String get projectStatusCompleted => 'Terminé';

  @override
  String get projectStatusCancelled => 'Annulé';

  @override
  String get profileTitle => 'Modifier le profil';

  @override
  String get profileTakePhoto => 'Prendre une photo';

  @override
  String get profileChooseGallery => 'Choisir dans la galerie';

  @override
  String get profilePhotoSaved => 'Photo de profil enregistrée';

  @override
  String get profilePhotoFailed => 'Échec de l\'enregistrement de la photo';

  @override
  String get profileFullName => 'Nom complet';

  @override
  String get profileFullNameRequired => 'Le nom est requis';

  @override
  String get profileStudentId => 'Numéro d\'étudiant';

  @override
  String get profileCourseMajor => 'Filière / Spécialité';

  @override
  String get profileYearOfStudy => 'Année d\'études';

  @override
  String profileYearN(int n) {
    return 'Année $n';
  }

  @override
  String get profileSaveChanges => 'Enregistrer les modifications';

  @override
  String get profileUpdated => 'Profil mis à jour';

  @override
  String get profileUpdateFailed => 'Échec de la mise à jour du profil';

  @override
  String get attachmentsTitle => 'Pièces jointes';

  @override
  String get attachmentsAdd => 'Ajouter';

  @override
  String get attachmentsNone => 'Aucune pièce jointe pour l\'instant';

  @override
  String attachmentsPendingSuffix(String name) {
    return '$name (en attente)';
  }

  @override
  String attachmentsOpenFailed(String message) {
    return 'Impossible d\'ouvrir le fichier : $message';
  }

  @override
  String get attachTakePhoto => 'Prendre une photo';

  @override
  String get attachChooseGallery => 'Choisir dans la galerie';

  @override
  String get attachChooseFile => 'Choisir un fichier';

  @override
  String get appLockedTitle => 'Application verrouillée';

  @override
  String get appLockedSubtitle =>
      'Déverrouillez avec votre empreinte ou votre visage pour continuer';

  @override
  String get appLockUnlockButton => 'Déverrouiller';

  @override
  String get appLockAuthenticating => 'Authentification…';

  @override
  String appLockAuthReason(String appName) {
    return 'Authentifiez-vous pour déverrouiller $appName';
  }

  @override
  String get errorLoadTasks => 'Échec du chargement des tâches';

  @override
  String get errorAddTask => 'Échec de l\'ajout de la tâche';

  @override
  String get errorUpdateTask => 'Échec de la mise à jour de la tâche';

  @override
  String get errorDeleteTask => 'Échec de la suppression de la tâche';

  @override
  String get errorLoadNotes => 'Échec du chargement des notes';

  @override
  String get errorAddNote => 'Échec de l\'ajout de la note';

  @override
  String get errorUpdateNote => 'Échec de la mise à jour de la note';

  @override
  String get errorDeleteNote => 'Échec de la suppression de la note';

  @override
  String get errorLoadProjects => 'Échec du chargement des projets';

  @override
  String get errorAddProject => 'Échec de l\'ajout du projet';

  @override
  String get errorUpdateProject => 'Échec de la mise à jour du projet';

  @override
  String get errorDeleteProject => 'Échec de la suppression du projet';

  @override
  String get errorLoadEvents =>
      'Échec du chargement des événements du calendrier';

  @override
  String get errorAddEvent => 'Échec de l\'ajout de l\'événement';

  @override
  String get errorUpdateEvent => 'Échec de la mise à jour de l\'événement';

  @override
  String get errorDeleteEvent => 'Échec de la suppression de l\'événement';

  @override
  String get errorLoadProgress => 'Échec du chargement de la progression';

  @override
  String get errorAddModule => 'Échec de l\'ajout de la matière';

  @override
  String get errorUpdateModule => 'Échec de la mise à jour de la progression';

  @override
  String get errorDeleteModule => 'Échec de la suppression de la matière';

  @override
  String get errorLoadProfile => 'Échec du chargement du profil';

  @override
  String get errorSaveProfile => 'Échec de l\'enregistrement du profil';

  @override
  String get errorSavePhoto => 'Échec de l\'enregistrement de la photo';

  @override
  String get errorLoadTimetable => 'Échec du chargement de l\'emploi du temps';

  @override
  String get errorAddClass => 'Échec de l\'ajout du cours';

  @override
  String get errorUpdateClass => 'Échec de la mise à jour du cours';

  @override
  String get errorDeleteClass => 'Échec de la suppression du cours';

  @override
  String get errorUpdateAttachments =>
      'Échec de la mise à jour des pièces jointes';
}
