import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:ksp/views/PhotoView.dart';

class SendFile {
  final BuildContext context;
  final String hashId, idFrom, idTo;
  final bool isSecure;
  SendFile({this.context, this.hashId, this.idFrom, this.idTo, this.isSecure});

  final style = TextStyle(color: Colors.white);
  final lowContrast = Color(0xFF54595E);

  Future<Null> showSendDialog() async {
    List list = [
      GridTile(
        footer: Center(child: Text("Share Location", style: style)),
        child: IconButton(
          color: Colors.orange,
          icon: Icon(Icons.location_on),
          iconSize: 50.0,
          onPressed: () {},
        ),
      ),
      GridTile(
        footer: Center(child: Text("Send File", style: style)),
        child: IconButton(
          color: Colors.blue,
          icon: Icon(Icons.file_upload),
          iconSize: 50.0,
          onPressed: () async {
            sendFileType(FileType.CUSTOM);
          },
        ),
      ),
      GridTile(
        footer: Center(child: Text("Gallery", style: style)),
        child: IconButton(
          color: Colors.purple,
          icon: Icon(Icons.photo_library),
          iconSize: 50.0,
          onPressed: () async {
            sendFileType(FileType.IMAGE);
          },
        ),
      ),
    ];
    return showModalBottomSheet(
        backgroundColor: Colors.transparent,
        context: context,
        builder: (context) {
          return Container(
            decoration: BoxDecoration(
                color: Color(0xFF54595E),
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(30.0),
                  topRight: Radius.circular(30.0),
                )),
            width: 50,
            height: 200,
            child: GridView.count(
              crossAxisCount: 3,
              children: list
                  .map((item) => Material(
                        color: lowContrast,
                        child: item,
                      ))
                  .toList(),
            ),
          );
        });
  }

  sendFileType(FileType fileType) async {
    File _file = await FilePicker.getFile(type: fileType, fileExtension: 'png');
    Navigator.of(context).push(MaterialPageRoute(
        builder: (c) => SendPhotoView(
              file: _file,
              hashId: hashId,
              idFrom: idFrom,
              idTo: idTo,
              isSecure: isSecure,
            )));
  }
}
