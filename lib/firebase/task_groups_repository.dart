import 'package:firebase_database/firebase_database.dart';
import 'package:memote/models/task.dart';
import 'package:memote/models/task_group.dart';
import 'package:meta/meta.dart';

class TaskGroupsRepository {
  final DatabaseReference taskGroupsRef;
  final void Function(TaskGroup) onChildAdded;
  final void Function(TaskGroup) onChildRemoved;

  TaskGroupsRepository(this.taskGroupsRef,
      {@required this.onChildAdded, @required this.onChildRemoved}) {
    taskGroupsRef
      ..onChildAdded.listen((event) {
        print('add taskGroup ${event.snapshot.value}');

        Map<String, dynamic> value = Map<String, dynamic>.from(event.snapshot.value);

        value['key'] = event.snapshot.key;

        this.onChildAdded(TaskGroup.fromMap(value));
      })
      ..onChildRemoved.listen((event) {
        print('remove taskGroup ${event.snapshot.value}');

        Map<String, dynamic> value = Map<String, dynamic>.from(event.snapshot.value);

        value['key'] = event.snapshot.key;

        this.onChildRemoved(TaskGroup.fromMap(value));
      });
  }

  Future<List<TaskGroup>> taskGroups() {
    return taskGroupsRef.once().then((value) {
      print(value.value);
    });
  }

  Future<void> add(TaskGroup taskGroup) {
    return taskGroupsRef.push().set(taskGroup.asMap());
  }

  Future<void> update(TaskGroup taskGroup) {
    return taskGroupsRef.child(taskGroup.key).update(taskGroup.asMap());
  }

  Future<void> remove(TaskGroup taskGroup) {
    return taskGroupsRef.child(taskGroup.key).remove();
  }
}
