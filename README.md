📝 To-Do App

A simple To-Do Application built with Flutter.
This app demonstrates CRUD operations (Create, Read, Update, Delete) with state management using Provider, and includes unit & widget testing.

🚀 Features

Add a new task (title & description)

Edit an existing task

Mark tasks as complete/incomplete (with strikethrough style for completed tasks)

Delete tasks

Clean and responsive UI built with Flutter

State management with Provider

Unit test for model logic

Widget test for verifying UI updates


🛠️ Tech Stack

Flutter
 (UI framework)

Provider
 (state management)

Dart
 (programming language)

📂 Project Structure
lib/
 ├── models/
 │    └── todo.dart          # Task model
 ├── providers/
 │    └── todo_provider.dart # State management with ChangeNotifier
 ├── widgets/
 │    └── custom_dialog.dart # Task add/edit dialog
 └── screens/
      └── home_screen.dart   # Main home screen

✅ Testing

Unit Test → Tests the Todo model logic (todo_model_test.dart)

Widget Test → Verifies task list UI updates correctly with Provider (home_screen_test.dart)

Run tests with:

flutter test

📦 Getting Started

Clone the repo

git clone https://github.com/arunjoshuaa/flutter_todo_app.git
cd todo_app


Install dependencies

flutter pub get


Run the app

flutter run


Run tests

flutter test
