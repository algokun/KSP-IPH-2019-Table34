import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ksp/models/messageModel.dart';
import 'package:ksp/utils/storageHandler.dart';
import 'package:photo_view/photo_view.dart';
import 'package:flutter/material.dart';

class Photo extends StatelessWidget {
  final String assetName;
  final bool isAsset;

  const Photo({Key key, this.assetName, this.isAsset}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFF323538),
      body: PhotoView(
        imageProvider:
            isAsset ? AssetImage(assetName) : NetworkImage(assetName),
      ),
    );
  }
}

class SendPhotoView extends StatefulWidget {
  final File file;
  final bool isSecure;
  final String idFrom, idTo, hashId;
  const SendPhotoView(
      {Key key, this.file, this.idFrom, this.idTo, this.hashId, this.isSecure})
      : super(key: key);

  @override
  _SendPhotoViewState createState() => _SendPhotoViewState();
}

class _SendPhotoViewState extends State<SendPhotoView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Send Image"),
      ),
      backgroundColor: Color(0xFF323538),
      body: PhotoView(
        imageProvider: FileImage(widget.file),
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.send),
        onPressed: () async {
          widget.isSecure
              ? sendSecureMessage(widget.isSecure)
              : sendTextMessage(widget.isSecure);
        },
      ),
    );
  }

  sendTextMessage(bool isSecure) async {
    final url = await StorageService().uploadFile(widget.file);
    final message = MessageModel(
        content: url,
        type: '1',
        idFrom: widget.idFrom,
        isSecure: isSecure,
        idTo: widget.idTo,
        timeStamp: DateTime.now().toString());

    await Firestore.instance
        .collection("messages")
        .document(widget.hashId)
        .collection("chats")
        .add(message.toMap())
        .then((_) {
      Navigator.of(context).pop();
    });
  }

  sendSecureMessage(bool isSecure) async {
    final url = await StorageService().uploadFile(widget.file);
    final message = MessageModel(
        content: url,
        type: '1',
        idFrom: widget.idFrom,
        isSecure: isSecure,
        idTo: widget.idTo,
        timeStamp: DateTime.now().toString());

    await Firestore.instance
        .collection("messages")
        .document(widget.hashId)
        .collection("chats")
        .add(message.toMap())
        .then((_) async {
      await Firestore.instance
          .collection("secure_chat")
          .document(widget.hashId)
          .collection("chats")
          .add(message.toMap())
          .then((_) {});
    });
  }
}

class PhotoNetwork extends StatelessWidget {
  final String url;

  const PhotoNetwork({Key key, this.url}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PhotoView(
        imageProvider: NetworkImage(url),
      ),
    );
  }
}
