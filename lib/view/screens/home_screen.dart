import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:todo/view/screens/task_detail_screen.dart';
import '../../view_model/task_view_model.dart';
import 'add_task_screen.dart';
import '../../data/models/task.model.dart';
import 'package:intl/intl.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  String _formatTime(DateTime dateTime) {
    final DateFormat timeFormatter = DateFormat('hh:mm a');
    return timeFormatter.format(dateTime);
  }

  @override
  Widget build(BuildContext context) {
    final TaskViewModel taskViewModel = Get.find();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Todo List'),
        actions: [
          PopupMenuButton<String>(
            onSelected: (value) {
              switch (value) {
                case 'priority':
                  taskViewModel.sortTasksByPriority();
                  break;
                case 'date':
                  taskViewModel.sortTasksByDueDate();
                  break;
              }
            },
            itemBuilder: (context) => [
              const PopupMenuItem(
                value: 'priority',
                child: Text('Sort by Priority'),
              ),
              const PopupMenuItem(
                value: 'date',
                child: Text('Sort by Due Date'),
              ),
            ],
          )
        ],
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              decoration: const InputDecoration(
                hintText: 'Search todos...',
                prefixIcon: Icon(Icons.search),
                border: OutlineInputBorder(),
              ),
              onChanged: (value) {
                taskViewModel.searchTasks(value);
              },
            ),
          ),
          Expanded(
            child: Obx(() {
              if (taskViewModel.tasks.isEmpty) {
                return const Center(
                  child: Text('No tasks yet. Add a task!'),
                );
              }
              return ListView.builder(
                itemCount: taskViewModel.tasks.length,
                itemBuilder: (context, index) {
                  final task = taskViewModel.tasks[index];
                  return TaskListItem(
                    task: task,
                    onDelete: () => taskViewModel.deleteTask(task.id!),
                    onToggleComplete: () {
                      task.isCompleted = !task.isCompleted;
                      taskViewModel.updateTask(task);
                    },
                    onTap: () {
                      Get.to(() => TaskDetailsScreen(task: task));
                    },
                  );
                },
              );
            }),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => Get.to(() => const AddTaskScreen()),
        child: const Icon(Icons.add),
      ),
    );
  }
}

class TaskListItem extends StatelessWidget {
  final Task task;
  final VoidCallback onDelete;
  final VoidCallback onToggleComplete;
  final VoidCallback onTap;

  const TaskListItem({
    Key? key,
    required this.task,
    required this.onDelete,
    required this.onToggleComplete,
    required this.onTap,
  }) : super(key: key);

  Color _getPriorityColor(Priority priority) {
    switch (priority) {
      case Priority.high:
        return Colors.red;
      case Priority.medium:
        return Colors.orange;
      case Priority.low:
        return Colors.green;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      child: ListTile(
        leading: Container(
          width: 10,
          color: _getPriorityColor(task.priority),
        ),
        title: Text(
          task.title,
          style: TextStyle(
            decoration: task.isCompleted
                ? TextDecoration.lineThrough
                : TextDecoration.none,
          ),
        ),
        subtitle: task.dueDate != null
            ? Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                      'Due: ${DateFormat('yyyy-MM-dd').format(task.dueDate!)}'),
                  Text('Time: ${_formatTime(task.dueDate!)}'),
                ],
              )
            : null,
        trailing: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Checkbox(
              value: task.isCompleted,
              onChanged: (_) => onToggleComplete(),
            ),
            IconButton(
              icon: const Icon(Icons.delete, color: Colors.red),
              onPressed: onDelete,
            ),
          ],
        ),
        onTap: onTap,
      ),
    );
  }

  String _formatTime(DateTime dateTime) {
    final DateFormat timeFormatter = DateFormat('hh:mm a');
    return timeFormatter.format(dateTime);
  }
}
