// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Spanish Castilian (`es`).
class AppLocalizationsEs extends AppLocalizations {
  AppLocalizationsEs([String locale = 'es']) : super(locale);

  @override
  String get appTitle => 'Productividad Estudiantil';

  @override
  String get cancel => 'Cancelar';

  @override
  String get save => 'Guardar';

  @override
  String get delete => 'Eliminar';

  @override
  String get edit => 'Editar';

  @override
  String get add => 'Añadir';

  @override
  String get confirm => 'Confirmar';

  @override
  String get required => 'Obligatorio';

  @override
  String get somethingWentWrong => 'Algo salió mal';

  @override
  String get unknownUser => 'Usuario desconocido';

  @override
  String get loginWelcomeBack => 'Bienvenido de nuevo';

  @override
  String get loginSignInToContinue => 'Inicia sesión para continuar';

  @override
  String get loginEmailLabel => 'Correo electrónico';

  @override
  String get loginPasswordLabel => 'Contraseña';

  @override
  String get loginButton => 'Iniciar sesión';

  @override
  String get loginNoAccount => '¿No tienes una cuenta?';

  @override
  String get loginRegisterLink => 'Regístrate';

  @override
  String get loginFailed => 'Error al iniciar sesión';

  @override
  String get validationEmailRequired => 'El correo electrónico es obligatorio';

  @override
  String get validationEmailInvalid => 'Introduce un correo válido';

  @override
  String get validationPasswordRequired => 'La contraseña es obligatoria';

  @override
  String get validationPasswordMinLength => 'Mínimo 6 caracteres';

  @override
  String get registerTitle => 'Crear cuenta';

  @override
  String get registerHeading => 'Únete a Productividad Estudiantil';

  @override
  String get registerConfirmPasswordLabel => 'Confirmar contraseña';

  @override
  String get registerButton => 'Registrarse';

  @override
  String get registerFailed => 'Error en el registro';

  @override
  String get validationPasswordsDoNotMatch => 'Las contraseñas no coinciden';

  @override
  String get navDashboard => 'Inicio';

  @override
  String get navCalendar => 'Calendario';

  @override
  String get navTasks => 'Tareas';

  @override
  String get navProjects => 'Proyectos';

  @override
  String get navSettings => 'Ajustes';

  @override
  String get dashboardTitle => 'Inicio';

  @override
  String get dashboardWelcome => '¡Bienvenido!';

  @override
  String get dashboardOverview => 'Resumen';

  @override
  String get dashboardTasksDue => 'Tareas pendientes';

  @override
  String get dashboardProgress => 'Progreso';

  @override
  String get dashboardQuickAccess => 'Acceso rápido';

  @override
  String get dashboardNotes => 'Notas';

  @override
  String dashboardCourseYear(String course, int year) {
    return '$course • Año $year';
  }

  @override
  String get settingsTitle => 'Ajustes';

  @override
  String get settingsSignedIn => 'Sesión iniciada';

  @override
  String get settingsSecuritySection => 'SEGURIDAD';

  @override
  String get settingsBiometricUnlock => 'Desbloqueo biométrico';

  @override
  String get settingsBiometricUnlockSubtitle =>
      'Requerir tu huella o rostro para abrir la aplicación';

  @override
  String get settingsLanguageSection => 'IDIOMA';

  @override
  String get settingsLanguage => 'Idioma';

  @override
  String get settingsLanguageSubtitle => 'Elige el idioma de la aplicación';

  @override
  String get settingsChooseLanguage => 'Elegir idioma';

  @override
  String get settingsLogout => 'Cerrar sesión';

  @override
  String get biometricNotAvailable =>
      'La autenticación biométrica no está disponible en este dispositivo.';

  @override
  String get biometricNotEnrolled =>
      'Aún no hay huella ni rostro configurado en este dispositivo. Añade uno en los ajustes del dispositivo.';

  @override
  String get biometricAuthCancelled => 'Se canceló la autenticación.';

  @override
  String get biometricEnableReason =>
      'Autentícate para activar el desbloqueo biométrico';

  @override
  String get languageEnglish => 'Inglés';

  @override
  String get languageFrench => 'Francés';

  @override
  String get languageSpanish => 'Español';

  @override
  String get languageGerman => 'Alemán';

  @override
  String get languageJapanese => 'Japonés';

  @override
  String get languageChinese => 'Chino';

  @override
  String get languageSystemDefault => 'Idioma del sistema';

  @override
  String get calendarTitle => 'Calendario';

  @override
  String get calendarDay => 'Día';

  @override
  String get calendarWeek => 'Semana';

  @override
  String get calendarMonth => 'Mes';

  @override
  String get calendarYear => 'Año';

  @override
  String get calendarJumpToToday => 'Ir a hoy';

  @override
  String get calendarNothingScheduled => 'Nada programado';

  @override
  String get calendarAddClass => 'Añadir clase';

  @override
  String get calendarAddTask => 'Añadir tarea';

  @override
  String get calendarAddAssignment => 'Añadir trabajo';

  @override
  String get calendarAddReminder => 'Añadir recordatorio';

  @override
  String get calendarAddEvent => 'Añadir evento';

  @override
  String calendarToday(String date) {
    return 'Hoy, $date';
  }

  @override
  String calendarDeleteItemTitle(String type) {
    return '¿Eliminar $type?';
  }

  @override
  String calendarDeleteItemBody(String title) {
    return '¿Quitar \"$title\"? Esta acción no se puede deshacer.';
  }

  @override
  String get calendarCompleted => 'Completado';

  @override
  String get calendarTaskDue => 'Tarea pendiente';

  @override
  String get calendarClassLabel => 'Clase';

  @override
  String get calendarTaskLabel => 'Tarea';

  @override
  String get calendarAllDay => 'Todo el día';

  @override
  String eventFormNewTitle(String category) {
    return 'Nuevo $category';
  }

  @override
  String eventFormEditTitle(String category) {
    return 'Editar $category';
  }

  @override
  String get eventFormTitleLabel => 'Título';

  @override
  String get eventFormDescriptionLabel => 'Descripción (opcional)';

  @override
  String get eventFormAllDay => 'Todo el día';

  @override
  String eventFormStart(String time) {
    return 'Inicio: $time';
  }

  @override
  String eventFormEnd(String time) {
    return 'Fin: $time';
  }

  @override
  String get eventFormReminder => 'Recordatorio';

  @override
  String get eventFormColor => 'Color';

  @override
  String get eventFormEndBeforeStart =>
      'La hora de fin debe ser posterior a la de inicio';

  @override
  String get categoryAssignment => 'Trabajo';

  @override
  String get categoryReminder => 'Recordatorio';

  @override
  String get categoryEvent => 'Evento';

  @override
  String get classFormNewTitle => 'Añadir clase';

  @override
  String get classFormEditTitle => 'Editar clase';

  @override
  String get classFormSubject => 'Asignatura';

  @override
  String get classFormLocation => 'Ubicación / Sala';

  @override
  String get classFormDay => 'Día';

  @override
  String classFormStart(String time) {
    return 'Inicio: $time';
  }

  @override
  String classFormEnd(String time) {
    return 'Fin: $time';
  }

  @override
  String get classFormColor => 'Color';

  @override
  String get reminderNone => 'Sin recordatorio';

  @override
  String get reminderMinutes5 => '5 minutos antes';

  @override
  String get reminderMinutes15 => '15 minutos antes';

  @override
  String get reminderMinutes30 => '30 minutos antes';

  @override
  String get reminderHour1 => '1 hora antes';

  @override
  String get reminderDay1 => '1 día antes';

  @override
  String get reminderRequiresDueDateHelper =>
      'Requiere una fecha de vencimiento. Usa las 9:00 si no se define hora.';

  @override
  String get tasksTitle => 'Tareas';

  @override
  String get tasksEmpty => 'Aún no hay tareas — toca + para añadir una';

  @override
  String tasksPendingCount(int count) {
    return 'Pendientes ($count)';
  }

  @override
  String tasksCompletedCount(int count) {
    return 'Completadas ($count)';
  }

  @override
  String taskDue(String date) {
    return 'Vence $date';
  }

  @override
  String get taskFormNewTitle => 'Nueva tarea';

  @override
  String get taskFormEditTitle => 'Editar tarea';

  @override
  String get taskFormTitleLabel => 'Título';

  @override
  String get taskFormDescriptionLabel => 'Descripción (opcional)';

  @override
  String get taskFormDueDatePlaceholder => 'Fecha de vencimiento';

  @override
  String get taskFormDueTimePlaceholder => 'Hora de vencimiento';

  @override
  String get taskFormPriority => 'Prioridad';

  @override
  String get priorityLow => 'Baja';

  @override
  String get priorityMedium => 'Media';

  @override
  String get priorityHigh => 'Alta';

  @override
  String get taskFormReminderRequiresDueDate =>
      'Define una fecha de vencimiento para usar un recordatorio';

  @override
  String get taskDeleteTitle => '¿Eliminar tarea?';

  @override
  String taskDeleteBody(String title) {
    return '¿Quitar \"$title\"?';
  }

  @override
  String get notesTitle => 'Notas';

  @override
  String get notesSearchHint => 'Buscar notas...';

  @override
  String get notesEmpty => 'Aún no hay notas — toca + para crear una';

  @override
  String get notesNoMatch => 'Ninguna nota coincide con tu búsqueda';

  @override
  String get filterAll => 'Todas';

  @override
  String get noteDeleteTitle => '¿Eliminar nota?';

  @override
  String noteDeleteBody(String title) {
    return '¿Quitar \"$title\"?';
  }

  @override
  String get noteUntitled => 'Sin título';

  @override
  String get noteEditorNewTitle => 'Nueva nota';

  @override
  String get noteEditorEditTitle => 'Editar nota';

  @override
  String get noteTitleHint => 'Título';

  @override
  String get noteSubjectHint => 'Asignatura / Módulo';

  @override
  String get noteSubjectOther => 'Otra...';

  @override
  String get noteContentHint => 'Empieza a escribir tus notas...';

  @override
  String get noteEnterTitleError => 'Introduce un título';

  @override
  String get noteSaveFailed => 'Error al guardar la nota';

  @override
  String noteTodayAt(String time) {
    return 'Hoy, $time';
  }

  @override
  String get progressTitle => 'Progreso Académico';

  @override
  String get progressOverview => 'Resumen';

  @override
  String get progressSyllabusProgress => 'Progreso\ndel temario';

  @override
  String get progressTaskCompletion => 'Tareas\ncompletadas';

  @override
  String get progressSyllabusCoverage => 'Cobertura del temario por asignatura';

  @override
  String get progressEmpty =>
      'Aún no hay asignaturas registradas — toca + para empezar';

  @override
  String get progressFormTitle => 'Registrar nueva asignatura';

  @override
  String get progressFormSubject => 'Asignatura';

  @override
  String get progressFormSubjectOther => 'Otra...';

  @override
  String get progressFormSubjectName => 'Nombre de la asignatura';

  @override
  String get progressFormTotalTopics =>
      'Total de temas / capítulos del temario';

  @override
  String get progressFormTotalTopicsError =>
      'Introduce un número de al menos 1';

  @override
  String get progressFormSubjectRequired =>
      'Selecciona o introduce una asignatura';

  @override
  String get progressFormStartTracking => 'Empezar seguimiento';

  @override
  String progressTopicsCount(int completed, int total, String percent) {
    return '$completed / $total temas ($percent %)';
  }

  @override
  String get projectsTitle => 'Biblioteca de proyectos';

  @override
  String get projectEmpty => 'Aún no hay proyectos aquí';

  @override
  String get projectDeleteTitle => '¿Eliminar proyecto?';

  @override
  String projectDeleteBody(String title) {
    return '¿Quitar \"$title\"?';
  }

  @override
  String get projectFormNewTitle => 'Nuevo proyecto';

  @override
  String get projectFormEditTitle => 'Editar proyecto';

  @override
  String get projectFormTitleLabel => 'Título del proyecto';

  @override
  String get projectFormDescriptionLabel => 'Descripción (opcional)';

  @override
  String get projectFormSetDueDate => 'Definir fecha de vencimiento (opcional)';

  @override
  String projectFormDuePrefix(String date) {
    return 'Vence: $date';
  }

  @override
  String get projectFormStatus => 'Estado';

  @override
  String projectDue(String date) {
    return 'Vence $date';
  }

  @override
  String get projectStatusOngoing => 'En curso';

  @override
  String get projectStatusPending => 'Pendiente';

  @override
  String get projectStatusCompleted => 'Completado';

  @override
  String get projectStatusCancelled => 'Cancelado';

  @override
  String get profileTitle => 'Editar perfil';

  @override
  String get profileTakePhoto => 'Tomar foto';

  @override
  String get profileChooseGallery => 'Elegir de la galería';

  @override
  String get profilePhotoSaved => 'Foto de perfil guardada';

  @override
  String get profilePhotoFailed => 'Error al guardar la foto';

  @override
  String get profileFullName => 'Nombre completo';

  @override
  String get profileFullNameRequired => 'El nombre es obligatorio';

  @override
  String get profileStudentId => 'ID de estudiante';

  @override
  String get profileCourseMajor => 'Carrera / Especialidad';

  @override
  String get profileYearOfStudy => 'Año de estudio';

  @override
  String profileYearN(int n) {
    return 'Año $n';
  }

  @override
  String get profileSaveChanges => 'Guardar cambios';

  @override
  String get profileUpdated => 'Perfil actualizado';

  @override
  String get profileUpdateFailed => 'Error al actualizar el perfil';

  @override
  String get attachmentsTitle => 'Archivos adjuntos';

  @override
  String get attachmentsAdd => 'Añadir';

  @override
  String get attachmentsNone => 'Aún no hay archivos adjuntos';

  @override
  String attachmentsPendingSuffix(String name) {
    return '$name (pendiente)';
  }

  @override
  String attachmentsOpenFailed(String message) {
    return 'No se pudo abrir el archivo: $message';
  }

  @override
  String get attachTakePhoto => 'Tomar foto';

  @override
  String get attachChooseGallery => 'Elegir de la galería';

  @override
  String get attachChooseFile => 'Elegir archivo';

  @override
  String get appLockedTitle => 'Aplicación bloqueada';

  @override
  String get appLockedSubtitle =>
      'Desbloquea con tu huella o rostro para continuar';

  @override
  String get appLockUnlockButton => 'Desbloquear';

  @override
  String get appLockAuthenticating => 'Autenticando…';

  @override
  String appLockAuthReason(String appName) {
    return 'Autentícate para desbloquear $appName';
  }

  @override
  String get errorLoadTasks => 'Error al cargar las tareas';

  @override
  String get errorAddTask => 'Error al añadir la tarea';

  @override
  String get errorUpdateTask => 'Error al actualizar la tarea';

  @override
  String get errorDeleteTask => 'Error al eliminar la tarea';

  @override
  String get errorLoadNotes => 'Error al cargar las notas';

  @override
  String get errorAddNote => 'Error al añadir la nota';

  @override
  String get errorUpdateNote => 'Error al actualizar la nota';

  @override
  String get errorDeleteNote => 'Error al eliminar la nota';

  @override
  String get errorLoadProjects => 'Error al cargar los proyectos';

  @override
  String get errorAddProject => 'Error al añadir el proyecto';

  @override
  String get errorUpdateProject => 'Error al actualizar el proyecto';

  @override
  String get errorDeleteProject => 'Error al eliminar el proyecto';

  @override
  String get errorLoadEvents => 'Error al cargar los eventos del calendario';

  @override
  String get errorAddEvent => 'Error al añadir el evento';

  @override
  String get errorUpdateEvent => 'Error al actualizar el evento';

  @override
  String get errorDeleteEvent => 'Error al eliminar el evento';

  @override
  String get errorLoadProgress => 'Error al cargar el progreso';

  @override
  String get errorAddModule => 'Error al añadir la asignatura';

  @override
  String get errorUpdateModule => 'Error al actualizar el progreso';

  @override
  String get errorDeleteModule => 'Error al eliminar la asignatura';

  @override
  String get errorLoadProfile => 'Error al cargar el perfil';

  @override
  String get errorSaveProfile => 'Error al guardar el perfil';

  @override
  String get errorSavePhoto => 'Error al guardar la foto';

  @override
  String get errorLoadTimetable => 'Error al cargar el horario';

  @override
  String get errorAddClass => 'Error al añadir la clase';

  @override
  String get errorUpdateClass => 'Error al actualizar la clase';

  @override
  String get errorDeleteClass => 'Error al eliminar la clase';

  @override
  String get errorUpdateAttachments =>
      'Error al actualizar los archivos adjuntos';
}
