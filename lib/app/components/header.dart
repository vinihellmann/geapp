import 'package:flutter/material.dart';
import 'package:geapp/themes/color.dart';
import 'package:geapp/themes/text.dart';

class Header extends StatelessWidget {
  const Header({
    super.key,
    required this.totalItemsShown,
    required this.totalItems,
    required this.onTapAdd,
    required this.onTapFilter,
  });

  final int totalItemsShown;
  final int totalItems;
  final VoidCallback onTapAdd;
  final VoidCallback onTapFilter;

  @override
  Widget build(BuildContext context) {
    return Container(
      color: TColor.background.main,
      padding: const EdgeInsets.fromLTRB(16, 16, 8, 16),
      child: Row(
        children: [
          Text("$totalItemsShown de $totalItems itens", style: TText.ss),
          const Spacer(),
          IconButton(
            onPressed: onTapAdd,
            icon: Icon(Icons.add_circle_outline, color: TColor.button.primary),
          ),
          IconButton(
            onPressed: onTapFilter,
            icon: Icon(
              Icons.filter_list_outlined,
              color: TColor.button.primary,
            ),
          ),
        ],
      ),
    );
  }
}
