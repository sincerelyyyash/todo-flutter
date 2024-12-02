import 'package:get/get.dart';
import 'package:todo/data/services/notification.service.dart';
import '../data/models/task.model.dart';
import '../data/repositories/task.repo.dart';


class TaskViewModel extends GetxController {
  final TaskRepository _repository = Get.find();
  final TodoNotificationService _notificationService = Get.find();

  RxList<Task> tasks = <Task>[].obs;
  RxString searchQuery = ''.obs;

  @override
  void onInit() {
    super.onInit();
    fetchTasks();
  }

  void fetchTasks() {
    tasks.value = _repository.getAllTasks();
  }

  void addTask(Task task) async {
    await _repository.addTask(task);

    if (task.dueDate != null) {
      _notificationService.scheduleTaskNotification(task);
    }
    fetchTasks();
  }

  void updateTask(Task task) async {
    await _repository.updateTask(task);
    fetchTasks();
  }

  void deleteTask(String id) async {
    await _repository.deleteTask(id);
    fetchTasks();
  }

  void searchTasks(String query) {
    searchQuery.value = query;
    if (query.isEmpty) {
      fetchTasks();
    } else {
      tasks.value = _repository.searchTasks(query);
    }
  }

  void sortTasksByPriority() {
    tasks.value = _repository.sortByPriority();
  }

  void sortTasksByDueDate() {
    tasks.value = _repository.sortByDueDate();
  }
}
