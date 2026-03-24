import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:my_skin_routine/app.dart';
import 'package:my_skin_routine/core/utils/notification_utils.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Initialize notifications — non-blocking, app works without them
  try {
    await NotificationService().initialize();
  } catch (e) {
    debugPrint('Notification init failed: $e');
  }

  runApp(
    const ProviderScope(
      child: MySkinRoutineApp(),
    ),
  );
}
