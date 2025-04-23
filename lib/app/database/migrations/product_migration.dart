import 'dart:developer';

import 'package:sqflite/sqflite.dart';

class ProductMigration {
  static const tableName = "PRODUTOS";
  static const tableNameUnit = "PRODUTOS_UNIDADE";
  static const tableNameImage = "PRODUTOS_IMAGEM";

  static Future<void> execute(Database db) async {
    await createTables(db);

    log("Tabela $tableName criada");
    log("Tabela $tableNameUnit criada");
    log("Tabela $tableNameImage criada");
  }

  static Future<void> createTables(Database db) async {
    await db.execute('''
      CREATE TABLE IF NOT EXISTS $tableName (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        code TEXT UNIQUE NOT NULL,
        barCode TEXT,
        name TEXT NOT NULL,
        brand TEXT,
        groupName TEXT,
        image TEXT,
        createdAt TEXT NOT NULL,
        updatedAt TEXT NOT NULL
      )
    ''');

    await db.execute('''
      CREATE TABLE IF NOT EXISTS $tableNameUnit (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        code TEXT UNIQUE NOT NULL,
        productCode TEXT NOT NULL,
        unit TEXT NOT NULL,
        stock FLOAT NOT NULL,
        price FLOAT NOT NULL,
        createdAt TEXT NOT NULL,
        updatedAt TEXT NOT NULL,
        FOREIGN KEY (productCode) REFERENCES $tableName (code) ON DELETE CASCADE
      )
    ''');

    await db.execute('''
      CREATE TABLE IF NOT EXISTS $tableNameImage (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        code TEXT UNIQUE NOT NULL,
        productCode TEXT NOT NULL,
        image TEXT NOT NULL,
        createdAt TEXT NOT NULL,
        FOREIGN KEY (productCode) REFERENCES $tableName (code) ON DELETE CASCADE
      )
    ''');
  }
}
