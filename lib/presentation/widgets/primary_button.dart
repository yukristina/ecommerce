import 'package:ecommerce/core/ui.dart';
import 'package:flutter/cupertino.dart';

class PrimaryButton extends StatefulWidget {
  const PrimaryButton({super.key, required this.text, this.onPressed});

  final String text;
  final Function()? onPressed;

  @override
  State<PrimaryButton> createState() => _PrimaryButtonState();
}

class _PrimaryButtonState extends State<PrimaryButton> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: MediaQuery.of(context).size.width,
      child: CupertinoButton(
        color: AppColors.accent,
        onPressed: widget.onPressed,
        child: Text(widget.text),
      ),
    );
  }
}
