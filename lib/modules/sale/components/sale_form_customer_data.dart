import 'package:flutter/material.dart';
import 'package:geapp/modules/sale/providers/sale_form_provider.dart';
import 'package:geapp/themes/color.dart';
import 'package:geapp/themes/text.dart';
import 'package:provider/provider.dart';

class SaleFormCustomerData extends StatelessWidget {
  const SaleFormCustomerData({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<SaleFormProvider>(
      builder: (context, formProvider, child) {
        if (formProvider.customer.code == null) {
          return Container(
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
                        style: TText.sm,
                        overflow: TextOverflow.ellipsis,
                        textAlign: TextAlign.end,
                      ),
                    ),
                  ],
                ),
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
                Row(
                  spacing: 10,
                  children: [
                    Text("Endereço:", style: TText.ss),
                    Expanded(
                      child: Text(
                        "${formProvider.customer.addressName}, ${formProvider.customer.addressNumber}",
                        style: TText.sm,
                        overflow: TextOverflow.ellipsis,
                        textAlign: TextAlign.end,
                      ),
                    ),
                  ],
                ),
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
                Row(
                  spacing: 10,
                  children: [
                    Text("Telefone:", style: TText.ss),
                    Expanded(
                      child: Text(
                        "${formProvider.customer.phone}",
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
