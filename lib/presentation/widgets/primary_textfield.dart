import 'package:flutter/material.dart';

class PrimaryTextField extends StatelessWidget {
  const PrimaryTextField(
      {super.key, required this.controller, required this.labelText,  this.obscureText = false});

  final TextEditingController controller;
  final String labelText;
  final bool obscureText;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      obscureText: obscureText,
      decoration: InputDecoration(
        
          labelText: labelText,
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(7))),
    );
  }
}
