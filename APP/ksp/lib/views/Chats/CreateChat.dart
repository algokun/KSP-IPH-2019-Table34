import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:ksp/config/colors.dart';
import 'package:ksp/models/profileModel.dart';
import 'package:provider/provider.dart';

class CreateChat extends StatefulWidget {
  @override
  _CreateChatState createState() => _CreateChatState();
}

class _CreateChatState extends State<CreateChat> with ColorConfig {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: background,
      appBar: AppBar(
        title: Text("Create Chat"),
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
            trailing: Icon(
              Icons.arrow_forward_ios,
              color: Colors.white,
            ),
            onTap: () {
              createChat(record);
            },
          ),
        ),
      ),
    );
  }

  createChat(ProfileModel model) {
    FirebaseUser user = Provider.of<FirebaseUser>(context);
    var uid = user.uid;
    Firestore.instance
        .collection("chats")
        .document(uid)
        .collection("users")
        .document(model.uid)
        .setData({
      'name': model.name,
      'uid': model.uid,
    }).then((_) {
      Firestore.instance
          .collection("chats")
          .document(model.uid)
          .collection("users")
          .document(uid)
          .setData({
        'name': user.displayName,
        'uid': user.uid,
      });
    });
  }
}
