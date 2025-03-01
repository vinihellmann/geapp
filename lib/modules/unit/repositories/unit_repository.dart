import 'package:geapp/app/database/migrations/product_migration.dart';
import 'package:geapp/app/models/query_result.dart';
import 'package:geapp/app/repositories/repository.dart';
import 'package:geapp/app/services/db_service.dart';
import 'package:geapp/modules/unit/models/unit_model.dart';

class UnitRepository extends Repository<UnitModel> {
  DBService dbService;
  UnitRepository(this.dbService);

  updateDependencies(DBService db) {
    dbService = db;
  }

  @override
  String get tableName => ProductMigration.tableNameUnit;

  @override
  Future<QueryResult> search(
    String? where,
    List<dynamic>? whereArgs,
    int page,
    int limit,
    String orderBy,
  ) async {
    try {
      return await dbService.getData(
        page: page,
        limit: limit,
        where: where,
        orderBy: orderBy,
        whereArgs: whereArgs,
        tableName: tableName,
      );
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<int?> upsert(UnitModel item) async {
    try {
      if (item.id != null) return await update(item);
      return await create(item);
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<int?> create(UnitModel item) async {
    try {
      return await dbService.insert(tableName: tableName, data: item.toMap());
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<int?> update(UnitModel item) async {
    try {
      return await dbService.update(
        tableName: tableName,
        data: item.toMap(),
        whereClause: "code = ?",
        whereArgs: [item.code],
      );
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<int?> delete(UnitModel item) async {
    try {
      return await dbService.delete(
        tableName: tableName,
        whereClause: "code = ?",
        whereArgs: [item.code],
      );
    } catch (e) {
      rethrow;
    }
  }
}
