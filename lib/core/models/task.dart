import 'package:hive_flutter/hive_flutter.dart';
import 'package:todo/core/models/todo.dart';

part 'task.g.dart';

@HiveType(
  typeId: 0,
)
class Task extends HiveObject {
  @HiveField(
    0,
  )
  String? title;

  @HiveField(
    1,
  )
  String? description;

  @HiveField(
    2,
  )
  List<Todo> todos;

  Task({
    this.title,
    this.description,
    required this.todos,
  });
}
