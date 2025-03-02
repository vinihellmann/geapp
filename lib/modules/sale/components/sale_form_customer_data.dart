import 'package:flutter/material.dart';
import 'package:geapp/modules/customer/models/customer_model.dart';
import 'package:geapp/modules/sale/providers/sale_form_provider.dart';
import 'package:geapp/routes/routes.dart';
import 'package:geapp/themes/color.dart';
import 'package:geapp/themes/text.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

class SaleFormCustomerData extends StatelessWidget {
  const SaleFormCustomerData({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<SaleFormProvider>(
      builder: (context, formProvider, child) {
        if (formProvider.customer.code == null) {
          return GestureDetector(
            onTap: () {
              context.push(
                Routes.saleFormSelectCustomer,
                extra: (CustomerModel customer) {
                  formProvider.setCustomer(customer);
                },
              );
            },
            child: Container(
              decoration: BoxDecoration(
                border: Border.all(color: TColor.background.border),
                borderRadius: BorderRadius.circular(8),
                color: TColor.background.light,
              ),
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [Text("Selecione um cliente", style: TText.ss)],
                ),
              ),
            ),
          );
        }

        return Container(
          decoration: BoxDecoration(
            border: Border.all(color: TColor.background.border),
            borderRadius: BorderRadius.circular(8),
            color: TColor.background.light,
          ),
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              spacing: 10,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  spacing: 10,
                  children: [
                    Text("Razão Social:", style: TText.ss),
                    Expanded(
                      child: Text(
                        "${formProvider.customer.name?.toUpperCase()}",
                        style: TText.sm.apply(fontWeightDelta: 2),
                        overflow: TextOverflow.ellipsis,
                        textAlign: TextAlign.end,
                      ),
                    ),
                  ],
                ),
                if (formProvider.customer.cpf != null ||
                    formProvider.customer.cnpj != null)
                  Row(
                    spacing: 10,
                    children: [
                      Text("CPF/CNPJ:", style: TText.ss),
                      Expanded(
                        child: Text(
                          formProvider.customer.isLegal == true
                              ? "${formProvider.customer.cnpj}"
                              : "${formProvider.customer.cpf}",
                          style: TText.sm,
                          overflow: TextOverflow.ellipsis,
                          textAlign: TextAlign.end,
                        ),
                      ),
                    ],
                  ),
                if (formProvider.customer.addressName != null)
                  Row(
                    spacing: 10,
                    children: [
                      Text("Endereço:", style: TText.ss),
                      Expanded(
                        child: Text(
                          "${formProvider.customer.addressName}",
                          style: TText.sm,
                          overflow: TextOverflow.ellipsis,
                          textAlign: TextAlign.end,
                        ),
                      ),
                    ],
                  ),
                if (formProvider.customer.addressNeighborhood != null)
                  Row(
                    spacing: 10,
                    children: [
                      Text("Bairro:", style: TText.ss),
                      Expanded(
                        child: Text(
                          "${formProvider.customer.addressNeighborhood}",
                          style: TText.sm,
                          overflow: TextOverflow.ellipsis,
                          textAlign: TextAlign.end,
                        ),
                      ),
                    ],
                  ),
                if (formProvider.customer.addressNumber != null)
                  Row(
                    spacing: 10,
                    children: [
                      Text("Número:", style: TText.ss),
                      Expanded(
                        child: Text(
                          "${formProvider.customer.addressNumber}",
                          style: TText.sm,
                          overflow: TextOverflow.ellipsis,
                          textAlign: TextAlign.end,
                        ),
                      ),
                    ],
                  ),
                if (formProvider.customer.addressCity != null)
                  Row(
                    spacing: 10,
                    children: [
                      Text("Cidade:", style: TText.ss),
                      Expanded(
                        child: Text(
                          "${formProvider.customer.addressCity}/${formProvider.customer.addressUF}",
                          style: TText.sm,
                          overflow: TextOverflow.ellipsis,
                          textAlign: TextAlign.end,
                        ),
                      ),
                    ],
                  ),
              ],
            ),
          ),
        );
      },
    );
  }
}
