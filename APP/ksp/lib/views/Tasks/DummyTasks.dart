import 'package:flutter/material.dart';
import 'package:ksp/views/Tasks/GivenTasks.dart';
import 'package:ksp/views/Tasks/YourTasks.dart';

import 'CompletedTasks.dart';
import 'CreateTask.dart';

class TaskList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        floatingActionButton: FloatingActionButton(
          child: Icon(Icons.add),
          onPressed: () {
            Navigator.of(context)
                .push(MaterialPageRoute(builder: (context) => CreateTask()));
          },
        ),
        appBar: AppBar(
          title: Text("Tasks"),
          bottom: TabBar(
            tabs: [
              Tab(
                text: 'Your Tasks',
              ),
              Tab(
                text: 'Given Tasks',
              ),
              Tab(
                text: 'Completed Tasks',
              ),
            ],
          ),
        ),
        body: TabBarView(
          children: [
            YourTasks(),
            GivenTasks(),
            CompletedTasks(),
          ],
        ),
      ),
    );
    ;
  }
}
