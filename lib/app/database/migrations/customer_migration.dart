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
        cpf TEXT,
        cnpj TEXT,
        name TEXT NOT NULL,
        phone TEXT,
        email TEXT,
        fantasy TEXT,
        contact TEXT,
        inscription TEXT,
        addressUF INTEGER NOT NULL,
        addressCity INTEGER NOT NULL,
        addressName TEXT NOT NULL,
        addressNumber TEXT NOT NULL,
        addressZipCode TEXT NOT NULL,
        addressComplement TEXT,
        addressNeighborhood TEXT NOT NULL,
        createdAt TEXT NOT NULL,
        updatedAt TEXT NOT NULL
      )
    ''');
  }
}
