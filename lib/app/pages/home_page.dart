import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:todo/app/pages/task_page.dart';
import 'package:todo/app/widgets/card_widget.dart';
import 'package:todo/core/models/task.dart';
import 'package:todo/core/ui/colors.dart';

class HomePage extends StatefulWidget {
  const HomePage({
    Key? key,
  }) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final _box = Hive.box<Task>('tasks');

  _handleForm({dynamic taskKey}) async {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => TaskPage(
          taskKey: taskKey,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          width: double.infinity,
          padding: const EdgeInsets.symmetric(
            horizontal: 24,
            vertical: 32,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Image.asset(
                'assets/images/logo.png',
              ),
              const SizedBox(
                height: 32,
              ),
              Expanded(
                child: ValueListenableBuilder<Box>(
                  valueListenable: _box.listenable(),
                  builder: (context, box, widget) {
                    return ListView.builder(
                      itemCount: box.values.length,
                      itemBuilder: (context, index) {
                        Task task = box.getAt(index);

                        return GestureDetector(
                          onTap: () {
                            _handleForm(
                              taskKey: task.key,
                            );
                          },
                          child: CardWidget(
                            title: task.title,
                            description: task.description,
                          ),
                        );
                      },
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: appAccentColor,
        onPressed: () {
          _handleForm();
        },
        child: const Icon(
          Icons.add,
        ),
      ),
    );
  }
}
