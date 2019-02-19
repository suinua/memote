import 'package:flutter/material.dart';
import 'package:memote/bloc/task_groups_bloc_provider.dart';
import 'package:memote/models/task_group.dart';

import 'package:memote/view/widgets/page_title.dart';

class CreateTaskGroupPage extends StatefulWidget {
  @override
  _CreateTaskGroupPageState createState() => _CreateTaskGroupPageState();
}

class _CreateTaskGroupPageState extends State<CreateTaskGroupPage> {
  String titleText = '';

  bool _canSave() => titleText.isNotEmpty;

  @override
  Widget build(BuildContext context) {
    final taskGroupsBloc = TaskGroupsBlocProvider.of(context);

    return Scaffold(
      resizeToAvoidBottomPadding: false,
      appBar: AppBar(
        elevation: 0.0,
        backgroundColor: Colors.white30,
        leading: IconButton(
          onPressed: () => Navigator.pop(context),
          icon: const Icon(Icons.close, color: Colors.black),
        ),
        actions: <Widget>[
          Center(
            child: RaisedButton(
              onPressed: _canSave()
                  ? () {
                      taskGroupsBloc.addGroup.add(TaskGroup(titleText));
                      Navigator.pop(context);
                    }
                  : null,
              child: Text('save'),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(30.0),
              ),
            ),
          )
        ],
      ),
      body: GestureDetector(
        behavior: HitTestBehavior.opaque,
        onTap: () {
          FocusScope.of(context).requestFocus(FocusNode());
        },
        child: Column(
          children: <Widget>[
            PageTitle(title: 'New Task Group', size: 30),
            Padding(padding: const EdgeInsets.only(bottom: 50)),
            TextField(
              decoration: InputDecoration(
                labelText: 'Title',
                border: OutlineInputBorder(),
              ),
              onChanged: (value) {
                setState(() {
                  titleText = value;
                });
              },
            ),
          ],
        ),
      ),
    );
  }
}
