import 'package:geapp/app/services/db_service.dart';
import 'package:geapp/modules/image/providers/image_list_provider.dart';
import 'package:geapp/modules/image/repositories/image_repository.dart';
import 'package:provider/provider.dart';

class ImageProviders {
  static List repositoryProviders() {
    return [
      ProxyProvider<DBService, ImageRepository>(
        create: (ctx) {
          return ImageRepository(ctx.read<DBService>());
        },
        update: (ctx, db, repo) {
          repo?.updateDependencies(db);
          return repo ?? ImageRepository(db);
        },
      ),
    ];
  }

  static List listProviders() {
    return [
      ChangeNotifierProxyProvider<ImageRepository, ImageListProvider>(
        create: (ctx) {
          return ImageListProvider(ctx.read<ImageRepository>());
        },
        update: (ctx, repo, provider) {
          provider?.updateDependencies(repo);
          provider?.getData();
          return provider ?? ImageListProvider(repo);
        },
      ),
    ];
  }

  static List formProviders() {
    return [];
  }

  static List all() {
    return [...repositoryProviders(), ...listProviders(), ...formProviders()];
  }
}
