import 'dart:developer';

import 'package:sqflite/sqflite.dart';

class UserMigration {
  static const tableName = "USUARIOS";

  static Future<void> execute(Database db) async {
    await createTables(db);
    await populateTables(db);

    log("Tabela $tableName criada");
  }

  static Future<void> createTables(Database db) async {
    await db.execute('''
      CREATE TABLE IF NOT EXISTS $tableName (
        id INTEGER PRIMARY KEY,
        user TEXT NOT NULL,
        password TEXT NOT NULL,
        role INTEGER NOT NULL
      )
    ''');
  }

  static Future<void> populateTables(Database db) async {
    await db.insert(tableName, {'user': "demo", 'password': "1234", 'role': 1});
  }
}
