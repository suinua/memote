import 'package:flutter/cupertino.dart';
import 'package:memote/bloc/task_groups_bloc.dart';

class TaskGroupsBlocProvider extends InheritedWidget {

  final TaskGroupsBloc bloc;

  TaskGroupsBlocProvider({
    Key key,
    @required Widget child,
    @required this.bloc,
  }) : super(key: key, child: child);

  static TaskGroupsBloc of(BuildContext context) {
    return (context.inheritFromWidgetOfExactType(TaskGroupsBlocProvider)
    as TaskGroupsBlocProvider)
        .bloc;
  }

  @override
  bool updateShouldNotify(TaskGroupsBlocProvider oldWidget) =>
      bloc != oldWidget.bloc;
}