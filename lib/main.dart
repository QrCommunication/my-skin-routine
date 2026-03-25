import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:my_skin_routine/app.dart';
import 'package:my_skin_routine/core/utils/notification_utils.dart';
import 'package:my_skin_routine/presentation/router/app_router.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Initialize notifications — always register callback even if init fails
  try {
    await NotificationService().initialize();
  } catch (e) {
    debugPrint('Notification init failed: $e');
  }

  // Always register tap handler
  NotificationService().onNotificationTap = (routineId) {
    appRouter.go('/routines/$routineId');
  };

  runApp(
    const ProviderScope(
      child: MySkinRoutineApp(),
    ),
  );
}
