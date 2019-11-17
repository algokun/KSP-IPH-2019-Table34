import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:ksp/models/taskModel.dart';
import 'package:provider/provider.dart';

class YourTasks extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    FirebaseUser user = Provider.of<FirebaseUser>(context);
    return StreamBuilder<QuerySnapshot>(
      stream: Firestore.instance
          .collection("tasks")
          .where('assignedTo', isEqualTo: user.uid)
          .where('isCompleted', isEqualTo: false)
          .snapshots(),
      builder: (context, snapshot) {
        if(!snapshot.hasData) return Center(child: CircularProgressIndicator());
        return _buildList(context, snapshot.data.documents);
      },
    );
  }

  Widget _buildList(BuildContext context, List<DocumentSnapshot> snapshot) {
    return ListView(
      padding: const EdgeInsets.all(10.0),
      children: snapshot.map((data) => _buildListItem(context, data)).toList(),
    );
  }

  Widget _buildListItem(BuildContext context, DocumentSnapshot data) {
    final record = Task.fromSnapShot(data);
    return ListTile(
      leading: Checkbox(
        value: record.isCompleted,
        activeColor: Colors.orange,
        onChanged: (v) {},
      ),
      title: Text(record.title),
      subtitle: Text(record.description),
    );
  }
}
