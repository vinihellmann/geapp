import 'package:flutter/material.dart';
import 'package:geapp/themes/color.dart';
import 'package:geapp/themes/text.dart';
import 'package:geapp/utils/utils.dart';

enum DateTimeFieldType { date, time }

class DateTimeInput extends StatefulWidget {
  const DateTimeInput({
    super.key,
    required this.type,
    required this.label,
    required this.onChanged,
    this.initialValue,
    this.isRequired = false,
    this.disabled = false,
  });

  final DateTimeFieldType type;
  final String label;
  final Function(DateTime) onChanged;
  final DateTime? initialValue;
  final bool isRequired;
  final bool disabled;

  @override
  State<DateTimeInput> createState() => _DateTimeInputState();
}

class _DateTimeInputState extends State<DateTimeInput> {
  late TextEditingController _controller;

  @override
  void initState() {
    super.initState();
    _controller = TextEditingController(
      text:
          widget.initialValue != null
              ? widget.type == DateTimeFieldType.date
                  ? Utils.formatDate(widget.initialValue!)
                  : Utils.formatTime(widget.initialValue!)
              : '',
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  Future<void> _pickDate(BuildContext context) async {
    DateTime? selectedDate = await showDatePicker(
      context: context,
      barrierDismissible: false,
      firstDate: DateTime(1900),
      lastDate: DateTime(2100),
      initialDate: widget.initialValue ?? DateTime.now(),
      builder: (context, child) {
        return Theme(
          data: Theme.of(context).copyWith(
            colorScheme: ColorScheme.dark(
              primary: TColor.primary.light,
              onPrimary: TColor.text.secondary,
              onSurface: TColor.primary.light,
              surface: TColor.background.main,
            ),
            textButtonTheme: TextButtonThemeData(
              style: TextButton.styleFrom(
                foregroundColor: TColor.primary.light,
              ),
            ),
          ),
          child: child!,
        );
      },
    );

    if (selectedDate != null) {
      setState(() => _controller.text = Utils.formatDate(selectedDate));
      widget.onChanged(selectedDate);
    }
  }

  Future<void> _pickTime(BuildContext context) async {
    TimeOfDay? selectedTime = await showTimePicker(
      context: context,
      barrierDismissible: false,
      initialTime:
          widget.initialValue != null
              ? TimeOfDay(
                hour: widget.initialValue!.hour,
                minute: widget.initialValue!.minute,
              )
              : TimeOfDay.now(),
      builder: (context, child) {
        return Theme(
          data: Theme.of(context).copyWith(
            colorScheme: ColorScheme.dark(
              primary: TColor.primary.light,
              onPrimary: TColor.text.secondary,
              onSurface: TColor.primary.light,
              surface: TColor.background.main,
            ),
            textButtonTheme: TextButtonThemeData(
              style: TextButton.styleFrom(
                foregroundColor: TColor.primary.light,
              ),
            ),
          ),
          child: child!,
        );
      },
    );

    if (selectedTime != null) {
      final now = DateTime.now();
      DateTime selectedDateTime = DateTime(
        now.year,
        now.month,
        now.day,
        selectedTime.hour,
        selectedTime.minute,
      );

      setState(() => _controller.text = Utils.formatTime(selectedDateTime));
      widget.onChanged(selectedDateTime);
    }
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () async {
        if (widget.type == DateTimeFieldType.date) {
          await _pickDate(context);
        } else if (widget.type == DateTimeFieldType.time) {
          await _pickTime(context);
        }
      },
      child: AbsorbPointer(
        child: TextFormField(
          readOnly: true,
          controller: _controller,
          validator:
              widget.isRequired
                  ? (value) {
                    if (value == null || value.isEmpty) {
                      return 'Campo Obrigatório!';
                    }
                    return null;
                  }
                  : null,
          cursorColor: TColor.primary.light,
          style: TText.md,
          decoration: InputDecoration(
            suffixIcon: Icon(
              color: TColor.button.primary,
              widget.type == DateTimeFieldType.date
                  ? Icons.calendar_month_outlined
                  : Icons.access_time_outlined,
            ),
            labelText: widget.label,
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
      ),
    );
  }
}
