// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for German (`de`).
class AppLocalizationsDe extends AppLocalizations {
  AppLocalizationsDe([String locale = 'de']) : super(locale);

  @override
  String get appTitle => 'Studenten-Produktivität';

  @override
  String get cancel => 'Abbrechen';

  @override
  String get save => 'Speichern';

  @override
  String get delete => 'Löschen';

  @override
  String get edit => 'Bearbeiten';

  @override
  String get add => 'Hinzufügen';

  @override
  String get confirm => 'Bestätigen';

  @override
  String get required => 'Erforderlich';

  @override
  String get somethingWentWrong => 'Etwas ist schiefgelaufen';

  @override
  String get unknownUser => 'Unbekannter Nutzer';

  @override
  String get loginWelcomeBack => 'Willkommen zurück';

  @override
  String get loginSignInToContinue => 'Melde dich an, um fortzufahren';

  @override
  String get loginEmailLabel => 'E-Mail';

  @override
  String get loginPasswordLabel => 'Passwort';

  @override
  String get loginButton => 'Anmelden';

  @override
  String get loginNoAccount => 'Noch kein Konto?';

  @override
  String get loginRegisterLink => 'Registrieren';

  @override
  String get loginFailed => 'Anmeldung fehlgeschlagen';

  @override
  String get validationEmailRequired => 'E-Mail ist erforderlich';

  @override
  String get validationEmailInvalid => 'Gib eine gültige E-Mail ein';

  @override
  String get validationPasswordRequired => 'Passwort ist erforderlich';

  @override
  String get validationPasswordMinLength => 'Mindestens 6 Zeichen';

  @override
  String get registerTitle => 'Konto erstellen';

  @override
  String get registerHeading => 'Tritt Studenten-Produktivität bei';

  @override
  String get registerConfirmPasswordLabel => 'Passwort bestätigen';

  @override
  String get registerButton => 'Registrieren';

  @override
  String get registerFailed => 'Registrierung fehlgeschlagen';

  @override
  String get validationPasswordsDoNotMatch =>
      'Passwörter stimmen nicht überein';

  @override
  String get navDashboard => 'Übersicht';

  @override
  String get navCalendar => 'Kalender';

  @override
  String get navTasks => 'Aufgaben';

  @override
  String get navProjects => 'Projekte';

  @override
  String get navSettings => 'Einstellungen';

  @override
  String get dashboardTitle => 'Übersicht';

  @override
  String get dashboardWelcome => 'Willkommen!';

  @override
  String get dashboardOverview => 'Überblick';

  @override
  String get dashboardTasksDue => 'Fällige Aufgaben';

  @override
  String get dashboardProgress => 'Fortschritt';

  @override
  String get dashboardQuickAccess => 'Schnellzugriff';

  @override
  String get dashboardNotes => 'Notizen';

  @override
  String dashboardCourseYear(String course, int year) {
    return '$course • Jahr $year';
  }

  @override
  String get settingsTitle => 'Einstellungen';

  @override
  String get settingsSignedIn => 'Angemeldet';

  @override
  String get settingsSecuritySection => 'SICHERHEIT';

  @override
  String get settingsBiometricUnlock => 'Biometrische Entsperrung';

  @override
  String get settingsBiometricUnlockSubtitle =>
      'Fingerabdruck oder Gesicht zum Öffnen der App verlangen';

  @override
  String get settingsLanguageSection => 'SPRACHE';

  @override
  String get settingsLanguage => 'Sprache';

  @override
  String get settingsLanguageSubtitle => 'Wähle die Anzeigesprache der App';

  @override
  String get settingsChooseLanguage => 'Sprache auswählen';

  @override
  String get settingsLogout => 'Abmelden';

  @override
  String get biometricNotAvailable =>
      'Biometrische Authentifizierung ist auf diesem Gerät nicht verfügbar.';

  @override
  String get biometricNotEnrolled =>
      'Auf diesem Gerät ist noch kein Fingerabdruck oder Gesicht eingerichtet. Richte zuerst eines in den Geräteeinstellungen ein.';

  @override
  String get biometricAuthCancelled =>
      'Die Authentifizierung wurde abgebrochen.';

  @override
  String get biometricEnableReason =>
      'Authentifiziere dich, um die biometrische Entsperrung zu aktivieren';

  @override
  String get languageEnglish => 'Englisch';

  @override
  String get languageFrench => 'Französisch';

  @override
  String get languageSpanish => 'Spanisch';

  @override
  String get languageGerman => 'Deutsch';

  @override
  String get languageJapanese => 'Japanisch';

  @override
  String get languageChinese => 'Chinesisch';

  @override
  String get languageSystemDefault => 'Systemsprache';

  @override
  String get calendarTitle => 'Kalender';

  @override
  String get calendarDay => 'Tag';

  @override
  String get calendarWeek => 'Woche';

  @override
  String get calendarMonth => 'Monat';

  @override
  String get calendarYear => 'Jahr';

  @override
  String get calendarJumpToToday => 'Zu heute springen';

  @override
  String get calendarNothingScheduled => 'Nichts geplant';

  @override
  String get calendarAddClass => 'Kurs hinzufügen';

  @override
  String get calendarAddTask => 'Aufgabe hinzufügen';

  @override
  String get calendarAddAssignment => 'Hausaufgabe hinzufügen';

  @override
  String get calendarAddReminder => 'Erinnerung hinzufügen';

  @override
  String get calendarAddEvent => 'Termin hinzufügen';

  @override
  String calendarToday(String date) {
    return 'Heute, $date';
  }

  @override
  String calendarDeleteItemTitle(String type) {
    return '$type löschen?';
  }

  @override
  String calendarDeleteItemBody(String title) {
    return '„$title“ entfernen? Dies kann nicht rückgängig gemacht werden.';
  }

  @override
  String get calendarCompleted => 'Erledigt';

  @override
  String get calendarTaskDue => 'Aufgabe fällig';

  @override
  String get calendarClassLabel => 'Kurs';

  @override
  String get calendarTaskLabel => 'Aufgabe';

  @override
  String get calendarAllDay => 'Ganztägig';

  @override
  String eventFormNewTitle(String category) {
    return 'Neu: $category';
  }

  @override
  String eventFormEditTitle(String category) {
    return 'Bearbeiten: $category';
  }

  @override
  String get eventFormTitleLabel => 'Titel';

  @override
  String get eventFormDescriptionLabel => 'Beschreibung (optional)';

  @override
  String get eventFormAllDay => 'Ganztägig';

  @override
  String eventFormStart(String time) {
    return 'Beginn: $time';
  }

  @override
  String eventFormEnd(String time) {
    return 'Ende: $time';
  }

  @override
  String get eventFormReminder => 'Erinnerung';

  @override
  String get eventFormColor => 'Farbe';

  @override
  String get eventFormEndBeforeStart =>
      'Die Endzeit muss nach der Startzeit liegen';

  @override
  String get categoryAssignment => 'Hausaufgabe';

  @override
  String get categoryReminder => 'Erinnerung';

  @override
  String get categoryEvent => 'Termin';

  @override
  String get classFormNewTitle => 'Kurs hinzufügen';

  @override
  String get classFormEditTitle => 'Kurs bearbeiten';

  @override
  String get classFormSubject => 'Fach';

  @override
  String get classFormLocation => 'Ort / Raum';

  @override
  String get classFormDay => 'Tag';

  @override
  String classFormStart(String time) {
    return 'Beginn: $time';
  }

  @override
  String classFormEnd(String time) {
    return 'Ende: $time';
  }

  @override
  String get classFormColor => 'Farbe';

  @override
  String get reminderNone => 'Keine Erinnerung';

  @override
  String get reminderMinutes5 => '5 Minuten vorher';

  @override
  String get reminderMinutes15 => '15 Minuten vorher';

  @override
  String get reminderMinutes30 => '30 Minuten vorher';

  @override
  String get reminderHour1 => '1 Stunde vorher';

  @override
  String get reminderDay1 => '1 Tag vorher';

  @override
  String get reminderRequiresDueDateHelper =>
      'Erfordert ein Fälligkeitsdatum. Verwendet 9:00 Uhr, falls keine Uhrzeit festgelegt ist.';

  @override
  String get tasksTitle => 'Aufgaben';

  @override
  String get tasksEmpty =>
      'Noch keine Aufgaben — tippe auf +, um eine hinzuzufügen';

  @override
  String tasksPendingCount(int count) {
    return 'Ausstehend ($count)';
  }

  @override
  String tasksCompletedCount(int count) {
    return 'Erledigt ($count)';
  }

  @override
  String taskDue(String date) {
    return 'Fällig am $date';
  }

  @override
  String get taskFormNewTitle => 'Neue Aufgabe';

  @override
  String get taskFormEditTitle => 'Aufgabe bearbeiten';

  @override
  String get taskFormTitleLabel => 'Titel';

  @override
  String get taskFormDescriptionLabel => 'Beschreibung (optional)';

  @override
  String get taskFormDueDatePlaceholder => 'Fälligkeitsdatum';

  @override
  String get taskFormDueTimePlaceholder => 'Fälligkeitszeit';

  @override
  String get taskFormPriority => 'Priorität';

  @override
  String get priorityLow => 'Niedrig';

  @override
  String get priorityMedium => 'Mittel';

  @override
  String get priorityHigh => 'Hoch';

  @override
  String get taskFormReminderRequiresDueDate =>
      'Lege ein Fälligkeitsdatum fest, um eine Erinnerung zu nutzen';

  @override
  String get taskDeleteTitle => 'Aufgabe löschen?';

  @override
  String taskDeleteBody(String title) {
    return '„$title“ entfernen?';
  }

  @override
  String get notesTitle => 'Notizen';

  @override
  String get notesSearchHint => 'Notizen durchsuchen...';

  @override
  String get notesEmpty =>
      'Noch keine Notizen — tippe auf +, um eine zu erstellen';

  @override
  String get notesNoMatch => 'Keine Notizen entsprechen deiner Suche';

  @override
  String get filterAll => 'Alle';

  @override
  String get noteDeleteTitle => 'Notiz löschen?';

  @override
  String noteDeleteBody(String title) {
    return '„$title“ entfernen?';
  }

  @override
  String get noteUntitled => 'Ohne Titel';

  @override
  String get noteEditorNewTitle => 'Neue Notiz';

  @override
  String get noteEditorEditTitle => 'Notiz bearbeiten';

  @override
  String get noteTitleHint => 'Titel';

  @override
  String get noteSubjectHint => 'Fach / Modul';

  @override
  String get noteSubjectOther => 'Andere...';

  @override
  String get noteContentHint => 'Beginne, deine Notizen zu schreiben...';

  @override
  String get noteEnterTitleError => 'Bitte gib einen Titel ein';

  @override
  String get noteSaveFailed => 'Notiz konnte nicht gespeichert werden';

  @override
  String noteTodayAt(String time) {
    return 'Heute, $time';
  }

  @override
  String get progressTitle => 'Akademischer Fortschritt';

  @override
  String get progressOverview => 'Überblick';

  @override
  String get progressSyllabusProgress => 'Lehrplan-\nfortschritt';

  @override
  String get progressTaskCompletion => 'Erledigte\nAufgaben';

  @override
  String get progressSyllabusCoverage => 'Lehrplanabdeckung nach Fach';

  @override
  String get progressEmpty =>
      'Noch keine Fächer erfasst — tippe auf +, um zu beginnen';

  @override
  String get progressFormTitle => 'Neues Fach verfolgen';

  @override
  String get progressFormSubject => 'Fach';

  @override
  String get progressFormSubjectOther => 'Andere...';

  @override
  String get progressFormSubjectName => 'Fachname';

  @override
  String get progressFormTotalTopics =>
      'Gesamtzahl der Themen / Kapitel im Lehrplan';

  @override
  String get progressFormTotalTopicsError =>
      'Gib eine Zahl von mindestens 1 ein';

  @override
  String get progressFormSubjectRequired => 'Bitte wähle oder gib ein Fach ein';

  @override
  String get progressFormStartTracking => 'Verfolgung starten';

  @override
  String progressTopicsCount(int completed, int total, String percent) {
    return '$completed / $total Themen ($percent %)';
  }

  @override
  String get projectsTitle => 'Projektbibliothek';

  @override
  String get projectEmpty => 'Hier noch keine Projekte';

  @override
  String get projectDeleteTitle => 'Projekt löschen?';

  @override
  String projectDeleteBody(String title) {
    return '„$title“ entfernen?';
  }

  @override
  String get projectFormNewTitle => 'Neues Projekt';

  @override
  String get projectFormEditTitle => 'Projekt bearbeiten';

  @override
  String get projectFormTitleLabel => 'Projekttitel';

  @override
  String get projectFormDescriptionLabel => 'Beschreibung (optional)';

  @override
  String get projectFormSetDueDate => 'Fälligkeitsdatum festlegen (optional)';

  @override
  String projectFormDuePrefix(String date) {
    return 'Fällig: $date';
  }

  @override
  String get projectFormStatus => 'Status';

  @override
  String projectDue(String date) {
    return 'Fällig am $date';
  }

  @override
  String get projectStatusOngoing => 'Laufend';

  @override
  String get projectStatusPending => 'Ausstehend';

  @override
  String get projectStatusCompleted => 'Abgeschlossen';

  @override
  String get projectStatusCancelled => 'Abgebrochen';

  @override
  String get profileTitle => 'Profil bearbeiten';

  @override
  String get profileTakePhoto => 'Foto aufnehmen';

  @override
  String get profileChooseGallery => 'Aus Galerie wählen';

  @override
  String get profilePhotoSaved => 'Profilfoto gespeichert';

  @override
  String get profilePhotoFailed => 'Foto konnte nicht gespeichert werden';

  @override
  String get profileFullName => 'Vollständiger Name';

  @override
  String get profileFullNameRequired => 'Name ist erforderlich';

  @override
  String get profileStudentId => 'Matrikelnummer';

  @override
  String get profileCourseMajor => 'Studiengang / Hauptfach';

  @override
  String get profileYearOfStudy => 'Studienjahr';

  @override
  String profileYearN(int n) {
    return 'Jahr $n';
  }

  @override
  String get profileSaveChanges => 'Änderungen speichern';

  @override
  String get profileUpdated => 'Profil aktualisiert';

  @override
  String get profileUpdateFailed => 'Profil konnte nicht aktualisiert werden';

  @override
  String get attachmentsTitle => 'Anhänge';

  @override
  String get attachmentsAdd => 'Hinzufügen';

  @override
  String get attachmentsNone => 'Noch keine Anhänge';

  @override
  String attachmentsPendingSuffix(String name) {
    return '$name (ausstehend)';
  }

  @override
  String attachmentsOpenFailed(String message) {
    return 'Datei konnte nicht geöffnet werden: $message';
  }

  @override
  String get attachTakePhoto => 'Foto aufnehmen';

  @override
  String get attachChooseGallery => 'Aus Galerie wählen';

  @override
  String get attachChooseFile => 'Datei auswählen';

  @override
  String get appLockedTitle => 'App gesperrt';

  @override
  String get appLockedSubtitle =>
      'Entsperre mit Fingerabdruck oder Gesicht, um fortzufahren';

  @override
  String get appLockUnlockButton => 'Entsperren';

  @override
  String get appLockAuthenticating => 'Authentifizierung…';

  @override
  String appLockAuthReason(String appName) {
    return 'Authentifiziere dich, um $appName zu entsperren';
  }

  @override
  String get errorLoadTasks => 'Aufgaben konnten nicht geladen werden';

  @override
  String get errorAddTask => 'Aufgabe konnte nicht hinzugefügt werden';

  @override
  String get errorUpdateTask => 'Aufgabe konnte nicht aktualisiert werden';

  @override
  String get errorDeleteTask => 'Aufgabe konnte nicht gelöscht werden';

  @override
  String get errorLoadNotes => 'Notizen konnten nicht geladen werden';

  @override
  String get errorAddNote => 'Notiz konnte nicht hinzugefügt werden';

  @override
  String get errorUpdateNote => 'Notiz konnte nicht aktualisiert werden';

  @override
  String get errorDeleteNote => 'Notiz konnte nicht gelöscht werden';

  @override
  String get errorLoadProjects => 'Projekte konnten nicht geladen werden';

  @override
  String get errorAddProject => 'Projekt konnte nicht hinzugefügt werden';

  @override
  String get errorUpdateProject => 'Projekt konnte nicht aktualisiert werden';

  @override
  String get errorDeleteProject => 'Projekt konnte nicht gelöscht werden';

  @override
  String get errorLoadEvents => 'Kalendertermine konnten nicht geladen werden';

  @override
  String get errorAddEvent => 'Termin konnte nicht hinzugefügt werden';

  @override
  String get errorUpdateEvent => 'Termin konnte nicht aktualisiert werden';

  @override
  String get errorDeleteEvent => 'Termin konnte nicht gelöscht werden';

  @override
  String get errorLoadProgress => 'Fortschritt konnte nicht geladen werden';

  @override
  String get errorAddModule => 'Fach konnte nicht hinzugefügt werden';

  @override
  String get errorUpdateModule =>
      'Fortschritt konnte nicht aktualisiert werden';

  @override
  String get errorDeleteModule => 'Fach konnte nicht gelöscht werden';

  @override
  String get errorLoadProfile => 'Profil konnte nicht geladen werden';

  @override
  String get errorSaveProfile => 'Profil konnte nicht gespeichert werden';

  @override
  String get errorSavePhoto => 'Foto konnte nicht gespeichert werden';

  @override
  String get errorLoadTimetable => 'Stundenplan konnte nicht geladen werden';

  @override
  String get errorAddClass => 'Kurs konnte nicht hinzugefügt werden';

  @override
  String get errorUpdateClass => 'Kurs konnte nicht aktualisiert werden';

  @override
  String get errorDeleteClass => 'Kurs konnte nicht gelöscht werden';

  @override
  String get errorUpdateAttachments =>
      'Anhänge konnten nicht aktualisiert werden';
}
