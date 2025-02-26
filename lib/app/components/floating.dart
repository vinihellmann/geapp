import 'package:geapp/themes/color.dart';
import 'package:geapp/themes/text.dart';
import 'package:flutter/material.dart';

class Floating extends StatelessWidget {
  const Floating({super.key, required this.isLoading, required this.onClick});

  final bool isLoading;
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
          backgroundColor: TColor.background.success,
          label: Text("Salvar", style: TText.md),
          icon: Icon(Icons.check_outlined, color: TColor.text.primary),
        );
  }
}
