import 'package:flutter/material.dart';
import 'package:geapp/app/components/divider.dart';
import 'package:geapp/app/components/header.dart';
import 'package:geapp/app/components/input.dart';
import 'package:geapp/app/components/layout.dart';
import 'package:geapp/app/components/loading.dart';
import 'package:geapp/app/components/pagination.dart';
import 'package:geapp/modules/product/components/product_list_item.dart';
import 'package:geapp/modules/product/models/product_model.dart';
import 'package:geapp/modules/product/providers/product_form_provider.dart';
import 'package:geapp/modules/product/providers/product_list_provider.dart';
import 'package:geapp/routes/routes.dart';
import 'package:geapp/themes/text.dart';
import 'package:geapp/utils/utils.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

class ProductListScreen extends StatelessWidget {
  const ProductListScreen({super.key, this.onClick});

  final void Function(ProductModel p)? onClick;

  @override
  Widget build(BuildContext context) {
    return Consumer<ProductListProvider>(
      builder: (context, provider, _) {
        if (provider.isLoading) return const Loading();
        return Layout(
          title: Text("Produtos", style: TText.xl),
          body: Column(
            children: [
              Header(
                totalItemsShown: provider.totalItemsShown,
                totalItems: provider.totalItems,
                onTapFilter: () async => await showModalFilters(context),
                onTapAdd: () async {
                  await context.read<ProductFormProvider>().setCreate();
                  if (context.mounted) {
                    final needUpdate = await context.push(Routes.productForm);
                    if (needUpdate == true) provider.getData();
                  }
                },
              ),
              Expanded(
                child: ListView.separated(
                  itemCount: provider.items.length,
                  separatorBuilder: (c, i) => ListDivider(),
                  itemBuilder: (context, i) {
                    return ProductListItem(item: provider.items[i]);
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
        );
      },
    );
  }

  Future<void> showModalFilters(BuildContext context) async {
    final provider = context.read<ProductListProvider>();

    Utils.showModal(
      context: context,
      icon: Icons.filter_list,
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
              label: "Código de Barras",
              initialValue: provider.filters.barCode,
              onChanged: (v) => provider.filters.barCode = v,
            ),
            Input(
              label: "Descrição",
              initialValue: provider.filters.name,
              onChanged: (v) => provider.filters.name = v,
            ),
            Input(
              label: "Marca",
              initialValue: provider.filters.brand,
              onChanged: (v) => provider.filters.brand = v,
            ),
            Input(
              label: "Grupo",
              initialValue: provider.filters.groupName,
              onChanged: (v) => provider.filters.groupName = v,
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
