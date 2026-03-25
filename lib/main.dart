import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:my_skin_routine/app.dart';
import 'package:my_skin_routine/core/utils/notification_utils.dart';
import 'package:my_skin_routine/presentation/router/app_router.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Initialize notifications
  try {
    await NotificationService().initialize();
    // When user taps a notification, navigate to the routine
    NotificationService().onNotificationTap = (routineId) {
      appRouter.go('/routines/$routineId');
    };
  } catch (e) {
    debugPrint('Notification init failed: $e');
  }

  runApp(
    const ProviderScope(
      child: MySkinRoutineApp(),
    ),
  );
}
