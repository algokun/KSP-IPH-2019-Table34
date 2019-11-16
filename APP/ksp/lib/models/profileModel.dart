import 'package:cloud_firestore/cloud_firestore.dart';

class ProfileModel {
  final String name;
  final String phone;
  final String userRole;
  final String uid;

  ProfileModel({this.name, this.phone, this.userRole, this.uid});
  factory ProfileModel.fromSnapshot(DocumentSnapshot snapshot) {
    return ProfileModel(
        name: snapshot?.data['name'],
        phone: snapshot?.data['phone'],
        userRole: snapshot?.data['role'],
        uid: snapshot?.documentID);
  }
}
