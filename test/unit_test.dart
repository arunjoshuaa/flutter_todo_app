// test/todo_model_test.dart
import 'package:flutter_test/flutter_test.dart';
import 'package:to_do_application/models/todo.dart';

void main() {
  group('Todo Model Tests', () {
    test('Task should be marked completed when toggled', () {
      // Arrange
      final todo = Todo(title: "Test Task", description: "Test Desc");

      // Act
      todo.completed = !todo.completed;

      // Assert
      expect(todo.completed, true);
    });

    test('Task should store correct title and description', () {
      final todo = Todo(
        title: "Read Book",
        description: "Read Flutter in Action",
      );

      expect(todo.title, "Read Book");
      expect(todo.description, "Read Flutter in Action");
      expect(todo.completed, false);
    });
  });
}
