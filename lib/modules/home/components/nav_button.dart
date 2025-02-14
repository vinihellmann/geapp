import 'package:geapp/themes/color.dart';
import 'package:geapp/themes/text.dart';
import 'package:flutter/material.dart';

class NavButton extends StatelessWidget {
  const NavButton({
    super.key,
    required this.label,
    required this.icon,
    required this.onTap,
  });

  final String label;
  final IconData icon;
  final Function onTap;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: InkWell(
        onTap: () => onTap(),
        borderRadius: BorderRadius.circular(8),
        splashColor: TColor.background.light,
        highlightColor: TColor.background.light,
        child: Ink(
          height: 90,
          decoration: BoxDecoration(
            color: TColor.background.light,
            border: Border.all(color: TColor.background.border),
            borderRadius: BorderRadius.circular(8),
          ),
          child: Padding(
            padding: const EdgeInsets.all(10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  icon,
                  color: TColor.button.primary,
                  size: 30,
                ),
                const SizedBox(width: 10),
                Text(label, style: TText.md)
              ],
            ),
          ),
        ),
      ),
    );
  }
}
