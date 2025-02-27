import 'package:flutter/material.dart';
import 'package:geapp/app/components/button.dart';
import 'package:geapp/app/components/input.dart';
import 'package:geapp/modules/login/providers/login_form_provider.dart';
import 'package:geapp/routes/routes.dart';
import 'package:geapp/themes/color.dart';
import 'package:geapp/themes/text.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

class LoginForm extends StatelessWidget {
  const LoginForm({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<LoginFormProvider>(
      builder: (context, provider, _) {
        return Expanded(
          child: Container(
            width: MediaQuery.of(context).size.width,
            color: TColor.background.main,
            child: ListView(
              padding: const EdgeInsets.all(20),
              children: [
                Text(
                  "Informe seus dados para acessar o sistema.",
                  style: TText.ss,
                ),
                const SizedBox(height: 20),
                Input(
                  label: "Usuário",
                  initialValue: provider.item.user,
                  icon: Icons.account_circle_rounded,
                  onChanged: (v) => provider.item.user = v,
                ),
                const SizedBox(height: 10),
                Input(
                  maxLines: 1,
                  obscure: true,
                  label: "Senha",
                  initialValue: provider.item.password,
                  textInputType: TextInputType.visiblePassword,
                  onChanged: (v) => provider.item.password = v,
                ),
                const SizedBox(height: 20),
                Button(
                  label: "Acessar",
                  isLoading: provider.isSaving,
                  onClick: () async {
                    var result = await provider.save();
                    if (context.mounted && result == true) {
                      context.pushReplacement(Routes.home);
                    }
                  },
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
