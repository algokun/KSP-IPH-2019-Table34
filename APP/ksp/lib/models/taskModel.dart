import 'package:cloud_firestore/cloud_firestore.dart';

class Task {
  final String assignedBy, assignedTo, timeStamp, title, description;
  final bool isCompleted;

  Task(
      {this.assignedBy,
      this.assignedTo,
      this.timeStamp,
      this.isCompleted,
      this.description,
      this.title});

  factory Task.fromSnapShot(DocumentSnapshot snapshot) {
    return Task(
      assignedBy: snapshot.data['assignedBy'],
      assignedTo: snapshot.data['assignedTo'],
      timeStamp: snapshot.data['timeStamp'],
      isCompleted: snapshot.data['isCompleted'],
    );
  }
}
