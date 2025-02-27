import 'package:geapp/app/services/db_service.dart';
import 'package:geapp/modules/product/providers/product_form_provider.dart';
import 'package:geapp/modules/product/providers/product_list_provider.dart';
import 'package:geapp/modules/product/repositories/product_repository.dart';
import 'package:geapp/modules/unit/providers/unit_list_provider.dart';
import 'package:provider/provider.dart';

class ProductProviders {
  static List all() {
    return [...repositoryProviders(), ...listProviders(), ...formProviders()];
  }

  static List repositoryProviders() {
    return [
      ProxyProvider<DBService, ProductRepository>(
        create: (ctx) => ProductRepository(ctx.read<DBService>()),
        update: (ctx, db, repo) => ProductRepository(db),
      ),
    ];
  }

  static List listProviders() {
    return [
      ChangeNotifierProxyProvider<ProductRepository, ProductListProvider>(
        create: (ctx) => ProductListProvider(ctx.read<ProductRepository>()),
        update: (ctx, repo, provider) => provider!..updateRepository(repo),
      ),
      ChangeNotifierProxyProvider<UnitListProvider, ProductListProvider>(
        create: (ctx) => ctx.read<ProductListProvider>(),
        update: (ctx, unitProvider, provider) {
          provider!.getData();
          return provider;
        },
      ),
    ];
  }

  static List formProviders() {
    return [
      ChangeNotifierProxyProvider2<
        ProductRepository,
        ProductListProvider,
        ProductFormProvider
      >(
        create: (ctx) {
          return ProductFormProvider(
            ctx.read<ProductRepository>(),
            ctx.read<ProductListProvider>(),
          );
        },
        update: (ctx, repo, listProvider, provider) {
          return ProductFormProvider(repo, listProvider);
        },
      ),
    ];
  }
}
