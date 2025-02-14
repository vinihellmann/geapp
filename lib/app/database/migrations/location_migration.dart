import 'dart:convert';
import 'dart:developer';

import 'package:flutter/services.dart';
import 'package:sqflite/sqflite.dart';

class LocationMigration {
  static const statesTable = "ESTADOS";
  static const citiesTable = "CIDADES";

  static Future<void> execute(Database db) async {
    await createTables(db);
    await populateTables(db);

    log("Tabelas $statesTable e $citiesTable criadas");
  }

  static Future<void> createTables(Database db) async {
    await db.execute('''
      CREATE TABLE IF NOT EXISTS $statesTable (
        id INTEGER PRIMARY KEY,
        sigla TEXT NOT NULL,
        nomeEstado TEXT NOT NULL
      )
    ''');

    await db.execute('''
      CREATE TABLE IF NOT EXISTS $citiesTable (
        id_cidade INTEGER PRIMARY KEY,
        nomeCidade TEXT NOT NULL,
        estado_id INTEGER NOT NULL,
        FOREIGN KEY (estado_id) REFERENCES $statesTable(id)
      )
    ''');
  }

  static Future<void> populateTables(Database db) async {
    final String jsonString =
        await rootBundle.loadString('assets/jsons/estados-com-cidades.json');
    final Map<String, dynamic> data = jsonDecode(jsonString);

    for (var estado in data['estados']) {
      await db.insert(statesTable, {
        'id': estado['id'],
        'sigla': estado['sigla'],
        'nomeEstado': estado['nomeEstado'],
      });

      for (var cidade in estado['cidades']) {
        await db.insert(citiesTable, {
          'id_cidade': cidade['id_cidade'],
          'nomeCidade': cidade['nomeCidade'],
          'estado_id': estado['id'],
        });
      }
    }
  }
}
