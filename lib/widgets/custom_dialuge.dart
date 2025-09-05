import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/todo_provider.dart';

class TaskDialog extends StatefulWidget {
  final int taskIndex;
  final String? initialTitle;
  final String? initialDescription;

  const TaskDialog({
    super.key,
    this.taskIndex = -1,
    this.initialTitle,
    this.initialDescription,
  });

  @override
  State<TaskDialog> createState() => _TaskDialogState();
}

class _TaskDialogState extends State<TaskDialog> {
  final _formKey = GlobalKey<FormState>();
  late TextEditingController _titleController;
  late TextEditingController _descController;

  @override
  void initState() {
    super.initState();
    _titleController = TextEditingController(text: widget.initialTitle ?? "");
    _descController = TextEditingController(
      text: widget.initialDescription ?? "",
    );
  }

  @override
  void dispose() {
    _titleController.dispose();
    _descController.dispose();
    super.dispose();
  }

  void _saveTask() {
    if (_formKey.currentState!.validate()) {
      final todoProvider = Provider.of<TodoProvider>(context, listen: false);
      if (widget.taskIndex == -1) {
        todoProvider.addTask(_titleController.text, _descController.text);
      } else {
        todoProvider.updateTask(
          widget.taskIndex,
          _titleController.text,
          _descController.text,
        );
      }
      Navigator.pop(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(widget.taskIndex == -1 ? "Add Task" : "Edit Task"),
      content: Form(
        key: _formKey,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextFormField(
              controller: _titleController,
              decoration: const InputDecoration(
                labelText: "Title",
                border: OutlineInputBorder(),
              ),
              validator: (value) {
                if (value == null || value.trim().isEmpty) {
                  return "Please enter a title"; // 👈 Error text appears here
                }
                return null;
              },
            ),
            const SizedBox(height: 10),
            TextFormField(
              controller: _descController,
              decoration: const InputDecoration(
                labelText: "Description",
                border: OutlineInputBorder(),
              ),
              validator: (value) {
                if (value == null || value.trim().isEmpty) {
                  return "Please enter a description"; // 👈 Error text appears here
                }
                return null;
              },
            ),
          ],
        ),
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.pop(context),
          child: const Text("Cancel"),
        ),
        ElevatedButton(onPressed: _saveTask, child: const Text("Save")),
      ],
    );
  }
}
