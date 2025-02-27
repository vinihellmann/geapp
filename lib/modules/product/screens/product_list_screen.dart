import 'package:flutter/material.dart';
import 'package:geapp/app/components/divider.dart';
import 'package:geapp/app/components/header.dart';
import 'package:geapp/app/components/layout.dart';
import 'package:geapp/app/components/loading.dart';
import 'package:geapp/app/components/pagination.dart';
import 'package:geapp/modules/product/components/product_list_item.dart';
import 'package:geapp/modules/product/models/product_model.dart';
import 'package:geapp/modules/product/providers/product_form_provider.dart';
import 'package:geapp/modules/product/providers/product_list_provider.dart';
import 'package:geapp/routes/routes.dart';
import 'package:geapp/themes/extension.dart';
import 'package:geapp/themes/text.dart';
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
                onTapAdd: () {
                  context.read<ProductFormProvider>().clearData();
                  context.push(Routes.productForm);
                },
                onTapFilter: () {},
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
}
