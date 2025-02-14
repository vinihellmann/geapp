import 'package:flutter/material.dart';
import 'package:geapp/app/components/layout.dart';
import 'package:geapp/app/components/loading.dart';
import 'package:geapp/app/components/pagination.dart';
import 'package:geapp/modules/unit/components/unit_item.dart';
import 'package:geapp/modules/unit/providers/unit_provider.dart';
import 'package:geapp/themes/color.dart';
import 'package:geapp/themes/text.dart';
import 'package:provider/provider.dart';

class UnitScreen extends StatelessWidget {
  const UnitScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<UnitProvider>(
      builder: (context, provider, _) {
        if (provider.isLoading) return const Loading();
        return DefaultTabController(
          length: 1,
          child: Layout(
            title: Text("Unidades", style: TText.xl),
            bottom: TabBar(
              labelStyle: TText.ml,
              indicatorSize: TabBarIndicatorSize.tab,
              indicatorColor: TColor.background.main,
              tabs: [
                Tab(
                  text: provider.product?.name?.toUpperCase(),
                ),
              ],
            ),
            body: TabBarView(
              children: [
                Column(
                  children: [
                    Container(
                      color: TColor.background.main,
                      padding: const EdgeInsets.fromLTRB(16, 16, 8, 16),
                      child: Row(
                        children: [
                          Text(
                            "${provider.items.length} de ${provider.totalItems} itens",
                            style: TText.ss,
                          ),
                          const Spacer(),
                          IconButton(
                            onPressed: () async {
                              // context.read<CustomerFormProvider>().clearData();
                              // context.push(Routes.customerForm);
                            },
                            icon: Icon(
                              Icons.add_circle_outline,
                              color: TColor.button.primary,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Expanded(
                      child: ListView.separated(
                        itemCount: provider.items.length,
                        separatorBuilder: (c, i) => Divider(
                          color: TColor.background.border,
                          height: 1,
                        ),
                        itemBuilder: (context, i) {
                          final item = provider.items[i];
                          return UnitItem(item: item);
                        },
                      ),
                    ),
                    Pagination(
                      page: provider.page,
                      totalPages: provider.totalPages,
                      onLeftPress: provider.previousPage,
                      onRightPress: provider.nextPage,
                    ),
                  ],
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
