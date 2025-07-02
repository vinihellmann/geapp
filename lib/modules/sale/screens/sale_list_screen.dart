import 'package:flutter/material.dart';
import 'package:geapp/app/components/base_list_layout.dart';
import 'package:geapp/modules/finance/providers/finance_list_provider.dart';
import 'package:geapp/modules/sale/components/sale_list_item.dart';
import 'package:geapp/modules/sale/providers/sale_form_provider.dart';
import 'package:geapp/modules/sale/providers/sale_list_provider.dart';
import 'package:geapp/routes/routes.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

class SaleListScreen extends StatelessWidget {
  const SaleListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final provider = context.watch<SaleListProvider>();
    return BaseListLayout<SaleListProvider, SaleFormProvider>(
      title: "Vendas",
      addRoute: Routes.saleForm,
      onTapAdd: () async {
        await context.read<SaleFormProvider>().setCreate();

        if (context.mounted) {
          final needUpdate = await context.push(Routes.saleForm);

          if (needUpdate == true && context.mounted) {
            context.read<FinanceListProvider>().getData();
            provider.getData();
          }
        }
      },
      itemBuilder: (context, i) {
        return SaleListItem(item: provider.items[i]);
      },
      modalFilterContent: [SizedBox(height: 20)],
    );
  }
}
