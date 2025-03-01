import 'package:geapp/app/database/migrations/user_migration.dart';
import 'package:geapp/app/models/query_result.dart';
import 'package:geapp/app/repositories/repository.dart';
import 'package:geapp/app/services/db_service.dart';
import 'package:geapp/modules/login/models/login_model.dart';

class LoginRepository extends Repository<LoginModel> {
  DBService dbService;
  LoginRepository(this.dbService);

  updateDependencies(DBService db) {
    dbService = db;
  }

  @override
  String get tableName => UserMigration.tableName;

  Future<bool> login(String user, String password) async {
    try {
      final result = await dbService.query(
        table: tableName,
        where: "user = ? AND password = ?",
        whereArgs: [user, password],
      );
      return result.isNotEmpty;
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<QueryResult> search(
    String? where,
    List<dynamic>? whereArgs,
    int page,
    int limit,
    String orderBy,
  ) {
    throw UnimplementedError();
  }

  @override
  Future<int?> upsert(LoginModel item) {
    throw UnimplementedError();
  }

  @override
  Future<int?> create(LoginModel item) {
    throw UnimplementedError();
  }

  @override
  Future<int?> update(LoginModel item) {
    throw UnimplementedError();
  }

  @override
  Future<int?> delete(LoginModel item) {
    throw UnimplementedError();
  }
}
