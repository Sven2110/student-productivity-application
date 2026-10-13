import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';

import 'config/firebase_options.dart';
import 'core/services/notification_service.dart';
import 'app/app.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  // Set up the notification plugin and ask for permission before the
  // app renders. Asking this early (even before login) means the
  // system permission dialog is out of the way immediately, rather
  // than interrupting the user mid-task later.
  await NotificationService().init();
  await NotificationService().requestPermission();

  runApp(const StudentProductivityApp());
}