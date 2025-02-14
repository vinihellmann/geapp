import 'package:geapp/themes/color.dart';
import 'package:geapp/themes/text.dart';
import 'package:flutter/material.dart';

class TSwitch extends StatelessWidget {
  const TSwitch({
    super.key,
    required this.value,
    required this.title,
    required this.onChanged,
  });

  final bool value;
  final String title;
  final Function(bool) onChanged;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Text(title, style: TText.sm),
        Switch(
          value: value,
          onChanged: onChanged,
          activeColor: TColor.primary.light,
          inactiveThumbColor: TColor.text.primary,
          inactiveTrackColor: TColor.primary.light,
          trackOutlineColor: WidgetStatePropertyAll(TColor.primary.light),
        ),
      ],
    );
  }
}
