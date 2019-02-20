import 'package:flutter/material.dart';
import 'package:flutter_driver/driver_extension.dart';
import 'package:memote/bloc/task_groups_bloc.dart';
import 'package:memote/bloc/task_groups_bloc_provider.dart';
import 'package:memote/view/pages/task_groups_page.dart';

void main() {
  runApp(TaskGroupsBlocProvider(
    child: MyApp(),
    bloc: TaskGroupsBloc(),
  ));
}

class MyApp extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
          primaryColor: Colors.red,
          buttonColor: Colors.orange,
          appBarTheme: AppBarTheme(
            elevation: 0.0,
            color: Colors.white30,
          )),
      home: TaskGroupsPage(),
    );
  }
}
