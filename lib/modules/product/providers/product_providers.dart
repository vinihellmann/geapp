import 'package:geapp/app/services/db_service.dart';
import 'package:geapp/modules/product/providers/product_form_provider.dart';
import 'package:geapp/modules/product/providers/product_list_provider.dart';
import 'package:geapp/modules/product/repositories/product_repository.dart';
import 'package:provider/provider.dart';

class ProductProviders {
  static List repositoryProviders() {
    return [
      ProxyProvider<DBService, ProductRepository>(
        create: (ctx) {
          return ProductRepository(ctx.read<DBService>());
        },
        update: (ctx, db, repo) {
          return ProductRepository(db);
        },
      ),
    ];
  }

  static List listProviders() {
    return [
      ChangeNotifierProxyProvider<ProductRepository, ProductListProvider>(
        create: (ctx) {
          return ProductListProvider(ctx.read<ProductRepository>());
        },
        update: (ctx, repo, provider) {
          return ProductListProvider(repo);
        },
      ),
    ];
  }

  static List formProviders() {
    return [
      ChangeNotifierProxyProvider<ProductRepository, ProductFormProvider>(
        create: (ctx) {
          return ProductFormProvider(ctx.read<ProductRepository>());
        },
        update: (ctx, repo, provider) {
          return ProductFormProvider(repo);
        },
      ),
    ];
  }

  static List all() {
    return [...repositoryProviders(), ...listProviders(), ...formProviders()];
  }
}
