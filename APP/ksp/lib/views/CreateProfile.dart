import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:ksp/config/colors.dart';
import 'package:ksp/models/profileModel.dart';
import 'package:ksp/utils/profileHandler.dart';
import 'package:provider/provider.dart';

class CreateProfile extends StatefulWidget {
  @override
  _CreateProfileState createState() => _CreateProfileState();
}

class _CreateProfileState extends State<CreateProfile> with ColorConfig {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: background,
      appBar: AppBar(
        title: Text("Create Profile"),
        centerTitle: true,
        elevation: 0.0,
      ),
    );
  }

  createProfile() {
    FirebaseUser user = Provider.of<FirebaseUser>(context);
    UserUpdateInfo info = UserUpdateInfo();
    info.displayName = "name";
    info.photoUrl = "phone";
    user.updateProfile(info);
    Profile(context).createProfile(ProfileModel(
        name: 'NAME', phone: 'PHONE', uid: user.uid, userRole: 'ROlE'));
  }
}
