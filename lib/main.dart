import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:to_do_application/providers/todo_provider.dart';
import 'package:to_do_application/screens/home_screen.dart';

void main(List<String> args) {
  runApp(
    ChangeNotifierProvider(create: (_) => TodoProvider(), child: const MyApp()),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'To-do App',
      home: HomeScreen(),
      debugShowCheckedModeBanner: false,
    );
  }
}
