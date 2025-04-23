import 'package:flutter/material.dart';
import 'package:geapp/app/components/divider.dart';
import 'package:geapp/app/components/header.dart';
import 'package:geapp/app/components/input.dart';
import 'package:geapp/app/components/layout.dart';
import 'package:geapp/app/components/loading.dart';
import 'package:geapp/app/components/pagination.dart';
import 'package:geapp/modules/product/providers/product_list_provider.dart';
import 'package:geapp/modules/unit/components/unit_item.dart';
import 'package:geapp/modules/unit/providers/unit_form_provider.dart';
import 'package:geapp/modules/unit/providers/unit_list_provider.dart';
import 'package:geapp/routes/routes.dart';
import 'package:geapp/themes/color.dart';
import 'package:geapp/themes/text.dart';
import 'package:geapp/utils/utils.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

class UnitListScreen extends StatelessWidget {
  const UnitListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<UnitListProvider>(
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
              tabs: [Tab(text: provider.product?.name?.toUpperCase())],
            ),
            body: TabBarView(
              children: [
                Column(
                  children: [
                    Header(
                      totalItemsShown: provider.totalItemsShown,
                      totalItems: provider.totalItems,
                      onTapFilter: () async => await showModalFilters(context),
                      onTapAdd: () async {
                        context.read<UnitFormProvider>().init(context);
                        final needUpdate = await context.push(Routes.unitForm);
                        if (needUpdate == true && context.mounted) {
                          await context.read<ProductListProvider>().getData();
                          provider.getData();
                        }
                      },
                    ),
                    Expanded(
                      child: ListView.separated(
                        itemCount: provider.items.length,
                        separatorBuilder: (c, i) => ListDivider(),
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

  Future<void> showModalFilters(BuildContext context) async {
    final provider = context.read<UnitListProvider>();

    Utils.showModal(
      context: context,
      icon: Icons.filter_list_outlined,
      title: "Filtros",
      confirmText: "Filtrar",
      showConfirm: true,
      content: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(vertical: 8),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          spacing: 10,
          children: [
            Input(
              label: "Unidade",
              initialValue: provider.filters.unit,
              onChanged: (v) => provider.filters.unit = v,
            ),
            SizedBox(height: 20),
          ],
        ),
      ),
      onConfirm: () async {
        provider.changeIsLoading();
        await provider.getData();
        provider.changeIsLoading();
      },
    );
  }
}
