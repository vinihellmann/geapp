import 'package:flutter/material.dart';
import 'package:geapp/app/components/base_list_layout.dart';
import 'package:geapp/app/components/input.dart';
import 'package:geapp/modules/product/components/product_list_item.dart';
import 'package:geapp/modules/product/models/product_model.dart';
import 'package:geapp/modules/product/providers/product_form_provider.dart';
import 'package:geapp/modules/product/providers/product_list_provider.dart';
import 'package:geapp/routes/routes.dart';
import 'package:provider/provider.dart';

class ProductListScreen extends StatelessWidget {
  const ProductListScreen({super.key, this.onClick});

  final void Function(ProductModel p)? onClick;

  @override
  Widget build(BuildContext context) {
    final provider = context.watch<ProductListProvider>();
    return BaseListLayout<ProductListProvider, ProductFormProvider>(
      title: onClick != null ? "Selecione um Produto" : "Produtos",
      addRoute: Routes.productForm,
      itemBuilder: (context, i) {
        return ProductListItem(item: provider.items[i], onClick: onClick);
      },
      modalFilterContent: [
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
    );
  }
}
