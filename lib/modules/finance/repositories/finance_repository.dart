import 'package:geapp/app/database/migrations/finance_migration.dart';
import 'package:geapp/app/models/query_result.dart';
import 'package:geapp/app/repositories/repository.dart';
import 'package:geapp/app/services/db_service.dart';
import 'package:geapp/modules/finance/models/finance_model.dart';

class FinanceRepository extends Repository<FinanceModel> {
  DBService dbService;
  FinanceRepository(this.dbService);

  updateDependencies(DBService db) {
    dbService = db;
  }

  @override
  String get tableName => FinanceMigration.tableName;

  Future<int?> upsertBySale(FinanceModel item) async {
    try {
      final hasFinance = await dbService.query(
        table: tableName,
        where: "saleCode = ?",
        whereArgs: [item.saleCode],
      );

      if (hasFinance.isNotEmpty) {
        final finance = FinanceModel.fromMap(hasFinance.first);
        final formattedFinance = finance.copyWith(
          value: item.value,
          dueDate: item.dueDate,
          customerCode: item.customerCode,
          customerName: item.customerName,
        );

        return await update(formattedFinance);
      }

      return await create(item);
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
  Future<int?> upsert(FinanceModel item) async {
    try {
      if (item.id != null) return await update(item);
      return await create(item);
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<int?> create(FinanceModel item) async {
    try {
      return await dbService.insert(tableName: tableName, data: item.toMap());
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<int?> update(FinanceModel item) async {
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
  Future<int?> delete(FinanceModel item) async {
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
