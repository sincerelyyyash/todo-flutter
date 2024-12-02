import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:timezone/timezone.dart' as tz;
import '../models/task.model.dart' as local_models;

class TodoNotificationService {
  final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin;

  TodoNotificationService(this.flutterLocalNotificationsPlugin);

  void initNotifications() {
    const initializationSettingsAndroid = AndroidInitializationSettings('app_icon');
    const initializationSettingsDarwin = DarwinInitializationSettings();
    const initializationSettings = InitializationSettings(
      android: initializationSettingsAndroid,
      iOS: initializationSettingsDarwin,
    );

    flutterLocalNotificationsPlugin.initialize(initializationSettings);
  }

  void scheduleTaskNotification(local_models.Task task) async {
  if (task.dueDate == null) return;


  var scheduledTime = tz.TZDateTime.from(
    task.dueDate!.subtract(const Duration(hours: 1)),
    tz.local,
  );


  if (scheduledTime.isBefore(tz.TZDateTime.now(tz.local))) {

    scheduledTime = tz.TZDateTime.now(tz.local).add(const Duration(seconds: 10)); 
    print('Scheduled time was in the past. Adjusting to $scheduledTime');
  }


  await flutterLocalNotificationsPlugin.zonedSchedule(
    task.id.hashCode,
    'Task Reminder',
    'Task "${task.title}" is due soon',
    scheduledTime,
    const NotificationDetails(
      android: AndroidNotificationDetails(
        'task_reminder',
        'Task Reminders',
        importance: Importance.high,
        priority: Priority.high,
      ),
    ),
    androidScheduleMode: AndroidScheduleMode.exactAllowWhileIdle,
    uiLocalNotificationDateInterpretation: UILocalNotificationDateInterpretation.absoluteTime,
  );
}
}