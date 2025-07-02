import 'package:geapp/themes/color.dart';
import 'package:geapp/themes/text.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class Input extends StatefulWidget {
  const Input({
    super.key,
    this.icon,
    this.maxLines,
    this.label,
    this.validator,
    this.onChanged,
    this.controller,
    this.initialValue,
    this.inputFormatters,
    this.obscure = false,
    this.readOnly = false,
    this.isRequired = false,
    this.textInputType = TextInputType.text,
    this.textCapitalization = TextCapitalization.none,
  });

  final bool obscure;
  final bool isRequired;
  final bool readOnly;
  final int? maxLines;
  final String? label;
  final IconData? icon;
  final String? initialValue;
  final TextInputType textInputType;
  final Function(String)? onChanged;
  final TextEditingController? controller;
  final String? Function(String?)? validator;
  final TextCapitalization textCapitalization;
  final List<TextInputFormatter>? inputFormatters;

  @override
  State<Input> createState() => _InputState();
}

class _InputState extends State<Input> {
  bool hidden = true;

  @override
  Widget build(BuildContext context) {
    return Theme(
      data: Theme.of(context).copyWith(
        textSelectionTheme: TextSelectionThemeData(
          selectionHandleColor: TColor.primary.light,
        ),
      ),
      child: TextFormField(
        textAlignVertical:
            widget.maxLines != null && widget.obscure != true
                ? TextAlignVertical.top
                : null,
        readOnly: widget.readOnly,
        maxLines: widget.maxLines,
        inputFormatters: widget.inputFormatters,
        keyboardType: widget.textInputType,
        textCapitalization: widget.textCapitalization,
        initialValue: widget.initialValue,
        onChanged:
            widget.onChanged != null
                ? (value) => widget.onChanged!(value)
                : null,
        controller: widget.controller,
        validator:
            widget.isRequired
                ? (value) {
                  if (value == null || value.isEmpty) {
                    return 'Campo Obrigatório!';
                  }

                  return null;
                }
                : widget.validator,
        obscureText: widget.obscure ? hidden : false,
        cursorColor: TColor.primary.light,
        style: TText.md,
        cursorHeight: 14,
        decoration: InputDecoration(
          suffixIcon:
              widget.icon != null
                  ? Icon(widget.icon, color: TColor.button.primary, size: 24)
                  : widget.obscure
                  ? IconButton(
                    onPressed: () {
                      setState(() {
                        hidden = !hidden;
                      });
                    },
                    icon: Icon(
                      hidden
                          ? Icons.visibility_off_outlined
                          : Icons.visibility_outlined,
                      color: TColor.button.primary,
                      size: 24,
                    ),
                  )
                  : null,
          labelText: widget.label,
          labelStyle: TText.ss,
          alignLabelWithHint: true,
          filled: true,
          fillColor: TColor.background.light,
          floatingLabelStyle: TextStyle(color: TColor.primary.light),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
            borderSide: BorderSide(color: TColor.background.border),
          ),
          errorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
            borderSide: BorderSide(color: TColor.error.main),
          ),
          errorStyle: TextStyle(color: TColor.error.main),
          focusedErrorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
            borderSide: BorderSide(color: TColor.primary.light),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
            borderSide: BorderSide(color: TColor.primary.light),
          ),
          contentPadding: const EdgeInsets.symmetric(
            vertical: 10,
            horizontal: 16,
          ),
        ),
      ),
    );
  }
}
