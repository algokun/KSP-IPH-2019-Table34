import 'package:flutter/material.dart';
import 'package:ksp/config/colors.dart';
import 'package:ksp/models/messageModel.dart';

class MessageView extends StatefulWidget {
  final MessageModel model;
  final Alignment alignment;
  const MessageView({Key key, this.model, this.alignment}) : super(key: key);
  @override
  _MessageViewState createState() => _MessageViewState();
}

class _MessageViewState extends State<MessageView> with ColorConfig {
  @override
  Widget build(BuildContext context) {
    switch (widget.model.type) {
      case '0':
        return Container(
          child: Image.network(widget.model.content),
          decoration: BoxDecoration(
              border: Border.all(
                  color: lowContrast, width: 2.0, style: BorderStyle.solid)),
        );
        break;
      default:
        return Container(
          child: Text(widget.model.content),
        );
    }
  }
}
