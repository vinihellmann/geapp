import 'package:geapp/app/services/db_service.dart';
import 'package:geapp/modules/customer/providers/customer_form_provider.dart';
import 'package:geapp/modules/customer/providers/customer_list_provider.dart';
import 'package:geapp/modules/customer/repositories/customer_repository.dart';
import 'package:provider/provider.dart';

class CustomerProviders {
  static List repositoryProviders() {
    return [
      ProxyProvider<DBService, CustomerRepository>(
        create: (ctx) {
          return CustomerRepository(ctx.read<DBService>());
        },
        update: (ctx, db, repo) {
          return CustomerRepository(db);
        },
      ),
    ];
  }

  static List listProviders() {
    return [
      ChangeNotifierProxyProvider<CustomerRepository, CustomerListProvider>(
        create: (ctx) {
          return CustomerListProvider(ctx.read<CustomerRepository>());
        },
        update: (ctx, repo, provider) {
          return CustomerListProvider(repo);
        },
      ),
    ];
  }

  static List formProviders() {
    return [
      ChangeNotifierProxyProvider<CustomerRepository, CustomerFormProvider>(
        create: (ctx) {
          return CustomerFormProvider(ctx.read<CustomerRepository>())..getUFs();
        },
        update: (ctx, repo, provider) {
          return CustomerFormProvider(repo)..getUFs();
        },
      ),
    ];
  }

  static List all() {
    return [...repositoryProviders(), ...listProviders(), ...formProviders()];
  }
}
