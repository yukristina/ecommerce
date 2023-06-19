import 'package:ecommerce/core/ui.dart';
import 'package:flutter/cupertino.dart';

class LinkButton extends StatefulWidget {
  const LinkButton({super.key, required this.onPressed, required this.text});

  final Function() onPressed;
  final String text;

  @override
  State<LinkButton> createState() => _LinkButtonState();
}

class _LinkButtonState extends State<LinkButton> {
  @override
  Widget build(BuildContext context) {
    return CupertinoButton(
      padding: EdgeInsets.zero,
      color: AppColors.accent,
      onPressed: widget.onPressed,
      child: Text(widget.text),
    );
  }
}
