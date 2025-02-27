import 'package:flutter/material.dart';
import 'package:geapp/app/components/floating.dart';
import 'package:geapp/app/components/input.dart';
import 'package:geapp/app/components/layout.dart';
import 'package:geapp/app/components/select.dart';
import 'package:geapp/app/components/switch.dart';
import 'package:geapp/app/formatters/input_formatters.dart';
import 'package:geapp/modules/customer/providers/customer_form_provider.dart';
import 'package:geapp/themes/color.dart';
import 'package:geapp/themes/extension.dart';
import 'package:geapp/themes/text.dart';
import 'package:geapp/utils/utils.dart';
import 'package:provider/provider.dart';

class CustomerFormScreen extends StatelessWidget {
  const CustomerFormScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<CustomerFormProvider>(
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
                    TSwitch(
                      title: "Pessoa Jurídica",
                      value: provider.item.isLegal!,
                      onChanged: (_) => provider.changeLegal(),
                    ),
                    const SizedBox(height: 10),
                    Input(
                      isRequired: true,
                      label: "Razão Social",
                      initialValue: provider.item.name,
                      onChanged: (nv) => provider.item.name = nv,
                    ),
                    const SizedBox(height: 10),
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
                    const SizedBox(height: 30),
                    Text("Contato", style: TText.lg),
                    const SizedBox(height: 20),
                    Input(
                      label: "Email",
                      icon: Icons.mail_outline,
                      textInputType: TextInputType.emailAddress,
                      initialValue: provider.item.email,
                      inputFormatters: [InputFormatters.emailMask],
                      onChanged: (nv) => provider.item.email = nv,
                    ),
                    const SizedBox(height: 10),
                    Input(
                      label: "Telefone",
                      icon: Icons.phone_outlined,
                      textInputType: TextInputType.phone,
                      initialValue: provider.item.phone,
                      inputFormatters: [InputFormatters.phoneMask],
                      onChanged: (nv) => provider.item.phone = nv,
                    ),
                    const SizedBox(height: 10),
                    Input(
                      icon: Icons.account_circle_outlined,
                      label: "Contato",
                      initialValue: provider.item.contact,
                      onChanged: (nv) => provider.item.contact = nv,
                    ),
                    const SizedBox(height: 30),
                    Text("Endereço", style: TText.lg),
                    const SizedBox(height: 20),
                    Input(
                      isRequired: true,
                      label: "Rua",
                      initialValue: provider.item.addressName,
                      onChanged: (nv) => provider.item.addressName = nv,
                    ),
                    const SizedBox(height: 10),
                    Input(
                      isRequired: true,
                      label: "Bairro",
                      initialValue: provider.item.addressNeighborhood,
                      onChanged: (nv) => provider.item.addressNeighborhood = nv,
                    ),
                    const SizedBox(height: 10),
                    Input(
                      isRequired: true,
                      label: "Número",
                      textInputType: TextInputType.number,
                      initialValue: provider.item.addressNumber,
                      onChanged: (nv) => provider.item.addressNumber = nv,
                    ),
                    const SizedBox(height: 10),
                    Input(
                      isRequired: true,
                      label: "CEP",
                      textInputType: TextInputType.number,
                      inputFormatters: [InputFormatters.cepMask],
                      initialValue: provider.item.addressZipCode,
                      onChanged: (nv) => provider.item.addressZipCode = nv,
                    ),
                    const SizedBox(height: 10),
                    Input(
                      label: "Complemento",
                      initialValue: provider.item.addressComplement,
                      onChanged: (nv) => provider.item.addressComplement = nv,
                    ),
                    const SizedBox(height: 10),
                    Select(
                      isRequired: true,
                      label: "Estado",
                      items: provider.ufs,
                      value: provider.item.addressUF,
                      onChanged: (nv) => provider.changeUF(nv),
                    ),
                    const SizedBox(height: 10),
                    Select(
                      isRequired: true,
                      label: "Cidade",
                      items: provider.cities,
                      value: provider.item.addressCity,
                      onChanged: (nv) => provider.changeCity(nv),
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
              final value = await provider.save();
              if (context.mounted && value == true) {
                context.pop();
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
