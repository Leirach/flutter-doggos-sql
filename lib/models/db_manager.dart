import 'dart:async';
import 'package:sql/models/database.dart';

class DBManager {
  // Singleton pattern ?????? flutter?
  static final DBManager _dbManager = new DBManager._internal();
  DBManager._internal();
  static DBManager get instance => _dbManager;

  // final _initDBMemoizer = AsyncMemoizer<dynamic>();

  // Member
  static AppDatabase? _database;
  Future<AppDatabase?> get database async {
    if (_database != null) return _database;

    _database = await _initDB();
    return _database;
  }

  Future<AppDatabase> _initDB() async {
    String databasePath = 'app_database.db';
    return $FloorAppDatabase.databaseBuilder(databasePath).build();
  }
}
