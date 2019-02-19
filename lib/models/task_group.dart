import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/cupertino.dart';
import 'package:memote/firebase/task_group_children_repository.dart';
import 'package:memote/models/models_widget/task_group_widget.dart';
import 'package:memote/models/task.dart';

class TaskGroup {
  final String key;
  TaskGroupChildrenRepository _repository;

  String title;
  List<Task> _children;

  double get progress => _children.isEmpty
      ? 0.0
      : getCompletedChildren().length / getAllChildren().length * 100;

  List<Task> getAllChildren() => _children;

  List<Task> getCompletedChildren() {
    return _children.where((task) => task.isComplete).toList();
  }

  List<Task> getNotCompletedChildren() {
    return _children.where((task) => !task.isComplete).toList();
  }

  Map<String, dynamic> asMap() => {
        "key": key,
        "title": title,
        "children": _children.map((child) => child.asMap()).toList(),
      };

  Widget asWidget() => TaskGroupWidget(taskGroup: this);

  void addChild(Task task) {
    _repository.addChild(task);
  }

  void removeChild(Task task) {
    _repository.removeChild(task);
  }

  TaskGroup(this.title, {this.key, children}) {
    if (key != null) {
      void add(Task task) => _children.add(task);
      void remove(Task task) => _children.add(task);

      final _taskGroupChildrenRef = FirebaseDatabase.instance
          .reference()
          .child('task_groups')
          .child(key)
          .child('children');

      _repository = TaskGroupChildrenRepository(_taskGroupChildrenRef,
          onChildAdded: add, onChildRemoved: remove);
    }

    if (children == null) {
      this._children = <Task>[];
    } else {
      this._children = children;
    }
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