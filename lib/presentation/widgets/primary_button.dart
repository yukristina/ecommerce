import 'package:ecommerce/core/ui.dart';
import 'package:flutter/cupertino.dart';

class PrimaryButton extends StatelessWidget {
  const PrimaryButton({super.key, required this.text, this.onPressed, this.color});

  final String text;
  final Function()? onPressed;
  final Color? color;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: MediaQuery.of(context).size.width,
      child: CupertinoButton(
        color: color ?? AppColors.accent,
        onPressed: onPressed,
        child: Text(text),
      ),
    );
  }
}
