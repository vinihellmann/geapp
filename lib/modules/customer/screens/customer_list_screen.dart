import 'package:flutter/material.dart';
import 'package:geapp/app/components/input.dart';
import 'package:geapp/app/components/layout.dart';
import 'package:geapp/app/components/loading.dart';
import 'package:geapp/app/components/pagination.dart';
import 'package:geapp/modules/customer/components/customer_list_item.dart';
import 'package:geapp/modules/customer/models/customer_model.dart';
import 'package:geapp/modules/customer/providers/customer_form_provider.dart';
import 'package:geapp/modules/customer/providers/customer_list_provider.dart';
import 'package:geapp/routes/routes.dart';
import 'package:geapp/themes/color.dart';
import 'package:geapp/themes/extension.dart';
import 'package:geapp/themes/text.dart';
import 'package:geapp/utils/utils.dart';
import 'package:provider/provider.dart';

class CustomerListScreen extends StatelessWidget {
  const CustomerListScreen({super.key, this.onClick});

  final void Function(CustomerModel c)? onClick;

  @override
  Widget build(BuildContext context) {
    return Consumer<CustomerListProvider>(
      builder: (context, provider, _) {
        if (provider.isLoading) return const Loading();
        return Layout(
          title: Text("Clientes", style: TText.xl),
          body: Column(
            children: [
              Container(
                color: TColor.background.main,
                padding: const EdgeInsets.fromLTRB(16, 16, 8, 16),
                child: Row(
                  children: [
                    Text(
                      "${provider.totalItemsShown} de ${provider.totalItems} itens",
                      style: TText.ss,
                    ),
                    const Spacer(),
                    IconButton(
                      onPressed: () async {
                        context.read<CustomerFormProvider>().clearData();
                        context.push(Routes.customerForm);
                      },
                      icon: Icon(
                        Icons.add_circle_outline,
                        color: TColor.button.primary,
                      ),
                    ),
                    IconButton(
                      onPressed: () async {
                        await showModalFilters(context);
                      },
                      icon: Icon(
                        Icons.filter_list_outlined,
                        color: TColor.button.primary,
                      ),
                    ),
                  ],
                ),
              ),
              Expanded(
                child: ListView.separated(
                  itemCount: provider.items.length,
                  separatorBuilder: (c, i) {
                    return Divider(color: TColor.background.border, height: 1);
                  },
                  itemBuilder: (context, i) {
                    return CustomerListItem(
                      item: provider.items[i],
                      onClick: onClick,
                    );
                  },
                ),
              ),
              Pagination(
                page: provider.page,
                totalPages: provider.totalPages,
                onLeftPress: provider.previousPage,
                onRightPress: provider.nextPage,
              ),
            ],
          ),
        );
      },
    );
  }

  Future<void> showModalFilters(BuildContext context) async {
    final provider = context.read<CustomerListProvider>();

    Utils.showModal(
      context: context,
      icon: Icons.filter_list,
      title: "Filtros",
      confirmText: "Filtrar",
      showConfirm: true,
      content: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(vertical: 8),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          spacing: 10,
          children: [
            Input(
              label: "Nome/Razão Social",
              initialValue: provider.filters.name,
              onChanged: (v) => provider.filters.name = v,
            ),
            Input(
              label: "Nome Fantasia",
              initialValue: provider.filters.fantasy,
              onChanged: (v) => provider.filters.fantasy = v,
            ),
            Input(
              label: "CPF",
              initialValue: provider.filters.cpf,
              onChanged: (v) => provider.filters.cpf = v,
            ),
            Input(
              label: "CNPJ",
              initialValue: provider.filters.cnpj,
              onChanged: (v) => provider.filters.cnpj = v,
            ),
            Input(
              label: "Inscrição Estadual",
              initialValue: provider.filters.inscription,
              onChanged: (v) => provider.filters.inscription = v,
            ),
            Input(
              label: "Email",
              initialValue: provider.filters.email,
              onChanged: (v) => provider.filters.email = v,
            ),
            SizedBox(height: 20),
          ],
        ),
      ),
      onConfirm: () async {
        provider.changeIsLoading();
        await provider.getData();
        provider.changeIsLoading();
      },
    );
  }
}
