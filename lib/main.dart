import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:my_skin_routine/app.dart';
import 'package:my_skin_routine/core/utils/notification_utils.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await NotificationService().initialize();
  runApp(
    const ProviderScope(
      child: MySkinRoutineApp(),
    ),
  );
}
