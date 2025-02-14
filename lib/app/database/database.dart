import 'dart:async';
import 'dart:developer';

import 'package:geapp/app/database/migrations/customer_migration.dart';
import 'package:geapp/app/database/migrations/location_migration.dart';
import 'package:geapp/app/database/migrations/product_migration.dart';
import 'package:geapp/app/database/migrations/user_migration.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class GEDatabase {
  static Database? _db;
  static const int _dbVersion = 1;
  static final GEDatabase _dbDefault = GEDatabase._createInstance();

  GEDatabase._createInstance();

  factory GEDatabase() {
    return _dbDefault;
  }

  Future<Database> get db async {
    return _db ??= await initialize();
  }

  static Future<Database> initialize() async {
    String dbPath = await getDatabasesPath();
    String finalPath = join(dbPath, "ge_database.db");

    return await openDatabase(
      finalPath,
      version: _dbVersion,
      onCreate: (db, version) => _onCreate(db, version),
    );
  }

  static FutureOr<void> _onCreate(Database db, int version) async {
    try {
      await Future.wait([
        UserMigration.execute(db),
        CustomerMigration.execute(db),
        ProductMigration.execute(db),
        LocationMigration.execute(db),
      ]);
    } catch (e) {
      log('GEDatabase::onCreate - $e');
    }
  }
}
