import 'package:flutter/material.dart';
import 'package:geapp/app/components/floating.dart';
import 'package:geapp/app/components/input_numeric.dart';
import 'package:geapp/app/components/layout.dart';
import 'package:geapp/app/formatters/input_formatters.dart';
import 'package:geapp/modules/product/models/product_model.dart';
import 'package:geapp/modules/sale/models/sale_item_model.dart';
import 'package:geapp/modules/sale/providers/sale_form_item_info_provider.dart';
import 'package:geapp/modules/sale/providers/sale_form_provider.dart';
import 'package:geapp/themes/text.dart';
import 'package:geapp/utils/utils.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

class SaleFormItemInfo extends StatelessWidget {
  const SaleFormItemInfo({super.key, required this.item});

  final Object item;

  @override
  Widget build(BuildContext context) {
    final formProvider = context.read<SaleFormProvider>();
    return ChangeNotifierProvider(
      create: (_) {
        if (item is SaleItemModel) {
          return SaleFormItemInfoProvider.fromSaleItem(
            item as SaleItemModel,
            formProvider.items,
          );
        } else if (item is ProductModel) {
          return SaleFormItemInfoProvider.fromProduct(
            item as ProductModel,
            formProvider.items,
          );
        }
      },
      child: Consumer<SaleFormItemInfoProvider>(
        builder: (context, provider, child) {
          return Layout(
            title: Text("Informações do Produto", style: TText.xl),
            padding: EdgeInsets.all(16),
            body: SingleChildScrollView(
              child: Column(
                spacing: 10,
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 10),
                    child: Row(
                      children: [
                        Expanded(
                          child: Text("Valor Original", style: TText.ss),
                        ),
                        Expanded(
                          child: Center(
                            child: Text(
                              "R\$${Utils.formatCurrency(provider.originalValue)}",
                              style: TText.sm,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Row(
                    children: [
                      Expanded(
                        child: Text(
                          "Quantidade (${provider.item.unitName?.toUpperCase()})",
                          style: TText.ss,
                        ),
                      ),
                      Expanded(
                        child: InputNumeric(
                          controller: provider.quantityController,
                          inputFormatters: [InputFormatters.currencyMask],
                          onPrefixPress: () => provider.removeQuantity(),
                          onSuffixPress: () => provider.addQuantity(),
                          onChange: () {
                            provider.updateDiscountValue();
                            provider.updateDiscountP();
                          },
                        ),
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      Expanded(child: Text("Desconto (%)", style: TText.ss)),
                      Expanded(
                        child: InputNumeric(
                          controller: provider.discountPercController,
                          inputFormatters: [InputFormatters.currencyMask],
                          onPrefixPress: () => provider.removeDiscountPerc(),
                          onSuffixPress: () => provider.addDiscountPerc(),
                          onChange: () => provider.updateDiscountValue(),
                        ),
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      Expanded(child: Text("Desconto (R\$)", style: TText.ss)),
                      Expanded(
                        child: InputNumeric(
                          controller: provider.discountValueController,
                          inputFormatters: [InputFormatters.currencyMask],
                          onPrefixPress: () => provider.removeDiscountValue(),
                          onSuffixPress: () => provider.addDiscountValue(),
                          onChange: () => provider.updateDiscountP(),
                        ),
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      Expanded(
                        child: Text("Valor Unitário (R\$)", style: TText.ss),
                      ),
                      Expanded(
                        child: InputNumeric(
                          controller: provider.finalValueController,
                          inputFormatters: [InputFormatters.currencyMask],
                          onPrefixPress: () => provider.removeFinalValue(),
                          onSuffixPress: () => provider.addFinalValue(),
                          onChange: () {
                            provider.updateDiscountValue();
                            provider.updateDiscountP();
                          },
                        ),
                      ),
                    ],
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 10),
                    child: Row(
                      children: [
                        Expanded(child: Text("Valor Total", style: TText.ss)),
                        Expanded(
                          child: Center(
                            child: Text(
                              "R\$${Utils.formatCurrency(provider.totalValue)}",
                              style: TText.sm,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            floating: Visibility(
              visible: provider.isValid,
              child: Floating(
                isLoading: false,
                onClick: () {
                  formProvider.updateItem(provider.getFilledItem());
                  context.pop();
                },
              ),
            ),
          );
        },
      ),
    );
  }
}
