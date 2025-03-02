import 'dart:developer';

import 'package:sqflite/sqflite.dart';

class CustomerMigration {
  static const tableName = "CLIENTES";

  static Future<void> execute(Database db) async {
    await createTables(db);

    log("Tabela $tableName criada");
  }

  static Future<void> createTables(Database db) async {
    await db.execute('''
      CREATE TABLE IF NOT EXISTS $tableName (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        code TEXT UNIQUE NOT NULL,
        isLegal INTEGER NOT NULL,
        name TEXT NOT NULL,
        cpf TEXT,
        cnpj TEXT,
        phone TEXT,
        email TEXT,
        fantasy TEXT,
        contact TEXT,
        inscription TEXT,
        addressName TEXT,
        addressNumber TEXT,
        addressZipCode TEXT,
        addressComplement TEXT,
        addressNeighborhood TEXT,
        addressUF TEXT NOT NULL,
        addressCity TEXT NOT NULL,
        createdAt TEXT NOT NULL,
        updatedAt TEXT NOT NULL
      )
    ''');
  }
}
