import 'package:geapp/app/services/db_service.dart';
import 'package:geapp/modules/customer/providers/customer_form_provider.dart';
import 'package:geapp/modules/customer/providers/customer_list_provider.dart';
import 'package:geapp/modules/customer/repositories/customer_repository.dart';
import 'package:provider/provider.dart';

class CustomerProviders {
  static List providers() {
    return [
      ProxyProvider<DBService, CustomerRepository>(
        create: (ctx) => CustomerRepository(ctx.read<DBService>()),
        update: (ctx, db, repo) => CustomerRepository(db),
      ),
      ChangeNotifierProxyProvider<CustomerRepository, CustomerListProvider>(
        create: (ctx) => CustomerListProvider(ctx.read<CustomerRepository>()),
        update: (ctx, repo, provider) => CustomerListProvider(repo),
      ),
      ChangeNotifierProxyProvider<CustomerRepository, CustomerFormProvider>(
        create: (ctx) => CustomerFormProvider(ctx.read<CustomerRepository>()),
        update: (ctx, repo, provider) => CustomerFormProvider(repo),
      ),
    ];
  }
}
