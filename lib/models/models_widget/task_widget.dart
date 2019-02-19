import 'package:flutter/material.dart';
import 'package:memote/models/task.dart';

class TaskWidget extends StatefulWidget {
  final Task task;
  final Function(Task) onRemoved;
  final Function(Task) onChecked;

  const TaskWidget(
      {Key key,
      @required this.task,
      @required this.onRemoved,
      @required this.onChecked})
      : super(key: key);

  @override
  _TaskWidgetState createState() => _TaskWidgetState();
}

class _TaskWidgetState extends State<TaskWidget> {
  @override
  Widget build(BuildContext context) {
    return ListTile(
        title: Text(widget.task.text),
        onTap: () {
          print('tap');
        },
        trailing: AnimatedContainer(
          duration: const Duration(milliseconds: 400),
          child: widget.task.isComplete
              ? IconButton(
                  icon: Icon(Icons.check),
                  onPressed: () {
                    setState(() {
                      widget.task.isComplete = !widget.task.isComplete;
                    });
                    widget.onChecked(widget.task);
                  },
                )
              : IconButton(
                  icon: Icon(Icons.check_box_outline_blank),
                  onPressed: () {
                    setState(() {
                      widget.task.isComplete = !widget.task.isComplete;
                    });
                    widget.onChecked(widget.task);
                  },
                ),
        ));
  }
}
