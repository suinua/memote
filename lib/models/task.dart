import 'package:flutter/cupertino.dart';
import 'package:memote/models/models_widget/task_widget.dart';

class Task {
  //todo parent key
  final String key;

  String text;
  bool isComplete;

  Map<String, dynamic> asMap() => {
        "key": key,
        "text": text,
        "is_complete": isComplete,
      };

  Widget asWidget() => TaskWidget(task: this);

  factory Task.fromMap(Map task) {
    return Task(
      task['text'],
      isComplete: task['is_complete'],
      key: task['key'],
    );
  }

  Task(this.text, {this.isComplete = false, this.key});

  bool operator ==(o) => o is Task && o.key == key;
}
