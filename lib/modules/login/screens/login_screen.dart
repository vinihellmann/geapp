import 'package:flutter/material.dart';
import 'package:geapp/app/components/gradient.dart';
import 'package:geapp/app/components/logo.dart';
import 'package:geapp/modules/login/components/login_form.dart';
import 'package:geapp/modules/login/providers/login_form_provider.dart';
import 'package:geapp/themes/color.dart';
import 'package:geapp/themes/extension.dart';
import 'package:provider/provider.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => LoginFormProvider(),
      child: Scaffold(
        body: TGradient(
          child: SafeArea(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.fromLTRB(20, 16, 20, 16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      LogoGEApp(),
                      AnimatedContainer(
                        duration: const Duration(milliseconds: 200),
                        height: context.isKeyboardVisible ? 40 : 120,
                      ),
                      Text(
                        'Bem-vindo',
                        style: TextStyle(
                          fontSize: 22,
                          fontWeight: FontWeight.w500,
                          color: TColor.text.primary,
                        ),
                      ),
                    ],
                  ),
                ),
                const LoginForm(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
