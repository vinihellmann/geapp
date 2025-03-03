import 'package:geapp/app/services/db_service.dart';
import 'package:geapp/modules/finance/providers/finance_list_provider.dart';
import 'package:geapp/modules/finance/repositories/finance_repository.dart';
import 'package:provider/provider.dart';

class FinanceProviders {
  static List repositoryProviders() {
    return [
      ProxyProvider<DBService, FinanceRepository>(
        create: (ctx) {
          return FinanceRepository(ctx.read<DBService>());
        },
        update: (ctx, db, repo) {
          repo?.updateDependencies(db);
          return repo ?? FinanceRepository(db);
        },
      ),
    ];
  }

  static List listProviders() {
    return [
      ChangeNotifierProxyProvider<FinanceRepository, FinanceListProvider>(
        create: (ctx) {
          return FinanceListProvider(ctx.read<FinanceRepository>());
        },
        update: (ctx, repo, provider) {
          provider?.updateDependencies(repo);
          provider?.getData();
          return provider ?? FinanceListProvider(repo);
        },
      ),
    ];
  }

  static List formProviders() {
    return [];
  }

  static List all() {
    return [...repositoryProviders(), ...listProviders(), ...formProviders()];
  }
}
