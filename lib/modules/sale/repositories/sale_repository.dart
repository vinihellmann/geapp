import 'package:geapp/app/database/migrations/customer_migration.dart';
import 'package:geapp/app/database/migrations/sale_migration.dart';
import 'package:geapp/app/models/query_result.dart';
import 'package:geapp/app/repositories/repository.dart';
import 'package:geapp/app/services/db_service.dart';
import 'package:geapp/modules/customer/models/customer_model.dart';
import 'package:geapp/modules/sale/models/sale_model.dart';

class SaleRepository extends Repository<SaleModel> {
  DBService dbService;
  SaleRepository(this.dbService);

  updateDependencies(DBService db) {
    dbService = db;
  }

  @override
  String get tableName => SaleMigration.tableName;

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
  Future<int?> upsert(SaleModel item) async {
    try {
      if (item.id != null) return await update(item);
      return await create(item);
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<int?> create(SaleModel item) async {
    try {
      return await dbService.insert(tableName: tableName, data: item.toMap());
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<int?> update(SaleModel item) async {
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
  Future<int?> delete(SaleModel item) async {
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

  Future<CustomerModel> searchCustomer(String? customerCode) async {
    try {
      final customer = await dbService.query(
        table: CustomerMigration.tableName,
        where: "code = ?",
        whereArgs: [customerCode],
      );

      return CustomerModel.fromMap(customer[0]);
    } catch (e) {
      rethrow;
    }
  }
}
