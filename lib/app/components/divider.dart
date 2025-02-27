import 'package:flutter/material.dart';
import 'package:geapp/themes/color.dart';

class ListDivider extends StatelessWidget {
  const ListDivider({super.key});

  @override
  Widget build(BuildContext context) {
    return Divider(color: TColor.background.border, height: 1);
  }
}
