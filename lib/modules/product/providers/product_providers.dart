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
    return [
      ProxyProvider<DBService, ProductRepository>(
        create: (ctx) => ProductRepository(ctx.read<DBService>()),
        update: (ctx, db, repo) => ProductRepository(db),
      ),
      ProxyProvider<DBService, UnitRepository>(
        create: (ctx) => UnitRepository(ctx.read<DBService>()),
        update: (ctx, db, repo) => UnitRepository(db),
      ),
      ChangeNotifierProxyProvider<ProductRepository, ProductFormProvider>(
        create: (ctx) => ProductFormProvider(ctx.read<ProductRepository>()),
        update: (ctx, repo, provider) => ProductFormProvider(repo),
      ),
      ChangeNotifierProxyProvider<UnitRepository, UnitFormProvider>(
        create: (ctx) => UnitFormProvider(ctx.read<UnitRepository>()),
        update: (ctx, repo, provider) => UnitFormProvider(repo),
      ),
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
}
