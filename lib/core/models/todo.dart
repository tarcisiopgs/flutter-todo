import 'package:hive_flutter/hive_flutter.dart';

part 'todo.g.dart';

@HiveType(
  typeId: 1,
)
class Todo extends HiveObject {
  @HiveField(
    0,
  )
  final String? title;

  @HiveField(
    1,
  )
  bool finished;

  Todo({
    this.title,
    required this.finished,
  });
}
