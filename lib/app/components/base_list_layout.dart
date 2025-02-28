import 'package:flutter/material.dart';
import 'package:geapp/app/components/divider.dart';
import 'package:geapp/app/components/header.dart';
import 'package:geapp/app/components/layout.dart';
import 'package:geapp/app/components/loading.dart';
import 'package:geapp/app/components/pagination.dart';
import 'package:geapp/app/provider/form_provider.dart';
import 'package:geapp/app/provider/list_provider.dart';
import 'package:geapp/themes/text.dart';
import 'package:geapp/utils/utils.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

class BaseListLayout<T extends ListProvider, E extends FormProvider>
    extends StatelessWidget {
  const BaseListLayout({
    super.key,
    this.onTapAdd,
    required this.title,
    required this.addRoute,
    required this.itemBuilder,
    required this.modalFilterContent,
  });

  final String title;
  final String addRoute;
  final VoidCallback? onTapAdd;
  final List<Widget> modalFilterContent;
  final Widget? Function(BuildContext, int) itemBuilder;

  @override
  Widget build(BuildContext context) {
    return Consumer<T>(
      builder: (context, provider, child) {
        if (provider.isLoading) return const Loading();

        return Layout(
          title: Text(title, style: TText.xl),
          body: Column(
            children: [
              Header(
                totalItemsShown: provider.totalItemsShown,
                totalItems: provider.totalItems,
                onTapFilter: () async => await showModalFilters(context),
                onTapAdd:
                    onTapAdd ??
                    () async {
                      await context.read<E>().setCreate();
                      if (context.mounted) {
                        final needUpdate = await context.push(addRoute);
                        if (needUpdate == true) provider.getData();
                      }
                    },
              ),
              Expanded(
                child: ListView.separated(
                  itemCount: provider.items.length,
                  separatorBuilder: (c, i) => ListDivider(),
                  itemBuilder: itemBuilder,
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
    final provider = context.read<T>();

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
          children: modalFilterContent,
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
