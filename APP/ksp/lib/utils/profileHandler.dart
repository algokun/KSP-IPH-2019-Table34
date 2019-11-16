import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:ksp/models/profileModel.dart';
import 'package:ksp/views/HomePage.dart';

class Profile {
  final BuildContext context;

  Profile(this.context);
  createProfile(ProfileModel profile) {
    Firestore.instance.collection("users").document(profile.uid).setData({
      'name': profile.name,
      'phone': profile.phone,
      'role': profile.userRole,
    }).then((_) {
      Navigator.of(context)
          .pushReplacement(MaterialPageRoute(builder: (_) => HomePage()));
    });
  }
}
