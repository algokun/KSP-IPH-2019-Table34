import 'package:cloud_firestore/cloud_firestore.dart';

class Task {
  final String assignedBy,
      assignedTo,
      timeStamp,
      title,
      description,
      assignedByName;
  final bool isCompleted, isVerified;

  Task(
      {this.assignedBy,
      this.assignedTo,
      this.timeStamp,
      this.isCompleted,
      this.description,
      this.isVerified,
      this.assignedByName,
      this.title});

  factory Task.fromSnapShot(DocumentSnapshot snapshot) {
    return Task(
      title: snapshot.data['title'],
      description: snapshot.data['description'],
      assignedBy: snapshot.data['assignedBy'],
      assignedTo: snapshot.data['assignedTo'],
      timeStamp: snapshot.data['timeStamp'],
      isVerified: snapshot.data['isVerified'],
      isCompleted: snapshot.data['isCompleted'],
      assignedByName: snapshot.data['assignedByName'],
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
      'assignedByName': assignedByName,
      'isVerified': isVerified,
    };
  }
}
