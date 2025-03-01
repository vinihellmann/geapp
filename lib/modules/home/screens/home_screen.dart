import 'package:flutter/material.dart';
import 'package:geapp/app/components/layout.dart';
import 'package:geapp/modules/home/components/nav_button.dart';
import 'package:geapp/modules/home/components/user_avatar.dart';
import 'package:geapp/routes/routes.dart';
import 'package:go_router/go_router.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Layout(
      withDrawer: true,
      backButton: false,
      title: UserAvatar(),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            const SizedBox(height: 8),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                NavButton(
                  label: "Clientes",
                  icon: Icons.person_outlined,
                  onTap: () => context.push(Routes.customerList),
                ),
                const SizedBox(width: 20),
                NavButton(
                  label: "Produtos",
                  icon: Icons.inventory_2_outlined,
                  onTap: () => context.push(Routes.productList),
                ),
              ],
            ),
            const SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                NavButton(
                  label: "Financeiro",
                  icon: Icons.currency_exchange_outlined,
                  onTap: () {},
                ),
                const SizedBox(width: 20),
                NavButton(
                  label: "Vendas",
                  icon: Icons.shopping_bag_outlined,
                  onTap: () => context.push(Routes.saleList),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
