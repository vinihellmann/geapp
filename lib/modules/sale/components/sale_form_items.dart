import 'package:flutter/material.dart';
import 'package:geapp/app/components/divider.dart';
import 'package:geapp/modules/product/models/product_model.dart';
import 'package:geapp/modules/sale/providers/sale_form_provider.dart';
import 'package:geapp/routes/routes.dart';
import 'package:geapp/themes/color.dart';
import 'package:geapp/themes/text.dart';
import 'package:geapp/utils/utils.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

class SaleFormItems extends StatelessWidget {
  const SaleFormItems({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<SaleFormProvider>(
      builder: (context, formProvider, child) {
        return Column(
          children: [
            Container(
              color: TColor.background.main,
              padding: const EdgeInsets.fromLTRB(16, 16, 8, 16),
              child: Row(
                children: [
                  Column(
                    spacing: 5,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Produtos: ${formProvider.items.length}",
                        style: TText.sm,
                      ),
                      Text(
                        "Valor Total: R\$${Utils.formatCurrency(formProvider.item.totalItems)}",
                        style: TText.sm,
                      ),
                    ],
                  ),
                  const Spacer(),
                  IconButton(
                    onPressed: () {
                      context.push(
                        Routes.saleFormSelectProduct,
                        extra: (ProductModel product) {
                          context.pushReplacement(
                            Routes.saleFormItemInfo,
                            extra: product,
                          );
                        },
                      );
                    },
                    icon: Icon(
                      Icons.add_circle_outline,
                      color: TColor.button.primary,
                    ),
                  ),
                  IconButton(
                    onPressed: () {},
                    icon: Icon(
                      Icons.more_vert_outlined,
                      color: TColor.button.primary,
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
              child: ListView.separated(
                itemCount: formProvider.items.length,
                separatorBuilder: (c, i) => ListDivider(),
                itemBuilder: (context, i) {
                  final item = formProvider.items[i];
                  return InkWell(
                    onTap: () {
                      context.push(Routes.saleFormItemInfo, extra: item);
                    },
                    child: Container(
                      decoration: BoxDecoration(color: TColor.background.light),
                      child: ListTile(
                        contentPadding: const EdgeInsets.symmetric(
                          horizontal: 20,
                          vertical: 10,
                        ),
                        title: Column(
                          spacing: 10,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "${item.productName?.toUpperCase()}",
                              style: TText.ml,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Expanded(
                                  child: Text(
                                    "Quantidade: ${Utils.formatCurrency(item.quantity)} ${item.unitName?.toUpperCase()}",
                                    style: TText.xs,
                                  ),
                                ),
                                Expanded(
                                  child: Text(
                                    "Valor Unitário: R\$${Utils.formatCurrency(item.finalValue)}",
                                    style: TText.xs,
                                    textAlign: TextAlign.end,
                                  ),
                                ),
                              ],
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Expanded(
                                  child: Text(
                                    "Desconto: R\$${Utils.formatCurrency(item.discountValue)}",
                                    style: TText.xs,
                                  ),
                                ),
                                Expanded(
                                  child: Text(
                                    "Valor Total: R\$${Utils.formatCurrency(item.totalValue)}",
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
                },
              ),
            ),
          ],
        );
      },
    );
  }
}
