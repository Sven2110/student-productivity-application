// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for English (`en`).
class AppLocalizationsEn extends AppLocalizations {
  AppLocalizationsEn([String locale = 'en']) : super(locale);

  @override
  String get appTitle => 'Student Productivity';

  @override
  String get cancel => 'Cancel';

  @override
  String get save => 'Save';

  @override
  String get delete => 'Delete';

  @override
  String get edit => 'Edit';

  @override
  String get add => 'Add';

  @override
  String get confirm => 'Confirm';

  @override
  String get required => 'Required';

  @override
  String get somethingWentWrong => 'Something went wrong';

  @override
  String get unknownUser => 'Unknown user';

  @override
  String get loginWelcomeBack => 'Welcome Back';

  @override
  String get loginSignInToContinue => 'Sign in to continue';

  @override
  String get loginEmailLabel => 'Email';

  @override
  String get loginPasswordLabel => 'Password';

  @override
  String get loginButton => 'Login';

  @override
  String get loginNoAccount => 'Don\'t have an account?';

  @override
  String get loginRegisterLink => 'Register';

  @override
  String get loginFailed => 'Login failed';

  @override
  String get validationEmailRequired => 'Email is required';

  @override
  String get validationEmailInvalid => 'Enter a valid email';

  @override
  String get validationPasswordRequired => 'Password is required';

  @override
  String get validationPasswordMinLength => 'Minimum 6 characters';

  @override
  String get registerTitle => 'Create Account';

  @override
  String get registerHeading => 'Join Student Productivity';

  @override
  String get registerConfirmPasswordLabel => 'Confirm Password';

  @override
  String get registerButton => 'Register';

  @override
  String get registerFailed => 'Registration failed';

  @override
  String get validationPasswordsDoNotMatch => 'Passwords do not match';

  @override
  String get navDashboard => 'Dashboard';

  @override
  String get navCalendar => 'Calendar';

  @override
  String get navTasks => 'Tasks';

  @override
  String get navProjects => 'Projects';

  @override
  String get navSettings => 'Settings';

  @override
  String get dashboardTitle => 'Dashboard';

  @override
  String get dashboardWelcome => 'Welcome!';

  @override
  String get dashboardOverview => 'Overview';

  @override
  String get dashboardTasksDue => 'Tasks Due';

  @override
  String get dashboardProgress => 'Progress';

  @override
  String get dashboardQuickAccess => 'Quick Access';

  @override
  String get dashboardNotes => 'Notes';

  @override
  String dashboardCourseYear(String course, int year) {
    return '$course • Year $year';
  }

  @override
  String get settingsTitle => 'Settings';

  @override
  String get settingsSignedIn => 'Signed in';

  @override
  String get settingsSecuritySection => 'SECURITY';

  @override
  String get settingsBiometricUnlock => 'Biometric Unlock';

  @override
  String get settingsBiometricUnlockSubtitle =>
      'Require your fingerprint or face to open the app';

  @override
  String get settingsLanguageSection => 'LANGUAGE';

  @override
  String get settingsLanguage => 'Language';

  @override
  String get settingsLanguageSubtitle => 'Choose the app\'s display language';

  @override
  String get settingsChooseLanguage => 'Choose language';

  @override
  String get settingsLogout => 'Logout';

  @override
  String get biometricNotAvailable =>
      'Biometric authentication is not available on this device.';

  @override
  String get biometricNotEnrolled =>
      'No fingerprint or face is set up on this device yet. Add one in your device settings first.';

  @override
  String get biometricAuthCancelled => 'Authentication was cancelled.';

  @override
  String get biometricEnableReason => 'Authenticate to enable biometric unlock';

  @override
  String get languageEnglish => 'English';

  @override
  String get languageFrench => 'French';

  @override
  String get languageSpanish => 'Spanish';

  @override
  String get languageGerman => 'German';

  @override
  String get languageJapanese => 'Japanese';

  @override
  String get languageChinese => 'Chinese';

  @override
  String get languageSystemDefault => 'System default';

  @override
  String get calendarTitle => 'Calendar';

  @override
  String get calendarDay => 'Day';

  @override
  String get calendarWeek => 'Week';

  @override
  String get calendarMonth => 'Month';

  @override
  String get calendarYear => 'Year';

  @override
  String get calendarJumpToToday => 'Jump to Today';

  @override
  String get calendarNothingScheduled => 'Nothing scheduled';

  @override
  String get calendarAddClass => 'Add Class';

  @override
  String get calendarAddTask => 'Add Task';

  @override
  String get calendarAddAssignment => 'Add Assignment';

  @override
  String get calendarAddReminder => 'Add Reminder';

  @override
  String get calendarAddEvent => 'Add Event';

  @override
  String calendarToday(String date) {
    return 'Today, $date';
  }

  @override
  String calendarDeleteItemTitle(String type) {
    return 'Delete $type?';
  }

  @override
  String calendarDeleteItemBody(String title) {
    return 'Remove \"$title\"? This cannot be undone.';
  }

  @override
  String get calendarCompleted => 'Completed';

  @override
  String get calendarTaskDue => 'Task due';

  @override
  String get calendarClassLabel => 'Class';

  @override
  String get calendarTaskLabel => 'Task';

  @override
  String get calendarAllDay => 'All day';

  @override
  String eventFormNewTitle(String category) {
    return 'New $category';
  }

  @override
  String eventFormEditTitle(String category) {
    return 'Edit $category';
  }

  @override
  String get eventFormTitleLabel => 'Title';

  @override
  String get eventFormDescriptionLabel => 'Description (optional)';

  @override
  String get eventFormAllDay => 'All day';

  @override
  String eventFormStart(String time) {
    return 'Start: $time';
  }

  @override
  String eventFormEnd(String time) {
    return 'End: $time';
  }

  @override
  String get eventFormReminder => 'Reminder';

  @override
  String get eventFormColor => 'Color';

  @override
  String get eventFormEndBeforeStart => 'End time must be after start time';

  @override
  String get categoryAssignment => 'Assignment';

  @override
  String get categoryReminder => 'Reminder';

  @override
  String get categoryEvent => 'Event';

  @override
  String get classFormNewTitle => 'Add Class';

  @override
  String get classFormEditTitle => 'Edit Class';

  @override
  String get classFormSubject => 'Subject';

  @override
  String get classFormLocation => 'Location / Room';

  @override
  String get classFormDay => 'Day';

  @override
  String classFormStart(String time) {
    return 'Start: $time';
  }

  @override
  String classFormEnd(String time) {
    return 'End: $time';
  }

  @override
  String get classFormColor => 'Color';

  @override
  String get reminderNone => 'No reminder';

  @override
  String get reminderMinutes5 => '5 minutes before';

  @override
  String get reminderMinutes15 => '15 minutes before';

  @override
  String get reminderMinutes30 => '30 minutes before';

  @override
  String get reminderHour1 => '1 hour before';

  @override
  String get reminderDay1 => '1 day before';

  @override
  String get reminderRequiresDueDateHelper =>
      'Requires a due date. Uses 9:00 AM if no due time set.';

  @override
  String get tasksTitle => 'Tasks';

  @override
  String get tasksEmpty => 'No tasks yet — tap + to add one';

  @override
  String tasksPendingCount(int count) {
    return 'Pending ($count)';
  }

  @override
  String tasksCompletedCount(int count) {
    return 'Completed ($count)';
  }

  @override
  String taskDue(String date) {
    return 'Due $date';
  }

  @override
  String get taskFormNewTitle => 'New Task';

  @override
  String get taskFormEditTitle => 'Edit Task';

  @override
  String get taskFormTitleLabel => 'Title';

  @override
  String get taskFormDescriptionLabel => 'Description (optional)';

  @override
  String get taskFormDueDatePlaceholder => 'Due date';

  @override
  String get taskFormDueTimePlaceholder => 'Due time';

  @override
  String get taskFormPriority => 'Priority';

  @override
  String get priorityLow => 'Low';

  @override
  String get priorityMedium => 'Medium';

  @override
  String get priorityHigh => 'High';

  @override
  String get taskFormReminderRequiresDueDate =>
      'Set a due date to use a reminder';

  @override
  String get taskDeleteTitle => 'Delete task?';

  @override
  String taskDeleteBody(String title) {
    return 'Remove \"$title\"?';
  }

  @override
  String get notesTitle => 'Notes';

  @override
  String get notesSearchHint => 'Search notes...';

  @override
  String get notesEmpty => 'No notes yet — tap + to create one';

  @override
  String get notesNoMatch => 'No notes match your search';

  @override
  String get filterAll => 'All';

  @override
  String get noteDeleteTitle => 'Delete note?';

  @override
  String noteDeleteBody(String title) {
    return 'Remove \"$title\"?';
  }

  @override
  String get noteUntitled => 'Untitled';

  @override
  String get noteEditorNewTitle => 'New Note';

  @override
  String get noteEditorEditTitle => 'Edit Note';

  @override
  String get noteTitleHint => 'Title';

  @override
  String get noteSubjectHint => 'Subject / Module';

  @override
  String get noteSubjectOther => 'Other...';

  @override
  String get noteContentHint => 'Start typing your notes...';

  @override
  String get noteEnterTitleError => 'Please enter a title';

  @override
  String get noteSaveFailed => 'Failed to save note';

  @override
  String noteTodayAt(String time) {
    return 'Today, $time';
  }

  @override
  String get progressTitle => 'Academic Progress';

  @override
  String get progressOverview => 'Overview';

  @override
  String get progressSyllabusProgress => 'Syllabus\nProgress';

  @override
  String get progressTaskCompletion => 'Task\nCompletion';

  @override
  String get progressSyllabusCoverage => 'Syllabus Coverage by Subject';

  @override
  String get progressEmpty =>
      'No subjects tracked yet — tap + to start tracking';

  @override
  String get progressFormTitle => 'Track New Subject';

  @override
  String get progressFormSubject => 'Subject';

  @override
  String get progressFormSubjectOther => 'Other...';

  @override
  String get progressFormSubjectName => 'Subject name';

  @override
  String get progressFormTotalTopics => 'Total topics / chapters in syllabus';

  @override
  String get progressFormTotalTopicsError => 'Enter a number of at least 1';

  @override
  String get progressFormSubjectRequired => 'Please select or enter a subject';

  @override
  String get progressFormStartTracking => 'Start Tracking';

  @override
  String progressTopicsCount(int completed, int total, String percent) {
    return '$completed / $total topics ($percent%)';
  }

  @override
  String get projectsTitle => 'Project Library';

  @override
  String get projectEmpty => 'No projects here yet';

  @override
  String get projectDeleteTitle => 'Delete project?';

  @override
  String projectDeleteBody(String title) {
    return 'Remove \"$title\"?';
  }

  @override
  String get projectFormNewTitle => 'New Project';

  @override
  String get projectFormEditTitle => 'Edit Project';

  @override
  String get projectFormTitleLabel => 'Project Title';

  @override
  String get projectFormDescriptionLabel => 'Description (optional)';

  @override
  String get projectFormSetDueDate => 'Set due date (optional)';

  @override
  String projectFormDuePrefix(String date) {
    return 'Due: $date';
  }

  @override
  String get projectFormStatus => 'Status';

  @override
  String projectDue(String date) {
    return 'Due $date';
  }

  @override
  String get projectStatusOngoing => 'Ongoing';

  @override
  String get projectStatusPending => 'Pending';

  @override
  String get projectStatusCompleted => 'Completed';

  @override
  String get projectStatusCancelled => 'Cancelled';

  @override
  String get profileTitle => 'Edit Profile';

  @override
  String get profileTakePhoto => 'Take Photo';

  @override
  String get profileChooseGallery => 'Choose from Gallery';

  @override
  String get profilePhotoSaved => 'Profile photo saved';

  @override
  String get profilePhotoFailed => 'Failed to save photo';

  @override
  String get profileFullName => 'Full Name';

  @override
  String get profileFullNameRequired => 'Name is required';

  @override
  String get profileStudentId => 'Student ID';

  @override
  String get profileCourseMajor => 'Course / Major';

  @override
  String get profileYearOfStudy => 'Year of Study';

  @override
  String profileYearN(int n) {
    return 'Year $n';
  }

  @override
  String get profileSaveChanges => 'Save Changes';

  @override
  String get profileUpdated => 'Profile updated';

  @override
  String get profileUpdateFailed => 'Failed to update profile';

  @override
  String get attachmentsTitle => 'Attachments';

  @override
  String get attachmentsAdd => 'Add';

  @override
  String get attachmentsNone => 'No attachments yet';

  @override
  String attachmentsPendingSuffix(String name) {
    return '$name (pending)';
  }

  @override
  String attachmentsOpenFailed(String message) {
    return 'Could not open file: $message';
  }

  @override
  String get attachTakePhoto => 'Take Photo';

  @override
  String get attachChooseGallery => 'Choose from Gallery';

  @override
  String get attachChooseFile => 'Choose File';

  @override
  String get appLockedTitle => 'App Locked';

  @override
  String get appLockedSubtitle =>
      'Unlock with your fingerprint or face to continue';

  @override
  String get appLockUnlockButton => 'Unlock';

  @override
  String get appLockAuthenticating => 'Authenticating…';

  @override
  String appLockAuthReason(String appName) {
    return 'Authenticate to unlock $appName';
  }

  @override
  String get errorLoadTasks => 'Failed to load tasks';

  @override
  String get errorAddTask => 'Failed to add task';

  @override
  String get errorUpdateTask => 'Failed to update task';

  @override
  String get errorDeleteTask => 'Failed to delete task';

  @override
  String get errorLoadNotes => 'Failed to load notes';

  @override
  String get errorAddNote => 'Failed to add note';

  @override
  String get errorUpdateNote => 'Failed to update note';

  @override
  String get errorDeleteNote => 'Failed to delete note';

  @override
  String get errorLoadProjects => 'Failed to load projects';

  @override
  String get errorAddProject => 'Failed to add project';

  @override
  String get errorUpdateProject => 'Failed to update project';

  @override
  String get errorDeleteProject => 'Failed to delete project';

  @override
  String get errorLoadEvents => 'Failed to load calendar events';

  @override
  String get errorAddEvent => 'Failed to add event';

  @override
  String get errorUpdateEvent => 'Failed to update event';

  @override
  String get errorDeleteEvent => 'Failed to delete event';

  @override
  String get errorLoadProgress => 'Failed to load progress';

  @override
  String get errorAddModule => 'Failed to add subject';

  @override
  String get errorUpdateModule => 'Failed to update progress';

  @override
  String get errorDeleteModule => 'Failed to delete subject';

  @override
  String get errorLoadProfile => 'Failed to load profile';

  @override
  String get errorSaveProfile => 'Failed to save profile';

  @override
  String get errorSavePhoto => 'Failed to save photo';

  @override
  String get errorLoadTimetable => 'Failed to load timetable';

  @override
  String get errorAddClass => 'Failed to add class';

  @override
  String get errorUpdateClass => 'Failed to update class';

  @override
  String get errorDeleteClass => 'Failed to delete class';

  @override
  String get errorUpdateAttachments => 'Failed to update attachments';
}
