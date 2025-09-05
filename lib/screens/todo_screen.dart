import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
final List<Map<String, dynamic>> todoList = [];
final TextEditingController titleController = TextEditingController();
final TextEditingController descriptionController = TextEditingController();
String? titleError;
String? descriptionError;

@override
void dispose() {
  titleController.dispose();
  descriptionController.dispose();
  super.dispose();
}

  int taskIndex=-1;

addTask(String title, String description) {
  setState(() {
    todoList.add({
      'title': title,
      'description': description,
       'completed': false,
    });
    titleController.clear();
    descriptionController.clear();
  });
}

updateTask(String title, String description, int index) {
  setState(() {
    todoList[index] = {
      'title': title,
      'description': description,
       'completed': todoList[index]['completed'],
    };
    taskIndex = -1;
    titleController.clear();
    descriptionController.clear();
  });
}
      deleteTask(int index){
      setState(() {
        todoList.removeAt(index);
      });
  }
void showTaskDialog(BuildContext context) {
    setState(() {
    // Reset errors on dialog open
    titleError = null;
    descriptionError = null;
  });
  showDialog(
    context: context,
    builder: (context) {
      return StatefulBuilder(
         builder: (context, setState) {
        return AlertDialog(
          title: Text(taskIndex == -1 ? 'Add Task' : 'Edit Task'),
          content: SingleChildScrollView(
            child: Column(
              children: [
                TextField(
                  controller: titleController,
                  autofocus: true,
                  decoration: InputDecoration(hintText: "Enter title",errorText: titleError),
                      //                onChanged: (value) {
                      //   if (value.trim().isNotEmpty && titleError != null) {
                      //     setState(() {
                      //       titleError = null;
                      //     });
                      //   }
                      // },
                ),
                SizedBox(height: 10),
                TextField(
                  controller: descriptionController,
                  maxLines: 3,
                  decoration: InputDecoration(hintText: "Enter description",errorText: descriptionError),

                ),
              ],
            ),
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
                titleController.clear();
                descriptionController.clear();
                taskIndex = -1;
              },
              child: Text('Cancel'),
            ),
            TextButton(
              onPressed: () {
                final title = titleController.text.trim();
                final desc = descriptionController.text.trim();
        
                if (title.isEmpty || desc.isEmpty) {
                    setState(() {
                      titleError = title.isEmpty ? 'Title cannot be empty' : null;
                      descriptionError = desc.isEmpty ? 'Description cannot be empty' : null;
                    });
            // If either field is invalid, don't proceed
                    if (titleError != null || descriptionError != null) return;
                  
                }
        
                Navigator.of(context).pop();
        
                if (taskIndex == -1) {
                  addTask(title, desc);
                } else {
                  updateTask(title, desc, taskIndex);
                }
              },
              child: Text(taskIndex == -1 ? 'Add' : 'Update'),
            ),
          ],
        );
         }
      );
    },
  );
}


  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      appBar: AppBar(
        title: Text("Todo App",style: TextStyle(fontWeight: FontWeight.bold,
            fontSize: 30,),),
        centerTitle: true,
        backgroundColor: Colors.blue,
        foregroundColor: Colors.white,
      ),
      body: Container(
        margin: EdgeInsets.all(10),
        child: Column(
          children: [
            Expanded(child: 
ListView.builder(
  itemCount: todoList.length,
  itemBuilder: (context, index) {
    final task = todoList[index];
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8),
      ),
      color: index % 2 == 0 ? Colors.white : Colors.grey[300],
      child: Container(
        padding: EdgeInsets.all(10),
        child: Row(
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    task['title'] ?? '',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 20,
                      decoration: task['completed'] ? TextDecoration.lineThrough : null,  
                    ),
                  ),
                  SizedBox(height: 5),
                  Text(
                    task['description'] ?? '',
                    style: TextStyle(fontSize: 16, decoration: task['completed'] ? TextDecoration.lineThrough : null, ),
                    
                  ),
                         // Add Completed Text if the task is completed
                  if (task['completed']) 
                    Padding(
                      padding: const EdgeInsets.only(top: 5),
                      child: Text(
                        'TaskCompleted!!!',
                        style: TextStyle(
                          color: Colors.green,
                          fontWeight: FontWeight.w200,
                        ),
                      ),
                    ),
                ],
              ),
            ),
                  IconButton(
              onPressed: () {
                setState(() {
                  todoList[index]['completed'] = !todoList[index]['completed'];  // Toggle completion
                });
              },
              icon: Icon(
                task['completed'] ? Icons.check_box : Icons.check_box_outline_blank, // Filled or empty checkbox based on completion
                size: 30,
                color: task['completed'] ? Colors.green : Colors.grey,
              ),
            ),
            IconButton(
              onPressed: () {
                titleController.text = task['title'] ?? '';
                descriptionController.text = task['description'] ?? '';
                taskIndex = index;
                showTaskDialog(context);
              },
              icon: Icon(Icons.edit, size: 30, color: Colors.lightBlueAccent),
            ),
            SizedBox(width: 10),
            IconButton(
              onPressed: () => deleteTask(index),
              icon: Icon(Icons.delete, size: 30, color: Colors.red),
            ),
          ],
        ),
      ),
    );
  },
)

            ),
            
          ],
        ),
      ),
floatingActionButton: FloatingActionButton.extended(
  onPressed: () {
    titleController.clear();
    descriptionController.clear();
    taskIndex = -1;
    showTaskDialog(context);
  },
  icon: Icon(Icons.add),
  label: Text("Add Task"),
  backgroundColor: Colors.blue,
  foregroundColor: Colors.white,
),

    );
  }
}