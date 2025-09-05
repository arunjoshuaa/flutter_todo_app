// test/home_screen_test.dart
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:provider/provider.dart';
import 'package:to_do_application/providers/todo_provider.dart';
import 'package:to_do_application/screens/home_screen.dart';

void main() {
  testWidgets('Displays added task in the list', (WidgetTester tester) async {
    // Arrange: Build widget with Provider
    await tester.pumpWidget(
      ChangeNotifierProvider(
        create: (_) => TodoProvider(),
        child: const MaterialApp(home: HomeScreen()),
      ),
    );

    // Initially should show "No tasks yet"
    expect(find.text("No tasks yet. Tap + to add one!"), findsOneWidget);

    // Act: Add a task directly through provider
    final provider = Provider.of<TodoProvider>(
      tester.element(find.byType(HomeScreen)),
      listen: false,
    );
    provider.addTask("Test Task", "This is a test");

    // Rebuild widget after provider update
    await tester.pump();

    // Assert: Task should now appear
    expect(find.text("Test Task"), findsOneWidget);
    expect(find.text("This is a test"), findsOneWidget);
  });
}
