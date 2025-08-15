import 'package:chat/constants.dart';

import 'package:flutter/material.dart';

class SendTextField extends StatelessWidget {
  const SendTextField({
    super.key,
    required this.onSubmitted,
    required this.controller,
  });
  final void Function(String)? onSubmitted;
  final TextEditingController controller;
  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      onSubmitted: onSubmitted,
      decoration: InputDecoration(
        suffixIcon: Icon(Icons.send, color: kPrimaryColor),
        hint: Text('Send Message'),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(
            width: 2,
            color: Colors.blue,
          ),
          borderRadius: BorderRadius.circular(20),
        ),
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(
            width: 2,
            color: kPrimaryColor,
          ),
          borderRadius: BorderRadius.circular(20),
        ),
      ),
    );
  }
}
