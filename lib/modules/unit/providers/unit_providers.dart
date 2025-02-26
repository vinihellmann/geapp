import 'package:geapp/app/services/db_service.dart';
import 'package:geapp/modules/unit/providers/unit_form_provider.dart';
import 'package:geapp/modules/unit/providers/unit_list_provider.dart';
import 'package:geapp/modules/unit/repositories/unit_repository.dart';
import 'package:provider/provider.dart';

class UnitProviders {
  static List providers() {
    return [
      ProxyProvider<DBService, UnitRepository>(
        create: (context) => UnitRepository(context.read<DBService>()),
        update: (context, dbService, repository) => UnitRepository(dbService),
      ),
      ChangeNotifierProxyProvider<UnitRepository, UnitListProvider>(
        create: (context) => UnitListProvider(context.read<UnitRepository>()),
        update: (context, repository, provider) => UnitListProvider(repository),
      ),
      ChangeNotifierProxyProvider<UnitRepository, UnitFormProvider>(
        create: (context) => UnitFormProvider(context.read<UnitRepository>()),
        update: (context, repository, provider) => UnitFormProvider(repository),
      ),
    ];
  }
}
