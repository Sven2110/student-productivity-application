// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Japanese (`ja`).
class AppLocalizationsJa extends AppLocalizations {
  AppLocalizationsJa([String locale = 'ja']) : super(locale);

  @override
  String get appTitle => 'スチューデント・プロダクティビティ';

  @override
  String get cancel => 'キャンセル';

  @override
  String get save => '保存';

  @override
  String get delete => '削除';

  @override
  String get edit => '編集';

  @override
  String get add => '追加';

  @override
  String get confirm => '確認';

  @override
  String get required => '必須項目';

  @override
  String get somethingWentWrong => '問題が発生しました';

  @override
  String get unknownUser => '不明なユーザー';

  @override
  String get loginWelcomeBack => 'おかえりなさい';

  @override
  String get loginSignInToContinue => '続けるにはログインしてください';

  @override
  String get loginEmailLabel => 'メールアドレス';

  @override
  String get loginPasswordLabel => 'パスワード';

  @override
  String get loginButton => 'ログイン';

  @override
  String get loginNoAccount => 'アカウントをお持ちでないですか？';

  @override
  String get loginRegisterLink => '新規登録';

  @override
  String get loginFailed => 'ログインに失敗しました';

  @override
  String get validationEmailRequired => 'メールアドレスを入力してください';

  @override
  String get validationEmailInvalid => '有効なメールアドレスを入力してください';

  @override
  String get validationPasswordRequired => 'パスワードを入力してください';

  @override
  String get validationPasswordMinLength => '6文字以上で入力してください';

  @override
  String get registerTitle => 'アカウント作成';

  @override
  String get registerHeading => 'スチューデント・プロダクティビティに参加';

  @override
  String get registerConfirmPasswordLabel => 'パスワード（確認）';

  @override
  String get registerButton => '登録';

  @override
  String get registerFailed => '登録に失敗しました';

  @override
  String get validationPasswordsDoNotMatch => 'パスワードが一致しません';

  @override
  String get navDashboard => 'ホーム';

  @override
  String get navCalendar => 'カレンダー';

  @override
  String get navTasks => 'タスク';

  @override
  String get navProjects => 'プロジェクト';

  @override
  String get navSettings => '設定';

  @override
  String get dashboardTitle => 'ホーム';

  @override
  String get dashboardWelcome => 'ようこそ！';

  @override
  String get dashboardOverview => '概要';

  @override
  String get dashboardTasksDue => '期限のあるタスク';

  @override
  String get dashboardProgress => '進捗';

  @override
  String get dashboardQuickAccess => 'クイックアクセス';

  @override
  String get dashboardNotes => 'ノート';

  @override
  String dashboardCourseYear(String course, int year) {
    return '$course・$year年生';
  }

  @override
  String get settingsTitle => '設定';

  @override
  String get settingsSignedIn => 'ログイン中';

  @override
  String get settingsSecuritySection => 'セキュリティ';

  @override
  String get settingsBiometricUnlock => '生体認証ロック';

  @override
  String get settingsBiometricUnlockSubtitle => 'アプリを開く際に指紋または顔認証を要求する';

  @override
  String get settingsLanguageSection => '言語';

  @override
  String get settingsLanguage => '言語';

  @override
  String get settingsLanguageSubtitle => 'アプリの表示言語を選択してください';

  @override
  String get settingsChooseLanguage => '言語を選択';

  @override
  String get settingsLogout => 'ログアウト';

  @override
  String get biometricNotAvailable => 'この端末では生体認証を利用できません。';

  @override
  String get biometricNotEnrolled => 'この端末には指紋や顔がまだ登録されていません。先に端末の設定で登録してください。';

  @override
  String get biometricAuthCancelled => '認証がキャンセルされました。';

  @override
  String get biometricEnableReason => '生体認証ロックを有効にするには認証してください';

  @override
  String get languageEnglish => '英語';

  @override
  String get languageFrench => 'フランス語';

  @override
  String get languageSpanish => 'スペイン語';

  @override
  String get languageGerman => 'ドイツ語';

  @override
  String get languageJapanese => '日本語';

  @override
  String get languageChinese => '中国語';

  @override
  String get languageSystemDefault => 'システムの既定値';

  @override
  String get calendarTitle => 'カレンダー';

  @override
  String get calendarDay => '日';

  @override
  String get calendarWeek => '週';

  @override
  String get calendarMonth => '月';

  @override
  String get calendarYear => '年';

  @override
  String get calendarJumpToToday => '今日に移動';

  @override
  String get calendarNothingScheduled => '予定はありません';

  @override
  String get calendarAddClass => '授業を追加';

  @override
  String get calendarAddTask => 'タスクを追加';

  @override
  String get calendarAddAssignment => '課題を追加';

  @override
  String get calendarAddReminder => 'リマインダーを追加';

  @override
  String get calendarAddEvent => '予定を追加';

  @override
  String calendarToday(String date) {
    return '今日、$date';
  }

  @override
  String calendarDeleteItemTitle(String type) {
    return '$typeを削除しますか？';
  }

  @override
  String calendarDeleteItemBody(String title) {
    return '「$title」を削除しますか？元に戻せません。';
  }

  @override
  String get calendarCompleted => '完了';

  @override
  String get calendarTaskDue => 'タスクの期限';

  @override
  String get calendarClassLabel => '授業';

  @override
  String get calendarTaskLabel => 'タスク';

  @override
  String get calendarAllDay => '終日';

  @override
  String eventFormNewTitle(String category) {
    return '新規：$category';
  }

  @override
  String eventFormEditTitle(String category) {
    return '編集：$category';
  }

  @override
  String get eventFormTitleLabel => 'タイトル';

  @override
  String get eventFormDescriptionLabel => '説明（任意）';

  @override
  String get eventFormAllDay => '終日';

  @override
  String eventFormStart(String time) {
    return '開始：$time';
  }

  @override
  String eventFormEnd(String time) {
    return '終了：$time';
  }

  @override
  String get eventFormReminder => 'リマインダー';

  @override
  String get eventFormColor => '色';

  @override
  String get eventFormEndBeforeStart => '終了時刻は開始時刻より後にしてください';

  @override
  String get categoryAssignment => '課題';

  @override
  String get categoryReminder => 'リマインダー';

  @override
  String get categoryEvent => '予定';

  @override
  String get classFormNewTitle => '授業を追加';

  @override
  String get classFormEditTitle => '授業を編集';

  @override
  String get classFormSubject => '科目';

  @override
  String get classFormLocation => '場所・教室';

  @override
  String get classFormDay => '曜日';

  @override
  String classFormStart(String time) {
    return '開始：$time';
  }

  @override
  String classFormEnd(String time) {
    return '終了：$time';
  }

  @override
  String get classFormColor => '色';

  @override
  String get reminderNone => 'リマインダーなし';

  @override
  String get reminderMinutes5 => '5分前';

  @override
  String get reminderMinutes15 => '15分前';

  @override
  String get reminderMinutes30 => '30分前';

  @override
  String get reminderHour1 => '1時間前';

  @override
  String get reminderDay1 => '1日前';

  @override
  String get reminderRequiresDueDateHelper => '期限日が必要です。時刻未設定の場合は午前9時が使われます。';

  @override
  String get tasksTitle => 'タスク';

  @override
  String get tasksEmpty => 'タスクはまだありません。＋をタップして追加してください';

  @override
  String tasksPendingCount(int count) {
    return '未完了（$count）';
  }

  @override
  String tasksCompletedCount(int count) {
    return '完了（$count）';
  }

  @override
  String taskDue(String date) {
    return '期限：$date';
  }

  @override
  String get taskFormNewTitle => '新しいタスク';

  @override
  String get taskFormEditTitle => 'タスクを編集';

  @override
  String get taskFormTitleLabel => 'タイトル';

  @override
  String get taskFormDescriptionLabel => '説明（任意）';

  @override
  String get taskFormDueDatePlaceholder => '期限日';

  @override
  String get taskFormDueTimePlaceholder => '期限時刻';

  @override
  String get taskFormPriority => '優先度';

  @override
  String get priorityLow => '低';

  @override
  String get priorityMedium => '中';

  @override
  String get priorityHigh => '高';

  @override
  String get taskFormReminderRequiresDueDate => 'リマインダーを使うには期限日を設定してください';

  @override
  String get taskDeleteTitle => 'タスクを削除しますか？';

  @override
  String taskDeleteBody(String title) {
    return '「$title」を削除しますか？';
  }

  @override
  String get notesTitle => 'ノート';

  @override
  String get notesSearchHint => 'ノートを検索...';

  @override
  String get notesEmpty => 'ノートはまだありません。＋をタップして作成してください';

  @override
  String get notesNoMatch => '検索に一致するノートがありません';

  @override
  String get filterAll => 'すべて';

  @override
  String get noteDeleteTitle => 'ノートを削除しますか？';

  @override
  String noteDeleteBody(String title) {
    return '「$title」を削除しますか？';
  }

  @override
  String get noteUntitled => '無題';

  @override
  String get noteEditorNewTitle => '新しいノート';

  @override
  String get noteEditorEditTitle => 'ノートを編集';

  @override
  String get noteTitleHint => 'タイトル';

  @override
  String get noteSubjectHint => '科目・モジュール';

  @override
  String get noteSubjectOther => 'その他...';

  @override
  String get noteContentHint => 'ノートを入力してください...';

  @override
  String get noteEnterTitleError => 'タイトルを入力してください';

  @override
  String get noteSaveFailed => 'ノートの保存に失敗しました';

  @override
  String noteTodayAt(String time) {
    return '今日、$time';
  }

  @override
  String get progressTitle => '学習の進捗';

  @override
  String get progressOverview => '概要';

  @override
  String get progressSyllabusProgress => 'シラバスの\n進捗';

  @override
  String get progressTaskCompletion => 'タスクの\n完了率';

  @override
  String get progressSyllabusCoverage => '科目別シラバス進捗';

  @override
  String get progressEmpty => '追跡中の科目はまだありません。＋をタップして開始してください';

  @override
  String get progressFormTitle => '新しい科目を追跡';

  @override
  String get progressFormSubject => '科目';

  @override
  String get progressFormSubjectOther => 'その他...';

  @override
  String get progressFormSubjectName => '科目名';

  @override
  String get progressFormTotalTopics => 'シラバスの総トピック数・章数';

  @override
  String get progressFormTotalTopicsError => '1以上の数値を入力してください';

  @override
  String get progressFormSubjectRequired => '科目を選択または入力してください';

  @override
  String get progressFormStartTracking => '追跡を開始';

  @override
  String progressTopicsCount(int completed, int total, String percent) {
    return '$completed / $total トピック（$percent%）';
  }

  @override
  String get projectsTitle => 'プロジェクト一覧';

  @override
  String get projectEmpty => 'ここにはまだプロジェクトがありません';

  @override
  String get projectDeleteTitle => 'プロジェクトを削除しますか？';

  @override
  String projectDeleteBody(String title) {
    return '「$title」を削除しますか？';
  }

  @override
  String get projectFormNewTitle => '新しいプロジェクト';

  @override
  String get projectFormEditTitle => 'プロジェクトを編集';

  @override
  String get projectFormTitleLabel => 'プロジェクト名';

  @override
  String get projectFormDescriptionLabel => '説明（任意）';

  @override
  String get projectFormSetDueDate => '期限日を設定（任意）';

  @override
  String projectFormDuePrefix(String date) {
    return '期限：$date';
  }

  @override
  String get projectFormStatus => 'ステータス';

  @override
  String projectDue(String date) {
    return '期限：$date';
  }

  @override
  String get projectStatusOngoing => '進行中';

  @override
  String get projectStatusPending => '保留中';

  @override
  String get projectStatusCompleted => '完了';

  @override
  String get projectStatusCancelled => '中止';

  @override
  String get profileTitle => 'プロフィールを編集';

  @override
  String get profileTakePhoto => '写真を撮る';

  @override
  String get profileChooseGallery => 'ギャラリーから選択';

  @override
  String get profilePhotoSaved => 'プロフィール写真を保存しました';

  @override
  String get profilePhotoFailed => '写真の保存に失敗しました';

  @override
  String get profileFullName => '氏名';

  @override
  String get profileFullNameRequired => '氏名は必須です';

  @override
  String get profileStudentId => '学籍番号';

  @override
  String get profileCourseMajor => 'コース・専攻';

  @override
  String get profileYearOfStudy => '学年';

  @override
  String profileYearN(int n) {
    return '$n年生';
  }

  @override
  String get profileSaveChanges => '変更を保存';

  @override
  String get profileUpdated => 'プロフィールを更新しました';

  @override
  String get profileUpdateFailed => 'プロフィールの更新に失敗しました';

  @override
  String get attachmentsTitle => '添付ファイル';

  @override
  String get attachmentsAdd => '追加';

  @override
  String get attachmentsNone => '添付ファイルはまだありません';

  @override
  String attachmentsPendingSuffix(String name) {
    return '$name（保留中）';
  }

  @override
  String attachmentsOpenFailed(String message) {
    return 'ファイルを開けませんでした：$message';
  }

  @override
  String get attachTakePhoto => '写真を撮る';

  @override
  String get attachChooseGallery => 'ギャラリーから選択';

  @override
  String get attachChooseFile => 'ファイルを選択';

  @override
  String get appLockedTitle => 'アプリはロックされています';

  @override
  String get appLockedSubtitle => '指紋または顔認証で解除してください';

  @override
  String get appLockUnlockButton => 'ロック解除';

  @override
  String get appLockAuthenticating => '認証中…';

  @override
  String appLockAuthReason(String appName) {
    return '$appNameのロックを解除するには認証してください';
  }

  @override
  String get errorLoadTasks => 'タスクの読み込みに失敗しました';

  @override
  String get errorAddTask => 'タスクの追加に失敗しました';

  @override
  String get errorUpdateTask => 'タスクの更新に失敗しました';

  @override
  String get errorDeleteTask => 'タスクの削除に失敗しました';

  @override
  String get errorLoadNotes => 'ノートの読み込みに失敗しました';

  @override
  String get errorAddNote => 'ノートの追加に失敗しました';

  @override
  String get errorUpdateNote => 'ノートの更新に失敗しました';

  @override
  String get errorDeleteNote => 'ノートの削除に失敗しました';

  @override
  String get errorLoadProjects => 'プロジェクトの読み込みに失敗しました';

  @override
  String get errorAddProject => 'プロジェクトの追加に失敗しました';

  @override
  String get errorUpdateProject => 'プロジェクトの更新に失敗しました';

  @override
  String get errorDeleteProject => 'プロジェクトの削除に失敗しました';

  @override
  String get errorLoadEvents => 'カレンダーの予定の読み込みに失敗しました';

  @override
  String get errorAddEvent => '予定の追加に失敗しました';

  @override
  String get errorUpdateEvent => '予定の更新に失敗しました';

  @override
  String get errorDeleteEvent => '予定の削除に失敗しました';

  @override
  String get errorLoadProgress => '進捗の読み込みに失敗しました';

  @override
  String get errorAddModule => '科目の追加に失敗しました';

  @override
  String get errorUpdateModule => '進捗の更新に失敗しました';

  @override
  String get errorDeleteModule => '科目の削除に失敗しました';

  @override
  String get errorLoadProfile => 'プロフィールの読み込みに失敗しました';

  @override
  String get errorSaveProfile => 'プロフィールの保存に失敗しました';

  @override
  String get errorSavePhoto => '写真の保存に失敗しました';

  @override
  String get errorLoadTimetable => '時間割の読み込みに失敗しました';

  @override
  String get errorAddClass => '授業の追加に失敗しました';

  @override
  String get errorUpdateClass => '授業の更新に失敗しました';

  @override
  String get errorDeleteClass => '授業の削除に失敗しました';

  @override
  String get errorUpdateAttachments => '添付ファイルの更新に失敗しました';
}
