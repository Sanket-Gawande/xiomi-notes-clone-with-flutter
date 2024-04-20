import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:mi_notes/models/todo.dart';

class TodoProvider extends ChangeNotifier {
  TodoProvider() {
    init();
  }
  List todos = [];

  Box _todos = Hive.box('tasks_box');

  void init() {
    final t = _todos.get('todos') ?? [];
    for (var todo in t) {
      todos.add(todo);
    }
    notifyListeners();
  }

  void update() async {
    _todos.put('todos', todos);
    notifyListeners();
    print("database updated, number of records ${todos.length}");
  }

  void addTodo(Todo todo) {
// add Todo into Todos
// update database
// change notifier

    todos.add({
      "title": todo.title,
      "completed": todo.completed,
      "deadline": todo.deadline,
      "createdAt": todo.createdAt ?? DateTime.timestamp(),
    });
    update();
  }

  void updateTodo(bool completed, int index) {
    todos[index]["completed"] = completed;
    update();
  }

  void deleteTodo(int id) {
// delete id from Todos
// delete from box
//  notify change
    todos.removeAt(id);
    update();
  }
}
