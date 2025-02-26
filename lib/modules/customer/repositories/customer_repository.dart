import 'package:geapp/app/database/migrations/customer_migration.dart';
import 'package:geapp/app/models/query_result.dart';
import 'package:geapp/app/models/select_object.dart';
import 'package:geapp/app/repositories/repository.dart';
import 'package:geapp/app/services/db_service.dart';
import 'package:geapp/modules/customer/models/customer_model.dart';

class CustomerRepository extends Repository<CustomerModel> {
  final DBService dbService;
  CustomerRepository(this.dbService);
  
  @override
  String get tableName => CustomerMigration.tableName;

  @override
  Future<QueryResult> search(String? where, List<dynamic>? whereArgs, int page, int limit, String orderBy) async {
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
  Future<int?> create(CustomerModel item) async {
    try {
      return await dbService.insert(
        tableName: tableName,
        data: item.toMap(),
      );
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
      return result.map((uf) => SelectObject(
        key: int.parse(uf['id'].toString()), 
        value: uf['sigla']))
      .toList();
    } catch (e) {
      rethrow;
    }
  }

  Future<List<SelectObject>> getCities(int id) async {
    try {
      final result = await dbService.query(table: "CIDADES", where: "estado_id = ?", whereArgs: [id]);
      return result.map((city) => SelectObject(
        key: int.parse(city['id_cidade'].toString()), 
        value: city['nomeCidade']))
      .toList();
    } catch (e) {
      rethrow;
    }
  }
}
