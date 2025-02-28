import 'dart:developer';

import 'package:geapp/app/models/query_result.dart';
import 'package:sqflite/sqflite.dart';

class DBService {
  final Database db;
  DBService(this.db);

  Future<List<dynamic>> query({
    required String table,
    String? where,
    List<dynamic>? whereArgs,
  }) async {
    return await db.query(table, where: where, whereArgs: whereArgs);
  }

  Future<QueryResult> getData({
    required String tableName,
    int page = 1,
    int limit = 10,
    String? where,
    String orderBy = 'ID',
    List<dynamic>? whereArgs,
  }) async {
    try {
      final data = await db.query(
        tableName,
        limit: limit,
        where: where,
        orderBy: orderBy,
        whereArgs: whereArgs,
        offset: (page - 1) * limit,
      );

      final count = Sqflite.firstIntValue(
        await db.rawQuery(
          "SELECT COUNT(*) FROM $tableName ${where != null ? "WHERE $where" : ""}",
          whereArgs,
        ),
      );
      final totalPages = (count! / limit).ceil();

      return QueryResult(data: data, totalItems: count, totalPages: totalPages);
    } catch (e) {
      log("DBService::getData - $e");
      rethrow;
    }
  }

  Future<int?> insert({
    required String tableName,
    required Map<String, dynamic> data,
  }) async {
    try {
      return await db.insert(tableName, data);
    } catch (e) {
      log("DBService::insert - $e");
      return null;
    }
  }

  Future<int?> update({
    required String tableName,
    required Map<String, dynamic> data,
    required String whereClause,
    required List<dynamic> whereArgs,
  }) async {
    try {
      return await db.update(
        tableName,
        data,
        where: whereClause,
        whereArgs: whereArgs,
      );
    } catch (e) {
      log("DBService::update - $e");
      return null;
    }
  }

  Future<int?> delete({
    required String tableName,
    String? whereClause,
    List<dynamic>? whereArgs,
  }) async {
    try {
      return await db.delete(
        tableName,
        where: whereClause,
        whereArgs: whereArgs,
      );
    } catch (e) {
      log("DBService::delete - $e");
      return null;
    }
  }
}
