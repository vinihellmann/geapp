import 'package:flutter/material.dart';
import 'package:geapp/modules/unit/models/unit_model.dart';
import 'package:geapp/modules/unit/providers/unit_form_provider.dart';
import 'package:geapp/routes/routes.dart';
import 'package:geapp/themes/color.dart';
import 'package:geapp/themes/extension.dart';
import 'package:geapp/themes/text.dart';
import 'package:geapp/utils/utils.dart';
import 'package:provider/provider.dart';

class UnitItem extends StatelessWidget {
  const UnitItem({super.key, required this.item});

  final UnitModel item;

  void handleOnTap(BuildContext context) async {
    await context.read<UnitFormProvider>().setEdit(item);
    if (context.mounted) context.push(Routes.unitForm);
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => handleOnTap(context),
      child: Container(
        decoration: BoxDecoration(color: TColor.background.light),
        child: ListTile(
          iconColor: TColor.primary.light,
          contentPadding: const EdgeInsets.symmetric(
            horizontal: 20,
            vertical: 10,
          ),
          title: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                item.unit?.toUpperCase() ?? "",
                style: TText.ml,
                overflow: TextOverflow.ellipsis,
              ),
              SizedBox(height: 10),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: Text(
                      "Estoque: ${Utils.formatDouble(item.stock)}",
                      style: TText.xs,
                    ),
                  ),
                  Expanded(
                    child: Text(
                      "Preço: R\$${Utils.formatDouble(item.price)}",
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
