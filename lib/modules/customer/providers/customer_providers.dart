import 'package:geapp/app/services/db_service.dart';
import 'package:geapp/modules/customer/providers/customer_form_provider.dart';
import 'package:geapp/modules/customer/providers/customer_list_provider.dart';
import 'package:geapp/modules/customer/repositories/customer_repository.dart';
import 'package:provider/provider.dart';

class CustomerProviders {
  static List providers() {
    return [
      ProxyProvider<DBService, CustomerRepository>(
        create: (context) => CustomerRepository(context.read<DBService>()),
        update: (context, dbService, repository) => CustomerRepository(dbService),
      ),
      ChangeNotifierProxyProvider<CustomerRepository, CustomerListProvider>(
        create: (context) => CustomerListProvider(context.read<CustomerRepository>()),
        update: (context, repository, provider) => CustomerListProvider(repository),
      ),
      ChangeNotifierProxyProvider<CustomerRepository, CustomerFormProvider>(
        create: (context) => CustomerFormProvider(context.read<CustomerRepository>()),
        update: (context, repository, provider) => CustomerFormProvider(repository),
      ),
    ];
  }
}
