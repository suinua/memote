import 'package:flutter/material.dart';
import 'package:memote/models/task.dart';

class TaskWidget extends StatefulWidget {
  final Task task;

  const TaskWidget({Key key, this.task}) : super(key: key);

  @override
  _TaskWidgetState createState() => _TaskWidgetState();
}

class _TaskWidgetState extends State<TaskWidget> {
  @override
  Widget build(BuildContext context) {
    return ListTile(
        title: Text(widget.task.text),
        trailing: AnimatedContainer(
          duration: const Duration(milliseconds: 400),
          child: widget.task.isComplete
              ? Icon(Icons.check)
              : Icon(Icons.check_box_outline_blank),
        ));
  }
}
