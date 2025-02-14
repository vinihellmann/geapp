import 'package:geapp/app/components/gradient.dart';
import 'package:geapp/themes/color.dart';
import 'package:flutter/material.dart';

class NavBar extends StatelessWidget implements PreferredSizeWidget {
  NavBar({
    super.key,
    required this.withDrawer,
    this.leading,
    required this.backButton,
    required this.title,
    this.actions,
    this.bottom,
  }) : preferredSize = Size.fromHeight(bottom != null ? 120 : 90);

  @override
  final Size preferredSize;
  final bool withDrawer;
  final bool backButton;
  final Widget? leading;
  final Widget title;
  final List<Widget>? actions;
  final PreferredSizeWidget? bottom;

  @override
  Widget build(BuildContext context) {
    return TGradient(
      child: AppBar(
        scrolledUnderElevation: 0,
        elevation: 0,
        titleSpacing: 0,
        toolbarHeight: bottom != null ? 120 : 90,
        backgroundColor: Colors.transparent,
        bottom: bottom,
        leading: leading ??
            (backButton
                ? Padding(
                    padding: const EdgeInsets.only(left: 10),
                    child: IconButton(
                      onPressed: () => Navigator.pop(context),
                      icon: Icon(
                        Icons.chevron_left_outlined,
                        color: TColor.text.primary,
                      ),
                    ),
                  )
                : null),
        title: title,
        centerTitle: true,
        actions: [
          ...?actions,
          Visibility(
            visible: withDrawer,
            child: Padding(
              padding: const EdgeInsets.only(right: 10),
              child: IconButton(
                icon: const Icon(Icons.menu_outlined),
                color: TColor.text.primary,
                onPressed: () => Scaffold.of(context).openEndDrawer(),
              ),
            ),
          )
        ],
      ),
    );
  }
}
