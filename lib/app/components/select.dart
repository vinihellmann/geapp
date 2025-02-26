import 'package:geapp/app/models/select_object.dart';
import 'package:geapp/themes/color.dart';
import 'package:geapp/themes/text.dart';
import 'package:flutter/material.dart';

class Select extends StatelessWidget {
  const Select({
    super.key,
    this.isRequired = false,
    required this.label,
    required this.value,
    required this.items,
    required this.onChanged,
    this.validator,
  });

  final bool isRequired;
  final String label;
  final dynamic value;
  final List<SelectObject> items;
  final Function(dynamic) onChanged;
  final String? Function(dynamic)? validator;

  @override
  Widget build(BuildContext context) {
    return DropdownButtonFormField(
      value: value,
      validator:
          isRequired
              ? (value) {
                if (value == null) {
                  return 'Campo Obrigatório!';
                }

                return null;
              }
              : validator,
      style: TText.md,
      dropdownColor: TColor.background.light,
      iconEnabledColor: TColor.primary.light,
      icon: Icon(Icons.unfold_more_outlined, color: TColor.primary.light),
      items:
          items.map((SelectObject option) {
            return DropdownMenuItem(
              value: option.key,
              child: Text(
                "${option.value}",
                style: TextStyle(color: TColor.text.primary),
              ),
            );
          }).toList(),
      onChanged: (newValue) => onChanged(newValue),
      decoration: InputDecoration(
        labelText: label,
        labelStyle: TText.ss,
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
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: BorderSide(color: TColor.primary.light),
        ),
        contentPadding: const EdgeInsets.symmetric(
          vertical: 10,
          horizontal: 16,
        ),
      ),
    );
  }
}
