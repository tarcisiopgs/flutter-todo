import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:todo/app/app_widget.dart';
import 'package:todo/core/models/task.dart';
import 'package:todo/core/models/todo.dart';

void main() async {
  await Hive.initFlutter();

  Hive.registerAdapter(TaskAdapter());
  Hive.registerAdapter(TodoAdapter());

  await Hive.openBox<Task>('tasks');

  runApp(
    const AppWidget(
      title: 'Todo App',
    ),
  );
}
