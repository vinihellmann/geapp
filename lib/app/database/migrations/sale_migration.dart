import 'dart:developer';

import 'package:sqflite/sqflite.dart';

class SaleMigration {
  static const tableName = "VENDAS";

  static Future<void> execute(Database db) async {
    await createTables(db);

    log("Tabela $tableName criada");
  }

  static Future<void> createTables(Database db) async {
    await db.execute('''
      CREATE TABLE IF NOT EXISTS $tableName (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        code TEXT UNIQUE NOT NULL,
        customerCode TEXT NOT NULL,
        customerName TEXT NOT NULL,
        paymentMethod INTEGER NOT NULL,
        paymentStatus INTEGER NOT NULL,
        paymentCondition INTEGER NOT NULL,
        totalValue FLOAT NOT NULL,
        totalItems FLOAT NOT NULL,
        discountValue FLOAT,
        additionValue FLOAT,
        shippingValue FLOAT,
        discountPercentage FLOAT,
        additionPercentage FLOAT,
        generalNotes TEXT,
        deliveryDate TEXT NOT NULL,
        createdAt TEXT NOT NULL,
        updatedAt TEXT NOT NULL
      )
    ''');
  }
}
