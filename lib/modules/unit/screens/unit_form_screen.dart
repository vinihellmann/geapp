import 'package:flutter/material.dart';
import 'package:geapp/app/components/delete.dart';
import 'package:geapp/app/components/floating.dart';
import 'package:geapp/app/components/input.dart';
import 'package:geapp/app/components/layout.dart';
import 'package:geapp/app/components/loading.dart';
import 'package:geapp/app/formatters/input_formatters.dart';
import 'package:geapp/modules/unit/providers/unit_form_provider.dart';
import 'package:geapp/themes/text.dart';
import 'package:geapp/utils/utils.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

class UnitFormScreen extends StatelessWidget {
  const UnitFormScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<UnitFormProvider>(
      builder: (context, provider, _) {
        if (provider.isLoading) return const Loading();
        return Layout(
          actions: [
            Delete(
              visible: provider.isEditing,
              onDelete: () async {
                final value = await provider.delete();
                if (context.mounted && value == true) {
                  context.pop(true);
                  Utils.showToast(
                    "Registro deletado com sucesso",
                    ToastType.success,
                  );
                }
              },
            ),
          ],
          title: Text(provider.title, style: TText.xl),
          body: SingleChildScrollView(
            child: Form(
              key: provider.formKey,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: 30),
                    Text("Dados Principais", style: TText.lg),
                    const SizedBox(height: 20),
                    Input(
                      isRequired: true,
                      label: "Descrição",
                      initialValue: provider.item.unit,
                      onChanged: (nv) => provider.item.unit = nv,
                    ),
                    const SizedBox(height: 10),
                    Input(
                      isRequired: true,
                      label: "Valor por Unidade",
                      initialValue: Utils.formatDouble(provider.item.price),
                      onChanged:
                          (nv) => provider.item.price = Utils.parseDouble(nv),
                      inputFormatters: [InputFormatters.currencyMask],
                    ),
                    const SizedBox(height: 10),
                    Input(
                      label: "Estoque",
                      initialValue: Utils.formatDouble(provider.item.stock),
                      onChanged:
                          (nv) => provider.item.stock = Utils.parseDouble(nv),
                      inputFormatters: [InputFormatters.currencyMask],
                    ),
                    const SizedBox(height: 70),
                  ],
                ),
              ),
            ),
          ),
          floating: Floating(
            isLoading: provider.isSaving,
            onClick: () async {
              final value = await provider.save();
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
    );
  }
}
