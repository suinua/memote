import 'package:flutter/material.dart';
import 'package:flutter_page_indicator/flutter_page_indicator.dart';
import 'package:memote/bloc/task_groups_bloc_provider.dart';
import 'package:memote/models/task_group.dart';
import 'package:memote/view/pages/create_task_group_page.dart';
import 'package:memote/view/widgets/page_title.dart';

import 'package:flutter_swiper/flutter_swiper.dart';

class TaskGroupsPage extends StatefulWidget {
  @override
  _TaskGroupsPageState createState() => _TaskGroupsPageState();
}

class _TaskGroupsPageState extends State<TaskGroupsPage> {
  @override
  Widget build(BuildContext context) {
    final taskGroupsBloc = TaskGroupsBlocProvider.of(context);

    return Scaffold(
      resizeToAvoidBottomPadding: false,
      floatingActionButton: _createTaskGroupButton(context),
      appBar: AppBar(),
      body: Column(
        children: <Widget>[
          PageTitle(title: 'Task Groups'),
          Container(
            height: 200,
            child: StreamBuilder<List<TaskGroup>>(
              stream: taskGroupsBloc.getAll,
              builder: (BuildContext context,
                  AsyncSnapshot<List<TaskGroup>> snapshot) {
                if (snapshot.hasData) {
                  return _buildTaskGroups(context, snapshot.data);
                } else {
                  return ListView(children: <Widget>[]);
                }
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTaskGroups(BuildContext context, List<TaskGroup> taskGroups) {
    return Swiper(
      itemBuilder: (BuildContext context, int index) {
        return taskGroups[index].asWidget();
      },
      loop: false,
      itemCount: taskGroups.length,
      viewportFraction: 0.8,
      scale: 0.9,
      scrollDirection: Axis.horizontal,
      pagination: SwiperPagination(),
      control: SwiperControl(
        color: Colors.black38,
        disableColor: Colors.orangeAccent,
        iconNext: null,
        iconPrevious: null,
      ),
    );
  }

  Widget _createTaskGroupButton(BuildContext context) {
    return FloatingActionButton.extended(
      elevation: 4.0,
      icon: const Icon(Icons.add),
      label: Text('add task group'),
      onPressed: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (BuildContext context) => CreateTaskGroupPage(),
          ),
        );
      },
    );
  }
}
