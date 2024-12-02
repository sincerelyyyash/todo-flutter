import 'package:get/get.dart';
import 'package:hive/hive.dart';
import '../models/task.model.dart';

class TaskRepository extends GetxService {
  late Box<Task> _taskBox;

  Future<void> init() async {
    _taskBox = await Hive.openBox<Task>('tasks');
  }


  Future<void> addTask(Task task) async {
    task.id = DateTime.now().toString();
    await _taskBox.put(task.id, task);
  }

 
  List<Task> getAllTasks() => _taskBox.values.toList();

  Task? getTaskById(String id) => _taskBox.get(id);


  Future<void> updateTask(Task task) async {
    await _taskBox.put(task.id, task);
  }


  Future<void> deleteTask(String id) async {
    await _taskBox.delete(id);
  }


  List<Task> searchTasks(String query) {
    return _taskBox.values
        .where((task) => 
          task.title.toLowerCase().contains(query.toLowerCase()) ||
          (task.description?.toLowerCase().contains(query.toLowerCase()) ?? false))
        .toList();
  }


  List<Task> sortByPriority() {
    var tasks = getAllTasks();
    tasks.sort((a, b) => b.comparePriority(a));
    return tasks;
  }

  List<Task> sortByDueDate() {
    var tasks = getAllTasks();
    tasks.sort((a, b) => a.compareDueDate(b));
    return tasks;
  }
}