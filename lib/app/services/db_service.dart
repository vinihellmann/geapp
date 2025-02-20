import 'dart:developer';

import 'package:geapp/app/database/database.dart';
import 'package:geapp/app/models/query_result.dart';
import 'package:sqflite/sqflite.dart';

class DBService {
  Future<bool> login(String user, String password) async {
    final db = await GEDatabase().db;
    final userQuery = await db.query(
      "USUARIOS",
      where: "user = ? AND password = ?",
      whereArgs: [user, password],
    );

    return userQuery.isNotEmpty;
  }

  Future<List<dynamic>> query({
    required String table,
    String? where,
    List<dynamic>? whereArgs,
  }) async {
    final db = await GEDatabase().db;
    return await db.query(table, where: where, whereArgs: whereArgs);
  }

  Future<QueryResult> getData({
    required String tableName,
    int limit = 10,
    int page = 1,
    String orderBy = 'ID',
    String? where,
  }) async {
    try {
      final db = await GEDatabase().db;

      final data = await db.query(
        tableName,
        where: where,
        offset: (page - 1) * limit,
        limit: limit,
        orderBy: orderBy,
      );

      final count = Sqflite.firstIntValue(
        await db.rawQuery(
            "SELECT COUNT(*) FROM $tableName ${where != null ? "WHERE $where" : ""}"),
      );

      final totalPages = (count! / limit).ceil();

      return QueryResult(
        data: data,
        totalItems: count,
        totalPages: totalPages,
      );
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
      final db = await GEDatabase().db;
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
      final db = await GEDatabase().db;
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
      final db = await GEDatabase().db;
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
