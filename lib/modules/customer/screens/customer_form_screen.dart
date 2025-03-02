import 'package:flutter/material.dart';
import 'package:geapp/app/components/delete.dart';
import 'package:geapp/app/components/floating.dart';
import 'package:geapp/app/components/input.dart';
import 'package:geapp/app/components/layout.dart';
import 'package:geapp/app/components/loading.dart';
import 'package:geapp/app/components/select.dart';
import 'package:geapp/app/components/switch.dart';
import 'package:geapp/app/formatters/input_formatters.dart';
import 'package:geapp/modules/customer/providers/customer_form_provider.dart';
import 'package:geapp/themes/text.dart';
import 'package:geapp/utils/utils.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

class CustomerFormScreen extends StatelessWidget {
  const CustomerFormScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<CustomerFormProvider>(
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
                  spacing: 10,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(top: 20),
                      child: Text("Dados Principais", style: TText.lg),
                    ),
                    TSwitch(
                      title: "Pessoa Jurídica",
                      value: provider.item.isLegal!,
                      onChanged: (_) => provider.changeLegal(),
                    ),
                    Input(
                      isRequired: true,
                      label: "Razão Social",
                      initialValue: provider.item.name,
                      onChanged: (nv) => provider.item.name = nv,
                    ),
                    Column(
                      children: [
                        Visibility(
                          visible: provider.item.isLegal!,
                          child: Input(
                            label: "Nome Fantasia",
                            initialValue: provider.item.fantasy,
                            onChanged: (nv) => provider.item.fantasy = nv,
                          ),
                        ),
                        Visibility(
                          visible: provider.item.isLegal!,
                          child: const SizedBox(height: 10),
                        ),
                        Visibility(
                          visible: provider.item.isLegal == false,
                          child: Input(
                            label: "CPF",
                            textInputType: TextInputType.number,
                            initialValue: provider.item.cpf,
                            inputFormatters: [InputFormatters.cpfMask],
                            onChanged: (nv) => provider.item.cpf = nv,
                            isRequired: provider.item.isLegal == false,
                          ),
                        ),
                        Visibility(
                          visible: provider.item.isLegal!,
                          child: Input(
                            label: "CNPJ",
                            initialValue: provider.item.cnpj,
                            inputFormatters: [InputFormatters.cnpjMask],
                            textInputType: TextInputType.number,
                            onChanged: (nv) => provider.item.cnpj = nv,
                            isRequired: provider.item.isLegal!,
                          ),
                        ),
                      ],
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 10),
                      child: Text("Endereço", style: TText.lg),
                    ),
                    Input(
                      label: "Logradouro",
                      initialValue: provider.item.addressName,
                      onChanged: (nv) => provider.item.addressName = nv,
                    ),
                    Row(
                      spacing: 10,
                      children: [
                        Expanded(
                          child: Input(
                            label: "Bairro",
                            initialValue: provider.item.addressNeighborhood,
                            onChanged:
                                (nv) => provider.item.addressNeighborhood = nv,
                          ),
                        ),
                        Expanded(
                          child: Input(
                            label: "Número",
                            textInputType: TextInputType.number,
                            initialValue: provider.item.addressNumber,
                            onChanged: (nv) => provider.item.addressNumber = nv,
                          ),
                        ),
                      ],
                    ),
                    Input(
                      label: "CEP",
                      textInputType: TextInputType.number,
                      inputFormatters: [InputFormatters.cepMask],
                      initialValue: provider.item.addressZipCode,
                      onChanged: (nv) => provider.item.addressZipCode = nv,
                    ),
                    Select(
                      isRequired: true,
                      label: "Estado",
                      items: provider.ufs,
                      value: provider.item.addressUF,
                      onChanged: (nv) => provider.changeUF(nv),
                    ),
                    Select(
                      isRequired: true,
                      label: "Cidade",
                      items: provider.cities,
                      value: provider.item.addressCity,
                      onChanged: (nv) => provider.changeCity(nv),
                    ),
                    Input(
                      label: "Complemento",
                      initialValue: provider.item.addressComplement,
                      onChanged: (nv) => provider.item.addressComplement = nv,
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 10),
                      child: Text("Contato", style: TText.lg),
                    ),
                    Input(
                      label: "Email",
                      icon: Icons.mail_outline,
                      textInputType: TextInputType.emailAddress,
                      initialValue: provider.item.email,
                      inputFormatters: [InputFormatters.emailMask],
                      onChanged: (nv) => provider.item.email = nv,
                    ),
                    Input(
                      label: "Telefone",
                      icon: Icons.phone_outlined,
                      textInputType: TextInputType.phone,
                      initialValue: provider.item.phone,
                      inputFormatters: [InputFormatters.phoneMask],
                      onChanged: (nv) => provider.item.phone = nv,
                    ),
                    Input(
                      icon: Icons.account_circle_outlined,
                      label: "Contato",
                      initialValue: provider.item.contact,
                      onChanged: (nv) => provider.item.contact = nv,
                    ),
                    SizedBox(height: 70),
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
