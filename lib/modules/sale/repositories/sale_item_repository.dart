import 'package:geapp/app/database/migrations/sale_item_migration.dart';
import 'package:geapp/app/models/query_result.dart';
import 'package:geapp/app/repositories/repository.dart';
import 'package:geapp/app/services/db_service.dart';
import 'package:geapp/modules/sale/models/sale_item_model.dart';
import 'package:sqflite/sqflite.dart';

class SaleItemRepository extends Repository<SaleItemModel> {
  DBService dbService;
  SaleItemRepository(this.dbService);

  updateDependencies(DBService db) {
    dbService = db;
  }

  @override
  String get tableName => SaleItemMigration.tableName;

  Future<List<SaleItemModel>> searchBySale(String? saleCode) async {
    try {
      final data = await dbService.query(
        table: tableName,
        where: "saleCode = ?",
        whereArgs: [saleCode],
      );

      return data.map((x) => SaleItemModel.fromMap(x)).toList();
    } catch (e) {
      rethrow;
    }
  }

  Future<bool> upsertAll(String? saleCode, List<SaleItemModel> items) async {
    try {
      final db = dbService.db;

      final updatedItems =
          items.map((saleItem) {
            return saleItem.copyWith(saleCode: saleCode);
          }).toList();

      final existingItems = await searchBySale(saleCode);

      final oldItemCodes = existingItems.map((item) => item.code!).toList();
      final newItemCodes = updatedItems.map((item) => item.code!).toList();

      final itemsToRemove =
          oldItemCodes.where((code) {
            return !newItemCodes.contains(code);
          }).toList();

      final batch = db.batch();

      for (var code in itemsToRemove) {
        batch.delete(
          tableName,
          where: 'saleCode = ? AND code = ?',
          whereArgs: [saleCode, code],
        );
      }

      for (var item in updatedItems) {
        batch.insert(
          tableName,
          item.toMap(),
          conflictAlgorithm: ConflictAlgorithm.replace,
        );
      }

      await batch.commit(noResult: true);
      return true;
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
  Future<int?> upsert(SaleItemModel item) async {
    try {
      if (item.id != null) return await update(item);
      return await create(item);
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<int?> create(SaleItemModel item) async {
    try {
      return await dbService.insert(tableName: tableName, data: item.toMap());
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<int?> update(SaleItemModel item) async {
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
  Future<int?> delete(SaleItemModel item) async {
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
