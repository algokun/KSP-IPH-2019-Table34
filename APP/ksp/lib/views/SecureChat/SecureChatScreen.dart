import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:ksp/config/colors.dart';
import 'package:ksp/models/messageModel.dart';
import 'package:ksp/utils/sendFile.dart';
import 'package:ksp/views/Message.dart';
import 'package:provider/provider.dart';

class SecureChatScreen extends StatefulWidget {
  final String peerId, name;

  const SecureChatScreen({Key key, this.peerId, this.name}) : super(key: key);
  @override
  _SecureChatScreenState createState() => _SecureChatScreenState();
}

class _SecureChatScreenState extends State<SecureChatScreen> with ColorConfig {
  String uid;
  TextEditingController controller;
  ScrollController _scrollController;
  @override
  void initState() {
    controller = TextEditingController();
    _scrollController = ScrollController();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    FirebaseUser user = Provider.of<FirebaseUser>(context);
    uid = user.uid;
    return Scaffold(
      appBar: AppBar(
        title: Text(widget?.name),
        actions: <Widget>[
          IconButton(
              icon: Icon(Icons.attach_file),
              onPressed: () {
                SendFile(
                        context: context,
                        hashId: getHashId(),
                        idFrom: uid,
                        idTo: widget.peerId,
                        isSecure: true)
                    .showSendDialog();
              }),
        ],
      ),
      backgroundColor: background,
      bottomNavigationBar: Container(
          padding: EdgeInsets.only(
              left: 20.0,
              right: 20.0,
              bottom: MediaQuery.of(context).viewInsets.bottom),
          child: Container(
            padding: EdgeInsets.all(20.0),
            child: Row(
              children: <Widget>[
                Expanded(
                  child: Container(
                    decoration: BoxDecoration(
                        color: lowContrast,
                        borderRadius: BorderRadius.circular(5.0)),
                    child: TextField(
                      controller: controller,
                      keyboardType: TextInputType.multiline,
                      maxLines: 1,
                      autofocus: true,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        hintText: 'Type a Message!',
                        hintStyle: TextStyle(color: Colors.white),
                      ),
                    ),
                  ),
                ),
                Container(
                  child: IconButton(
                    icon: Icon(Icons.send),
                    splashColor: Colors.orange,
                    color: Colors.orange,
                    onPressed: sendTextMessage,
                  ),
                )
              ],
            ),
          )),
      body: StreamBuilder<QuerySnapshot>(
        stream: Firestore.instance
            .collection("secure_chat")
            .document(getHashId())
            .collection("chats")
            .where('isSecure', isEqualTo: true)
            .orderBy('timeStamp', descending: false)
            .snapshots(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) return LinearProgressIndicator();

          if (snapshot.data.documents.isEmpty) {
            return Center(
              child: Text(
                "NO DATA FOUND",
                style: Theme.of(context)
                    .textTheme
                    .title
                    .copyWith(color: Colors.white),
              ),
            );
          }

          return _buildList(context, snapshot.data.documents);
        },
      ),
    );
  }

  Widget _buildList(BuildContext context, List<DocumentSnapshot> snapshot) {
    return ListView(
      controller: _scrollController,
      padding: const EdgeInsets.all(10.0),
      children: snapshot.map((data) => _buildListItem(context, data)).toList(),
    );
  }

  Widget _buildListItem(BuildContext context, DocumentSnapshot data) {
    final message = MessageModel.fromSnapShot(data);
    if (message.idFrom == uid) {
      return MessageView(
        message: message,
        alignment: Alignment.centerRight,
      );
    } else {
      return MessageView(
        message: message,
        alignment: Alignment.centerLeft,
      );
    }
  }

  getHashId() {
    String groupChatId;
    String peerId = widget.peerId;
    if (uid.hashCode <= peerId.hashCode) {
      groupChatId = '$uid-$peerId';
    } else {
      groupChatId = '$peerId-$uid';
    }
    return groupChatId;
  }

  sendTextMessage() async {
    MessageModel message = MessageModel(
        content: controller.text,
        type: '0',
        idFrom: uid,
        isSecure: true,
        idTo: widget.peerId,
        timeStamp: DateTime.now().toString());

    await Firestore.instance
        .collection("messages")
        .document(getHashId())
        .collection("chats")
        .add(message.toMap())
        .then((_) async {
      controller.text = "";
      await Firestore.instance
          .collection("secure_chat")
          .document(getHashId())
          .collection("chats")
          .add(message.toMap())
          .then((_) {
        controller.text = "";
      });
    });
  }
}
