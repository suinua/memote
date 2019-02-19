import 'package:flutter/material.dart';
import 'package:memote/models/task_group.dart';
import 'package:memote/view/pages/task_group_page.dart';

class TaskGroupWidget extends StatelessWidget {
  final TaskGroup taskGroup;

  const TaskGroupWidget(
      {Key key, @required this.taskGroup})
      : super(key: key);

  Widget progressGauge() {
    return Stack(
      children: <Widget>[
        Container(
          height: 15.0,
          width: 100.0,
          decoration: BoxDecoration(
            color: Colors.grey,
            borderRadius: BorderRadius.all(Radius.circular(10.0)),
          ),
          child: null,
        ),
        Container(
          height: 15.0,
          width: taskGroup.progress,
          decoration: BoxDecoration(
            color: Colors.redAccent,
            borderRadius: BorderRadius.all(Radius.circular(10.0)),
          ),
          child: null,
        ),
        Container(
          height: 15.0,
          width: 100.0,
          child: Center(child: Text(taskGroup.progress.toString())),
        )
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (BuildContext context) =>
                TaskGroupPage(taskGroup: taskGroup),
          ),
        );
      },
      child: Container(
        width: 150,
        child: Card(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Hero(
                tag: '${taskGroup.key}_hero_tag',
                child: Material(
                  color: Colors.transparent,
                  child: Text(
                    taskGroup.title,
                    textAlign: TextAlign.center,
                    style: TextStyle(fontSize: 30),
                  ),
                ),
              ),
              progressGauge(),
            ],
          ),
        ),
      ),
    );
  }
}
