import 'package:geapp/app/services/db_service.dart';
import 'package:geapp/modules/product/providers/product_form_provider.dart';
import 'package:geapp/modules/product/providers/product_list_provider.dart';
import 'package:geapp/modules/product/repositories/product_repository.dart';
import 'package:provider/provider.dart';

class ProductProviders {
  static List providers() {
    return [
      ProxyProvider<DBService, ProductRepository>(
        create: (context) => ProductRepository(context.read<DBService>()),
        update:
            (context, dbService, repository) => ProductRepository(dbService),
      ),
      ChangeNotifierProxyProvider<ProductRepository, ProductListProvider>(
        create:
            (context) => ProductListProvider(context.read<ProductRepository>()),
        update:
            (context, repository, provider) => ProductListProvider(repository),
      ),
      ChangeNotifierProxyProvider<ProductRepository, ProductFormProvider>(
        create:
            (context) => ProductFormProvider(context.read<ProductRepository>()),
        update:
            (context, repository, provider) => ProductFormProvider(repository),
      ),
    ];
  }
}
