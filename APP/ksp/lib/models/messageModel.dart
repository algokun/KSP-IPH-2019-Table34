import 'package:cloud_firestore/cloud_firestore.dart';

class MessageModel {
  final String idFrom, idTo, type, content, timeStamp;
  final bool isSecure, isExpired;

  MessageModel(
      {this.idFrom,
      this.idTo,
      this.type,
      this.isExpired,
      this.content,
      this.timeStamp,
      this.isSecure});

  factory MessageModel.fromSnapShot(DocumentSnapshot snapshot) {
    return MessageModel(
      content: snapshot.data['content'],
      idFrom: snapshot.data['idFrom'],
      idTo: snapshot.data['idTo'],
      timeStamp: snapshot.data['timeStamp'],
      type: snapshot.data['type'],
      isSecure: snapshot.data['isSecure'] ?? false,
      isExpired: snapshot.data['isExpired'] ?? false,
    );
  }

  toMap() {
    return {
      "content": content,
      "idFrom": idFrom,
      "idTo": idTo,
      "timeStamp": timeStamp,
      "type": type,
      "isSecure": isSecure ?? false,
      "isExpired": isExpired ?? false
    };
  }
}
