import 'package:geapp/app/models/query_result.dart';

abstract class Repository<T> {
  String get tableName;

  Future<QueryResult> search(String? where, List<dynamic>? whereArgs, int page, int limit, String orderBy);
  Future<int?> create(T item);
  Future<int?> update(T item);
  Future<int?> delete(T item);
}
