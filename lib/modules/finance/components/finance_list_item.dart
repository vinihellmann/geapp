import 'package:flutter/material.dart';
import 'package:geapp/modules/finance/models/finance_model.dart';
import 'package:geapp/themes/color.dart';
import 'package:geapp/themes/text.dart';
import 'package:geapp/utils/utils.dart';

class FinanceListItem extends StatelessWidget {
  final FinanceModel item;

  const FinanceListItem({super.key, required this.item});

  String getStatusName(int? status) {
    switch (status) {
      case 1:
        return "Recebida";
      case 2:
        return "Atrasada";
      case 3:
      default:
        return "A Receber";
    }
  }

  Color getStatusColor(int? status) {
    switch (status) {
      case 1:
        return TColor.background.success;
      case 2:
        return TColor.error.main;
      case 3:
      default:
        return TColor.text.primary;
    }
  }

  @override
  Widget build(BuildContext context) {
    final isReceivable = item.type == 1;
    final iconData = isReceivable ? Icons.arrow_upward : Icons.arrow_downward;
    final iconColor =
        isReceivable ? TColor.background.success : TColor.error.main;

    return InkWell(
      splashColor: TColor.background.light,
      highlightColor: TColor.background.light,
      child: Ink(
        decoration: BoxDecoration(color: TColor.background.light),
        child: ListTile(
          contentPadding: const EdgeInsets.fromLTRB(15, 5, 15, 5),
          leading: CircleAvatar(
            backgroundColor: iconColor.withAlpha(50),
            child: Icon(iconData, color: iconColor),
          ),
          title: Text(item.description?.toUpperCase() ?? "", style: TText.ml),
          subtitle: Column(
            spacing: 5,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(),
              Text(
                'Vencimento: ${Utils.formatDatePtBr(item.dueDate!)}',
                style: TText.ss,
              ),
              Text(
                'Valor: R\$${Utils.formatCurrency(item.value)}',
                style: TText.ss,
              ),
              if (item.customerCode != null && item.customerName != null)
                Text(
                  'Cliente: ${item.customerName?.toUpperCase()}',
                  style: TText.ss,
                ),
            ],
          ),
          trailing: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                getStatusName(item.status),
                style: TText.ss.apply(
                  color: getStatusColor(item.status),
                  fontSizeFactor: 0.9,
                  fontWeightDelta: 2,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
