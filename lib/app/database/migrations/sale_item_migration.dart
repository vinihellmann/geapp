import 'dart:developer';

import 'package:sqflite/sqflite.dart';

class SaleItemMigration {
  static const tableName = "VENDAS_ITEM";

  static Future<void> execute(Database db) async {
    await createTables(db);

    log("Tabela $tableName criada");
  }

  static Future<void> createTables(Database db) async {
    await db.execute('''
      CREATE TABLE IF NOT EXISTS $tableName (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        code TEXT UNIQUE NOT NULL,
        saleCode TEXT NOT NULL,
        productCode TEXT NOT NULL,
        productName TEXT NOT NULL,
        unitCode TEXT NOT NULL,
        unitName TEXT NOT NULL,
        unitValue FLOAT NOT NULL,
        quantity FLOAT NOT NULL,
        discountValue FLOAT NOT NULL,
        discountPercentage FLOAT NOT NULL,
        finalValue FLOAT NOT NULL,
        totalValue FLOAT NOT NULL,
        createdAt TEXT NOT NULL,
        updatedAt TEXT NOT NULL,
        FOREIGN KEY (saleCode) REFERENCES VENDAS (code) ON DELETE CASCADE
      )
    ''');
  }
}
