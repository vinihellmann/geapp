import 'package:geapp/themes/color.dart';
import 'package:geapp/themes/text.dart';
import 'package:flutter/material.dart';

class Pagination extends StatelessWidget {
  const Pagination({
    super.key,
    required this.page,
    required this.totalPages,
    required this.onLeftPress,
    required this.onRightPress,
  });

  final int page;
  final int totalPages;
  final VoidCallback onLeftPress;
  final VoidCallback onRightPress;

  @override
  Widget build(BuildContext context) {
    return Container(
      color: TColor.background.main,
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          IconButton(
            onPressed: onLeftPress,
            icon: Icon(
              Icons.chevron_left_outlined,
              color: TColor.button.primary,
            ),
          ),
          Text("Página $page de $totalPages", style: TText.ss),
          IconButton(
            onPressed: onRightPress,
            icon: Icon(
              Icons.chevron_right_outlined,
              color: TColor.button.primary,
            ),
          ),
        ],
      ),
    );
  }
}
