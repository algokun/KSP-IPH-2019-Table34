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
      title: snapshot.data['title'],
      description: snapshot.data['description'],
      assignedBy: snapshot.data['assignedBy'],
      assignedTo: snapshot.data['assignedTo'],
      timeStamp: snapshot.data['timeStamp'],
      isCompleted: snapshot.data['isCompleted'],
    );
  }

  toMap() {
    return {
      'title': title,
      'description': description,
      'assignedBy': assignedBy,
      'assignedTo': assignedTo,
      'timeStamp': timeStamp,
      'isCompleted': isCompleted,
    };
  }
}
