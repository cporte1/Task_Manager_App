import 'package:flutter/material.dart';

void main() {
  runApp(MaterialApp(home: TaskListScreen()));
}

class TaskListScreen extends StatefulWidget {
  @override
  TaskListScreenState createState() => TaskListScreenState();
}

class TaskListScreenState extends State<TaskListScreen> {
  List<Task> tasks = [];

  void addTask(String task) {
    setState(() {
      tasks.add(Task(name: task));
    });
  }

  void CheckOffTask(int index) {
    setState(() {
      tasks[index].check = !tasks[index].check;
    });
  }

  void deleteTask(int index) {
    setState(() {
      tasks.removeAt(index);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Task Manager'),
      ),
      body: Column(
        children: [
          TextField(
            decoration: const InputDecoration(
              hintText: 'Name of task',
            ),
            onSubmitted: (value) {
              if (value.isNotEmpty) {
                addTask(value);
              }
            },
          ),
          ElevatedButton(
            onPressed: () {
              showDialog(
                context: context,
                builder: (context) {
                  return AlertDialog(
                    title: const Text('Add Task'),
                    content: TextField(
                      decoration: const InputDecoration(
                        hintText: 'Name of task',
                      ),
                      onSubmitted: (value) {
                        if (value.isNotEmpty) {
                          addTask(value);
                          Navigator.pop(context);
                        }
                      },
                    ),
                    actions: [
                      TextButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        child: const Text('Cancel'),
                      ),
                      TextButton(
                        onPressed: () {
                          Navigator.pop(context);
                          //addTask(value);
                        },
                        child: const Text('Add'),
                      ),
                    ],
                  );
                },
              );
            },
            child: const Text('Add'),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: tasks.length,
              itemBuilder: (context, index) {
                return ListTile(
                  leading: Checkbox(
                      value: tasks[index].check,
                      onChanged: (value) {
                        CheckOffTask(index);
                      }),
                  title: Text(tasks[index].name),
                  trailing: IconButton(
                    icon: const Icon(Icons.delete),
                    onPressed: () {
                      deleteTask(index);
                    },
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

class Task {
  String name;
  bool check;

  Task({required this.name, this.check = false});
}
