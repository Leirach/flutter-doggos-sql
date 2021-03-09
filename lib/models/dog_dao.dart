import 'dart:async';
import 'package:floor/floor.dart';
import 'package:sql/models/dog.dart';

@dao
abstract class DogDao {
  @Query('SELECT * FROM dogs')
  Future<List<Dog>> findAllDogs();

  @Query('SELECT * FROM dogs WHERE id = :id')
  Stream<Dog?> findDogById(int id);

  @insert
  Future<void> insertDog(Dog dog);

  @Query('DELETE FROM dogs WHERE id = :id')
  Future<void> delete(int id);
}
