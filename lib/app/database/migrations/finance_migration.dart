import 'dart:developer';

import 'package:sqflite/sqflite.dart';

class FinanceMigration {
  static const tableName = "FINANCEIRO";

  static Future<void> execute(Database db) async {
    await createTables(db);

    log("Tabela $tableName criada");
  }

  static Future<void> createTables(Database db) async {
    await db.execute('''
      CREATE TABLE IF NOT EXISTS $tableName (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        type INTEGER NOT NULL,
        status INTEGER NOT NULL,
        code TEXT UNIQUE NOT NULL,
        saleCode TEXT NOT NULL,
        customerCode TEXT,
        customerName TEXT,
        description TEXT,
        value FLOAT NOT NULL,
        dueDate TEXT NOT NULL,
        paymentDate TEXT,
        createdAt TEXT NOT NULL,
        updatedAt TEXT NOT NULL,
        FOREIGN KEY (saleCode) REFERENCES VENDAS (code) ON DELETE CASCADE,
        FOREIGN KEY (customerCode) REFERENCES CLIENTES (code) ON DELETE CASCADE
      )
    ''');
  }
}
