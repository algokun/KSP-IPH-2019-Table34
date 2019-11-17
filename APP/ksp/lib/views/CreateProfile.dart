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
  int groupvalue;

  TextEditingController profileName;
  TextEditingController address;
  TextEditingController phoneController;
  String userRole;

  List<String> userRoles = [
    "DGP",
    "ADGP",
    "IGP",
    "DIGP",
    "DCP",
    "SP",
    "ASP",
    "DSP",
    "POLICE_INSPECTOR",
    "ASSISTANT_POLICE_INSPECTOR",
    "POLICE_SUB_INSPECTOR",
    "ASSISTANT_POLICE_SUB_INSPECTOR",
    "HEAD_CONSTABLE",
    "POLICE_CONSTABLE",
  ];

  static final _formKey = GlobalKey<FormState>();
  static final _key = GlobalKey<ScaffoldState>();

  void initState() {
    profileName = TextEditingController();
    phoneController = TextEditingController();
    super.initState();
  }

  setSelected(int val) {
    setState(() {
      groupvalue = val;
    });
  }

  @override
  Widget build(BuildContext context) {
    final buildProfile = Text(
      'Build Your Profile',
      style: TextStyle(
          color: Colors.white,
          fontSize: 25,
          fontFamily: 'WorkSans',
          fontWeight: FontWeight.bold),
    );
    final profilename = Container(
        decoration: BoxDecoration(
            color: lowContrast, borderRadius: BorderRadius.circular(5.0)),
        child: TextFormField(
          controller: profileName,
          validator: (String val) {
            if (val.isEmpty) {
              return 'Please Enter your name';
            } else if (val.contains('@')) {
              return 'Please Check your name..! It is invalid';
            } else {
              return null;
            }
          },
          decoration: new InputDecoration(
              contentPadding: EdgeInsets.fromLTRB(20, 15, 20, 15),
              border: new OutlineInputBorder(
                borderRadius: new BorderRadius.circular(5.0),
                borderSide: new BorderSide(color: Colors.white),
              ),
              hintText: 'Enter Your name',
              labelText: 'Profile Name',
              labelStyle: TextStyle(color: Colors.white)),
        ));
    final phone = Container(
        decoration: BoxDecoration(
            color: lowContrast, borderRadius: BorderRadius.circular(5.0)),
        child: TextFormField(
          maxLength: 10,
          controller: phoneController,
          validator: (String val) {
            if (val.isEmpty) {
              return 'Please Enter your number';
            } else {
              return null;
            }
          },
          keyboardType: TextInputType.phone,
          decoration: new InputDecoration(
              contentPadding: EdgeInsets.fromLTRB(20, 15, 20, 15),
              border: new OutlineInputBorder(
                borderRadius: new BorderRadius.circular(5.0),
                borderSide: new BorderSide(color: Colors.white),
              ),
              hintText: 'Enter your Mobile Number',
              labelText: 'Phone',
              labelStyle: TextStyle(color: Colors.white)),
        ));
    final signUpButton = Material(
      elevation: 5.0,
      borderRadius: BorderRadius.circular(5.0),
      color: Color(0xFFFF9800),
      child: MaterialButton(
        minWidth: MediaQuery.of(context).size.width,
        padding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
        onPressed: () {
          if (_formKey.currentState.validate()) {
            createProfile();
          }
        },
        child: Text(
          'Update Profile',
          textAlign: TextAlign.center,
          style: TextStyle(
              color: Colors.white,
              fontFamily: 'WorkSans',
              fontSize: 15,
              fontWeight: FontWeight.bold),
        ),
      ),
    );
    final userRoleSelect = DropdownButton<String>(
      value: userRole,
      icon: Icon(Icons.arrow_downward),
      iconSize: 20.0,
      elevation: 6,
      hint: Text("Choose Your Role"),
      items: userRoles.map((String value) {
        return new DropdownMenuItem<String>(
          value: value,
          child: new Text(value),
        );
      }).toList(),
      onChanged: (newValue) {
        setState(() {
          userRole = newValue;
        });
      },
    );
    List<Widget> list2 = [
      buildProfile,
      profilename,
      phone,
      userRoleSelect,
      signUpButton,
    ];
    return Scaffold(
      key: _key,
      backgroundColor: background,
      appBar: AppBar(
        title: Text("Create Profile"),
        centerTitle: true,
        elevation: 0.0,
      ),
      body: Form(
        key: _formKey,
        child: Center(
          child: ListView.separated(
            padding: EdgeInsets.all(30.0),
            itemCount: list2.length,
            itemBuilder: (context, index) {
              return list2[index];
            },
            separatorBuilder: (context, index) {
              return SizedBox(
                height: 25,
              );
            },
            shrinkWrap: true,
          ),
        ),
      ),
    );
  }

  createProfile() async{
    FirebaseUser user = Provider.of<FirebaseUser>(context);
    UserUpdateInfo info = UserUpdateInfo();
    info.displayName = profileName.text;
    info.photoUrl = phoneController.text;
    await user.updateProfile(info);
    await Profile(context).createProfile(ProfileModel(
        name: profileName.text,
        phone: phoneController.text,
        uid: user.uid,
        userRole: 'ROlE'));
  }
}
