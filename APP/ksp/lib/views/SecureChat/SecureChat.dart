import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:ksp/config/colors.dart';
import 'package:ksp/models/profileModel.dart';
import 'package:provider/provider.dart';

class SecureChat extends StatefulWidget {
  @override
  _SecureChatState createState() => _SecureChatState();
}

class _SecureChatState extends State<SecureChat> with ColorConfig {
  bool isProgressVisible = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: background,
      appBar: AppBar(
        title: Text("Secure Chat"),
        leading: Icon(Icons.lock),
        centerTitle: true,
      ),
      body: _buildBody(context),
    );
  }

  Widget _buildBody(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
      stream: Firestore.instance.collection("users").snapshots(),
      builder: (context, snapshot) {
        if (!snapshot.hasData) return LinearProgressIndicator();

        return _buildList(context, snapshot.data.documents);
      },
    );
  }

  Widget _buildList(BuildContext context, List<DocumentSnapshot> snapshot) {
    return ListView(
      padding: const EdgeInsets.only(top: 20.0),
      children: snapshot.map((data) => _buildListItem(context, data)).toList(),
    );
  }

  Widget _buildListItem(BuildContext context, DocumentSnapshot data) {
    final record = ProfileModel.fromSnapshot(data);
    FirebaseUser user = Provider.of<FirebaseUser>(context);
    var uid = user.uid;
    return Visibility(
      visible: !(record.uid == uid),
      child: Padding(
        key: ValueKey(record.name),
        padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
        child: Container(
          child: ListTile(
            leading: CircleAvatar(
              child: Text(record.name[0].toUpperCase()),
            ),
            title: Text(
              record.name,
              style: Theme.of(context)
                  .textTheme
                  .title
                  .copyWith(color: Colors.white),
            ),
            trailing: isProgressVisible
                ? CircularProgressIndicator()
                : Icon(
                    Icons.arrow_forward_ios,
                    color: Colors.white,
                  ),
            onTap: createSecureChat(record),
          ),
        ),
      ),
    );
  }

  createSecureChat(ProfileModel model) async {
    setProgress();
    FirebaseUser user = Provider.of<FirebaseUser>(context);
    var uid = user.uid;
    await Firestore.instance
        .collection("secure-chat")
        .document(uid)
        .collection("users")
        .document(model.uid)
        .setData({
      'name': model.name,
      'uid': model.uid,
    }).then((_) async {
      await Firestore.instance
          .collection("secure-chat")
          .document(model.uid)
          .collection("users")
          .document(uid)
          .setData({
        'name': user.displayName,
        'uid': user.uid,
      }).then((_) {
        setProgress();
      });
    });
  }

  setProgress() {
    setState(() {
      isProgressVisible = !isProgressVisible;
    });
  }
}
