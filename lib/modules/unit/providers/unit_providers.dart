import 'package:geapp/app/services/db_service.dart';
import 'package:geapp/modules/unit/providers/unit_form_provider.dart';
import 'package:geapp/modules/unit/providers/unit_list_provider.dart';
import 'package:geapp/modules/unit/repositories/unit_repository.dart';
import 'package:provider/provider.dart';

class UnitProviders {
  static List repositoryProviders() {
    return [
      ProxyProvider<DBService, UnitRepository>(
        create: (ctx) => UnitRepository(ctx.read<DBService>()),
        update: (ctx, db, repo) => UnitRepository(db),
      ),
    ];
  }

  static List listProviders() {
    return [
      ChangeNotifierProxyProvider<UnitRepository, UnitListProvider>(
        create: (ctx) => UnitListProvider(ctx.read<UnitRepository>()),
        update: (ctx, repo, provider) => provider!..updateRepository(repo),
      ),
    ];
  }

  static List formProviders() {
    return [
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

  static List all() {
    return [...repositoryProviders(), ...listProviders(), ...formProviders()];
  }
}
