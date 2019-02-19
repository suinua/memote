import 'dart:async';

import 'package:firebase_database/firebase_database.dart';
import 'package:memote/firebase/task_group_children_repository.dart';
import 'package:memote/models/task.dart';
import 'package:memote/models/task_group.dart';

class TaskGroupChildrenBloc {
  final TaskGroup parent;
  List<Task> _children = <Task>[];

  DatabaseReference _childrenRef;

  TaskGroupChildrenRepository _repository;

  StreamController<List<Task>> _childrenController =
      StreamController<List<Task>>();
  //StreamController<List<Task>> _completedChildrenController =
  //    StreamController<List<Task>>();
  //StreamController<List<Task>> _notCompletedChildrenController =
  //    StreamController<List<Task>>();

  void _setList(List<Task> children) {
    _childrenController.sink.add(children);
    //_completedChildrenController.sink.add(children);
    //_notCompletedChildrenController.sink.add(children);
    parent.setChild(children);
  }

  Stream<List<Task>> get getAll => _childrenController.stream;

  //Stream<List<Task>> get getCompleted => _completedChildrenController.stream;
//
  //Stream<List<Task>> get getNotCompleted =>
  //    _notCompletedChildrenController.stream;

  StreamController<Task> _addController = StreamController<Task>();
  StreamController<Task> _updateController = StreamController<Task>();
  StreamController<Task> _removeController = StreamController<Task>();

  StreamSink<Task> get addChild => _addController.sink;

  StreamSink<Task> get updateChild => _updateController.sink;

  StreamSink<Task> get removeChild => _removeController.sink;

  TaskGroupChildrenBloc(this.parent) {
    _setList([]);
    void add(Task task) {
      _children.add(task);
      _setList(_children);
    }

    void remove(Task task) {
      _children.remove(task);
      _setList(_children);
    }

    void update(Task task) {
      _children.forEach((target) {
        if (target.key == task.key) {
          target = task;
        }
      });
      _setList(_children);
    }

    _childrenRef = FirebaseDatabase.instance
        .reference()
        .child('task_groups')
        .child(parent.key)
        .child('children');

    _repository = TaskGroupChildrenRepository(
      _childrenRef,
      onChildAdded: add,
      onChildChanged: update,
      onChildRemoved: remove,
    );
    _setDatabaseHandles(_repository);
  }

  void _setDatabaseHandles(TaskGroupChildrenRepository repository) {
    _addController.stream.listen(repository.addChild);
    _removeController.stream.listen(repository.removeChild);
    _updateController.stream.listen(repository.updateChild);
  }

  void dispose() async {
    await _childrenController.close();
    //await _completedChildrenController.close();
    //await _notCompletedChildrenController.close();
    await _addController.close();
    await _updateController.close();
    await _removeController.close();
  }
}
