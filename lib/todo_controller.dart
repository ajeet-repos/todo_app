import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class TodoItem {
  String title;
  bool completed;

  TodoItem({required this.title, this.completed = false});

  Map<String, dynamic> toJson() {
    return {
      'title': title,
      'completed': completed,
    };
  }

  static TodoItem fromJson(Map<String, dynamic> json) {
    return TodoItem(
      title: json['title'],
      completed: json['completed'],
    );
  }
}

class TodoController extends GetxController {
  var todoList = <TodoItem>[].obs;
  final _storage = GetStorage();

  @override
  void onInit() {
    super.onInit();
    loadTodos();
  }

  void loadTodos() {
    print("load todo called");
    final jsonList = _storage.read<List>('todos');
    print(jsonList);
    if (jsonList != null) {
      todoList.value = jsonList.map((json) => TodoItem.fromJson(json)).toList();
    } else {
      print("json stored is null");
    }
  }

  void saveTodos() {
    final jsonList = todoList.map((todo) => todo.toJson()).toList();
    _storage.write('todos', jsonList);
    print("todo saved to storage");
    print(jsonList);
  }

  void addTodo(String title) {
    todoList.add(TodoItem(title: title));
    saveTodos();
  }

  void toggleTodo(int index) {
    todoList[index].completed = !todoList[index].completed;
    todoList.refresh();
    saveTodos();
  }

  void removeTodo(int index) {
    todoList.removeAt(index);
    saveTodos();
  }
}