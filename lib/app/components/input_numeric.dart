import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:geapp/themes/color.dart';
import 'package:geapp/themes/text.dart';

class InputNumeric extends StatelessWidget {
  const InputNumeric({
    super.key,
    this.blocked = false,
    this.readOnly = false,
    this.onChange,
    required this.onPrefixPress,
    required this.onSuffixPress,
    this.controller,
    this.inputFormatters,
  });

  final bool blocked;
  final bool readOnly;
  final Function? onChange;
  final Function onPrefixPress;
  final Function onSuffixPress;
  final TextEditingController? controller;
  final List<TextInputFormatter>? inputFormatters;

  @override
  Widget build(BuildContext context) {
    return AbsorbPointer(
      absorbing: blocked,
      child: Opacity(
        opacity: blocked ? 0.5 : 1.0,
        child: Theme(
          data: Theme.of(context).copyWith(
            textSelectionTheme: TextSelectionThemeData(
              selectionHandleColor: TColor.primary.light,
            ),
          ),
          child: TextFormField(
            readOnly: readOnly,
            controller: controller,
            inputFormatters: inputFormatters,
            onChanged: onChange != null ? (value) => onChange!() : null,
            cursorHeight: 14,
            cursorColor: TColor.primary.light,
            keyboardType: const TextInputType.numberWithOptions(),
            textAlignVertical: TextAlignVertical.center,
            textAlign: TextAlign.center,
            style: TText.sm,
            decoration: InputDecoration(
              filled: true,
              fillColor: TColor.background.light,
              alignLabelWithHint: true,
              floatingLabelStyle: TextStyle(color: TColor.primary.light),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8),
                borderSide: BorderSide(color: TColor.background.border),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8),
                borderSide: BorderSide(color: TColor.primary.light),
              ),
              contentPadding: const EdgeInsets.symmetric(
                vertical: 10,
                horizontal: 16,
              ),
              prefixIcon: IconButton(
                onPressed: () => onPrefixPress(),
                icon: Icon(
                  Icons.remove_outlined,
                  color: TColor.primary.light,
                  size: 20,
                ),
              ),
              suffixIcon: IconButton(
                onPressed: () => onSuffixPress(),
                icon: Icon(
                  Icons.add_outlined,
                  color: TColor.primary.light,
                  size: 20,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
