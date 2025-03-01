import 'package:geapp/app/services/db_service.dart';
import 'package:geapp/modules/login/providers/login_form_provider.dart';
import 'package:geapp/modules/login/repositories/login_repository.dart';
import 'package:provider/provider.dart';

class LoginProviders {
  static List providers() {
    return [
      ProxyProvider<DBService, LoginRepository>(
        create: (ctx) => LoginRepository(ctx.read<DBService>()),
        update: (ctx, db, repo) {
          repo?.updateDependencies(db);
          return repo ?? LoginRepository(db);
        },
      ),
      ChangeNotifierProxyProvider<LoginRepository, LoginFormProvider>(
        create: (ctx) => LoginFormProvider(ctx.read<LoginRepository>()),
        update: (ctx, repo, provider) {
          provider?.updateDependencies(repo);
          return provider ?? LoginFormProvider(repo);
        },
      ),
    ];
  }
}
