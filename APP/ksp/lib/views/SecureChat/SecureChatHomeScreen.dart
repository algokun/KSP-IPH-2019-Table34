import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:ksp/config/colors.dart';
import 'package:ksp/models/profileModel.dart';
import 'package:ksp/views/ChatScreen.dart';
import 'package:ksp/views/SecureChatScreen.dart';
import 'package:provider/provider.dart';

class SecureChatHome extends StatefulWidget {
  @override
  _SecureChatHomeState createState() => _SecureChatHomeState();
}

class _SecureChatHomeState extends State<SecureChatHome> with ColorConfig {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: background,
      body: _buildBody(context),
    );
  }

  Widget _buildBody(BuildContext context) {
    FirebaseUser user = Provider.of<FirebaseUser>(context);
    var uid = user.uid;
    return StreamBuilder<QuerySnapshot>(
      stream: Firestore.instance
          .collection('secure-chat')
          .document(uid)
          .collection("users")
          .snapshots(),
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
              Navigator.of(context).push(MaterialPageRoute(
                  builder: (_) =>
                      SecureChatScreen(peerId: record.uid, name: record.name)));
            },
          ),
        ),
      ),
    );
  }
}
