import 'package:flutter/material.dart';
import 'package:ksp/models/messageModel.dart';

class MessageView extends StatelessWidget {
  MessageView({this.message, this.alignment});

  final MessageModel message;
  final Alignment alignment;

  @override
  Widget build(BuildContext context) {
    bool isMe = alignment == Alignment.centerLeft ? true : false;
    bool delivered = true;
    final bg = isMe ? Color(0xFFDDE3E5) : Colors.orange;
    final align = isMe ? CrossAxisAlignment.start : CrossAxisAlignment.end;
    final icon = delivered ? Icons.done : Icons.timer;
    final radius = isMe
        ? BorderRadius.only(
            topRight: Radius.circular(5.0),
            bottomLeft: Radius.circular(10.0),
            bottomRight: Radius.circular(5.0),
          )
        : BorderRadius.only(
            topLeft: Radius.circular(5.0),
            bottomLeft: Radius.circular(5.0),
            bottomRight: Radius.circular(10.0),
          );
    final time = DateTime.parse(message.timeStamp);
    switch (message.type) {
      case '1':
        return Image.network(message.content);
        break;
      default:
        return Bubble(
            align: align,
            bg: bg,
            radius: radius,
            message: message,
            time: time,
            icon: icon,
            isMe: isMe);
    }
  }
}

class Bubble extends StatelessWidget {
  const Bubble({
    Key key,
    @required this.align,
    @required this.bg,
    @required this.radius,
    @required this.message,
    @required this.time,
    @required this.icon,
    @required this.isMe,
  }) : super(key: key);

  final CrossAxisAlignment align;
  final Color bg;
  final BorderRadius radius;
  final MessageModel message;
  final DateTime time;
  final IconData icon;
  final bool isMe;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: align,
      children: <Widget>[
        Container(
          margin: const EdgeInsets.all(3.0),
          padding: const EdgeInsets.all(8.0),
          decoration: BoxDecoration(
            boxShadow: [
              BoxShadow(
                  blurRadius: .5,
                  spreadRadius: 1.0,
                  color: Colors.black.withOpacity(.12))
            ],
            color: bg,
            borderRadius: radius,
          ),
          child: Stack(
            children: <Widget>[
              Padding(
                padding: EdgeInsets.only(right: 60.0),
                child: Text(message.content),
              ),
              Positioned(
                bottom: 0.0,
                right: 0.0,
                child: Row(
                  children: <Widget>[
                    Text("${time.hour} : ${time.minute}",
                        style: TextStyle(
                          color: Colors.black38,
                          fontSize: 10.0,
                        )),
                    SizedBox(width: 3.0),
                    Icon(
                      icon,
                      size: !isMe ? 12.0 : 0,
                      color: Colors.black38,
                    )
                  ],
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
