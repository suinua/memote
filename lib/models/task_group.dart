import 'package:flutter/cupertino.dart';
import 'package:memote/bloc/task_group_children_bloc.dart';
import 'package:memote/models/models_widget/task_group_widget.dart';
import 'package:memote/models/task.dart';

class TaskGroup {
  final String key;
  TaskGroupChildrenBloc _childrenBloc;

  String title;
  List<Task> _children;

  double get progress => getNotCompletedChildren.length / getAllChildren.length * 10;

  List<Task> get getAllChildren => _children;

  List<Task> get getCompletedChildren => _children.where((task) => task.isComplete).toList();

  List<Task> get getNotCompletedChildren => _children.where((task) => !task.isComplete).toList();

  Map<String, dynamic> asMap() => {
        "title": title,
        "children": _children.map((child) => child.asMap()).toList(),
      };

  Widget asWidget() => TaskGroupWidget(taskGroup: this);

  void setChild(List<Task> children){
    _children = children;
  }
  void addChild(Task task) {
    _childrenBloc.addChild.add(task);
  }

  void removeChild(Task task) {
    _childrenBloc.removeChild.add(task);
  }

  void updateChild(Task task) {
    _childrenBloc.updateChild.add(task);
  }

  TaskGroup(this.title, {this.key, children}) {
    _childrenBloc = TaskGroupChildrenBloc(this);
  }

  factory TaskGroup.fromMap(Map taskGroup) {
    return TaskGroup(
      taskGroup['title'],
      key: taskGroup['key'],
      children: taskGroup['children']?.forEach((key, value) {
        value = Map<String, dynamic>.from(value);
        value['key'] = key;
        return Task.fromMap(value);
      }),
    );
  }

  bool operator ==(o) => o is TaskGroup && o.key == key;
}
