import 'package:flutter/material.dart';
import 'package:geapp/themes/color.dart';
import 'package:geapp/themes/text.dart';
import 'package:geapp/utils/utils.dart';

class Delete extends StatelessWidget {
  const Delete({super.key, required this.visible, required this.onDelete});

  final bool visible;
  final VoidCallback onDelete;

  @override
  Widget build(BuildContext context) {
    return Visibility(
      visible: visible,
      child: Padding(
        padding: const EdgeInsets.only(right: 10),
        child: IconButton(
          icon: Icon(Icons.delete_outlined, color: TColor.error.main),
          onPressed: () async {
            await Utils.showModal(
              context: context,
              showConfirm: true,
              title: "Excluir",
              icon: Icons.delete_outline,
              content: Padding(
                padding: const EdgeInsets.symmetric(vertical: 10),
                child: Text(
                  "Deseja realmente excluir o registro?",
                  style: TText.sm,
                ),
              ),
              onConfirm: onDelete,
            );
          },
        ),
      ),
    );
  }
}
