// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'database.dart';

// **************************************************************************
// FloorGenerator
// **************************************************************************

class $FloorAppDatabase {
  /// Creates a database builder for a persistent database.
  /// Once a database is built, you should keep a reference to it and re-use it.
  static _$AppDatabaseBuilder databaseBuilder(String name) =>
      _$AppDatabaseBuilder(name);

  /// Creates a database builder for an in memory database.
  /// Information stored in an in memory database disappears when the process is killed.
  /// Once a database is built, you should keep a reference to it and re-use it.
  static _$AppDatabaseBuilder inMemoryDatabaseBuilder() =>
      _$AppDatabaseBuilder(null);
}

class _$AppDatabaseBuilder {
  _$AppDatabaseBuilder(this.name);

  final String? name;

  final List<Migration> _migrations = [];

  Callback? _callback;

  /// Adds migrations to the builder.
  _$AppDatabaseBuilder addMigrations(List<Migration> migrations) {
    _migrations.addAll(migrations);
    return this;
  }

  /// Adds a database [Callback] to the builder.
  _$AppDatabaseBuilder addCallback(Callback callback) {
    _callback = callback;
    return this;
  }

  /// Creates the database and initializes it.
  Future<AppDatabase> build() async {
    final path = name != null
        ? await sqfliteDatabaseFactory.getDatabasePath(name!)
        : ':memory:';
    final database = _$AppDatabase();
    database.database = await database.open(
      path,
      _migrations,
      _callback,
    );
    return database;
  }
}

class _$AppDatabase extends AppDatabase {
  _$AppDatabase([StreamController<String>? listener]) {
    changeListener = listener ?? StreamController<String>.broadcast();
  }

  DogDao? _dogDaoInstance;

  Future<sqflite.Database> open(String path, List<Migration> migrations,
      [Callback? callback]) async {
    final databaseOptions = sqflite.OpenDatabaseOptions(
      version: 1,
      onConfigure: (database) async {
        await database.execute('PRAGMA foreign_keys = ON');
      },
      onOpen: (database) async {
        await callback?.onOpen?.call(database);
      },
      onUpgrade: (database, startVersion, endVersion) async {
        await MigrationAdapter.runMigrations(
            database, startVersion, endVersion, migrations);

        await callback?.onUpgrade?.call(database, startVersion, endVersion);
      },
      onCreate: (database, version) async {
        await database.execute(
            'CREATE TABLE IF NOT EXISTS `Dogs` (`id` INTEGER PRIMARY KEY AUTOINCREMENT, `name` TEXT NOT NULL, `age` INTEGER NOT NULL)');

        await callback?.onCreate?.call(database, version);
      },
    );
    return sqfliteDatabaseFactory.openDatabase(path, options: databaseOptions);
  }

  @override
  DogDao get dogDao {
    return _dogDaoInstance ??= _$DogDao(database, changeListener);
  }
}

class _$DogDao extends DogDao {
  _$DogDao(this.database, this.changeListener)
      : _queryAdapter = QueryAdapter(database, changeListener),
        _dogInsertionAdapter = InsertionAdapter(
            database,
            'Dogs',
            (Dog item) => <String, Object?>{
                  'id': item.id,
                  'name': item.name,
                  'age': item.age
                },
            changeListener);

  final sqflite.DatabaseExecutor database;

  final StreamController<String> changeListener;

  final QueryAdapter _queryAdapter;

  final InsertionAdapter<Dog> _dogInsertionAdapter;

  @override
  Future<List<Dog>> findAllDogs() async {
    return _queryAdapter.queryList('SELECT * FROM dogs',
        mapper: (Map<String, Object?> row) =>
            Dog(name: row['name'] as String, age: row['age'] as int));
  }

  @override
  Stream<Dog?> findDogById(int id) {
    return _queryAdapter.queryStream('SELECT * FROM dogs WHERE id = ?',
        arguments: [id],
        queryableName: 'Dogs',
        isView: false,
        mapper: (Map<String, Object?> row) =>
            Dog(name: row['name'] as String, age: row['age'] as int));
  }

  @override
  Future<void> delete(int id) async {
    await _queryAdapter
        .queryNoReturn('DELETE FROM dogs WHERE id = ?', arguments: [id]);
  }

  @override
  Future<void> insertDog(Dog dog) async {
    await _dogInsertionAdapter.insert(dog, OnConflictStrategy.abort);
  }
}
