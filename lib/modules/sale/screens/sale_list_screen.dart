import 'package:flutter/material.dart';
import 'package:geapp/app/components/base_list_layout.dart';
import 'package:geapp/modules/sale/components/sale_list_item.dart';
import 'package:geapp/modules/sale/providers/sale_form_provider.dart';
import 'package:geapp/modules/sale/providers/sale_list_provider.dart';
import 'package:geapp/routes/routes.dart';
import 'package:provider/provider.dart';

class SaleListScreen extends StatelessWidget {
  const SaleListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final provider = context.watch<SaleListProvider>();
    return BaseListLayout<SaleListProvider, SaleFormProvider>(
      title: "Vendas",
      addRoute: Routes.saleForm,
      itemBuilder: (context, i) {
        return SaleListItem(item: provider.items[i]);
      },
      modalFilterContent: [SizedBox(height: 20)],
    );
  }
}
