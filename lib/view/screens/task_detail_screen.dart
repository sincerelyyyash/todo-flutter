import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../view_model/task_view_model.dart';
import 'add_task_screen.dart';
import '../../data/models/task.model.dart';
import 'package:intl/intl.dart';  

class TaskDetailsScreen extends StatelessWidget {
  final Task task;

  const TaskDetailsScreen({Key? key, required this.task}) : super(key: key);

  String _formatPriority(Priority priority) {
    return priority.toString().split('.').last.toUpperCase();
  }

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

  String _formatDueDate(DateTime dueDate) {
    final DateFormat dateFormatter = DateFormat('yyyy-MM-dd');
    final DateFormat timeFormatter = DateFormat('hh:mm a');
    return '${dateFormatter.format(dueDate)} at ${timeFormatter.format(dueDate)}';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Task Details'),
        actions: [
          IconButton(
            icon: const Icon(Icons.edit),
            onPressed: () => Get.to(() => AddTaskScreen(existingTask: task)),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ListView(
          children: [
            Card(
              child: ListTile(
                title: const Text('Title', style: TextStyle(fontWeight: FontWeight.bold)),
                subtitle: Text(task.title),
              ),
            ),
            if (task.description != null)
              Card(
                child: ListTile(
                  title: const Text('Description', style: TextStyle(fontWeight: FontWeight.bold)),
                  subtitle: Text(task.description!),
                ),
              ),
            Card(
              child: ListTile(
                title: const Text('Priority', style: TextStyle(fontWeight: FontWeight.bold)),
                subtitle: Text(_formatPriority(task.priority)),
                leading: Container(
                  width: 20,
                  color: _getPriorityColor(task.priority),
                ),
              ),
            ),
            Card(
              child: ListTile(
                title: const Text('Created On', style: TextStyle(fontWeight: FontWeight.bold)),
                subtitle: Text(task.createdAt.toLocal().toString().split(' ')[0]),
              ),
            ),
            if (task.dueDate != null)
              Card(
                child: ListTile(
                  title: const Text('Due Date', style: TextStyle(fontWeight: FontWeight.bold)),
                  subtitle: Text(_formatDueDate(task.dueDate!)),
                ),
              ),
            Card(
              child: CheckboxListTile(
                title: const Text('Completed', style: TextStyle(fontWeight: FontWeight.bold)),
                value: task.isCompleted,
                onChanged: (bool? value) {
                  if (value != null) {
                    task.isCompleted = value;
                    Get.find<TaskViewModel>().updateTask(task);
                  }
                },
              ),
            ),
            const SizedBox(height: 16),
            ElevatedButton(
              style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
              onPressed: () {
                Get.find<TaskViewModel>().deleteTask(task.id!);
                Get.back();
              },
              child: const Text('Delete Task', style: TextStyle(color: Colors.white)),
            ),
          ],
        ),
      ),
    );
  }
}
