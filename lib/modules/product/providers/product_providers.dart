import 'package:geapp/app/services/db_service.dart';
import 'package:geapp/modules/product/providers/product_form_provider.dart';
import 'package:geapp/modules/product/providers/product_list_provider.dart';
import 'package:geapp/modules/product/repositories/product_repository.dart';
import 'package:geapp/modules/unit/providers/unit_form_provider.dart';
import 'package:geapp/modules/unit/providers/unit_list_provider.dart';
import 'package:geapp/modules/unit/repositories/unit_repository.dart';
import 'package:provider/provider.dart';

class ProductUnitProviders {
  static List providers() {
    return [...repositoryProviders(), ...listProviders(), ...formProviders()];
  }

  static List repositoryProviders() {
    return [
      ProxyProvider<DBService, ProductRepository>(
        create: (ctx) => ProductRepository(ctx.read<DBService>()),
        update: (ctx, db, repo) => ProductRepository(db),
      ),
      ProxyProvider<DBService, UnitRepository>(
        create: (ctx) => UnitRepository(ctx.read<DBService>()),
        update: (ctx, db, repo) => UnitRepository(db),
      ),
    ];
  }

  static List listProviders() {
    return [
      ChangeNotifierProxyProvider<ProductRepository, ProductListProvider>(
        create: (ctx) => ProductListProvider(ctx.read<ProductRepository>()),
        update: (ctx, repo, provider) => provider!..updateRepository(repo),
      ),
      ChangeNotifierProxyProvider<UnitRepository, UnitListProvider>(
        create: (ctx) => UnitListProvider(ctx.read<UnitRepository>()),
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
      ChangeNotifierProxyProvider2<
        UnitRepository,
        UnitListProvider,
        UnitFormProvider
      >(
        create: (ctx) {
          return UnitFormProvider(
            ctx.read<UnitRepository>(),
            ctx.read<UnitListProvider>(),
          );
        },
        update: (ctx, repo, listProvider, provider) {
          return UnitFormProvider(repo, listProvider);
        },
      ),
    ];
  }
}
