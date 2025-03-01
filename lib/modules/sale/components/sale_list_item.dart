import 'package:flutter/material.dart';
import 'package:geapp/app/components/option_tile.dart';
import 'package:geapp/modules/sale/models/sale_model.dart';
import 'package:geapp/modules/sale/providers/sale_list_provider.dart';
import 'package:geapp/themes/color.dart';
import 'package:geapp/themes/text.dart';
import 'package:geapp/utils/utils.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

class SaleListItem extends StatelessWidget {
  const SaleListItem({super.key, required this.item});

  final SaleModel item;

  void handleOpenModal(BuildContext context) {
    final listProvider = context.read<SaleListProvider>();
    Utils.showModal(
      context: context,
      icon: Icons.menu_outlined,
      title: "Opções",
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          OptionTile(title: "Editar", onPress: () async {}),
          OptionTile(
            title: "Excluir",
            onPress: () async {
              context.pop();
              await listProvider.delete(item);
            },
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => handleOpenModal(context),
      child: Container(
        decoration: BoxDecoration(color: TColor.background.light),
        child: ListTile(
          contentPadding: const EdgeInsets.symmetric(
            horizontal: 20,
            vertical: 10,
          ),
          title: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "${item.id} - ${item.customerName?.toUpperCase()}",
                style: TText.ml,
              ),
              SizedBox(height: 10),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: Text(
                      "Data Entrega: ${Utils.formatDatePtBr(item.deliveryDate!)}",
                      style: TText.xs,
                    ),
                  ),
                  Expanded(
                    child: Text(
                      "Total: R\$${Utils.formatCurrency(item.totalValue!)}",
                      style: TText.xs,
                      textAlign: TextAlign.end,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
