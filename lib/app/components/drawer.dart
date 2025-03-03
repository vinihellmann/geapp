import 'package:flutter/material.dart';
import 'package:geapp/app/components/drawer_item.dart';
import 'package:geapp/routes/routes.dart';
import 'package:geapp/themes/color.dart';
import 'package:go_router/go_router.dart';

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
            spacing: 10,
            children: [
              TDrawerItem(
                title: "Clientes",
                icon: Icons.person_outlined,
                onClick: () => context.push(Routes.customerList),
              ),
              TDrawerItem(
                title: "Produtos",
                icon: Icons.inventory_2_outlined,
                onClick: () => context.push(Routes.productList),
              ),
              TDrawerItem(
                title: "Financeiro",
                icon: Icons.currency_exchange_outlined,
                onClick: () => context.push(Routes.financeList),
              ),
              TDrawerItem(
                title: "Vendas",
                icon: Icons.shopping_bag_outlined,
                onClick: () => context.push(Routes.saleList),
              ),
              const Spacer(flex: 4),
              TDrawerItem(
                exitApp: true,
                title: "Sair",
                icon: Icons.exit_to_app_outlined,
                onClick: () {
                  context.pushReplacement(Routes.login);
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
