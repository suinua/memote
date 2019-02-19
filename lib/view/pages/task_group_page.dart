import 'package:flutter/material.dart';
import 'package:memote/models/task.dart';
import 'package:memote/models/task_group.dart';
import 'package:memote/view/widgets/add_task_widget.dart';

class TaskGroupPage extends StatelessWidget {
  final TaskGroup taskGroup;

  const TaskGroupPage({Key key, @required this.taskGroup}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomPadding: false,
      floatingActionButton: FloatingActionButton.extended(
        elevation: 4.0,
        icon: const Icon(Icons.add),
        label: Text('add task'),
        onPressed: () {
          showModalBottomSheet(
            context: context,
            builder: (BuildContext context) {
              return AddTaskWidget(parent: taskGroup);
            },
          );
        },
      ),
      appBar: AppBar(
        leading: IconButton(
          onPressed: () => Navigator.pop(context),
          icon: const Icon(Icons.arrow_back, color: Colors.black),
        ),
        actions: <Widget>[
          //todo setting button
        ],
      ),
      body: Column(
        children: <Widget>[
          Center(
            child: Hero(
              tag: '${taskGroup.key}_hero_tag',
              child: Material(
                color: Colors.transparent,
                child: Text(
                  taskGroup.title,
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 40,
                  ),
                ),
              ),
            ),
          ),
          Divider(),
          Expanded(
            child: _buildChildren(),
          ),
        ],
      ),
    );
  }

  Widget _buildChildren() {
    List<Task> children = taskGroup.getAllChildren();
    return ListView.builder(
      itemCount: children.length,
      itemBuilder: (BuildContext context, int index) {
        return children[index].asWidget();
      },
    );
  }
}
