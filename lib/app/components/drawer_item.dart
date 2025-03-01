import 'package:geapp/themes/color.dart';
import 'package:geapp/themes/text.dart';
import 'package:flutter/material.dart';

class TDrawerItem extends StatelessWidget {
  const TDrawerItem({
    super.key,
    required this.icon,
    required this.title,
    required this.onClick,
    this.exitApp = false,
  });

  final bool exitApp;
  final IconData icon;
  final String title;
  final Function onClick;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => onClick(),
      borderRadius: BorderRadius.circular(8),
      splashColor: TColor.background.light,
      highlightColor: TColor.background.light,
      child: Ink(
        decoration: BoxDecoration(
          color: TColor.background.light,
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
              icon,
              color: exitApp ? TColor.error.main : TColor.primary.light,
            ),
            title: Text(title, style: TText.md),
            trailing: Icon(
              Icons.chevron_right_outlined,
              color: exitApp ? TColor.error.main : TColor.button.primary,
            ),
          ),
        ),
      ),
    );
  }
}
