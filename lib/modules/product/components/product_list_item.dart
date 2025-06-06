import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:geapp/app/components/option_tile.dart';
import 'package:geapp/modules/image/providers/image_list_provider.dart';
import 'package:geapp/modules/product/models/product_model.dart';
import 'package:geapp/modules/product/providers/product_form_provider.dart';
import 'package:geapp/modules/product/providers/product_list_provider.dart';
import 'package:geapp/modules/unit/providers/unit_list_provider.dart';
import 'package:geapp/routes/routes.dart';
import 'package:geapp/themes/color.dart';
import 'package:geapp/themes/text.dart';
import 'package:geapp/utils/utils.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

class ProductListItem extends StatelessWidget {
  const ProductListItem({super.key, required this.item, this.onClick});

  final ProductModel item;
  final void Function(ProductModel p)? onClick;

  void handleOnTap(BuildContext context) async {
    if (onClick != null) {
      onClick?.call(item);
      return;
    }

    handleOpenModal(context);
  }

  void handleOpenModal(BuildContext context) {
    final provider = context.read<ProductListProvider>();
    Utils.showModal(
      context: context,
      icon: Icons.menu_outlined,
      title: "Opções",
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          OptionTile(
            title: "Editar",
            onPress: () async {
              await context.read<ProductFormProvider>().setEdit(item);
              if (context.mounted) {
                context.pop();
                final needUpdate = await context.push(Routes.productForm);
                if (needUpdate == true) provider.getData();
              }
            },
          ),
          SizedBox(height: 10),
          OptionTile(
            title: "Unidades",
            onPress: () async {
              await context.read<UnitListProvider>().init(item);

              if (context.mounted) {
                context.pop();
                context.push(Routes.unitList);
              }
            },
          ),
          SizedBox(height: 10),
          OptionTile(
            title: "Imagens",
            onPress: () async {
              await context.read<ImageListProvider>().init(item);

              if (context.mounted) {
                context.pop();
                context.push(Routes.imageList);
              }
            },
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => handleOnTap(context),
      child: Container(
        decoration: BoxDecoration(color: TColor.background.light),
        child: ListTile(
          contentPadding: const EdgeInsets.symmetric(
            horizontal: 20,
            vertical: 10,
          ),
          leading:
              item.images.isNotEmpty
                  ? Image.memory(
                    base64Decode(item.images.first.image!),
                    width: 50,
                  )
                  : null,
          title: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "${item.barCode} - ${item.name?.toUpperCase()}",
                style: TText.ml,
              ),
              SizedBox(height: 10),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: Text("Marca: ${item.brand}", style: TText.xs),
                  ),
                  Expanded(
                    child: Text(
                      "Grupo: ${item.groupName}",
                      style: TText.xs,
                      textAlign: TextAlign.end,
                    ),
                  ),
                ],
              ),
              if (item.units.isNotEmpty) ...[
                const SizedBox(height: 10),
                InkWell(
                  onTap: () async {
                    await context.read<ProductListProvider>().setUnit(item);
                  },
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: Text(
                          "Estoque: ${Utils.formatCurrency(item.stock)} ${item.unit.toUpperCase()}",
                          style: TText.xs,
                        ),
                      ),
                      Icon(
                        Icons.change_circle_outlined,
                        color: TColor.primary.light,
                        size: 20,
                      ),
                      Expanded(
                        child: Text(
                          "Preço: R\$${Utils.formatCurrency(item.price)}",
                          style: TText.xs,
                          textAlign: TextAlign.end,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ],
          ),
        ),
      ),
    );
  }
}
