import 'package:flutter/material.dart';
import 'package:flutter_multi_formatter/flutter_multi_formatter.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:geapp/app/components/modal.dart';
import 'package:geapp/app/services/local_storage_service.dart';
import 'package:geapp/themes/color.dart';
import 'package:intl/intl.dart';
import 'package:uuid/uuid.dart';

enum ToastType { success, error, info }

class Utils {
  static double parseDouble(String value) {
    String numericString = value.replaceAll(RegExp(r'[^\d,]'), '');
    numericString = numericString.replaceAll(',', '.');
    double valueDouble = double.tryParse(numericString) ?? 0.0;
    String finalValue = valueDouble.toStringAsFixed(2);
    return double.parse(finalValue);
  }

  static String formatCurrency(double? value) {
    if (value == null) return "";

    return CurrencyInputFormatter(
          thousandSeparator: ThousandSeparator.Period,
          mantissaLength: 2,
        )
        .formatEditUpdate(
          TextEditingValue.empty,
          TextEditingValue(text: value.toStringAsFixed(2)),
        )
        .text;
  }

  static String formatDate(DateTime? date) {
    if (date == null) return "";
    return DateFormat("dd/MM/yyyy").format(date);
  }

  static String formatDatePtBr(String isoDate) {
    DateTime dateTime = DateTime.parse(isoDate);
    return DateFormat('dd/MM/yyyy').format(dateTime);
  }

  static String formatTime(DateTime? time) {
    if (time == null) return "";
    return DateFormat("HH:mm").format(time);
  }

  static Future<bool?> showToast(String message, ToastType type) async {
    late Color bgColor;

    switch (type) {
      case ToastType.success:
        bgColor = TColor.background.success;
        break;
      case ToastType.info:
        bgColor = TColor.background.light;
        break;
      case ToastType.error:
        bgColor = TColor.error.main;
        break;
    }

    return Fluttertoast.showToast(
      msg: message,
      gravity: ToastGravity.BOTTOM,
      textColor: TColor.text.primary,
      toastLength: Toast.LENGTH_LONG,
      backgroundColor: bgColor,
    );
  }

  static Future<void> showModal({
    required BuildContext context,
    bool? showConfirm,
    double? height,
    required IconData icon,
    required String title,
    String? confirmText,
    VoidCallback? onConfirm,
    VoidCallback? onClear,
    required Widget content,
  }) async {
    return await showDialog<void>(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return Modal(
          showConfirm: showConfirm,
          height: height,
          icon: icon,
          title: title,
          confirmText: confirmText,
          onConfirm: onConfirm,
          onClear: onClear,
          content: content,
        );
      },
    );
  }

  static Future<String> generateGUID() async {
    final guid = await LocalStorageService.getData("GUID");
    if (guid != null) return guid;

    var uuid = const Uuid();
    String shortUuid = uuid.v4().substring(0, 8);
    String timestamp = DateTime.now().millisecondsSinceEpoch.toRadixString(36);

    var newGuid = '$shortUuid-$timestamp';
    await LocalStorageService.setData("GUID", newGuid);

    return newGuid;
  }
}
