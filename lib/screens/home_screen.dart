import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:to_do_application/widgets/custom_dialuge.dart';
import '../providers/todo_provider.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  void openTaskDialog(BuildContext context, {int taskIndex = -1}) {
    final todoProvider = Provider.of<TodoProvider>(context, listen: false);
    final task = taskIndex == -1 ? null : todoProvider.todos[taskIndex];

    showDialog(
      context: context,
      builder: (_) => TaskDialog(
        taskIndex: taskIndex,
        initialTitle: task?.title,
        initialDescription: task?.description,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final todoProvider = Provider.of<TodoProvider>(context);
    final todoList = todoProvider.todos;

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Todo App",
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 30),
        ),
        centerTitle: true,
        backgroundColor: Colors.blue,
        foregroundColor: Colors.white,
      ),
      body: todoList.isEmpty
          ? const Center(
              child: Text(
                "No tasks yet. Tap + to add one!",
                style: TextStyle(fontSize: 18, color: Colors.grey),
              ),
            )
          : Container(
              padding: EdgeInsets.all(10),
              //  margin: const EdgeInsets.all(10),
              child: ListView.builder(
                itemCount: todoList.length,
                itemBuilder: (context, index) {
                  final task = todoList[index];
                  return Card(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                    color: index % 2 == 0 ? Colors.white : Colors.grey[300],
                    child: ListTile(
                      title: Text(
                        task.title,
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 20,
                          decoration: task.completed
                              ? TextDecoration.lineThrough
                              : null,
                        ),
                      ),
                      subtitle: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            task.description,
                            style: TextStyle(
                              fontSize: 16,
                              decoration: task.completed
                                  ? TextDecoration.lineThrough
                                  : null,
                            ),
                          ),
                          if (task.completed)
                            const Padding(
                              padding: EdgeInsets.only(top: 5),
                              child: Text(
                                'Task Completed!!!',
                                style: TextStyle(color: Colors.green),
                              ),
                            ),
                        ],
                      ),
                      trailing: Wrap(
                        spacing: 10,
                        children: [
                          IconButton(
                            onPressed: () => todoProvider.toggleTask(index),
                            icon: Icon(
                              task.completed
                                  ? Icons.check_box
                                  : Icons.check_box_outline_blank,
                              color: task.completed
                                  ? Colors.green
                                  : Colors.grey,
                            ),
                          ),
                          IconButton(
                            onPressed: () =>
                                openTaskDialog(context, taskIndex: index),
                            icon: const Icon(Icons.edit, color: Colors.blue),
                          ),
                          IconButton(
                            onPressed: () => todoProvider.deleteTask(index),
                            icon: const Icon(Icons.delete, color: Colors.red),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
      floatingActionButton: Padding(
        padding: const EdgeInsets.only(bottom: 50),
        child: FloatingActionButton.extended(
          backgroundColor: Colors.blue,
          foregroundColor: Colors.white,
          onPressed: () => openTaskDialog(context),
          icon: const Icon(Icons.add),
          label: const Text("Add Task"),
        ),
      ),
    );
  }
}
