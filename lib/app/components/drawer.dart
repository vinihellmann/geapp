import 'package:flutter/material.dart';
import 'package:geapp/app/components/drawer_item.dart';
import 'package:geapp/modules/login/screens/login_screen.dart';
import 'package:geapp/routes/routes.dart';
import 'package:geapp/themes/color.dart';
import 'package:geapp/themes/extension.dart';

class TDrawer extends StatelessWidget {
  const TDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Drawer(
        backgroundColor: TColor.background.main,
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            children: [
              TDrawerItem(
                title: "Clientes",
                icon: Icons.person_outlined,
                onClick: () => context.push(Routes.customerList),
              ),
              const SizedBox(height: 10),
              TDrawerItem(
                title: "Produtos",
                icon: Icons.inventory_2_outlined,
                onClick: () => context.push(Routes.productList),
              ),
              const SizedBox(height: 10),
              TDrawerItem(
                title: "Financeiro",
                icon: Icons.attach_money_outlined,
                onClick: () {},
              ),
              const SizedBox(height: 10),
              TDrawerItem(
                title: "Vendas",
                icon: Icons.shopping_bag_outlined,
                onClick: () {},
              ),
              const Spacer(),
              TDrawerItem(
                title: "GUID",
                icon: Icons.key_outlined,
                onClick: () {},
              ),
              const SizedBox(height: 10),
              TDrawerItem(
                title: "Configurações",
                icon: Icons.settings_outlined,
                onClick: () {},
              ),
              const Spacer(flex: 4),
              TDrawerItem(
                exitApp: true,
                title: "Sair",
                icon: Icons.exit_to_app_outlined,
                onClick: () {
                  context.pushAndRemoveUntil(const LoginScreen());
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
