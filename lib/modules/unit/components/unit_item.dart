import 'package:flutter/material.dart';
import 'package:geapp/modules/unit/models/unit_model.dart';
import 'package:geapp/themes/color.dart';
import 'package:geapp/themes/text.dart';

class UnitItem extends StatelessWidget {
  const UnitItem({super.key, required this.item});

  final UnitModel item;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {},
      child: Container(
        decoration: BoxDecoration(color: TColor.background.light),
        child: ListTile(
          iconColor: TColor.primary.light,
          contentPadding: const EdgeInsets.fromLTRB(20, 5, 10, 5),
          title: Text(
            item.unit?.toUpperCase() ?? "",
            style: TText.ml,
            overflow: TextOverflow.ellipsis,
          ),
          subtitle: Text(
            item.stock.toString(),
            style: TText.xs,
          ),
        ),
      ),
    );
  }
}
