import 'package:flutter/material.dart';
import 'package:to_do_application/models/todo.dart';

class TodoProvider with ChangeNotifier {
  final List<Todo> _todos = [];
  List<Todo> get todos => _todos;
  void addTask(String title, String description) {
    _todos.add(Todo(title: title, description: description));
    notifyListeners();
  }

  void updateTask(int index, String title, String description) {
    _todos[index].title = title;
    _todos[index].description = description;
    notifyListeners();
  }

  void deleteTask(int index) {
    _todos.removeAt(index);
    notifyListeners();
  }

  void toggleTask(int index) {
    _todos[index].completed = !_todos[index].completed;
    notifyListeners();
  }
}
