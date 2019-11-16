import 'package:flutter/material.dart';
import 'package:ksp/config/colors.dart';

class CreateProfile extends StatefulWidget {
  @override
  _CreateProfileState createState() => _CreateProfileState();
}

class _CreateProfileState extends State<CreateProfile> with ColorConfig {
  int groupvalue;

  TextEditingController profileName;
  TextEditingController address;
  TextEditingController phone;
  TextEditingController age;

  static final _formKey = GlobalKey<FormState>();
  static final _key = GlobalKey<ScaffoldState>();

  void initState() {
    profileName = TextEditingController();
    phone = TextEditingController();
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
    final profilename = TextFormField(
      controller: profileName,
      validator: (String val) {
        if(val.isEmpty){
          return 'Please Enter your name';
        }else if(val.contains('@')){
          return 'Please Check your name..! It is invalid';
        }else{
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
        labelStyle: TextStyle(color: Colors.white)
      ),
    );
    final age = TextFormField(
      controller: profileName,
      validator: (String val) {
        if(val.isEmpty){
          return 'Please Enter your age';
        }else{
          return null;
        }
      },
      decoration: new InputDecoration(
        contentPadding: EdgeInsets.fromLTRB(20, 15, 20, 15),
        border: new OutlineInputBorder(
          borderRadius: new BorderRadius.circular(5.0),
          borderSide: new BorderSide(color: Colors.white),
        ),
        hintText: 'Enter your Mobile Number',
        labelText: 'Phone',
        labelStyle: TextStyle(color: Colors.white)
      ),
    );
    final signUpButton =  Material(
            elevation: 5.0,
            borderRadius: BorderRadius.circular(5.0),
            color: Color(0xFFFF9800),
            child: MaterialButton(
              minWidth: MediaQuery.of(context).size.width,
              padding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
              onPressed: (){},
              child: Text(
                'Update Profile',
                textAlign: TextAlign.center,
                style: TextStyle(color: Colors.white, fontFamily: 'WorkSans', fontSize: 15, fontWeight: FontWeight.bold ),
              ),
            ),
          );

    List<Widget> list2 = [
      buildProfile,
      profilename,
      age,
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
            itemBuilder: (context, index){
              return list2[index];
            },
            separatorBuilder: (context, index){
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
}
