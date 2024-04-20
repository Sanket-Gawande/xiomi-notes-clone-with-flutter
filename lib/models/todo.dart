import 'package:hive/hive.dart';
import 'package:flutter/material.dart';

part 'todo.g.dart';

@HiveType(typeId: 1)
class Todo {
  @HiveField(0)
  String? title;

  @HiveField(1)
  bool completed;

  @HiveField(2)
  DateTime? createdAt;

  @HiveField(3)
  DateTime? deadline;

  Todo(
      {required this.title,
      this.completed = false,
      this.deadline,
      this.createdAt}) {}
}
