import 'package:geapp/app/components/drawer.dart';
import 'package:geapp/app/components/navbar.dart';
import 'package:geapp/themes/color.dart';
import 'package:flutter/material.dart';

class Layout extends StatelessWidget {
  const Layout({
    super.key,
    required this.title,
    required this.body,
    this.backButton = true,
    this.leading,
    this.actions,
    this.withDrawer = false,
    this.padding,
    this.floating,
    this.bottom,
  });

  final bool withDrawer;
  final bool backButton;
  final Widget? leading;
  final List<Widget>? actions;
  final Widget title;
  final Widget body;
  final EdgeInsets? padding;
  final Widget? floating;
  final PreferredSizeWidget? bottom;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      endDrawer: const TDrawer(),
      backgroundColor: TColor.background.main,
      appBar: NavBar(
        title: title,
        withDrawer: withDrawer,
        leading: leading,
        backButton: backButton,
        actions: actions,
        bottom: bottom,
      ),
      body: body,
      floatingActionButton: floating,
    );
  }
}
