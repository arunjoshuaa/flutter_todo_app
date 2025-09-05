import 'package:flutter/material.dart';
import 'package:to_do_application/screens/todo_screen.dart';

void main(List<String> args) {
  runApp(MyApp());
}
class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return  MaterialApp(
      title: 'To-do App',
      home: HomeScreen(),
      debugShowCheckedModeBanner: false,
    );
  }
}

