import 'package:geapp/app/services/db_service.dart';
import 'package:geapp/modules/finance/repositories/finance_repository.dart';
import 'package:geapp/modules/sale/providers/sale_form_provider.dart';
import 'package:geapp/modules/sale/providers/sale_list_provider.dart';
import 'package:geapp/modules/sale/repositories/sale_item_repository.dart';
import 'package:geapp/modules/sale/repositories/sale_repository.dart';
import 'package:provider/provider.dart';

class SaleProviders {
  static List repositoryProviders() {
    return [
      ProxyProvider<DBService, SaleRepository>(
        create: (ctx) {
          return SaleRepository(ctx.read<DBService>());
        },
        update: (ctx, db, repo) {
          repo?.updateDependencies(db);
          return repo ?? SaleRepository(db);
        },
      ),
      ProxyProvider<DBService, SaleItemRepository>(
        create: (ctx) {
          return SaleItemRepository(ctx.read<DBService>());
        },
        update: (ctx, db, repo) {
          repo?.updateDependencies(db);
          return repo ?? SaleItemRepository(db);
        },
      ),
    ];
  }

  static List listProviders() {
    return [
      ChangeNotifierProxyProvider2<
        SaleRepository,
        SaleItemRepository,
        SaleListProvider
      >(
        create: (ctx) {
          return SaleListProvider(
            ctx.read<SaleRepository>(),
            ctx.read<SaleItemRepository>(),
          );
        },
        update: (ctx, repo, itemRepo, provider) {
          provider?.updateDependencies(repo, itemRepo);
          provider?.getData();
          return provider ?? SaleListProvider(repo, itemRepo);
        },
      ),
    ];
  }

  static List formProviders() {
    return [
      ChangeNotifierProxyProvider3<
        SaleRepository,
        SaleItemRepository,
        FinanceRepository,
        SaleFormProvider
      >(
        create: (ctx) {
          return SaleFormProvider(
            ctx.read<SaleRepository>(),
            ctx.read<SaleItemRepository>(),
            ctx.read<FinanceRepository>(),
          );
        },
        update: (ctx, repo, itemRepo, financeRepo, provider) {
          provider?.updateDependencies(repo, itemRepo, financeRepo);
          return provider ?? SaleFormProvider(repo, itemRepo, financeRepo);
        },
      ),
    ];
  }

  static List all() {
    return [...repositoryProviders(), ...listProviders(), ...formProviders()];
  }
}
