import 'package:firebase_database/firebase_database.dart';
import 'package:memote/models/task.dart';

class TaskGroupChildrenRepository {
  final DatabaseReference childrenRef;
  final void Function(Task) onChildAdded;
  final void Function(Task) onChildChanged;
  final void Function(Task) onChildRemoved;

  void addChild(Task task) {
    childrenRef.push().set(task.asMap());
  }

  void updateChild(Task task) {
    childrenRef.child(task.key).update(task.asMap());
  }

  void removeChild(Task task) {
    childrenRef.child(task.key).remove();
  }

  TaskGroupChildrenRepository(this.childrenRef,
      {this.onChildAdded, this.onChildChanged, this.onChildRemoved}) {
    childrenRef.onChildAdded.listen((event) {
      print('add child ${event.snapshot.value}');

      Map value = event.snapshot.value;
      value['key'] = event.snapshot.key;

      onChildAdded(Task.fromMap(value));
    });

    childrenRef.onChildRemoved.listen((event) {
      print('remove child ${event.snapshot.value}');

      Map value = event.snapshot.value;
      value['key'] = event.snapshot.key;

      onChildRemoved(Task.fromMap(value));
    });

    childrenRef.onChildChanged.listen((event) {
      print('changed child ${event.snapshot.value}');
      Map value = event.snapshot.value;
      value['key'] = event.snapshot.key;

      onChildChanged(Task.fromMap(value));
    });
  }
}
