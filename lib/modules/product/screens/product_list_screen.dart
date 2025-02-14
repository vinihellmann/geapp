import 'package:flutter/material.dart';
import 'package:geapp/app/components/layout.dart';
import 'package:geapp/app/components/loading.dart';
import 'package:geapp/app/components/pagination.dart';
import 'package:geapp/modules/product/components/product_list_item.dart';
import 'package:geapp/modules/product/models/product_model.dart';
import 'package:geapp/modules/product/providers/product_form_provider.dart';
import 'package:geapp/modules/product/providers/product_list_provider.dart';
import 'package:geapp/routes/routes.dart';
import 'package:geapp/themes/color.dart';
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
                        context.read<ProductFormProvider>().clearData();
                        context.push(Routes.productForm);
                      },
                      icon: Icon(
                        Icons.add_circle_outline,
                        color: TColor.button.primary,
                      ),
                    ),
                    IconButton(
                      onPressed: () {},
                      icon: Icon(
                        Icons.filter_list_outlined,
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
                    return ProductListItem(item: item);
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
