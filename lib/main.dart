import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'todo_controller.dart';

Future<void> main() async {
  await GetStorage.init();
  runApp(TodoApp());
}

class TodoApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Todo App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: TodoListScreen(),
    );
  }
}

class TodoListScreen extends StatelessWidget {
  // New line
  final TodoController todoController = Get.put(TodoController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Todo List'),
      ),
      body: Obx(  // New lines
            () => ListView.builder(
          itemCount: todoController.todoList.length,
          itemBuilder: (context, index) {
            final todo = todoController.todoList[index];
            return ListTile(
              title: Text(
                todo.title,
                style: todo.completed
                    ? TextStyle(decoration: TextDecoration.lineThrough)
                    : null,
              ),
              trailing: Checkbox(
                value: todo.completed,
                onChanged: (value) => todoController.toggleTodo(index),
              ),
            );
          },
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () { // Enabling the button
          Get.dialog(
            AlertDialog(
              title: Text('New Todo'),
              content: TextFormField(
                onFieldSubmitted: (value) {
                  todoController.addTodo(value);
                  Get.back();
                },
                decoration: InputDecoration(
                  hintText: 'Enter todo title',
                ),
              ),
            ),
          );
        },
        child: Icon(Icons.add),
      ),
    );
  }
}