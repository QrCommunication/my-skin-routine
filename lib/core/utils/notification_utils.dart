import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:timezone/timezone.dart' as tz;
import 'package:timezone/data/latest.dart' as tz;
import 'package:flutter_timezone/flutter_timezone.dart';
import 'package:permission_handler/permission_handler.dart';

/// Callback for handling notification taps. Set by the app to navigate.
typedef NotificationTapCallback = void Function(int routineId);

class NotificationService {
  static final NotificationService _instance = NotificationService._();
  factory NotificationService() => _instance;
  NotificationService._();

  final FlutterLocalNotificationsPlugin _plugin =
      FlutterLocalNotificationsPlugin();

  NotificationTapCallback? onNotificationTap;
  bool _initialized = false;

  Future<void> initialize() async {
    if (_initialized) return;

    tz.initializeTimeZones();
    try {
      final timeZoneInfo = await FlutterTimezone.getLocalTimezone();
      final timeZoneName = timeZoneInfo.toString().contains('(')
          ? timeZoneInfo.toString().split('(').first.trim()
          : timeZoneInfo.toString();
      tz.setLocalLocation(tz.getLocation(timeZoneName));
    } catch (_) {
      try {
        tz.setLocalLocation(tz.getLocation('Europe/Paris'));
      } catch (_) {
        // Last resort — use UTC offset approach
      }
    }

    const androidSettings =
        AndroidInitializationSettings('@mipmap/ic_launcher');
    const iosSettings = DarwinInitializationSettings(
      requestAlertPermission: false,
      requestBadgePermission: false,
      requestSoundPermission: false,
    );

    await _plugin.initialize(
      settings: const InitializationSettings(
        android: androidSettings,
        iOS: iosSettings,
      ),
      onDidReceiveNotificationResponse: (NotificationResponse response) {
        // The payload contains the routine ID
        final payload = response.payload;
        if (payload != null && onNotificationTap != null) {
          final routineId = int.tryParse(payload);
          if (routineId != null) {
            onNotificationTap!(routineId);
          }
        }
      },
    );

    _initialized = true;
    debugPrint('NotificationService initialized');
  }

  Future<bool> requestPermission() async {
    if (Platform.isIOS) {
      final granted = await _plugin
          .resolvePlatformSpecificImplementation<
              IOSFlutterLocalNotificationsPlugin>()
          ?.requestPermissions(alert: true, badge: true, sound: true);
      return granted ?? false;
    } else if (Platform.isAndroid) {
      final status = await Permission.notification.request();
      return status.isGranted;
    }
    return false;
  }

  /// Schedule a daily notification for a routine at the given time.
  /// [routineId] is used as both the notification ID and the payload.
  Future<void> scheduleRoutineReminder({
    required int routineId,
    required String routineName,
    required int hour,
    required int minute,
    required int actionCount,
  }) async {
    if (!_initialized) {
      debugPrint('NotificationService not initialized, skipping schedule');
      return;
    }

    // Request permission first
    final hasPermission = await requestPermission();
    if (!hasPermission) {
      debugPrint('Notification permission denied');
      return;
    }

    try {
      await _plugin.zonedSchedule(
        id: routineId,
        title: routineName,
        body: '$actionCount action(s) vous attendent 💜',
        scheduledDate: _nextInstanceOfTime(hour, minute),
        notificationDetails: NotificationDetails(
          android: AndroidNotificationDetails(
            'routine_reminders',
            'Rappels de routine',
            channelDescription: 'Rappels pour vos routines de soin',
            importance: Importance.high,
            priority: Priority.high,
            icon: '@mipmap/ic_launcher',
          ),
          iOS: const DarwinNotificationDetails(
            presentAlert: true,
            presentBadge: true,
            presentSound: true,
          ),
        ),
        payload: routineId.toString(),
        androidScheduleMode: AndroidScheduleMode.inexactAllowWhileIdle,
        matchDateTimeComponents: DateTimeComponents.time,
      );
      debugPrint('Notification scheduled for $routineName at $hour:$minute');
    } catch (e) {
      debugPrint('Failed to schedule notification: $e');
    }
  }

  Future<void> cancelRoutineReminder(int routineId) async {
    await _plugin.cancel(id: routineId);
    debugPrint('Notification cancelled for routine $routineId');
  }

  Future<void> cancelAll() async {
    await _plugin.cancelAll();
  }

  tz.TZDateTime _nextInstanceOfTime(int hour, int minute) {
    final now = tz.TZDateTime.now(tz.local);
    var scheduledDate = tz.TZDateTime(
      tz.local,
      now.year,
      now.month,
      now.day,
      hour,
      minute,
    );
    if (scheduledDate.isBefore(now)) {
      scheduledDate = scheduledDate.add(const Duration(days: 1));
    }
    return scheduledDate;
  }
}
