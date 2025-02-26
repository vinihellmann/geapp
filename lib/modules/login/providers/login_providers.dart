import 'package:geapp/app/services/db_service.dart';
import 'package:geapp/modules/login/providers/login_form_provider.dart';
import 'package:geapp/modules/login/repositories/login_repository.dart';
import 'package:provider/provider.dart';

class LoginProviders {
  static List providers() {
    return [
      ProxyProvider<DBService, LoginRepository>(
        create: (context) => LoginRepository(context.read<DBService>()),
        update: (context, dbService, repository) => LoginRepository(dbService),
      ),
      ChangeNotifierProxyProvider<LoginRepository, LoginFormProvider>(
        create: (context) => LoginFormProvider(context.read<LoginRepository>()),
        update:
            (context, repository, provider) => LoginFormProvider(repository),
      ),
    ];
  }
}
