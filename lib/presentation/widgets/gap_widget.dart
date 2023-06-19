import 'package:flutter/material.dart';

class GapWidget extends StatelessWidget {
  const GapWidget({super.key, this.size = 0.0});
  final double size;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 16 + size,
      width: 16 + size,
    );
  }
}
