import 'package:flutter/material.dart';
import 'package:memote/models/task.dart';
import 'package:memote/models/task_group.dart';
import 'package:memote/view/widgets/add_task_widget.dart';

class TaskGroupPage extends StatefulWidget {
  final TaskGroup taskGroup;

  const TaskGroupPage({Key key, @required this.taskGroup}) : super(key: key);

  @override
  _TaskGroupPageState createState() => _TaskGroupPageState();
}

class _TaskGroupPageState extends State<TaskGroupPage> {
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
              return AddTaskWidget(parent: widget.taskGroup);
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
              tag: '${widget.taskGroup.key}_hero_tag',
              child: Material(
                color: Colors.transparent,
                child: Text(
                  widget.taskGroup.title,
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 40,
                  ),
                ),
              ),
            ),
          ),
          progressGauge(),
          Divider(),
          Expanded(
            child: _buildChildren(widget.taskGroup.getAllChildren),
          ),
        ],
      ),
    );
  }

  Widget _buildChildren(List<Task> children) {
    return ListView.builder(
      itemCount: children.length,
      itemBuilder: (BuildContext context, int index) {
        return children[index].asWidget(
          onChecked: (value) {
            widget.taskGroup.updateChild(value);
            setState(() {});
          },
          onRemoved: (value) {
            widget.taskGroup.removeChild(value);
            setState(() {});
          },
        );
      },
    );
  }

  Widget progressGauge() {
    return Stack(
      children: <Widget>[
        Container(
          height: 15.0,
          width: 150.0,
          decoration: BoxDecoration(
            color: Colors.grey,
            borderRadius: BorderRadius.all(Radius.circular(10.0)),
          ),
          child: null,
        ),
        Container(
          height: 15.0,
          width: widget.taskGroup.progress * 1.5,
          decoration: BoxDecoration(
            color: Colors.redAccent,
            borderRadius: BorderRadius.all(Radius.circular(10.0)),
          ),
          child: null,
        ),
        Container(
          height: 15.0,
          width: 150.0,
          child: Center(
              child: Text(
                  '${widget.taskGroup.getCompletedChildren.length} / ${widget.taskGroup.getAllChildren.length}')),
        )
      ],
    );
  }
}
