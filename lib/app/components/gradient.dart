import 'package:geapp/themes/color.dart';
import 'package:flutter/material.dart';

class TGradient extends StatelessWidget {
  const TGradient({super.key, this.child, this.height});

  final Widget? child;
  final double? height;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: height,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [TColor.primary.light, TColor.primary.dark],
        ),
      ),
      child: child,
    );
  }
}
