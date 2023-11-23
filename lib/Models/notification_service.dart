import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:timezone/timezone.dart' as tz;
import 'package:timezone/data/latest.dart' as tz;
import 'package:to_do/Models/task.dart';

class NotificationService {
  static final FlutterLocalNotificationsPlugin localNotificationsService = FlutterLocalNotificationsPlugin();

  static Future<void> init() async {
    tz.initializeTimeZones();
    AndroidInitializationSettings androidInitializationSettings = const AndroidInitializationSettings('task');
    // DarwinInitializationSettings darwinInitializationSettings = const DarwinInitializationSettings(
    //   requestAlertPermission: true,
    //   requestBadgePermission: true,
    //   requestCriticalPermission: true,
    //   requestSoundPermission: true,
    //   requestProvisionalPermission: true,
    //   onDidReceiveLocalNotification: _onDidReceiveLocalNotification,
    // );
    InitializationSettings initializationSettings = InitializationSettings(
      android: androidInitializationSettings,
    );
    await localNotificationsService.initialize(
      initializationSettings,
      onDidReceiveNotificationResponse: _onDidReceiveNotificationResponse,
      onDidReceiveBackgroundNotificationResponse: _onDidReceiveBackgroundNotificationResponse,
    );
  }

  // static void _onDidReceiveLocalNotification(int id, String? title, String? body, String? payload) {}

  static Future<void> pushScheduleNotification({required Task task, required bool isRescheduled}) async {
    NotificationDetails notificationDetails = _getNotificationDetails();
    await localNotificationsService.zonedSchedule(
      task.id,
      task.name,
      task.description,
      // tz.TZDateTime.from(dateTime, tz.local),
      getTimeZone(task, isRescheduled),
      notificationDetails,
      uiLocalNotificationDateInterpretation: UILocalNotificationDateInterpretation.absoluteTime,
    );
  }

  static void _onDidReceiveNotificationResponse(NotificationResponse details) {}

  static void _onDidReceiveBackgroundNotificationResponse(NotificationResponse details) {}

  static NotificationDetails _getNotificationDetails() {
    AndroidNotificationDetails androidNotificationDetails = const AndroidNotificationDetails(
      'todoCh',
      'todo_channel',
      importance: Importance.max,
      priority: Priority.max,
      playSound: true,
      sound: RawResourceAndroidNotificationSound('ringtone'),
    );
    // DarwinNotificationDetails darwinNotificationDetails = const DarwinNotificationDetails();
    return NotificationDetails(android: androidNotificationDetails);
  }

  static tz.TZDateTime getTimeZone(Task task, bool isRescheduled) {
    tz.TZDateTime timeZone = tz.TZDateTime.from(
      task.startDateTime!,
      tz.local,
    );

    if ((timeZone.isBefore(tz.TZDateTime.now(tz.local)) || isRescheduled) && task.repeat != 'none') {
      DateTime dateTime = task.startDateTime!;
      switch (task.repeat) {
        case 'daily':
          dateTime.add(const Duration(days: 1));
          break;
        case 'weekly':
          dateTime.add(const Duration(days: 7));
          break;
        case 'monthly':
          dateTime.add(const Duration(days: 30));
          break;
      }
      timeZone = tz.TZDateTime.from(
        dateTime,
        tz.local,
      );
    }
    return timeZone;
  }
}
