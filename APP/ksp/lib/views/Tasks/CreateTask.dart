import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:ksp/config/colors.dart';
import 'package:ksp/models/taskModel.dart';
import 'package:ksp/views/Tasks/UserList.dart';
import 'package:provider/provider.dart';

class CreateTask extends StatefulWidget {
  @override
  _CreateTaskState createState() => _CreateTaskState();
}

class _CreateTaskState extends State<CreateTask> with ColorConfig {
  TextEditingController titleController, descController;
  @override
  void initState() {
    titleController = TextEditingController();
    descController = TextEditingController();
    super.initState();
  }

  String selectedUserName = "Select an User";
  String selectedUserId = "";

  @override
  Widget build(BuildContext context) {
    final title = Container(
        decoration: BoxDecoration(
            color: lowContrast, borderRadius: BorderRadius.circular(5.0)),
        child: TextField(
          controller: titleController,
          keyboardType: TextInputType.emailAddress,
          decoration: new InputDecoration(
              contentPadding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
              border: new OutlineInputBorder(
                borderRadius: BorderRadius.circular(5.0),
                borderSide: BorderSide(color: Colors.black),
              ),
              hintText: 'Please Enter Title',
              labelText: 'Title'),
        ));

    final description = Container(
        decoration: BoxDecoration(
            color: lowContrast, borderRadius: BorderRadius.circular(5.0)),
        child: TextField(
          controller: descController,
          keyboardType: TextInputType.emailAddress,
          decoration: new InputDecoration(
              contentPadding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
              border: new OutlineInputBorder(
                borderRadius: BorderRadius.circular(5.0),
                borderSide: BorderSide(color: Colors.black),
              ),
              hintText: 'Please Enter Description',
              labelText: 'Description'),
        ));

    final assignPerson = Container(
        decoration: BoxDecoration(
            color: lowContrast, borderRadius: BorderRadius.circular(5.0)),
        child: ListTile(
          trailing: Icon(Icons.arrow_forward_ios),
          title: Text(selectedUserName),
          onTap: () async {
            final result = await Navigator.of(context)
                .push(MaterialPageRoute(builder: (context) => UserList()));

            if (result != null) {
              setState(() {
                selectedUserName = result['name'];
                selectedUserId = result['uid'];
              });
            }
          },
        ));

    List<Widget> list = [title, description, assignPerson];
    return Scaffold(
      backgroundColor: background,
      bottomNavigationBar: Container(
        padding: EdgeInsets.all(10.0),
        color: Colors.orange,
        child: FlatButton(
          padding: EdgeInsets.all(10.0),
          child: Text("Add Task"),
          onPressed: createTaskFunction,
        ),
      ),
      appBar: AppBar(
        title: Text("Create Task"),
        centerTitle: true,
      ),
      body: ListView.separated(
        padding: EdgeInsets.all(20.0),
        itemCount: list.length,
        itemBuilder: (context, i) {
          return list[i];
        },
        separatorBuilder: (context, index) {
          return SizedBox(
            height: 30.0,
          );
        },
      ),
    );
  }

  createTaskFunction() async {
    FirebaseUser user = Provider.of<FirebaseUser>(context);
    Task task = Task(
        assignedBy: user.uid,
        assignedTo: selectedUserId,
        description: descController.text,
        timeStamp: DateTime.now().toString(),
        isCompleted: false,
        title: titleController.text);

    await Firestore.instance.collection("tasks").add(task.toMap()).then((_) {
      Navigator.of(context).pop();
    });
  }
}
