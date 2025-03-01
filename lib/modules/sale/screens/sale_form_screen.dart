import 'package:flutter/material.dart';
import 'package:geapp/app/components/floating.dart';
import 'package:geapp/app/components/gradient.dart';
import 'package:geapp/app/components/layout.dart';
import 'package:geapp/modules/sale/components/sale_form_general.dart';
import 'package:geapp/modules/sale/components/sale_form_items.dart';
import 'package:geapp/modules/sale/providers/sale_form_provider.dart';
import 'package:geapp/themes/color.dart';
import 'package:geapp/themes/text.dart';
import 'package:geapp/utils/utils.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

class SaleFormScreen extends StatelessWidget {
  const SaleFormScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Consumer<SaleFormProvider>(
        builder: (context, formProvider, child) {
          return Layout(
            withDrawer: false,
            title: Text(formProvider.title, style: TText.xl),
            body: Column(
              children: [
                TGradient(
                  child: TabBar(
                    dividerHeight: 0,
                    indicatorColor: TColor.text.primary,
                    indicatorSize: TabBarIndicatorSize.tab,
                    unselectedLabelStyle: TText.md.apply(
                      color: TColor.text.secondary.withAlpha(150),
                    ),
                    labelStyle: TText.md.apply(color: TColor.text.primary),
                    tabs: const [
                      Tab(text: 'Dados Principais'),
                      Tab(text: 'Produtos'),
                    ],
                  ),
                ),
                Expanded(
                  child: Form(
                    key: formProvider.formKey,
                    child: const TabBarView(
                      children: [SaleFormGeneral(), SaleFormItems()],
                    ),
                  ),
                ),
              ],
            ),
            floating: Floating(
              isLoading: formProvider.isSaving,
              onClick: () async {
                final value = await formProvider.save();
                if (context.mounted && value == true) {
                  context.pop(true);
                  Utils.showToast(
                    "Registro salvo com sucesso",
                    ToastType.success,
                  );
                }
              },
            ),
          );
        },
      ),
    );
  }
}
