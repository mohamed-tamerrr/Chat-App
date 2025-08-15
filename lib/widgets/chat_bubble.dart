import 'package:chat/constants.dart';
import 'package:flutter/material.dart';

import '../models/message.dart';

class ChatBubble extends StatelessWidget {
  const ChatBubble({super.key, required this.msg});
  final Message msg;
  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.centerLeft,
      child: Container(
        padding: EdgeInsets.only(
          left: 16,
          top: 32,
          bottom: 32,
          right: 32,
        ),

        margin: EdgeInsets.symmetric(
          horizontal: 16,
          vertical: 8,
        ),
        decoration: BoxDecoration(
          color: kPrimaryColor,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(32),
            topRight: Radius.circular(32),
            bottomRight: Radius.circular(32),
          ),
        ),
        child: Text(
          msg.msg,
          style: TextStyle(color: Colors.white),
        ),
      ),
    );
  }
}

class OtherChatBubble extends StatelessWidget {
  const OtherChatBubble({super.key, required this.msg});
  final Message msg;
  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.centerRight,
      child: Container(
        padding: EdgeInsets.only(
          left: 16,
          top: 32,
          bottom: 32,
          right: 32,
        ),

        margin: EdgeInsets.symmetric(
          horizontal: 16,
          vertical: 8,
        ),
        decoration: BoxDecoration(
          color: Color(0xff006084),
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(32),
            topRight: Radius.circular(32),
            bottomRight: Radius.circular(0),
            bottomLeft: Radius.circular(32),
          ),
        ),
        child: Text(
          msg.msg,
          style: TextStyle(color: Colors.white),
        ),
      ),
    );
  }
}
