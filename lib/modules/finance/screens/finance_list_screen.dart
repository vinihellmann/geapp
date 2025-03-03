import 'package:flutter/material.dart';
import 'package:geapp/app/components/base_list_layout.dart';
import 'package:geapp/modules/finance/components/finance_list_item.dart';
import 'package:geapp/modules/finance/providers/finance_list_provider.dart';
import 'package:geapp/modules/unit/providers/unit_form_provider.dart';
import 'package:geapp/routes/routes.dart';
import 'package:provider/provider.dart';

class FinanceListScreen extends StatelessWidget {
  const FinanceListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final provider = context.watch<FinanceListProvider>();
    return BaseListLayout<FinanceListProvider, UnitFormProvider>(
      title: "Financeiro",
      addRoute: Routes.customerForm,
      itemBuilder: (context, i) {
        return FinanceListItem(item: provider.items[i]);
      },
      modalFilterContent: [],
    );
  }
}
