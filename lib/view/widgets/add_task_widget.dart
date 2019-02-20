import 'package:flutter/material.dart';
import 'package:memote/models/task.dart';
import 'package:memote/models/task_group.dart';

class AddTaskWidget extends StatefulWidget {
  final TaskGroup parent;

  const AddTaskWidget({Key key, @required this.parent}) : super(key: key);

  @override
  _AddTaskWidgetState createState() => _AddTaskWidgetState();
}

class _AddTaskWidgetState extends State<AddTaskWidget> {
  TextEditingController taskTextController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding:
          EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
      child: Row(
        children: <Widget>[
          Expanded(
              child: TextField(
            controller: taskTextController,
          )),
          RaisedButton(
            onPressed: () {
              widget.parent.addChild(
                  Task(taskTextController.text));
              Navigator.pop(context);
            },
            child: Icon(Icons.add),
          )
        ],
      ),
    );
  }
}
