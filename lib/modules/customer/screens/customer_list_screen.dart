import 'package:flutter/material.dart';
import 'package:geapp/app/components/base_list_layout.dart';
import 'package:geapp/app/components/input.dart';
import 'package:geapp/modules/customer/components/customer_list_item.dart';
import 'package:geapp/modules/customer/models/customer_model.dart';
import 'package:geapp/modules/customer/providers/customer_form_provider.dart';
import 'package:geapp/modules/customer/providers/customer_list_provider.dart';
import 'package:geapp/routes/routes.dart';
import 'package:provider/provider.dart';

class CustomerListScreen extends StatelessWidget {
  const CustomerListScreen({super.key, this.onClick});

  final void Function(CustomerModel c)? onClick;

  @override
  Widget build(BuildContext context) {
    final provider = context.watch<CustomerListProvider>();
    return BaseListLayout<CustomerListProvider, CustomerFormProvider>(
      title: "Clientes",
      addRoute: Routes.customerForm,
      itemBuilder: (context, i) {
        return CustomerListItem(item: provider.items[i], onClick: onClick);
      },
      modalFilterContent: [
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
    );
  }
}
