import 'package:flutter/material.dart';
import 'package:geapp/modules/customer/models/customer_model.dart';
import 'package:geapp/modules/sale/providers/sale_form_provider.dart';
import 'package:geapp/routes/routes.dart';
import 'package:geapp/themes/color.dart';
import 'package:geapp/themes/text.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

class SaleFormSelectCustomer extends StatelessWidget {
  const SaleFormSelectCustomer({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<SaleFormProvider>(
      builder: (context, formProvider, child) {
        return Padding(
          padding: const EdgeInsets.only(top: 10, bottom: 5),
          child: Row(
            children: [
              Expanded(child: Text("Dados do Cliente", style: TText.lg)),
              Expanded(
                child: InkWell(
                  onTap: () {
                    context.push(
                      Routes.saleFormSelectCustomer,
                      extra: (CustomerModel customer) {
                        formProvider.setCustomer(customer);
                      },
                    );
                  },
                  borderRadius: BorderRadius.circular(8),
                  splashColor: TColor.background.light,
                  highlightColor: TColor.background.light,
                  child: Ink(
                    height: 45,
                    decoration: BoxDecoration(
                      color: TColor.background.light,
                      border: Border.all(color: TColor.background.border),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Row(
                      spacing: 10,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text("Buscar", style: TText.md),
                        Icon(
                          Icons.person_search_outlined,
                          color: TColor.primary.light,
                          size: 22,
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
