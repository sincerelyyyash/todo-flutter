import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../view_model/task_view_model.dart';
import '../../data/models/task.model.dart';

class AddTaskScreen extends StatefulWidget {
  final Task? existingTask;
  
  const AddTaskScreen({Key? key, this.existingTask}) : super(key: key);

  @override
  _AddTaskScreenState createState() => _AddTaskScreenState();
}

class _AddTaskScreenState extends State<AddTaskScreen> {
  final _formKey = GlobalKey<FormState>();
  late String _title;
  String? _description;
  Priority _priority = Priority.low;
  DateTime? _dueDate;

  @override
  void initState() {
    super.initState();


    _title = widget.existingTask?.title ?? '';
    _description = widget.existingTask?.description;
    _priority = widget.existingTask?.priority ?? Priority.low;
    _dueDate = widget.existingTask?.dueDate;
  }


  void _selectDate() async {
    final DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: _dueDate ?? DateTime.now(),
      firstDate: DateTime.now(),
      lastDate: DateTime(2101),
    );


    if (pickedDate != null) {
      final TimeOfDay? pickedTime = await showTimePicker(
        context: context,
        initialTime: TimeOfDay.fromDateTime(_dueDate ?? DateTime.now()),
      );


      if (pickedTime != null) {
        setState(() {
          _dueDate = DateTime(
            pickedDate.year,
            pickedDate.month,
            pickedDate.day,
            pickedTime.hour,
            pickedTime.minute,
          );
        });
      }
    }
  }


  void _saveTask() {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();
      
      final task = Task(
        id: widget.existingTask?.id,
        title: _title,
        description: _description,
        priority: _priority,
        dueDate: _dueDate,
      );

      final TaskViewModel taskViewModel = Get.find();
      
      if (widget.existingTask == null) {
        taskViewModel.addTask(task);
      } else {
        taskViewModel.updateTask(task);
      }

      Get.back();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.existingTask == null 
          ? 'Add New Task' 
          : 'Edit Task'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [

              TextFormField(
                initialValue: _title,
                decoration: const InputDecoration(
                  labelText: 'Task Title',
                  border: OutlineInputBorder(),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter a task title';
                  }
                  return null;
                },
                onSaved: (value) => _title = value!,
              ),
              const SizedBox(height: 16),
              

              TextFormField(
                initialValue: _description,
                decoration: const InputDecoration(
                  labelText: 'Description (Optional)',
                  border: OutlineInputBorder(),
                ),
                maxLines: 3,
                onSaved: (value) => _description = value,
              ),
              const SizedBox(height: 16),

              DropdownButtonFormField<Priority>(
                value: _priority,
                decoration: const InputDecoration(
                  labelText: 'Priority',
                  border: OutlineInputBorder(),
                ),
                items: Priority.values
                    .map((priority) => DropdownMenuItem(
                          value: priority,
                          child: Text(priority.toString().split('.').last.toUpperCase()),
                        ))
                    .toList(),
                onChanged: (value) {
                  setState(() {
                    _priority = value!;
                  });
                },
              ),
              const SizedBox(height: 16),


              ListTile(
                title: Text(
                  _dueDate == null 
                    ? 'Select Due Date' 
                    : 'Due Date: ${_dueDate!.toLocal()}'.split(' ')[0] + ' ${_dueDate!.toLocal().toString().split(' ')[1].substring(0,5)}',
                ),
                trailing: const Icon(Icons.calendar_today),
                onTap: _selectDate,
              ),
              const SizedBox(height: 24),

              ElevatedButton(
                onPressed: _saveTask,
                child: Text(widget.existingTask == null 
                  ? 'Create Task' 
                  : 'Update Task'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
