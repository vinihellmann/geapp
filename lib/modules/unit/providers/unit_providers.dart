import 'package:geapp/app/services/db_service.dart';
import 'package:geapp/modules/unit/providers/unit_form_provider.dart';
import 'package:geapp/modules/unit/providers/unit_list_provider.dart';
import 'package:geapp/modules/unit/repositories/unit_repository.dart';
import 'package:provider/provider.dart';

class UnitProviders {
  static List repositoryProviders() {
    return [
      ProxyProvider<DBService, UnitRepository>(
        create: (ctx) {
          return UnitRepository(ctx.read<DBService>());
        },
        update: (ctx, db, repo) {
          repo?.updateDependencies(db);
          return repo ?? UnitRepository(db);
        },
      ),
    ];
  }

  static List listProviders() {
    return [
      ChangeNotifierProxyProvider<UnitRepository, UnitListProvider>(
        create: (ctx) {
          return UnitListProvider(ctx.read<UnitRepository>());
        },
        update: (ctx, repo, provider) {
          provider?.updateDependencies(repo);
          provider?.getData();
          return provider ?? UnitListProvider(repo);
        },
      ),
    ];
  }

  static List formProviders() {
    return [
      ChangeNotifierProxyProvider<UnitRepository, UnitFormProvider>(
        create: (ctx) {
          return UnitFormProvider(ctx.read<UnitRepository>());
        },
        update: (ctx, repo, provider) {
          provider?.updateDependencies(repo);
          return provider ?? UnitFormProvider(repo);
        },
      ),
    ];
  }

  static List all() {
    return [...repositoryProviders(), ...listProviders(), ...formProviders()];
  }
}
