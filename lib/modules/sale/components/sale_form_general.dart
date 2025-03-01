import 'package:flutter/material.dart';
import 'package:geapp/app/components/date_time_input.dart';
import 'package:geapp/app/components/input.dart';
import 'package:geapp/app/components/select.dart';
import 'package:geapp/modules/sale/components/sale_form_customer_data.dart';
import 'package:geapp/modules/sale/components/sale_form_select_customer.dart';
import 'package:geapp/modules/sale/constants/sale_form_constants.dart';
import 'package:geapp/modules/sale/providers/sale_form_provider.dart';
import 'package:geapp/themes/text.dart';
import 'package:provider/provider.dart';

class SaleFormGeneral extends StatelessWidget {
  const SaleFormGeneral({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<SaleFormProvider>(
      builder: (context, formProvider, child) {
        return SingleChildScrollView(
          padding: EdgeInsets.all(16),
          child: Column(
            spacing: 10,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SaleFormSelectCustomer(),
              SaleFormCustomerData(),
              Padding(
                padding: const EdgeInsets.only(top: 10, bottom: 5),
                child: Text("Pagamento", style: TText.lg),
              ),
              Select(
                isRequired: true,
                label: "Status do Pagamento",
                value: formProvider.item.paymentStatus,
                items: SaleFormConstants.paymentStatus,
                onChanged: (value) {
                  formProvider.item.paymentStatus = value;
                },
              ),
              Select(
                isRequired: true,
                label: "Forma de Pagamento",
                value: formProvider.item.paymentMethod,
                items: SaleFormConstants.paymentMethods,
                onChanged: (value) {
                  formProvider.item.paymentMethod = value;
                },
              ),
              Select(
                isRequired: true,
                label: "Condição de Pagamento",
                value: formProvider.item.paymentCondition,
                items: SaleFormConstants.paymentConditions,
                onChanged: (value) {
                  formProvider.item.paymentCondition = value;
                },
              ),
              Padding(
                padding: const EdgeInsets.only(top: 10, bottom: 5),
                child: Text("Entrega", style: TText.lg),
              ),
              DateTimeInput(
                isRequired: true,
                label: "Data de Entrega",
                type: DateTimeFieldType.date,
                initialValue: DateTime.tryParse(
                  formProvider.item.deliveryDate ?? "",
                ),
                onChanged: (value) {
                  formProvider.item.deliveryDate = value.toIso8601String();
                },
              ),
              Input(
                label: "Observações Gerais",
                maxLines: 3,
                initialValue: formProvider.item.generalNotes,
                onChanged: (value) {
                  formProvider.item.generalNotes = value;
                },
              ),
              SizedBox(height: 50),
            ],
          ),
        );
      },
    );
  }
}
