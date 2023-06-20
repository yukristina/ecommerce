import 'package:ecommerce/core/ui.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class LinkButton extends StatelessWidget {
  const LinkButton({super.key, required this.onPressed, required this.text, this.color});

  final Function() onPressed;
  final String text;
  final Color? color;

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: onPressed,
      child: Text(
        text,
        style:  TextStyle(fontSize: 18, color: color ?? AppColors.accent),
      ),
    );
  }
}
