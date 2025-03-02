import 'package:geapp/app/database/migrations/customer_migration.dart';
import 'package:geapp/app/models/query_result.dart';
import 'package:geapp/app/models/select_object.dart';
import 'package:geapp/app/repositories/repository.dart';
import 'package:geapp/app/services/db_service.dart';
import 'package:geapp/modules/customer/models/customer_model.dart';

class CustomerRepository extends Repository<CustomerModel> {
  DBService dbService;
  CustomerRepository(this.dbService);

  updateDependencies(DBService db) {
    dbService = db;
  }

  @override
  String get tableName => CustomerMigration.tableName;

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
  Future<int?> upsert(CustomerModel item) async {
    try {
      if (item.id != null) return await update(item);
      return await create(item);
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<int?> create(CustomerModel item) async {
    try {
      return await dbService.insert(tableName: tableName, data: item.toMap());
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<int?> update(CustomerModel item) async {
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
  Future<int?> delete(CustomerModel item) async {
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

  Future<List<SelectObject>> getStates() async {
    try {
      final result = await dbService.query(table: "ESTADOS");
      return result
          .map((uf) => SelectObject(key: uf['sigla'], value: uf['sigla']))
          .toList();
    } catch (e) {
      rethrow;
    }
  }

  Future<List<SelectObject>> getCities(String state) async {
    try {
      final stateQuery = await dbService.query(
        table: "ESTADOS",
        where: "sigla = ?",
        whereArgs: [state],
      );
      if (stateQuery.isEmpty) return [];

      final stateId = stateQuery[0]['id'];
      final cityQuery = await dbService.query(
        table: "CIDADES",
        where: "estado_id = ?",
        whereArgs: [stateId],
      );
      if (cityQuery.isEmpty) return [];

      return cityQuery
          .map(
            (city) => SelectObject(
              key: city['nomeCidade'].toString().toUpperCase(),
              value: city['nomeCidade'].toString().toUpperCase(),
            ),
          )
          .toList();
    } catch (e) {
      rethrow;
    }
  }
}
