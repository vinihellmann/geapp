import 'package:geapp/themes/color.dart';
import 'package:geapp/themes/text.dart';
import 'package:flutter/material.dart';

class Floating extends StatelessWidget {
  const Floating({
    super.key,
    required this.isLoading,
    required this.onClick,
    this.label,
    this.bgColor,
    this.icon,
  });

  final bool isLoading;
  final IconData? icon;
  final String? label;
  final Color? bgColor;
  final VoidCallback onClick;

  @override
  Widget build(BuildContext context) {
    return isLoading
        ? FloatingActionButton(
          onPressed: () {},
          backgroundColor: TColor.background.success,
          child: SizedBox(
            width: 20,
            height: 20,
            child: CircularProgressIndicator(
              color: TColor.text.primary,
              strokeWidth: 2,
            ),
          ),
        )
        : FloatingActionButton.extended(
          onPressed: onClick,
          backgroundColor: bgColor ?? TColor.background.success,
          label: Text(label ?? "Salvar", style: TText.md),
          icon: Icon(
            icon ?? Icons.check_outlined,
            color: TColor.text.primary,
            size: 20,
          ),
        );
  }
}
