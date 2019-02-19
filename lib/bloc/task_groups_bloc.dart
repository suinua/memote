import 'dart:async';

import 'package:firebase_database/firebase_database.dart';
import 'package:memote/firebase/task_groups_repository.dart';
import 'package:memote/models/task_group.dart';

class TaskGroupsBloc {
  List<TaskGroup> _taskGroups = <TaskGroup>[];

  final _taskGroupsRef =
      FirebaseDatabase.instance.reference().child('task_groups');

  TaskGroupsRepository _repository;

  StreamController<List<TaskGroup>> _taskGroupsController =
      StreamController<List<TaskGroup>>();

  StreamSink<List<TaskGroup>> get _setList => _taskGroupsController.sink;

  Stream<List<TaskGroup>> get getAll => _taskGroupsController.stream;

  StreamController<TaskGroup> _addController = StreamController<TaskGroup>();
  StreamController<TaskGroup> _updateController = StreamController<TaskGroup>();
  StreamController<TaskGroup> _removeController = StreamController<TaskGroup>();

  StreamSink<TaskGroup> get addGroup => _addController.sink;

  StreamSink<TaskGroup> get updateGroup => _updateController.sink;

  StreamSink<TaskGroup> get removeGroup => _removeController.sink;

  TaskGroupsBloc() {
    void add(TaskGroup taskGroup) {
      _taskGroups.add(taskGroup);
      _setList.add(_taskGroups);
    }

    void remove(TaskGroup taskGroup) {
      _taskGroups.remove(taskGroup);
      _setList.add(_taskGroups);
    }

    _repository = TaskGroupsRepository(_taskGroupsRef,
        onChildAdded: add, onChildRemoved: remove);
    _setDatabaseHandles();
  }

  void _setDatabaseHandles() {
    _addController.stream.listen(_repository.add);
    _removeController.stream.listen(_repository.remove);
  }

  void dispose() async {
    await _taskGroupsController.close();
    await _addController.close();
    await _updateController.close();
    await _removeController.close();
  }
}
