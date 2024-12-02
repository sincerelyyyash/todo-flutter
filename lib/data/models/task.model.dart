import 'package:hive/hive.dart';

part 'task.model.g.dart';

@HiveType(typeId: 0)
enum Priority {
  @HiveField(0)
  low,
  @HiveField(1)
  medium,
  @HiveField(2)
  high,
}

@HiveType(typeId: 1)
class Task extends HiveObject {
  @HiveField(0)
  String? id;

  @HiveField(1)
  String title;

  @HiveField(2)
  String? description;

  @HiveField(3)
  Priority priority;

  @HiveField(4)
  DateTime createdAt;

  @HiveField(5)
  DateTime? dueDate;

  @HiveField(6)
  bool isCompleted;

  Task({
    this.id,
    required this.title,
    this.description,
    this.priority = Priority.low,
    DateTime? createdAt,
    this.dueDate,
    this.isCompleted = false,
  }) : createdAt = createdAt ?? DateTime.now();

  int comparePriority(Task other) =>
      priority.index.compareTo(other.priority.index);

  int compareDueDate(Task other) {
    if (dueDate == null) return 1;
    if (other.dueDate == null) return -1;
    return dueDate!.compareTo(other.dueDate!);
  }
}
