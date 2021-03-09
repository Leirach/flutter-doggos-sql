import 'dart:async';
import 'package:floor/floor.dart';
import 'package:sqflite/sqflite.dart' as sqflite;

import 'dog.dart';
import 'dog_dao.dart';

part 'database.g.dart'; // the generated code will be there

@Database(version: 1, entities: [Dog])
abstract class AppDatabase extends FloorDatabase {
  DogDao get dogDao;
}
