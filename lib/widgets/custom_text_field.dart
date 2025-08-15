import 'package:flutter/material.dart';

class CustomTextField extends StatelessWidget {
  const CustomTextField({
    super.key,
    required this.hint,
    this.obscure = false,
    required this.onChanged,
  });
  final String hint;
  final bool obscure;
  final Function(String)? onChanged;
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      validator: (data) {
        if (data!.isEmpty) {
          return 'Field is required';
        }
        return null;
      },
      onChanged: onChanged,
      obscureText: obscure,
      style: TextStyle(color: Colors.white),
      cursorColor: Colors.blue,
      decoration: InputDecoration(
        contentPadding: EdgeInsets.symmetric(
          vertical: 20,
          horizontal: 12,
        ),
        hint: Text(
          '$hint',
          style: TextStyle(color: Colors.white),
        ),

        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(
            color: Colors.white,
            width: 2,
          ),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(
            color: Colors.blue,
            width: 2,
          ),
        ),
      ),
    );
  }
}
