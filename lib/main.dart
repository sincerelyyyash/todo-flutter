import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:todo/view/screens/home_screen.dart';
import 'package:todo/view_model/task_view_model.dart';
import 'package:todo/data/repositories/task.repo.dart';
import 'package:todo/data/services/notification.service.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:timezone/data/latest.dart' as tz;
import 'package:todo/data/models/task.model.dart';

void main() async {

  WidgetsFlutterBinding.ensureInitialized();

  await Hive.initFlutter();
  Hive.registerAdapter(TaskAdapter());
  Hive.registerAdapter(PriorityAdapter());

  tz.initializeTimeZones();


  final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();


  final notificationService = TodoNotificationService(flutterLocalNotificationsPlugin);
  notificationService.initNotifications();


  final taskRepository = TaskRepository();
  await taskRepository.init();


  Get.put(taskRepository);
  Get.put(notificationService);
  Get.put(TaskViewModel());

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Todo List',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const HomeScreen(),
    );
  }
}
