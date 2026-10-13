import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/intl.dart' as intl;

import 'app_localizations_de.dart';
import 'app_localizations_en.dart';
import 'app_localizations_es.dart';
import 'app_localizations_fr.dart';
import 'app_localizations_ja.dart';
import 'app_localizations_zh.dart';

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
    Locale('de'),
    Locale('en'),
    Locale('es'),
    Locale('fr'),
    Locale('ja'),
    Locale('zh'),
  ];

  /// Application title, shown in the OS task switcher
  ///
  /// In en, this message translates to:
  /// **'Student Productivity'**
  String get appTitle;

  /// No description provided for @cancel.
  ///
  /// In en, this message translates to:
  /// **'Cancel'**
  String get cancel;

  /// No description provided for @save.
  ///
  /// In en, this message translates to:
  /// **'Save'**
  String get save;

  /// No description provided for @delete.
  ///
  /// In en, this message translates to:
  /// **'Delete'**
  String get delete;

  /// No description provided for @edit.
  ///
  /// In en, this message translates to:
  /// **'Edit'**
  String get edit;

  /// No description provided for @add.
  ///
  /// In en, this message translates to:
  /// **'Add'**
  String get add;

  /// No description provided for @confirm.
  ///
  /// In en, this message translates to:
  /// **'Confirm'**
  String get confirm;

  /// No description provided for @required.
  ///
  /// In en, this message translates to:
  /// **'Required'**
  String get required;

  /// No description provided for @somethingWentWrong.
  ///
  /// In en, this message translates to:
  /// **'Something went wrong'**
  String get somethingWentWrong;

  /// No description provided for @unknownUser.
  ///
  /// In en, this message translates to:
  /// **'Unknown user'**
  String get unknownUser;

  /// No description provided for @loginWelcomeBack.
  ///
  /// In en, this message translates to:
  /// **'Welcome Back'**
  String get loginWelcomeBack;

  /// No description provided for @loginSignInToContinue.
  ///
  /// In en, this message translates to:
  /// **'Sign in to continue'**
  String get loginSignInToContinue;

  /// No description provided for @loginEmailLabel.
  ///
  /// In en, this message translates to:
  /// **'Email'**
  String get loginEmailLabel;

  /// No description provided for @loginPasswordLabel.
  ///
  /// In en, this message translates to:
  /// **'Password'**
  String get loginPasswordLabel;

  /// No description provided for @loginButton.
  ///
  /// In en, this message translates to:
  /// **'Login'**
  String get loginButton;

  /// No description provided for @loginNoAccount.
  ///
  /// In en, this message translates to:
  /// **'Don\'t have an account?'**
  String get loginNoAccount;

  /// No description provided for @loginRegisterLink.
  ///
  /// In en, this message translates to:
  /// **'Register'**
  String get loginRegisterLink;

  /// No description provided for @loginFailed.
  ///
  /// In en, this message translates to:
  /// **'Login failed'**
  String get loginFailed;

  /// No description provided for @validationEmailRequired.
  ///
  /// In en, this message translates to:
  /// **'Email is required'**
  String get validationEmailRequired;

  /// No description provided for @validationEmailInvalid.
  ///
  /// In en, this message translates to:
  /// **'Enter a valid email'**
  String get validationEmailInvalid;

  /// No description provided for @validationPasswordRequired.
  ///
  /// In en, this message translates to:
  /// **'Password is required'**
  String get validationPasswordRequired;

  /// No description provided for @validationPasswordMinLength.
  ///
  /// In en, this message translates to:
  /// **'Minimum 6 characters'**
  String get validationPasswordMinLength;

  /// No description provided for @registerTitle.
  ///
  /// In en, this message translates to:
  /// **'Create Account'**
  String get registerTitle;

  /// No description provided for @registerHeading.
  ///
  /// In en, this message translates to:
  /// **'Join Student Productivity'**
  String get registerHeading;

  /// No description provided for @registerConfirmPasswordLabel.
  ///
  /// In en, this message translates to:
  /// **'Confirm Password'**
  String get registerConfirmPasswordLabel;

  /// No description provided for @registerButton.
  ///
  /// In en, this message translates to:
  /// **'Register'**
  String get registerButton;

  /// No description provided for @registerFailed.
  ///
  /// In en, this message translates to:
  /// **'Registration failed'**
  String get registerFailed;

  /// No description provided for @validationPasswordsDoNotMatch.
  ///
  /// In en, this message translates to:
  /// **'Passwords do not match'**
  String get validationPasswordsDoNotMatch;

  /// No description provided for @navDashboard.
  ///
  /// In en, this message translates to:
  /// **'Dashboard'**
  String get navDashboard;

  /// No description provided for @navCalendar.
  ///
  /// In en, this message translates to:
  /// **'Calendar'**
  String get navCalendar;

  /// No description provided for @navTasks.
  ///
  /// In en, this message translates to:
  /// **'Tasks'**
  String get navTasks;

  /// No description provided for @navProjects.
  ///
  /// In en, this message translates to:
  /// **'Projects'**
  String get navProjects;

  /// No description provided for @navSettings.
  ///
  /// In en, this message translates to:
  /// **'Settings'**
  String get navSettings;

  /// No description provided for @dashboardTitle.
  ///
  /// In en, this message translates to:
  /// **'Dashboard'**
  String get dashboardTitle;

  /// No description provided for @dashboardWelcome.
  ///
  /// In en, this message translates to:
  /// **'Welcome!'**
  String get dashboardWelcome;

  /// No description provided for @dashboardOverview.
  ///
  /// In en, this message translates to:
  /// **'Overview'**
  String get dashboardOverview;

  /// No description provided for @dashboardTasksDue.
  ///
  /// In en, this message translates to:
  /// **'Tasks Due'**
  String get dashboardTasksDue;

  /// No description provided for @dashboardProgress.
  ///
  /// In en, this message translates to:
  /// **'Progress'**
  String get dashboardProgress;

  /// No description provided for @dashboardQuickAccess.
  ///
  /// In en, this message translates to:
  /// **'Quick Access'**
  String get dashboardQuickAccess;

  /// No description provided for @dashboardNotes.
  ///
  /// In en, this message translates to:
  /// **'Notes'**
  String get dashboardNotes;

  /// No description provided for @dashboardCourseYear.
  ///
  /// In en, this message translates to:
  /// **'{course} • Year {year}'**
  String dashboardCourseYear(String course, int year);

  /// No description provided for @settingsTitle.
  ///
  /// In en, this message translates to:
  /// **'Settings'**
  String get settingsTitle;

  /// No description provided for @settingsSignedIn.
  ///
  /// In en, this message translates to:
  /// **'Signed in'**
  String get settingsSignedIn;

  /// No description provided for @settingsSecuritySection.
  ///
  /// In en, this message translates to:
  /// **'SECURITY'**
  String get settingsSecuritySection;

  /// No description provided for @settingsBiometricUnlock.
  ///
  /// In en, this message translates to:
  /// **'Biometric Unlock'**
  String get settingsBiometricUnlock;

  /// No description provided for @settingsBiometricUnlockSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Require your fingerprint or face to open the app'**
  String get settingsBiometricUnlockSubtitle;

  /// No description provided for @settingsLanguageSection.
  ///
  /// In en, this message translates to:
  /// **'LANGUAGE'**
  String get settingsLanguageSection;

  /// No description provided for @settingsLanguage.
  ///
  /// In en, this message translates to:
  /// **'Language'**
  String get settingsLanguage;

  /// No description provided for @settingsLanguageSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Choose the app\'s display language'**
  String get settingsLanguageSubtitle;

  /// No description provided for @settingsChooseLanguage.
  ///
  /// In en, this message translates to:
  /// **'Choose language'**
  String get settingsChooseLanguage;

  /// No description provided for @settingsLogout.
  ///
  /// In en, this message translates to:
  /// **'Logout'**
  String get settingsLogout;

  /// No description provided for @biometricNotAvailable.
  ///
  /// In en, this message translates to:
  /// **'Biometric authentication is not available on this device.'**
  String get biometricNotAvailable;

  /// No description provided for @biometricNotEnrolled.
  ///
  /// In en, this message translates to:
  /// **'No fingerprint or face is set up on this device yet. Add one in your device settings first.'**
  String get biometricNotEnrolled;

  /// No description provided for @biometricAuthCancelled.
  ///
  /// In en, this message translates to:
  /// **'Authentication was cancelled.'**
  String get biometricAuthCancelled;

  /// No description provided for @biometricEnableReason.
  ///
  /// In en, this message translates to:
  /// **'Authenticate to enable biometric unlock'**
  String get biometricEnableReason;

  /// No description provided for @languageEnglish.
  ///
  /// In en, this message translates to:
  /// **'English'**
  String get languageEnglish;

  /// No description provided for @languageFrench.
  ///
  /// In en, this message translates to:
  /// **'French'**
  String get languageFrench;

  /// No description provided for @languageSpanish.
  ///
  /// In en, this message translates to:
  /// **'Spanish'**
  String get languageSpanish;

  /// No description provided for @languageGerman.
  ///
  /// In en, this message translates to:
  /// **'German'**
  String get languageGerman;

  /// No description provided for @languageJapanese.
  ///
  /// In en, this message translates to:
  /// **'Japanese'**
  String get languageJapanese;

  /// No description provided for @languageChinese.
  ///
  /// In en, this message translates to:
  /// **'Chinese'**
  String get languageChinese;

  /// No description provided for @languageSystemDefault.
  ///
  /// In en, this message translates to:
  /// **'System default'**
  String get languageSystemDefault;

  /// No description provided for @calendarTitle.
  ///
  /// In en, this message translates to:
  /// **'Calendar'**
  String get calendarTitle;

  /// No description provided for @calendarDay.
  ///
  /// In en, this message translates to:
  /// **'Day'**
  String get calendarDay;

  /// No description provided for @calendarWeek.
  ///
  /// In en, this message translates to:
  /// **'Week'**
  String get calendarWeek;

  /// No description provided for @calendarMonth.
  ///
  /// In en, this message translates to:
  /// **'Month'**
  String get calendarMonth;

  /// No description provided for @calendarYear.
  ///
  /// In en, this message translates to:
  /// **'Year'**
  String get calendarYear;

  /// No description provided for @calendarJumpToToday.
  ///
  /// In en, this message translates to:
  /// **'Jump to Today'**
  String get calendarJumpToToday;

  /// No description provided for @calendarNothingScheduled.
  ///
  /// In en, this message translates to:
  /// **'Nothing scheduled'**
  String get calendarNothingScheduled;

  /// No description provided for @calendarAddClass.
  ///
  /// In en, this message translates to:
  /// **'Add Class'**
  String get calendarAddClass;

  /// No description provided for @calendarAddTask.
  ///
  /// In en, this message translates to:
  /// **'Add Task'**
  String get calendarAddTask;

  /// No description provided for @calendarAddAssignment.
  ///
  /// In en, this message translates to:
  /// **'Add Assignment'**
  String get calendarAddAssignment;

  /// No description provided for @calendarAddReminder.
  ///
  /// In en, this message translates to:
  /// **'Add Reminder'**
  String get calendarAddReminder;

  /// No description provided for @calendarAddEvent.
  ///
  /// In en, this message translates to:
  /// **'Add Event'**
  String get calendarAddEvent;

  /// No description provided for @calendarToday.
  ///
  /// In en, this message translates to:
  /// **'Today, {date}'**
  String calendarToday(String date);

  /// No description provided for @calendarDeleteItemTitle.
  ///
  /// In en, this message translates to:
  /// **'Delete {type}?'**
  String calendarDeleteItemTitle(String type);

  /// No description provided for @calendarDeleteItemBody.
  ///
  /// In en, this message translates to:
  /// **'Remove \"{title}\"? This cannot be undone.'**
  String calendarDeleteItemBody(String title);

  /// No description provided for @calendarCompleted.
  ///
  /// In en, this message translates to:
  /// **'Completed'**
  String get calendarCompleted;

  /// No description provided for @calendarTaskDue.
  ///
  /// In en, this message translates to:
  /// **'Task due'**
  String get calendarTaskDue;

  /// No description provided for @calendarClassLabel.
  ///
  /// In en, this message translates to:
  /// **'Class'**
  String get calendarClassLabel;

  /// No description provided for @calendarTaskLabel.
  ///
  /// In en, this message translates to:
  /// **'Task'**
  String get calendarTaskLabel;

  /// No description provided for @calendarAllDay.
  ///
  /// In en, this message translates to:
  /// **'All day'**
  String get calendarAllDay;

  /// No description provided for @eventFormNewTitle.
  ///
  /// In en, this message translates to:
  /// **'New {category}'**
  String eventFormNewTitle(String category);

  /// No description provided for @eventFormEditTitle.
  ///
  /// In en, this message translates to:
  /// **'Edit {category}'**
  String eventFormEditTitle(String category);

  /// No description provided for @eventFormTitleLabel.
  ///
  /// In en, this message translates to:
  /// **'Title'**
  String get eventFormTitleLabel;

  /// No description provided for @eventFormDescriptionLabel.
  ///
  /// In en, this message translates to:
  /// **'Description (optional)'**
  String get eventFormDescriptionLabel;

  /// No description provided for @eventFormAllDay.
  ///
  /// In en, this message translates to:
  /// **'All day'**
  String get eventFormAllDay;

  /// No description provided for @eventFormStart.
  ///
  /// In en, this message translates to:
  /// **'Start: {time}'**
  String eventFormStart(String time);

  /// No description provided for @eventFormEnd.
  ///
  /// In en, this message translates to:
  /// **'End: {time}'**
  String eventFormEnd(String time);

  /// No description provided for @eventFormReminder.
  ///
  /// In en, this message translates to:
  /// **'Reminder'**
  String get eventFormReminder;

  /// No description provided for @eventFormColor.
  ///
  /// In en, this message translates to:
  /// **'Color'**
  String get eventFormColor;

  /// No description provided for @eventFormEndBeforeStart.
  ///
  /// In en, this message translates to:
  /// **'End time must be after start time'**
  String get eventFormEndBeforeStart;

  /// No description provided for @categoryAssignment.
  ///
  /// In en, this message translates to:
  /// **'Assignment'**
  String get categoryAssignment;

  /// No description provided for @categoryReminder.
  ///
  /// In en, this message translates to:
  /// **'Reminder'**
  String get categoryReminder;

  /// No description provided for @categoryEvent.
  ///
  /// In en, this message translates to:
  /// **'Event'**
  String get categoryEvent;

  /// No description provided for @classFormNewTitle.
  ///
  /// In en, this message translates to:
  /// **'Add Class'**
  String get classFormNewTitle;

  /// No description provided for @classFormEditTitle.
  ///
  /// In en, this message translates to:
  /// **'Edit Class'**
  String get classFormEditTitle;

  /// No description provided for @classFormSubject.
  ///
  /// In en, this message translates to:
  /// **'Subject'**
  String get classFormSubject;

  /// No description provided for @classFormLocation.
  ///
  /// In en, this message translates to:
  /// **'Location / Room'**
  String get classFormLocation;

  /// No description provided for @classFormDay.
  ///
  /// In en, this message translates to:
  /// **'Day'**
  String get classFormDay;

  /// No description provided for @classFormStart.
  ///
  /// In en, this message translates to:
  /// **'Start: {time}'**
  String classFormStart(String time);

  /// No description provided for @classFormEnd.
  ///
  /// In en, this message translates to:
  /// **'End: {time}'**
  String classFormEnd(String time);

  /// No description provided for @classFormColor.
  ///
  /// In en, this message translates to:
  /// **'Color'**
  String get classFormColor;

  /// No description provided for @reminderNone.
  ///
  /// In en, this message translates to:
  /// **'No reminder'**
  String get reminderNone;

  /// No description provided for @reminderMinutes5.
  ///
  /// In en, this message translates to:
  /// **'5 minutes before'**
  String get reminderMinutes5;

  /// No description provided for @reminderMinutes15.
  ///
  /// In en, this message translates to:
  /// **'15 minutes before'**
  String get reminderMinutes15;

  /// No description provided for @reminderMinutes30.
  ///
  /// In en, this message translates to:
  /// **'30 minutes before'**
  String get reminderMinutes30;

  /// No description provided for @reminderHour1.
  ///
  /// In en, this message translates to:
  /// **'1 hour before'**
  String get reminderHour1;

  /// No description provided for @reminderDay1.
  ///
  /// In en, this message translates to:
  /// **'1 day before'**
  String get reminderDay1;

  /// No description provided for @reminderRequiresDueDateHelper.
  ///
  /// In en, this message translates to:
  /// **'Requires a due date. Uses 9:00 AM if no due time set.'**
  String get reminderRequiresDueDateHelper;

  /// No description provided for @tasksTitle.
  ///
  /// In en, this message translates to:
  /// **'Tasks'**
  String get tasksTitle;

  /// No description provided for @tasksEmpty.
  ///
  /// In en, this message translates to:
  /// **'No tasks yet — tap + to add one'**
  String get tasksEmpty;

  /// No description provided for @tasksPendingCount.
  ///
  /// In en, this message translates to:
  /// **'Pending ({count})'**
  String tasksPendingCount(int count);

  /// No description provided for @tasksCompletedCount.
  ///
  /// In en, this message translates to:
  /// **'Completed ({count})'**
  String tasksCompletedCount(int count);

  /// No description provided for @taskDue.
  ///
  /// In en, this message translates to:
  /// **'Due {date}'**
  String taskDue(String date);

  /// No description provided for @taskFormNewTitle.
  ///
  /// In en, this message translates to:
  /// **'New Task'**
  String get taskFormNewTitle;

  /// No description provided for @taskFormEditTitle.
  ///
  /// In en, this message translates to:
  /// **'Edit Task'**
  String get taskFormEditTitle;

  /// No description provided for @taskFormTitleLabel.
  ///
  /// In en, this message translates to:
  /// **'Title'**
  String get taskFormTitleLabel;

  /// No description provided for @taskFormDescriptionLabel.
  ///
  /// In en, this message translates to:
  /// **'Description (optional)'**
  String get taskFormDescriptionLabel;

  /// No description provided for @taskFormDueDatePlaceholder.
  ///
  /// In en, this message translates to:
  /// **'Due date'**
  String get taskFormDueDatePlaceholder;

  /// No description provided for @taskFormDueTimePlaceholder.
  ///
  /// In en, this message translates to:
  /// **'Due time'**
  String get taskFormDueTimePlaceholder;

  /// No description provided for @taskFormPriority.
  ///
  /// In en, this message translates to:
  /// **'Priority'**
  String get taskFormPriority;

  /// No description provided for @priorityLow.
  ///
  /// In en, this message translates to:
  /// **'Low'**
  String get priorityLow;

  /// No description provided for @priorityMedium.
  ///
  /// In en, this message translates to:
  /// **'Medium'**
  String get priorityMedium;

  /// No description provided for @priorityHigh.
  ///
  /// In en, this message translates to:
  /// **'High'**
  String get priorityHigh;

  /// No description provided for @taskFormReminderRequiresDueDate.
  ///
  /// In en, this message translates to:
  /// **'Set a due date to use a reminder'**
  String get taskFormReminderRequiresDueDate;

  /// No description provided for @taskDeleteTitle.
  ///
  /// In en, this message translates to:
  /// **'Delete task?'**
  String get taskDeleteTitle;

  /// No description provided for @taskDeleteBody.
  ///
  /// In en, this message translates to:
  /// **'Remove \"{title}\"?'**
  String taskDeleteBody(String title);

  /// No description provided for @notesTitle.
  ///
  /// In en, this message translates to:
  /// **'Notes'**
  String get notesTitle;

  /// No description provided for @notesSearchHint.
  ///
  /// In en, this message translates to:
  /// **'Search notes...'**
  String get notesSearchHint;

  /// No description provided for @notesEmpty.
  ///
  /// In en, this message translates to:
  /// **'No notes yet — tap + to create one'**
  String get notesEmpty;

  /// No description provided for @notesNoMatch.
  ///
  /// In en, this message translates to:
  /// **'No notes match your search'**
  String get notesNoMatch;

  /// No description provided for @filterAll.
  ///
  /// In en, this message translates to:
  /// **'All'**
  String get filterAll;

  /// No description provided for @noteDeleteTitle.
  ///
  /// In en, this message translates to:
  /// **'Delete note?'**
  String get noteDeleteTitle;

  /// No description provided for @noteDeleteBody.
  ///
  /// In en, this message translates to:
  /// **'Remove \"{title}\"?'**
  String noteDeleteBody(String title);

  /// No description provided for @noteUntitled.
  ///
  /// In en, this message translates to:
  /// **'Untitled'**
  String get noteUntitled;

  /// No description provided for @noteEditorNewTitle.
  ///
  /// In en, this message translates to:
  /// **'New Note'**
  String get noteEditorNewTitle;

  /// No description provided for @noteEditorEditTitle.
  ///
  /// In en, this message translates to:
  /// **'Edit Note'**
  String get noteEditorEditTitle;

  /// No description provided for @noteTitleHint.
  ///
  /// In en, this message translates to:
  /// **'Title'**
  String get noteTitleHint;

  /// No description provided for @noteSubjectHint.
  ///
  /// In en, this message translates to:
  /// **'Subject / Module'**
  String get noteSubjectHint;

  /// No description provided for @noteSubjectOther.
  ///
  /// In en, this message translates to:
  /// **'Other...'**
  String get noteSubjectOther;

  /// No description provided for @noteContentHint.
  ///
  /// In en, this message translates to:
  /// **'Start typing your notes...'**
  String get noteContentHint;

  /// No description provided for @noteEnterTitleError.
  ///
  /// In en, this message translates to:
  /// **'Please enter a title'**
  String get noteEnterTitleError;

  /// No description provided for @noteSaveFailed.
  ///
  /// In en, this message translates to:
  /// **'Failed to save note'**
  String get noteSaveFailed;

  /// No description provided for @noteTodayAt.
  ///
  /// In en, this message translates to:
  /// **'Today, {time}'**
  String noteTodayAt(String time);

  /// No description provided for @progressTitle.
  ///
  /// In en, this message translates to:
  /// **'Academic Progress'**
  String get progressTitle;

  /// No description provided for @progressOverview.
  ///
  /// In en, this message translates to:
  /// **'Overview'**
  String get progressOverview;

  /// No description provided for @progressSyllabusProgress.
  ///
  /// In en, this message translates to:
  /// **'Syllabus\nProgress'**
  String get progressSyllabusProgress;

  /// No description provided for @progressTaskCompletion.
  ///
  /// In en, this message translates to:
  /// **'Task\nCompletion'**
  String get progressTaskCompletion;

  /// No description provided for @progressSyllabusCoverage.
  ///
  /// In en, this message translates to:
  /// **'Syllabus Coverage by Subject'**
  String get progressSyllabusCoverage;

  /// No description provided for @progressEmpty.
  ///
  /// In en, this message translates to:
  /// **'No subjects tracked yet — tap + to start tracking'**
  String get progressEmpty;

  /// No description provided for @progressFormTitle.
  ///
  /// In en, this message translates to:
  /// **'Track New Subject'**
  String get progressFormTitle;

  /// No description provided for @progressFormSubject.
  ///
  /// In en, this message translates to:
  /// **'Subject'**
  String get progressFormSubject;

  /// No description provided for @progressFormSubjectOther.
  ///
  /// In en, this message translates to:
  /// **'Other...'**
  String get progressFormSubjectOther;

  /// No description provided for @progressFormSubjectName.
  ///
  /// In en, this message translates to:
  /// **'Subject name'**
  String get progressFormSubjectName;

  /// No description provided for @progressFormTotalTopics.
  ///
  /// In en, this message translates to:
  /// **'Total topics / chapters in syllabus'**
  String get progressFormTotalTopics;

  /// No description provided for @progressFormTotalTopicsError.
  ///
  /// In en, this message translates to:
  /// **'Enter a number of at least 1'**
  String get progressFormTotalTopicsError;

  /// No description provided for @progressFormSubjectRequired.
  ///
  /// In en, this message translates to:
  /// **'Please select or enter a subject'**
  String get progressFormSubjectRequired;

  /// No description provided for @progressFormStartTracking.
  ///
  /// In en, this message translates to:
  /// **'Start Tracking'**
  String get progressFormStartTracking;

  /// No description provided for @progressTopicsCount.
  ///
  /// In en, this message translates to:
  /// **'{completed} / {total} topics ({percent}%)'**
  String progressTopicsCount(int completed, int total, String percent);

  /// No description provided for @projectsTitle.
  ///
  /// In en, this message translates to:
  /// **'Project Library'**
  String get projectsTitle;

  /// No description provided for @projectEmpty.
  ///
  /// In en, this message translates to:
  /// **'No projects here yet'**
  String get projectEmpty;

  /// No description provided for @projectDeleteTitle.
  ///
  /// In en, this message translates to:
  /// **'Delete project?'**
  String get projectDeleteTitle;

  /// No description provided for @projectDeleteBody.
  ///
  /// In en, this message translates to:
  /// **'Remove \"{title}\"?'**
  String projectDeleteBody(String title);

  /// No description provided for @projectFormNewTitle.
  ///
  /// In en, this message translates to:
  /// **'New Project'**
  String get projectFormNewTitle;

  /// No description provided for @projectFormEditTitle.
  ///
  /// In en, this message translates to:
  /// **'Edit Project'**
  String get projectFormEditTitle;

  /// No description provided for @projectFormTitleLabel.
  ///
  /// In en, this message translates to:
  /// **'Project Title'**
  String get projectFormTitleLabel;

  /// No description provided for @projectFormDescriptionLabel.
  ///
  /// In en, this message translates to:
  /// **'Description (optional)'**
  String get projectFormDescriptionLabel;

  /// No description provided for @projectFormSetDueDate.
  ///
  /// In en, this message translates to:
  /// **'Set due date (optional)'**
  String get projectFormSetDueDate;

  /// No description provided for @projectFormDuePrefix.
  ///
  /// In en, this message translates to:
  /// **'Due: {date}'**
  String projectFormDuePrefix(String date);

  /// No description provided for @projectFormStatus.
  ///
  /// In en, this message translates to:
  /// **'Status'**
  String get projectFormStatus;

  /// No description provided for @projectDue.
  ///
  /// In en, this message translates to:
  /// **'Due {date}'**
  String projectDue(String date);

  /// No description provided for @projectStatusOngoing.
  ///
  /// In en, this message translates to:
  /// **'Ongoing'**
  String get projectStatusOngoing;

  /// No description provided for @projectStatusPending.
  ///
  /// In en, this message translates to:
  /// **'Pending'**
  String get projectStatusPending;

  /// No description provided for @projectStatusCompleted.
  ///
  /// In en, this message translates to:
  /// **'Completed'**
  String get projectStatusCompleted;

  /// No description provided for @projectStatusCancelled.
  ///
  /// In en, this message translates to:
  /// **'Cancelled'**
  String get projectStatusCancelled;

  /// No description provided for @profileTitle.
  ///
  /// In en, this message translates to:
  /// **'Edit Profile'**
  String get profileTitle;

  /// No description provided for @profileTakePhoto.
  ///
  /// In en, this message translates to:
  /// **'Take Photo'**
  String get profileTakePhoto;

  /// No description provided for @profileChooseGallery.
  ///
  /// In en, this message translates to:
  /// **'Choose from Gallery'**
  String get profileChooseGallery;

  /// No description provided for @profilePhotoSaved.
  ///
  /// In en, this message translates to:
  /// **'Profile photo saved'**
  String get profilePhotoSaved;

  /// No description provided for @profilePhotoFailed.
  ///
  /// In en, this message translates to:
  /// **'Failed to save photo'**
  String get profilePhotoFailed;

  /// No description provided for @profileFullName.
  ///
  /// In en, this message translates to:
  /// **'Full Name'**
  String get profileFullName;

  /// No description provided for @profileFullNameRequired.
  ///
  /// In en, this message translates to:
  /// **'Name is required'**
  String get profileFullNameRequired;

  /// No description provided for @profileStudentId.
  ///
  /// In en, this message translates to:
  /// **'Student ID'**
  String get profileStudentId;

  /// No description provided for @profileCourseMajor.
  ///
  /// In en, this message translates to:
  /// **'Course / Major'**
  String get profileCourseMajor;

  /// No description provided for @profileYearOfStudy.
  ///
  /// In en, this message translates to:
  /// **'Year of Study'**
  String get profileYearOfStudy;

  /// No description provided for @profileYearN.
  ///
  /// In en, this message translates to:
  /// **'Year {n}'**
  String profileYearN(int n);

  /// No description provided for @profileSaveChanges.
  ///
  /// In en, this message translates to:
  /// **'Save Changes'**
  String get profileSaveChanges;

  /// No description provided for @profileUpdated.
  ///
  /// In en, this message translates to:
  /// **'Profile updated'**
  String get profileUpdated;

  /// No description provided for @profileUpdateFailed.
  ///
  /// In en, this message translates to:
  /// **'Failed to update profile'**
  String get profileUpdateFailed;

  /// No description provided for @attachmentsTitle.
  ///
  /// In en, this message translates to:
  /// **'Attachments'**
  String get attachmentsTitle;

  /// No description provided for @attachmentsAdd.
  ///
  /// In en, this message translates to:
  /// **'Add'**
  String get attachmentsAdd;

  /// No description provided for @attachmentsNone.
  ///
  /// In en, this message translates to:
  /// **'No attachments yet'**
  String get attachmentsNone;

  /// No description provided for @attachmentsPendingSuffix.
  ///
  /// In en, this message translates to:
  /// **'{name} (pending)'**
  String attachmentsPendingSuffix(String name);

  /// No description provided for @attachmentsOpenFailed.
  ///
  /// In en, this message translates to:
  /// **'Could not open file: {message}'**
  String attachmentsOpenFailed(String message);

  /// No description provided for @attachTakePhoto.
  ///
  /// In en, this message translates to:
  /// **'Take Photo'**
  String get attachTakePhoto;

  /// No description provided for @attachChooseGallery.
  ///
  /// In en, this message translates to:
  /// **'Choose from Gallery'**
  String get attachChooseGallery;

  /// No description provided for @attachChooseFile.
  ///
  /// In en, this message translates to:
  /// **'Choose File'**
  String get attachChooseFile;

  /// No description provided for @appLockedTitle.
  ///
  /// In en, this message translates to:
  /// **'App Locked'**
  String get appLockedTitle;

  /// No description provided for @appLockedSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Unlock with your fingerprint or face to continue'**
  String get appLockedSubtitle;

  /// No description provided for @appLockUnlockButton.
  ///
  /// In en, this message translates to:
  /// **'Unlock'**
  String get appLockUnlockButton;

  /// No description provided for @appLockAuthenticating.
  ///
  /// In en, this message translates to:
  /// **'Authenticating…'**
  String get appLockAuthenticating;

  /// No description provided for @appLockAuthReason.
  ///
  /// In en, this message translates to:
  /// **'Authenticate to unlock {appName}'**
  String appLockAuthReason(String appName);

  /// No description provided for @errorLoadTasks.
  ///
  /// In en, this message translates to:
  /// **'Failed to load tasks'**
  String get errorLoadTasks;

  /// No description provided for @errorAddTask.
  ///
  /// In en, this message translates to:
  /// **'Failed to add task'**
  String get errorAddTask;

  /// No description provided for @errorUpdateTask.
  ///
  /// In en, this message translates to:
  /// **'Failed to update task'**
  String get errorUpdateTask;

  /// No description provided for @errorDeleteTask.
  ///
  /// In en, this message translates to:
  /// **'Failed to delete task'**
  String get errorDeleteTask;

  /// No description provided for @errorLoadNotes.
  ///
  /// In en, this message translates to:
  /// **'Failed to load notes'**
  String get errorLoadNotes;

  /// No description provided for @errorAddNote.
  ///
  /// In en, this message translates to:
  /// **'Failed to add note'**
  String get errorAddNote;

  /// No description provided for @errorUpdateNote.
  ///
  /// In en, this message translates to:
  /// **'Failed to update note'**
  String get errorUpdateNote;

  /// No description provided for @errorDeleteNote.
  ///
  /// In en, this message translates to:
  /// **'Failed to delete note'**
  String get errorDeleteNote;

  /// No description provided for @errorLoadProjects.
  ///
  /// In en, this message translates to:
  /// **'Failed to load projects'**
  String get errorLoadProjects;

  /// No description provided for @errorAddProject.
  ///
  /// In en, this message translates to:
  /// **'Failed to add project'**
  String get errorAddProject;

  /// No description provided for @errorUpdateProject.
  ///
  /// In en, this message translates to:
  /// **'Failed to update project'**
  String get errorUpdateProject;

  /// No description provided for @errorDeleteProject.
  ///
  /// In en, this message translates to:
  /// **'Failed to delete project'**
  String get errorDeleteProject;

  /// No description provided for @errorLoadEvents.
  ///
  /// In en, this message translates to:
  /// **'Failed to load calendar events'**
  String get errorLoadEvents;

  /// No description provided for @errorAddEvent.
  ///
  /// In en, this message translates to:
  /// **'Failed to add event'**
  String get errorAddEvent;

  /// No description provided for @errorUpdateEvent.
  ///
  /// In en, this message translates to:
  /// **'Failed to update event'**
  String get errorUpdateEvent;

  /// No description provided for @errorDeleteEvent.
  ///
  /// In en, this message translates to:
  /// **'Failed to delete event'**
  String get errorDeleteEvent;

  /// No description provided for @errorLoadProgress.
  ///
  /// In en, this message translates to:
  /// **'Failed to load progress'**
  String get errorLoadProgress;

  /// No description provided for @errorAddModule.
  ///
  /// In en, this message translates to:
  /// **'Failed to add subject'**
  String get errorAddModule;

  /// No description provided for @errorUpdateModule.
  ///
  /// In en, this message translates to:
  /// **'Failed to update progress'**
  String get errorUpdateModule;

  /// No description provided for @errorDeleteModule.
  ///
  /// In en, this message translates to:
  /// **'Failed to delete subject'**
  String get errorDeleteModule;

  /// No description provided for @errorLoadProfile.
  ///
  /// In en, this message translates to:
  /// **'Failed to load profile'**
  String get errorLoadProfile;

  /// No description provided for @errorSaveProfile.
  ///
  /// In en, this message translates to:
  /// **'Failed to save profile'**
  String get errorSaveProfile;

  /// No description provided for @errorSavePhoto.
  ///
  /// In en, this message translates to:
  /// **'Failed to save photo'**
  String get errorSavePhoto;

  /// No description provided for @errorLoadTimetable.
  ///
  /// In en, this message translates to:
  /// **'Failed to load timetable'**
  String get errorLoadTimetable;

  /// No description provided for @errorAddClass.
  ///
  /// In en, this message translates to:
  /// **'Failed to add class'**
  String get errorAddClass;

  /// No description provided for @errorUpdateClass.
  ///
  /// In en, this message translates to:
  /// **'Failed to update class'**
  String get errorUpdateClass;

  /// No description provided for @errorDeleteClass.
  ///
  /// In en, this message translates to:
  /// **'Failed to delete class'**
  String get errorDeleteClass;

  /// No description provided for @errorUpdateAttachments.
  ///
  /// In en, this message translates to:
  /// **'Failed to update attachments'**
  String get errorUpdateAttachments;
}

class _AppLocalizationsDelegate
    extends LocalizationsDelegate<AppLocalizations> {
  const _AppLocalizationsDelegate();

  @override
  Future<AppLocalizations> load(Locale locale) {
    return SynchronousFuture<AppLocalizations>(lookupAppLocalizations(locale));
  }

  @override
  bool isSupported(Locale locale) => <String>[
    'de',
    'en',
    'es',
    'fr',
    'ja',
    'zh',
  ].contains(locale.languageCode);

  @override
  bool shouldReload(_AppLocalizationsDelegate old) => false;
}

AppLocalizations lookupAppLocalizations(Locale locale) {
  // Lookup logic when only language code is specified.
  switch (locale.languageCode) {
    case 'de':
      return AppLocalizationsDe();
    case 'en':
      return AppLocalizationsEn();
    case 'es':
      return AppLocalizationsEs();
    case 'fr':
      return AppLocalizationsFr();
    case 'ja':
      return AppLocalizationsJa();
    case 'zh':
      return AppLocalizationsZh();
  }

  throw FlutterError(
    'AppLocalizations.delegate failed to load unsupported locale "$locale". This is likely '
    'an issue with the localizations generation tool. Please file an issue '
    'on GitHub with a reproducible sample app and the gen-l10n configuration '
    'that was used.',
  );
}
