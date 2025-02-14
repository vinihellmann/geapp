import 'package:flutter/material.dart';
import 'package:geapp/app/components/option_tile.dart';
import 'package:geapp/modules/product/models/product_model.dart';
import 'package:geapp/modules/product/providers/product_form_provider.dart';
import 'package:geapp/modules/unit/providers/unit_provider.dart';
import 'package:geapp/routes/routes.dart';
import 'package:geapp/themes/color.dart';
import 'package:geapp/themes/extension.dart';
import 'package:geapp/themes/text.dart';
import 'package:geapp/utils/utils.dart';
import 'package:provider/provider.dart';

class ProductListItem extends StatelessWidget {
  const ProductListItem({super.key, required this.item, this.onClick});

  final ProductModel item;
  final void Function(ProductModel p)? onClick;

  final String noImageUrl = "assets/images/no_image.png";

  void handleOnTap(BuildContext context) async {
    if (onClick != null) {
      onClick?.call(item);
      context.pop();
      return;
    }

    handleOpenModal(context);
  }

  void handleOpenModal(BuildContext context) {
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
              if (context.mounted) context.push(Routes.productForm);
            },
          ),
          SizedBox(height: 10),
          OptionTile(
            title: "Unidades",
            onPress: () async {
              await context.read<UnitProvider>().init(item);
              if (context.mounted) context.push(Routes.unit);
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
          titleAlignment: ListTileTitleAlignment.titleHeight,
          leading: SizedBox(
            height: 60,
            width: 60,
            child: item.image != null
                ? Image.network(item.image!)
                : Image.asset(noImageUrl),
          ),
          title: Text(item.name?.toUpperCase() ?? "", style: TText.ml),
          subtitle: Column(
            children: [
              SizedBox(height: 10),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: Text("Marca: ${item.brand ?? ""}", style: TText.xs),
                  ),
                  Expanded(
                    child: Text(
                      "Grupo: ${item.groupName ?? ""}",
                      style: TText.xs,
                      textAlign: TextAlign.end,
                    ),
                  ),
                ],
              ),
              if (item.units.isNotEmpty) ...[
                const SizedBox(height: 10),
                InkWell(
                  onTap: item.setUnit,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(vertical: 5),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
                          child: Row(
                            children: [
                              Icon(
                                Icons.sync_alt_outlined,
                                color: TColor.primary.light,
                                size: 20,
                              ),
                              const SizedBox(width: 10),
                              Text(
                                "Est.: ${item.stock} ${item.unit}",
                                style: TText.xs,
                              ),
                            ],
                          ),
                        ),
                        Expanded(
                          child: Text(
                            "Preço: ${item.price}",
                            style: TText.xs,
                            textAlign: TextAlign.end,
                          ),
                        ),
                      ],
                    ),
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
