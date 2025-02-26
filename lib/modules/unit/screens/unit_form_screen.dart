import 'package:flutter/material.dart';
import 'package:geapp/app/components/floating.dart';
import 'package:geapp/app/components/input.dart';
import 'package:geapp/app/components/layout.dart';
import 'package:geapp/app/formatters/input_formatters.dart';
import 'package:geapp/modules/unit/providers/unit_form_provider.dart';
import 'package:geapp/modules/unit/providers/unit_list_provider.dart';
import 'package:geapp/themes/color.dart';
import 'package:geapp/themes/extension.dart';
import 'package:geapp/themes/text.dart';
import 'package:geapp/utils/utils.dart';
import 'package:provider/provider.dart';

class UnitFormScreen extends StatelessWidget {
  const UnitFormScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<UnitFormProvider>(
      builder: (context, provider, _) {
        return Layout(
          actions: [
            Visibility(
              visible: provider.isEditing,
              child: Padding(
                padding: const EdgeInsets.only(right: 10),
                child: IconButton(
                  icon: Icon(Icons.delete_outlined, color: TColor.error.main),
                  onPressed: () async {
                    await Utils.showModal(
                      context: context,
                      showConfirm: true,
                      title: "Excluir",
                      icon: Icons.delete_outline,
                      content: Padding(
                        padding: const EdgeInsets.symmetric(vertical: 10),
                        child: Text(
                          "Deseja realmente excluir o registro?",
                          style: TText.sm,
                        ),
                      ),
                      onConfirm: () async {
                        final value = await provider.delete();
                        if (context.mounted && value == true) {
                          context.read<UnitListProvider>().getData();
                          context.pop();
                          Utils.showToast(
                            "Registro deletado com sucesso",
                            ToastType.info,
                          );
                        }
                      },
                    );
                  },
                ),
              ),
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
                      onChanged: (nv) =>
                          provider.item.price = Utils.parseDouble(nv),
                      inputFormatters: [InputFormatters.currencyMask],
                    ),
                    const SizedBox(height: 10),
                    Input(
                      label: "Estoque",
                      initialValue: Utils.formatDouble(provider.item.stock),
                      onChanged: (nv) =>
                          provider.item.stock = Utils.parseDouble(nv),
                      inputFormatters: [InputFormatters.currencyMask],
                    ),
                    const SizedBox(height: 70),
                  ],
                ),
              ),
            ),
          ),
          floating: Floating(
            isLoading: provider.isLoading,
            onClick: () async {
              provider.setProductCode(context);
              final value = await provider.save();
              if (context.mounted && value == true) {
                await context.read<UnitListProvider>().getData();

                if (context.mounted) {
                  context.pop();
                  Utils.showToast(
                    "Registro salvo com sucesso",
                    ToastType.success,
                  );
                }
              }
            },
          ),
        );
      },
    );
  }
}
