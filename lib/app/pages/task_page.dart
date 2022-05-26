import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:todo/app/widgets/checkbox_widget.dart';
import 'package:todo/core/models/task.dart';
import 'package:todo/core/models/todo.dart';
import 'package:todo/core/ui/colors.dart';

class TaskPage extends StatefulWidget {
  final dynamic taskKey;

  const TaskPage({
    Key? key,
    this.taskKey,
  }) : super(key: key);

  @override
  State<TaskPage> createState() => _TaskPageState();
}

class _TaskPageState extends State<TaskPage> {
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();
  final TextEditingController _todoController = TextEditingController();
  final _box = Hive.box<Task>('tasks');
  dynamic _taskKey;
  bool _finished = false;

  _handleBack() {
    Navigator.pop(context);
  }

  _handleCreate({
    String? title,
    String? description,
  }) async {
    final identifier = await _box.add(
      Task(
        title: title,
        description: description,
        todos: [],
      ),
    );

    setState(() {
      _taskKey = identifier;
    });
  }

  _handleUpdate({
    String? title,
    String? description,
  }) async {
    final task = _box.get(_taskKey);

    if (title != null) task?.title = title;
    if (description != null) task?.description = description;

    await task?.save();
  }

  _handleDelete() async {
    await _box.delete(_taskKey);

    _handleBack();
  }

  _handleCreateTodo() async {
    final task = _box.get(_taskKey);

    task?.todos.add(
      Todo(
        finished: _finished,
        title: _todoController.text,
      ),
    );

    task?.save();

    _todoController.clear();

    setState(() {
      _finished = false;
    });
  }

  _handleUpdateTodo({
    required bool finished,
    required int index,
  }) async {
    final task = _box.get(_taskKey);

    var todo = task?.todos[index];

    todo?.finished = finished;

    task?.save();
  }

  _handleChangeFinished(bool? value) {
    setState(() {
      _finished = value ?? false;
    });
  }

  _onTaskChanged() {
    if (_taskKey != null) {
      _handleUpdate(
        title: _titleController.text,
        description: _descriptionController.text,
      );
    } else {
      _handleCreate(
        title: _titleController.text,
        description: _descriptionController.text,
      );
    }
  }

  @override
  void initState() {
    if (widget.taskKey != null) {
      final task = _box.get(widget.taskKey);

      _titleController.text = task?.title ?? '';
      _descriptionController.text = task?.description ?? '';

      setState(() {
        _taskKey = widget.taskKey;
      });
    }

    _titleController.addListener(_onTaskChanged);

    _descriptionController.addListener(_onTaskChanged);

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          padding: const EdgeInsets.only(
            top: 32,
          ),
          child: Column(
            children: [
              Row(
                children: [
                  IconButton(
                    icon: Icon(
                      Icons.arrow_back,
                      color: appAccentColor,
                    ),
                    onPressed: () {
                      _handleBack();
                    },
                  ),
                  const SizedBox(
                    width: 12,
                  ),
                  Expanded(
                    child: TextField(
                      controller: _titleController,
                      decoration: const InputDecoration(
                        hintText: 'Enter task title...',
                        border: InputBorder.none,
                      ),
                      style: TextStyle(
                        fontSize: 26,
                        fontWeight: FontWeight.bold,
                        color: appTitleColor,
                      ),
                    ),
                  )
                ],
              ),
              const SizedBox(
                height: 6,
              ),
              TextField(
                controller: _descriptionController,
                decoration: const InputDecoration(
                  hintText: 'Enter description for the task...',
                  border: InputBorder.none,
                  contentPadding: EdgeInsets.symmetric(
                    horizontal: 24,
                  ),
                ),
              ),
              const SizedBox(
                height: 6,
              ),
              _taskKey != null
                  ? Expanded(
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 16,
                        ),
                        child: ValueListenableBuilder<Box>(
                          valueListenable: _box.listenable(keys: [_taskKey]),
                          builder: (context, box, widget) {
                            final task = box.get(_taskKey);

                            return ListView.builder(
                              itemCount: task != null ? task.todos.length : 0,
                              itemBuilder: (context, index) {
                                Todo todo = task.todos[index];

                                return CheckboxWidget(
                                    title: todo.title,
                                    finished: todo.finished,
                                    handleUpdate: (value) {
                                      _handleUpdateTodo(
                                        finished: value,
                                        index: index,
                                      );
                                    });
                              },
                            );
                          },
                        ),
                      ),
                    )
                  : const Spacer(
                      flex: 1,
                    ),
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 16,
                ),
                child: Row(
                  children: [
                    Checkbox(
                      activeColor: appAccentColor,
                      value: _finished,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(6),
                      ),
                      onChanged: _taskKey != null
                          ? (value) {
                              _handleChangeFinished(value);
                            }
                          : null,
                    ),
                    const SizedBox(
                      width: 6,
                    ),
                    Expanded(
                      child: TextField(
                        enabled: _taskKey != null,
                        controller: _todoController,
                        onSubmitted: (_) {
                          _handleCreateTodo();
                        },
                        decoration: const InputDecoration(
                          hintText: 'Enter todo item...',
                          border: InputBorder.none,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
      floatingActionButton: Visibility(
        visible: _taskKey != null,
        child: FloatingActionButton(
          backgroundColor: appDangerColor,
          onPressed: () {
            _handleDelete();
          },
          child: const Icon(
            Icons.delete_forever,
          ),
        ),
      ),
    );
  }
}
