import 'package:flutter/material.dart';
import 'package:geapp/themes/color.dart';
import 'package:geapp/themes/text.dart';

class OptionTile extends StatelessWidget {
  const OptionTile({
    super.key,
    required this.title,
    required this.onPress,
    this.leading = true,
  });

  final bool leading;
  final String title;
  final Function onPress;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => onPress(),
      borderRadius: BorderRadius.circular(8),
      splashColor: TColor.background.main,
      highlightColor: TColor.background.main,
      child: Ink(
        decoration: BoxDecoration(
          color: TColor.background.main,
          borderRadius: BorderRadius.circular(8),
        ),
        child: Theme(
          data: Theme.of(context).copyWith(
            dividerColor: Colors.transparent,
            splashColor: Colors.transparent,
          ),
          child: ListTile(
            contentPadding: const EdgeInsets.fromLTRB(20, 0, 16, 0),
            leading: Icon(
              Icons.chevron_right_outlined,
              color: TColor.primary.light,
            ),
            title: Text(title, style: TText.md),
          ),
        ),
      ),
    );
  }
}
