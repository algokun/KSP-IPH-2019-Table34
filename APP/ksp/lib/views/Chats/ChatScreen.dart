import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:ksp/config/colors.dart';
import 'package:ksp/models/messageModel.dart';
import 'package:ksp/utils/sendFile.dart';
import 'package:ksp/views/Message.dart';
import 'package:ksp/views/SecureChat/SecureChatHomeScreen.dart';
import 'package:local_auth/local_auth.dart';
import 'package:provider/provider.dart';

class ChatScreen extends StatefulWidget {
  final String peerId, name;

  const ChatScreen({Key key, this.peerId, this.name}) : super(key: key);
  @override
  _ChatScreenState createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> with ColorConfig {
  LocalAuthentication localAuthentication = LocalAuthentication();
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
          FlatButton.icon(
            label: Text("Secure Chat"),
            icon: Icon(Icons.lock),
            onPressed: openSecureChat,
          ),
          IconButton(
              icon: Icon(Icons.attach_file),
              onPressed: () {
                SendFile(
                        context: context,
                        hashId: getHashId(),
                        idFrom: uid,
                        idTo: widget.peerId,
                        isSecure: false)
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
            .collection("messages")
            .document(getHashId())
            .collection("chats")
            .where('isSecure', isEqualTo: false)
            .where('isExpired', isEqualTo: false)
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
        isSecure: false,
        isExpired: false,
        idTo: widget.peerId,
        timeStamp: DateTime.now().toString());

    await Firestore.instance
        .collection("messages")
        .document(getHashId())
        .collection("chats")
        .add(message.toMap())
        .then((_) {
      controller.text = "";
    });
  }

  openSecureChat() async {
    try {
      bool didAuthenticate =
          await localAuthentication.authenticateWithBiometrics(
              localizedReason: 'Please authenticate to show account balance');
      if (didAuthenticate) {
        Navigator.of(context)
            .push(MaterialPageRoute(builder: (_) => SecureChatHome()));
      }
    } on PlatformException catch (e) {
      print(e);
    }
  }
}
