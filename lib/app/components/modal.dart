import 'package:flutter/material.dart';
import 'package:geapp/app/components/button.dart';
import 'package:geapp/themes/color.dart';
import 'package:geapp/themes/text.dart';
import 'package:go_router/go_router.dart';

class Modal extends StatelessWidget {
  const Modal({
    super.key,
    this.showConfirm,
    this.height,
    required this.icon,
    required this.title,
    this.confirmText,
    this.onConfirm,
    this.onClear,
    required this.content,
  });

  final bool? showConfirm;
  final double? height;
  final IconData icon;
  final String title;
  final String? confirmText;
  final VoidCallback? onConfirm;
  final VoidCallback? onClear;
  final Widget content;

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: TColor.background.main,
      titlePadding:
          onClear != null
              ? const EdgeInsets.fromLTRB(16, 5, 5, 10)
              : const EdgeInsets.all(16),
      contentPadding: const EdgeInsets.symmetric(vertical: 0, horizontal: 16),
      actionsPadding: const EdgeInsets.all(16),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
      title: Row(
        children: [
          Icon(icon, color: TColor.primary.light),
          const SizedBox(width: 8),
          Expanded(child: Text(title, style: TText.ml)),
          Visibility(
            visible: onClear != null,
            child: IconButton(
              onPressed: onClear,
              icon: Icon(Icons.block, color: TColor.primary.light),
            ),
          ),
        ],
      ),
      content: SizedBox(
        height: height,
        width: MediaQuery.sizeOf(context).width * 0.85,
        child: content,
      ),
      actions: [
        Row(
          children: [
            Expanded(
              child: Button(
                outlined: true,
                label: "Fechar",
                bgColor: TColor.background.main,
                onClick: () => Navigator.pop(context),
              ),
            ),
            if (showConfirm == true) ...[
              const SizedBox(width: 8),
              Expanded(
                child: Button(
                  label: confirmText ?? "Confirmar",
                  onClick: () {
                    onConfirm!();
                    context.pop();
                  },
                ),
              ),
            ],
          ],
        ),
      ],
    );
  }
}
