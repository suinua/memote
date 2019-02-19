import 'package:firebase_database/firebase_database.dart';
import 'package:memote/models/task.dart';

class TaskGroupChildrenRepository {
  final DatabaseReference taskGroupRef;
  final void Function(Task) onChildAdded;
  final void Function(Task) onChildRemoved;

  void addChild(Task task) {
    taskGroupRef.push().set(task.asMap());
  }

  void removeChild(Task task) {
    taskGroupRef.child(task.key).remove();
  }

  TaskGroupChildrenRepository(this.taskGroupRef,
      {this.onChildAdded, this.onChildRemoved}) {
    taskGroupRef.onChildAdded.listen((event) {
      print('add child ${event.snapshot.value}');

      Map value = event.snapshot.value;
      value['key'] = event.snapshot.key;

      onChildAdded(Task.fromMap(value));
    });
    taskGroupRef.onChildRemoved.listen((event) {
      print('remove child ${event.snapshot.value}');

      Map value = event.snapshot.value;
      value['key'] = event.snapshot.key;

      onChildAdded(Task.fromMap(value));
    });
  }
}
