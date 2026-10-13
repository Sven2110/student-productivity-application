// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Chinese (`zh`).
class AppLocalizationsZh extends AppLocalizations {
  AppLocalizationsZh([String locale = 'zh']) : super(locale);

  @override
  String get appTitle => '学生效率助手';

  @override
  String get cancel => '取消';

  @override
  String get save => '保存';

  @override
  String get delete => '删除';

  @override
  String get edit => '编辑';

  @override
  String get add => '添加';

  @override
  String get confirm => '确认';

  @override
  String get required => '必填';

  @override
  String get somethingWentWrong => '出了点问题';

  @override
  String get unknownUser => '未知用户';

  @override
  String get loginWelcomeBack => '欢迎回来';

  @override
  String get loginSignInToContinue => '登录以继续';

  @override
  String get loginEmailLabel => '邮箱';

  @override
  String get loginPasswordLabel => '密码';

  @override
  String get loginButton => '登录';

  @override
  String get loginNoAccount => '还没有账号？';

  @override
  String get loginRegisterLink => '注册';

  @override
  String get loginFailed => '登录失败';

  @override
  String get validationEmailRequired => '请输入邮箱';

  @override
  String get validationEmailInvalid => '请输入有效的邮箱地址';

  @override
  String get validationPasswordRequired => '请输入密码';

  @override
  String get validationPasswordMinLength => '至少需要6个字符';

  @override
  String get registerTitle => '创建账号';

  @override
  String get registerHeading => '加入学生效率助手';

  @override
  String get registerConfirmPasswordLabel => '确认密码';

  @override
  String get registerButton => '注册';

  @override
  String get registerFailed => '注册失败';

  @override
  String get validationPasswordsDoNotMatch => '两次输入的密码不一致';

  @override
  String get navDashboard => '主页';

  @override
  String get navCalendar => '日历';

  @override
  String get navTasks => '任务';

  @override
  String get navProjects => '项目';

  @override
  String get navSettings => '设置';

  @override
  String get dashboardTitle => '主页';

  @override
  String get dashboardWelcome => '欢迎！';

  @override
  String get dashboardOverview => '概览';

  @override
  String get dashboardTasksDue => '待完成任务';

  @override
  String get dashboardProgress => '进度';

  @override
  String get dashboardQuickAccess => '快捷入口';

  @override
  String get dashboardNotes => '笔记';

  @override
  String dashboardCourseYear(String course, int year) {
    return '$course · 大$year';
  }

  @override
  String get settingsTitle => '设置';

  @override
  String get settingsSignedIn => '已登录';

  @override
  String get settingsSecuritySection => '安全';

  @override
  String get settingsBiometricUnlock => '生物识别解锁';

  @override
  String get settingsBiometricUnlockSubtitle => '打开应用时需要指纹或面容验证';

  @override
  String get settingsLanguageSection => '语言';

  @override
  String get settingsLanguage => '语言';

  @override
  String get settingsLanguageSubtitle => '选择应用的显示语言';

  @override
  String get settingsChooseLanguage => '选择语言';

  @override
  String get settingsLogout => '退出登录';

  @override
  String get biometricNotAvailable => '此设备不支持生物识别验证。';

  @override
  String get biometricNotEnrolled => '此设备尚未录入指纹或面容。请先在设备设置中添加。';

  @override
  String get biometricAuthCancelled => '验证已取消。';

  @override
  String get biometricEnableReason => '请验证以启用生物识别解锁';

  @override
  String get languageEnglish => '英语';

  @override
  String get languageFrench => '法语';

  @override
  String get languageSpanish => '西班牙语';

  @override
  String get languageGerman => '德语';

  @override
  String get languageJapanese => '日语';

  @override
  String get languageChinese => '中文';

  @override
  String get languageSystemDefault => '跟随系统';

  @override
  String get calendarTitle => '日历';

  @override
  String get calendarDay => '日';

  @override
  String get calendarWeek => '周';

  @override
  String get calendarMonth => '月';

  @override
  String get calendarYear => '年';

  @override
  String get calendarJumpToToday => '跳转到今天';

  @override
  String get calendarNothingScheduled => '没有日程安排';

  @override
  String get calendarAddClass => '添加课程';

  @override
  String get calendarAddTask => '添加任务';

  @override
  String get calendarAddAssignment => '添加作业';

  @override
  String get calendarAddReminder => '添加提醒';

  @override
  String get calendarAddEvent => '添加日程';

  @override
  String calendarToday(String date) {
    return '今天，$date';
  }

  @override
  String calendarDeleteItemTitle(String type) {
    return '删除$type？';
  }

  @override
  String calendarDeleteItemBody(String title) {
    return '删除“$title”？此操作无法撤销。';
  }

  @override
  String get calendarCompleted => '已完成';

  @override
  String get calendarTaskDue => '任务到期';

  @override
  String get calendarClassLabel => '课程';

  @override
  String get calendarTaskLabel => '任务';

  @override
  String get calendarAllDay => '全天';

  @override
  String eventFormNewTitle(String category) {
    return '新建$category';
  }

  @override
  String eventFormEditTitle(String category) {
    return '编辑$category';
  }

  @override
  String get eventFormTitleLabel => '标题';

  @override
  String get eventFormDescriptionLabel => '描述（可选）';

  @override
  String get eventFormAllDay => '全天';

  @override
  String eventFormStart(String time) {
    return '开始：$time';
  }

  @override
  String eventFormEnd(String time) {
    return '结束：$time';
  }

  @override
  String get eventFormReminder => '提醒';

  @override
  String get eventFormColor => '颜色';

  @override
  String get eventFormEndBeforeStart => '结束时间必须晚于开始时间';

  @override
  String get categoryAssignment => '作业';

  @override
  String get categoryReminder => '提醒';

  @override
  String get categoryEvent => '日程';

  @override
  String get classFormNewTitle => '添加课程';

  @override
  String get classFormEditTitle => '编辑课程';

  @override
  String get classFormSubject => '科目';

  @override
  String get classFormLocation => '地点 / 教室';

  @override
  String get classFormDay => '星期';

  @override
  String classFormStart(String time) {
    return '开始：$time';
  }

  @override
  String classFormEnd(String time) {
    return '结束：$time';
  }

  @override
  String get classFormColor => '颜色';

  @override
  String get reminderNone => '不提醒';

  @override
  String get reminderMinutes5 => '提前5分钟';

  @override
  String get reminderMinutes15 => '提前15分钟';

  @override
  String get reminderMinutes30 => '提前30分钟';

  @override
  String get reminderHour1 => '提前1小时';

  @override
  String get reminderDay1 => '提前1天';

  @override
  String get reminderRequiresDueDateHelper => '需要设置截止日期。若未设置时间，默认为上午9点。';

  @override
  String get tasksTitle => '任务';

  @override
  String get tasksEmpty => '还没有任务 — 点击 + 添加一个';

  @override
  String tasksPendingCount(int count) {
    return '待完成（$count）';
  }

  @override
  String tasksCompletedCount(int count) {
    return '已完成（$count）';
  }

  @override
  String taskDue(String date) {
    return '截止 $date';
  }

  @override
  String get taskFormNewTitle => '新建任务';

  @override
  String get taskFormEditTitle => '编辑任务';

  @override
  String get taskFormTitleLabel => '标题';

  @override
  String get taskFormDescriptionLabel => '描述（可选）';

  @override
  String get taskFormDueDatePlaceholder => '截止日期';

  @override
  String get taskFormDueTimePlaceholder => '截止时间';

  @override
  String get taskFormPriority => '优先级';

  @override
  String get priorityLow => '低';

  @override
  String get priorityMedium => '中';

  @override
  String get priorityHigh => '高';

  @override
  String get taskFormReminderRequiresDueDate => '请先设置截止日期才能使用提醒';

  @override
  String get taskDeleteTitle => '删除任务？';

  @override
  String taskDeleteBody(String title) {
    return '删除“$title”？';
  }

  @override
  String get notesTitle => '笔记';

  @override
  String get notesSearchHint => '搜索笔记...';

  @override
  String get notesEmpty => '还没有笔记 — 点击 + 创建一条';

  @override
  String get notesNoMatch => '没有匹配的笔记';

  @override
  String get filterAll => '全部';

  @override
  String get noteDeleteTitle => '删除笔记？';

  @override
  String noteDeleteBody(String title) {
    return '删除“$title”？';
  }

  @override
  String get noteUntitled => '无标题';

  @override
  String get noteEditorNewTitle => '新建笔记';

  @override
  String get noteEditorEditTitle => '编辑笔记';

  @override
  String get noteTitleHint => '标题';

  @override
  String get noteSubjectHint => '科目 / 模块';

  @override
  String get noteSubjectOther => '其他...';

  @override
  String get noteContentHint => '开始输入笔记内容...';

  @override
  String get noteEnterTitleError => '请输入标题';

  @override
  String get noteSaveFailed => '笔记保存失败';

  @override
  String noteTodayAt(String time) {
    return '今天 $time';
  }

  @override
  String get progressTitle => '学习进度';

  @override
  String get progressOverview => '概览';

  @override
  String get progressSyllabusProgress => '教学大纲\n进度';

  @override
  String get progressTaskCompletion => '任务\n完成率';

  @override
  String get progressSyllabusCoverage => '各科目大纲覆盖情况';

  @override
  String get progressEmpty => '还没有跟踪的科目 — 点击 + 开始跟踪';

  @override
  String get progressFormTitle => '跟踪新科目';

  @override
  String get progressFormSubject => '科目';

  @override
  String get progressFormSubjectOther => '其他...';

  @override
  String get progressFormSubjectName => '科目名称';

  @override
  String get progressFormTotalTopics => '大纲中的总主题数 / 章节数';

  @override
  String get progressFormTotalTopicsError => '请输入至少为1的数字';

  @override
  String get progressFormSubjectRequired => '请选择或输入一个科目';

  @override
  String get progressFormStartTracking => '开始跟踪';

  @override
  String progressTopicsCount(int completed, int total, String percent) {
    return '$completed / $total 个主题（$percent%）';
  }

  @override
  String get projectsTitle => '项目库';

  @override
  String get projectEmpty => '这里还没有项目';

  @override
  String get projectDeleteTitle => '删除项目？';

  @override
  String projectDeleteBody(String title) {
    return '删除“$title”？';
  }

  @override
  String get projectFormNewTitle => '新建项目';

  @override
  String get projectFormEditTitle => '编辑项目';

  @override
  String get projectFormTitleLabel => '项目标题';

  @override
  String get projectFormDescriptionLabel => '描述（可选）';

  @override
  String get projectFormSetDueDate => '设置截止日期（可选）';

  @override
  String projectFormDuePrefix(String date) {
    return '截止：$date';
  }

  @override
  String get projectFormStatus => '状态';

  @override
  String projectDue(String date) {
    return '截止 $date';
  }

  @override
  String get projectStatusOngoing => '进行中';

  @override
  String get projectStatusPending => '待处理';

  @override
  String get projectStatusCompleted => '已完成';

  @override
  String get projectStatusCancelled => '已取消';

  @override
  String get profileTitle => '编辑资料';

  @override
  String get profileTakePhoto => '拍照';

  @override
  String get profileChooseGallery => '从相册选择';

  @override
  String get profilePhotoSaved => '头像已保存';

  @override
  String get profilePhotoFailed => '头像保存失败';

  @override
  String get profileFullName => '姓名';

  @override
  String get profileFullNameRequired => '姓名为必填项';

  @override
  String get profileStudentId => '学号';

  @override
  String get profileCourseMajor => '课程 / 专业';

  @override
  String get profileYearOfStudy => '年级';

  @override
  String profileYearN(int n) {
    return '大$n';
  }

  @override
  String get profileSaveChanges => '保存更改';

  @override
  String get profileUpdated => '资料已更新';

  @override
  String get profileUpdateFailed => '资料更新失败';

  @override
  String get attachmentsTitle => '附件';

  @override
  String get attachmentsAdd => '添加';

  @override
  String get attachmentsNone => '还没有附件';

  @override
  String attachmentsPendingSuffix(String name) {
    return '$name（待上传）';
  }

  @override
  String attachmentsOpenFailed(String message) {
    return '无法打开文件：$message';
  }

  @override
  String get attachTakePhoto => '拍照';

  @override
  String get attachChooseGallery => '从相册选择';

  @override
  String get attachChooseFile => '选择文件';

  @override
  String get appLockedTitle => '应用已锁定';

  @override
  String get appLockedSubtitle => '使用指纹或面容验证解锁以继续';

  @override
  String get appLockUnlockButton => '解锁';

  @override
  String get appLockAuthenticating => '正在验证…';

  @override
  String appLockAuthReason(String appName) {
    return '请验证以解锁$appName';
  }

  @override
  String get errorLoadTasks => '任务加载失败';

  @override
  String get errorAddTask => '任务添加失败';

  @override
  String get errorUpdateTask => '任务更新失败';

  @override
  String get errorDeleteTask => '任务删除失败';

  @override
  String get errorLoadNotes => '笔记加载失败';

  @override
  String get errorAddNote => '笔记添加失败';

  @override
  String get errorUpdateNote => '笔记更新失败';

  @override
  String get errorDeleteNote => '笔记删除失败';

  @override
  String get errorLoadProjects => '项目加载失败';

  @override
  String get errorAddProject => '项目添加失败';

  @override
  String get errorUpdateProject => '项目更新失败';

  @override
  String get errorDeleteProject => '项目删除失败';

  @override
  String get errorLoadEvents => '日历日程加载失败';

  @override
  String get errorAddEvent => '日程添加失败';

  @override
  String get errorUpdateEvent => '日程更新失败';

  @override
  String get errorDeleteEvent => '日程删除失败';

  @override
  String get errorLoadProgress => '进度加载失败';

  @override
  String get errorAddModule => '科目添加失败';

  @override
  String get errorUpdateModule => '进度更新失败';

  @override
  String get errorDeleteModule => '科目删除失败';

  @override
  String get errorLoadProfile => '资料加载失败';

  @override
  String get errorSaveProfile => '资料保存失败';

  @override
  String get errorSavePhoto => '照片保存失败';

  @override
  String get errorLoadTimetable => '课程表加载失败';

  @override
  String get errorAddClass => '课程添加失败';

  @override
  String get errorUpdateClass => '课程更新失败';

  @override
  String get errorDeleteClass => '课程删除失败';

  @override
  String get errorUpdateAttachments => '附件更新失败';
}
